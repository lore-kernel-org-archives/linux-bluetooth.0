Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BD2701C1
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507415; cv=pass; b=XlQXH+OkwxNWcUHC/gj3PiijOOAO0Z+AX4Sxii1K1k0tfTjZ6Swud5MIJtfWcCukvsuwa2QcF+ANwgXLGLQD8UImNDksG5MgxCaG58kwlwotJv4HYNkjd39ovGskMTFMKsxbQndT2ba9tnen0rpUX1DpVTehw/dpP/KSjJxvP6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507415; c=relaxed/simple;
	bh=s4j+06EJe3UBTeDjKqh//BS7qwA9r2UFvDN7UBr8XTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFxPo9NnXTyYTEGodX3lodNkWDmTWXW9nbHSQGPjxqrp08UrtUSHw8+0GvWdgNMknAxucT8UK6DTfgXc7A39Tcm4NONrqaJPzb9SOXcqxY+bW1MheDEuKqsTZZDjEzHcBoASgvwZupuvExvnVp3zaWmmEej2fEyIE0hn3x/1znI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=O42kDKfv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="O42kDKfv"
ARC-Seal: i=1; a=rsa-sha256; t=1745507409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=acv/E0nyicGe7EW5WbH1pXiGLlJILCkSbl+HBdUYng26A8HZC428VWIONW0JkwxvyNdQbX7v1l8bkHrN4R0AvIACqIjio3+ZCV+nZ3Ra11jKxoFSdQr3hpLmKdRntv7mhOtu+/J1jbuSYrF0slSoWfU3Z+m0NjX820L7yDCvjpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745507409; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HHiUKGDeWXpORTI+c6vkRDDONpAHZNnD7cwLyZ/9O6M=; 
	b=bHfoqoHkPVwXua/4K/vdzQnnoApVx8M338iRJYiosSkUk+ou4QemwrGIc/dBaeTwrSiXa3YWTx+pQYWVLdxKdLGU3QjKklOXYe85SGez6592/w7UeKf+gv121vJpzigaLTw/5Gx4gLrFTUmLVZ/bQ9E4qAJKtlqABP5nhfzFIZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745507409;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HHiUKGDeWXpORTI+c6vkRDDONpAHZNnD7cwLyZ/9O6M=;
	b=O42kDKfvN3Ffd2/L9iwcoV1hVt5cvf0ddM10gz8QMjqsdJKMA/B1rGVq5CflGV0c
	wcY/LvkuoXo+UDNqK7mckjoelNotSGTDCWWIgiOEf3MmHKcFsxXDE1tZZ7JG+mUj/vZ
	T5nbsT+olfRHeN+HQlU1w8Qy87VIPOJ9JJclPlv8=
Received: by mx.zohomail.com with SMTPS id 1745507407152294.8628316496131;
	Thu, 24 Apr 2025 08:10:07 -0700 (PDT)
Message-ID: <be3ecba1-8f13-4b63-9835-e4dc4b375dbe@collabora.com>
Date: Thu, 24 Apr 2025 17:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3 6/7] adapter: Set server security level in
 load_devices()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
 <20250424144831.95766-7-ludovico.denittis@collabora.com>
 <CABBYNZKZoBaw_MzRqmR3CUv+=rw_U=Uo25engjsFG=9u-jU8XQ@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZKZoBaw_MzRqmR3CUv+=rw_U=Uo25engjsFG=9u-jU8XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 4/24/25 4:57 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Thu, Apr 24, 2025 at 10:50 AM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> After loading known devices from storage, change the security level if
>> we have a device with `CablePairing`.
>> This will allow it to successfully establish a connection.
>> ---
>>   src/adapter.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index fd425e6d2..8d875013c 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -68,6 +68,7 @@
>>   #include "adv_monitor.h"
>>   #include "eir.h"
>>   #include "battery.h"
>> +#include "profiles/input/server.h"
>>
>>   #define MODE_OFF               0x00
>>   #define MODE_CONNECTABLE       0x01
>> @@ -5090,6 +5091,12 @@ free:
>>                  g_key_file_free(key_file);
>>          }
>>
>> +       if (btd_adapter_has_cable_pairing_devices(adapter)) {
>> +               DBG("There is at least one known cable paired device, setting the "
>> +                       "listening input server security level accordingly");
>> +               server_set_cable_pairing(&adapter->bdaddr, true);
>> +       }
> This creates a dependency on the input which is a plugin that can be
> excluded/not loaded at runtime, so we can't really do this at daemon
> core.

Do you have any suggestions on how to shuffle this around to avoid calling
`server_set_cable_pairing()` directly from `adapter.c`? Because in 
theory that
should still happen after we ensured  we loaded all devices from storage.

>>          closedir(dir);
>>
>>          load_link_keys(adapter, keys, btd_opts.debug_keys);
>> --
>> 2.49.0
>>
>>
>

