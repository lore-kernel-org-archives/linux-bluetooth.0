Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DA1DF248
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171563; cv=pass; b=MMJANhM8zTlQWBAUsFcEmL8Hez/9kStXLRTEl5JgZP0Eyy9gqJBlzz3Wgk3foYDAlj0YPQSKWu/6nG0Cx63GA0V6p5Y8tiltVNl11bFbc6XrhD2jcyVNzUjB34rzL8NnVed9AcLEFRZAkQQQp0xgsi0e4KtGzezm/khfoRaL9OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171563; c=relaxed/simple;
	bh=Q9IHyheuaY+odaYi9mb4xUAwAr20qJR6br9GhVfeNbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vo4jHEj+ImfzYb3Tl+3R58oIjZAYnNKNopeEAkUg6Tv4ZeOnZNhFPOzqUKr9ma2ygMTYdRom7Ie2j/Hs+XrRoE+zGM7vCWU3G2U83ucKxIex3l5YUZ4gBxNzIMwYn81pf2wor84Acm9FGT0LijsibwSa1rFDLmxf6EmlUZo4qsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=HqjGgibr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="HqjGgibr"
ARC-Seal: i=1; a=rsa-sha256; t=1738171558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MmTXSYAw23Wj+xeaYVJMO9E1X4WUtJtGwWqyJKfmQv1yOIX9f55zRgQnlSXD/iIkJCiobrXtR9GDMNseUXSE/kGRfnEW6qWABrnXGyGS1UBQqXD7I0li/eDQXmypZiTY3RMuY0FA2BoiftXSQbAqaBF9B8D7UnXZcn8fp4Sea4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738171558; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mLBgyA2XoNsL0iGPHBH/Jrw6naqHiNn3PLh+ZETcT4I=; 
	b=S46Biys4+wFHeerckw4w54JsyWNQ8wKGK5XIHOo4ogPealxr9dLSVow+XmkIkv3tyAdCCF33VnKKJa75HXE6rXzBrbz+0aL/1FtrqlfIAEscwaZllRkkCpT8uL3Zu61/4na0M/viKwV6Zvi0p8g0ozZlcTk1/kHP4ac5ooxddr8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738171558;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mLBgyA2XoNsL0iGPHBH/Jrw6naqHiNn3PLh+ZETcT4I=;
	b=HqjGgibrW20n0Vtfw+smfU9OssktqM2PyB89ttDQErPyLIe3NTTc2SHIiQl40a2r
	AMGZ0oew72KrrH+J/NFVUDKOTknfSa2DbyPA4EN+9W7ipDotkfL2hodhZHRjt4+MyP0
	Oj3J/m8lQJkd6s6lNS6FIj5cTU6eltYVAomVP9uk=
Received: by mx.zohomail.com with SMTPS id 1738171554251341.3780549230744;
	Wed, 29 Jan 2025 09:25:54 -0800 (PST)
Message-ID: <736b35d1-bb10-4132-b662-37707f0065c1@collabora.com>
Date: Wed, 29 Jan 2025 18:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] adapter: Include pending flags in
 device_flags_changed_callback
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250128102937.16215-1-ludovico.denittis@collabora.com>
 <CABBYNZJ8NUAGpmmaezy=4KJD4uM8f7J1pkMgZnDoOoFkdRSRqA@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZJ8NUAGpmmaezy=4KJD4uM8f7J1pkMgZnDoOoFkdRSRqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Right, makes sense. I did something similar to what you suggested in 
"[PATCH BlueZ] device: Clear only the pending flags that have been applied".

However, I changed it to `dev->pending_flags &= ~current_flags`, because 
otherwise we could have left `pending_flags` to some unexpected value.

For example, if we are in `device_set_wake_allowed()` and we want to 
enable the wake allowed:
- Assume the current flags is 2, i.e. DEVICE_FLAG_DEVICE_PRIVACY
- It calls `adapter_set_device_flags()` with current flags plus 
DEVICE_FLAG_REMOTE_WAKEUP (aka 3)
- In `adapter_set_device_flags()` we have `flags == 3`, which then gets 
assigned to `pending_flags`
- In `btd_device_flags_changed()` we end up with `changed_flags == 1`

In this situation, if we only remove the `changed_flags`, pending flags 
will remain with a value of 2 even if there are no other pending changes.
For this reason I remove the current_flags, instead of only changed_flags.

The other two patches that I created "[PATCH BlueZ v2] device: Clear 
pending_flags on error" and "[PATCH BlueZ] adapter: Fix the pending 
changing flags check", are kinda related to this one, but I sent them 
separately because they don't really depend on one another.


On 1/28/25 9:33 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Tue, Jan 28, 2025 at 5:30 AM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> When signalling the new device flags, we need to include the pending
>> ones. Otherwise, the eventual non-zero `pending_flags` will be wiped out
>> in `btd_device_flags_changed()`, and we'll lose the pending changed
>> flags.
>>
>> Fixes https://github.com/bluez/bluez/issues/1076
>> ---
>>   src/adapter.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 5d4117a49..cbc0f678f 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -5727,6 +5727,7 @@ static void device_flags_changed_callback(uint16_t index, uint16_t length,
>>          struct btd_adapter *adapter = user_data;
>>          struct btd_device *dev;
>>          char addr[18];
>> +       uint32_t changed_flags = 0;
>>
>>          if (length < sizeof(*ev)) {
>>                  btd_error(adapter->dev_id,
>> @@ -5744,7 +5745,9 @@ static void device_flags_changed_callback(uint16_t index, uint16_t length,
>>                  return;
>>          }
>>
>> -       btd_device_flags_changed(dev, ev->supported_flags, ev->current_flags);
>> +       changed_flags = ev->current_flags | btd_device_get_pending_flags(dev);
>> +
>> +       btd_device_flags_changed(dev, ev->supported_flags, changed_flags);
> This doesn't sound right, it would be as if the pending flags always
> succeed which I don't think it is always the case, perhaps we should
> something like the following:
>
> diff --git a/src/device.c b/src/device.c
> index e8bff718c201..4959f36542fb 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -7413,7 +7413,7 @@ void btd_device_flags_changed(struct btd_device
> *dev, uint32_t supported_flags,
>
>          dev->supported_flags = supported_flags;
>          dev->current_flags = current_flags;
> -       dev->pending_flags = 0;
> +       dev->pending_flags &= ~changed_flags;
>
>          if (!changed_flags)
>                  return;
>
> That way we clear pending_flags based on the changed_flags.
>
>>   }
>>
>>
>> --
>> 2.48.1
>>
>>
>

