select * from Nashville

select saleDate from Nashville

select propertyAddress
from Nashville
where PropertyAddress is null

select *, ISNULL(a.PropertyAddress, b.PropertyAddress)
from Nashville a 
join Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = Isnull(a.PropertyAddress, b.PropertyAddress)
from Nashville a 
join Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select 
substring(propertyAddress, 1, charindex(',', PropertyAddress) - 1) as address,
substring(propertyAddress, charindex(',', PropertyAddress) +1, len(PropertyAddress)) as addressCity
from Nashville

Alter table Nashville
add PropertysplitAddress Nvarchar(225);

update Nashville
set PropertysplitAddress = substring(propertyAddress, 1, charindex(',', PropertyAddress) - 1)

alter table Nashville
add propertysplitCity Nvarchar(225);

update Nashville
set propertysplitCity = substring(propertyAddress, charindex(',', PropertyAddress) +1, len(PropertyAddress))

select * from Nashville

select
PARSENAME(Replace(OwnerAddress, ',','.') ,3),
parsename(Replace(OwnerAddress, ',','.') ,2),
parsename(Replace(OwnerAddress, ',','.') ,1)
from Nashville

alter table Nashville
add OwnerStreetAddress NVarchar(255);

update Nashville
set OwnerStreetAddress =  PARSENAME(Replace(OwnerAddress, ',','.') ,3)

alter table Nashville
add OwnerCityAddress NVarchar(255);

update Nashville
set OwnerCityAddress =  PARSENAME(Replace(OwnerAddress, ',','.') ,2)

alter table Nashville
add OwnerStateAddress NVarchar(255);

update Nashville
set OwnerStateAddress =  PARSENAME(Replace(OwnerAddress, ',','.') ,1)

select * from Nashville

select SoldAsVacant,
Case when SoldAsVacant = 'Y' Then 'YES'
	 when SoldAsVacant = 'N' Then 'NO'
	 Else SoldAsVacant
	 End
from Nashville

update Nashville 
set SoldAsVacant = Case when SoldAsVacant = 'Y' Then 'YES'
	 when SoldAsVacant = 'N' Then 'NO'
	 Else SoldAsVacant
	 End
from Nashville


with rownumberCTE as(
select *,
row_number() over(partition by ParcelID order by ParcelID) as rn
from Nashville
)

Delete * from rownumberCTE
where rn > 1

alter table nashville
drop column PropertyAddress, OwnerName, TaxDistrict

select * from Nashville