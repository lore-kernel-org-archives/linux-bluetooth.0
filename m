Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77818224C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FkKNTtkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704377466;
	bh=xDJ4S9zr6hgLYmzym7hNAHKIxkgNSHlznCnPMMsQ458=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FkKNTtkHEVjwiv1u46jMMzt1RPEKydyYvX6wFpWLW887y95iYEpaZYmMmUGYsxAyM
	 lVvZkQC1qXheQTHFEsNWgMmD+dK4QiLNUfqG0H0LLF91SSzhc3EfS34wBizzm+Luxq
	 9+Pwcfstdud7PWTvK15JreMtVjio/IYDDokiXYiOWD4g/MUvrlzZArkh3ddxfB2gn1
	 AQECkJkYiST5unXiStOIIIweDTL2m2yYiA0kanM36wuqhZdHE/7EYNXiKJh8AHXZnj
	 v0d76+ossSbAC4e0PdBnfqm3iWe/vHvHYLtVMiGIm5zEUTFFvs2n8D+8hMGK8S2jGB
	 steknk7LPI33w==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 508F73782006;
	Thu,  4 Jan 2024 14:11:06 +0000 (UTC)
Message-ID: <3e6cf301-a869-4799-a869-af45cdb6635f@collabora.com>
Date: Thu, 4 Jan 2024 15:11:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] shared/gatt-db: Fix munmap_chunk invalid pointer
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240103092816.22952-1-frederic.danis@collabora.com>
 <CABBYNZJ-pPU=3jFWK8dDWrqPMG_8Uzow5XTxEP7mKnV7OhdajA@mail.gmail.com>
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJ-pPU=3jFWK8dDWrqPMG_8Uzow5XTxEP7mKnV7OhdajA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 03/01/2024 16:50, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Jan 3, 2024 at 4:28 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
>> and ending at 0xffff.
> Don't we have a test for it under unit/test-gatt.c? Perhaps it would
> be a good idea to add one while doing this change.

Yes
My idea should be to add a new unordered database and run 
gatt_db_get_hash() on it.

>
>> This resets the next_handle to 0 in gatt_db_insert_service() instead of
>> setting it to 0x10000. Other services are added later.
>> This could end-up by a crash in db_hash_update() if not enough space has
>> been allocated for hash.iov and some entries are overwritten.
> I understand we don't want to loop around but handle 0x10000 is not
> valid either.

Afaiu the next_handle is used as:
- the next available handle, with special value 0 to define an empty db
- and the maximum size to allocate during db_hash_update()

So, 0x10000 is not a valid handle but is a valid size.

gatt_db_insert_service() is already protected to not use handle > 0xFFFF.

>
>> ---
>>   src/shared/gatt-db.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 676f963ec..d32c9a70f 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -58,7 +58,7 @@ struct gatt_db {
>>          struct bt_crypto *crypto;
>>          uint8_t hash[16];
>>          unsigned int hash_id;
>> -       uint16_t next_handle;
>> +       uint32_t next_handle;
> I wonder if we can just set the next_handle to 0 and then check it
> when using it, that way it indicates that it had looped around and
> handle 0 is invalid already so we shouldn't allocate anything on it.

Not sure this can work as 0 can mean it's an empty db or a db requesting 
UINT16_MAX+1 elements.

During this test case, it loops to 0, but as other services are added 
setting next_handle to another value, ending up to allocate less memory 
than expected (i.e. UINT16_MAX+1 elements).

We may replace the next_handle by last_handle, use gatt_db_isempty() 
instead of the handle 0 to check for empty db, and allocate 
last_handle+1 in db_hash_update().
Does it seems better?

Regards,

Fred

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

