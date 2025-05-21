Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99B231852
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818157; cv=pass; b=GbjpiKrPTvgX4dKwlOAI8W5tgNmlsoMwLBYzBjx9Lc4H+wYbFkd/aiRUsND4MYrzmegPTzJ+QAxrfqD/jr53Y2vu9ZnLPxn61XyEDDUgaSFuq2wfKaubAQxlVHOx47xNuMkBJcb+zX/69Hp+pI9dy2VrGGcCt60KUkFkwfZvxRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818157; c=relaxed/simple;
	bh=xRnhFXG4cxvnWaJPIeYPKC6FuUxRSa67rKVgarDVrxY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TmSH5lnCGiSOtnW/tRTpVxm8gq6PBqfTGUJdv9Og89/j5ejUKFpFiVX3sxUlled4R9L/HYIWqCvgSh805GGzrh+GdXOkmHHjja2yuN9cLwm29n0pNPg3qeFMWEvmLiosECeqRKamXZvd2+E5C8EfgPSTaeDPMtLW4PwV1UMaaOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=LEITnikn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="LEITnikn"
ARC-Seal: i=1; a=rsa-sha256; t=1747818152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nzQSwXnwObZeoPWzMga71GNYFxPV0TmDClu5D9/wGlG9/A2AhmHjyKKMUvCzr/PC367L087HL4pXCXoVsv5u4kJH/uIuoInrYyy7x1OYw5qj13Zoso0TFl6U0vDniJQBd3EfbssFAAhY1WBioQCdnOjCRmk4vwwz6T5+op3PpWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747818152; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GB1VQidCyQH0soTQRjG34p05xjpUhG5h1dHPwU9vPJA=; 
	b=K6oeY8Yqbp376vB3Tn9TQAmqXOiwtBsqv5w+nfyW5XUUJj1egXbz2p8DpqGEvrGry03dDPMhoYUwkzQ11wOPDmLP3UwTAUFO+hlZ1rf2KRhmM770GJ8/QL9rM6HPMg3oGQBXuYCgAGcKINMBluVjz2qDakVZ7QuVllQaaOihyk8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747818152;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GB1VQidCyQH0soTQRjG34p05xjpUhG5h1dHPwU9vPJA=;
	b=LEITnikned1B5VRuKpTN4ZQ+nu46XyKjVM+oiQmNFGqb//7DTRnwHG6D6MrH3cpz
	fvJQ75Qg6k8xQbMR0mGsJV5aq50cNYXwxI7WstguQ9xykg9nOpMXadS+uBB6Ig4Bt/I
	2TMo18FAXTfk5Y1jtgqSL3Y121O1VINLGIDFu90g=
Received: by mx.zohomail.com with SMTPS id 1747818150390664.320409342519;
	Wed, 21 May 2025 02:02:30 -0700 (PDT)
Message-ID: <de10ec0c-802e-4fa1-b19c-15cf2c7d181f@collabora.com>
Date: Wed, 21 May 2025 11:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
Subject: Re: [PATCH BlueZ v2 1/3] src/device: Add Disconnected signal to
 propagate disconnection reason
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250520162621.190769-1-frederic.danis@collabora.com>
 <20250520162621.190769-2-frederic.danis@collabora.com>
 <CABBYNZ+jMjs2Nj-9LiREM31cwhhT4O9Fv0nay_qFY4JfJKszuw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+jMjs2Nj-9LiREM31cwhhT4O9Fv0nay_qFY4JfJKszuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 20/05/2025 18:41, Luiz Augusto von Dentz wrote:

> Hi Frédéric,
>
> On Tue, May 20, 2025 at 12:26 PM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Currently a client application is informed of the disconnection by the
>> update of the Connected property to false.
>> This sends a Disconnected signal with the disconnection reason before
>> the property is updated.
>>
>> This helps client application to know the reason for the disconnection
>> and to take appropriate action.
>> ---
>> v1->v2: Propagate numerical reason instead of text one
>>
>>   src/adapter.c | 13 ++++++++-----
>>   src/device.c  | 16 ++++++++++++++--
>>   src/device.h  |  3 ++-
>>   3 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index fd425e6d2..a10721489 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -7549,7 +7549,8 @@ struct agent *adapter_get_agent(struct btd_adapter *adapter)
>>
>>   static void adapter_remove_connection(struct btd_adapter *adapter,
>>                                                  struct btd_device *device,
>> -                                               uint8_t bdaddr_type)
>> +                                               uint8_t bdaddr_type,
>> +                                               uint8_t reason)
>>   {
>>          bool remove_device = false;
>>
>> @@ -7560,7 +7561,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
>>                  return;
>>          }
>>
>> -       device_remove_connection(device, bdaddr_type, &remove_device);
>> +       device_remove_connection(device, bdaddr_type, &remove_device, reason);
>>
>>          device_cancel_authentication(device, TRUE);
>>
>> @@ -7601,9 +7602,11 @@ static void adapter_stop(struct btd_adapter *adapter)
>>                  struct btd_device *device = adapter->connections->data;
>>                  uint8_t addr_type = btd_device_get_bdaddr_type(device);
>>
>> -               adapter_remove_connection(adapter, device, BDADDR_BREDR);
>> +               adapter_remove_connection(adapter, device, BDADDR_BREDR,
>> +                                               MGMT_DEV_DISCONN_UNKNOWN);
>>                  if (addr_type != BDADDR_BREDR)
>> -                       adapter_remove_connection(adapter, device, addr_type);
>> +                       adapter_remove_connection(adapter, device, addr_type,
>> +                                               MGMT_DEV_DISCONN_UNKNOWN);
>>          }
>>
>>          g_dbus_emit_property_changed(dbus_conn, adapter->path,
>> @@ -8551,7 +8554,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
>>
>>          device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
>>          if (device) {
>> -               adapter_remove_connection(adapter, device, addr->type);
>> +               adapter_remove_connection(adapter, device, addr->type, reason);
>>                  disconnect_notify(device, reason);
>>          }
>>
>> diff --git a/src/device.c b/src/device.c
>> index d230af0a8..00a0fbfc7 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -3417,6 +3417,12 @@ static const GDBusMethodTable device_methods[] = {
>>          { }
>>   };
>>
>> +static const GDBusSignalTable device_signals[] = {
>> +       { GDBUS_SIGNAL("Disconnected",
>> +                       GDBUS_ARGS({ "reason", "y" })) },
> Ive changed my mind regarding this, this should actually have the same
> format as Device.Connect error reply, so we use the same domain of
> errors org.bluez.Error.{Name} followed by its message.

I'm not sure to understand this point as some of the possible reason are not errors
like MGMT_DEV_DISCONN_LOCAL_HOST or MGMT_DEV_DISCONN_REMOTE, and so org.bluez.Error.{Name}
seems inappropriate to me here.

To be more similar to other methods, the Disconnected signal may provide the reason as text
and numerical value, which can be useful in case of 'disconnection-unknown' text.

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

