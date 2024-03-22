Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A386216D
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130804; cv=none; b=bopcpkQnISV9nwh9PZYQAA1rNhTrkIto1c2TMLg66zSqOfCfnrkyud4ANFgK21zsQUmQx4RufJqoO+xg2sVpv/tSm0nTWT4lOjGe6FyeB6PqCN/+ql9KntRJk+kvSENcWcc6097njNm400yfNHsj1eAsRfo/VkaBjW/i4shpcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130804; c=relaxed/simple;
	bh=ZDi1gAA0yqJ2zl+yKEq9CaHTbFhf5PPE7V2a+4KIbnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBQnS3f8vgVka1pnaWAZol4LFfyG3Vn3EvtileZsJr3Nz+QxRedSJtCJjxMzwKrSHmgGsULBsnHloLTMbUD/7BtTXfcNCs9eMkQwwM2c3WCObQ7qmzHS+qIaWB7ViI2Pm35mf+4HGHvJUgoYQsrlgiF598ENj5jqAxZrIphLpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=eQ3QSUwr; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eQ3QSUwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=cW2mt37Z/a+Rt6EHEHmz1Gi6tbwi2vJAaXQEKqVoAMk=;
	b=eQ3QSUwryqFDkAo9jq/GuEqwdIIZwIQj3gzXsvdB6Hoa+KEYHJKm15ePsPZrGP
	aqkVNzWs/cLmGQEl0jmuEDQI5sNVPAsjGBBponEwchZm9cXUWCrbLqKYRhwGyvOJ
	Z22Z/0BZfue+c2BX5t3Tz/Y7jCO4z9wwhaBJWnPAkYULE=
Received: from [192.168.50.76] (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3XySgyP1lg1AXAQ--.37525S2;
	Sat, 23 Mar 2024 02:06:27 +0800 (CST)
Message-ID: <0078fcaa-180b-47e9-991a-6f18d920f4b0@126.com>
Date: Sat, 23 Mar 2024 02:06:24 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] avctp: Remove redundant UUID checks and additions
Content-Language: en-GB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Xiao Yao <xiaoyao@rock-chips.com>
References: <20240322143830.1476938-1-xiaokeqinhealth@126.com>
 <CABBYNZK64cAFTm7221QxN2T4Eip0=LbpmWUX_bJ3w+O4wAG2UQ@mail.gmail.com>
From: Yao Xiao <xiaokeqinhealth@126.com>
In-Reply-To: <CABBYNZK64cAFTm7221QxN2T4Eip0=LbpmWUX_bJ3w+O4wAG2UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XySgyP1lg1AXAQ--.37525S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWDKF1rGF4rZF1fJr17GFg_yoW8Zry7pF
	yYgFyUJFWkKr15ta4avF18uryaq3yUAr95WrZ5tw4jkwn3GryYqFyktr1Fqa4UursFkw4F
	vrWUGF92vwsIv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKsj8UUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgSp1WVLafX+oAABsP

Hi,

在 2024/3/22 23:28, Luiz Augusto von Dentz 写道:

> Hi,
>
> On Fri, Mar 22, 2024 at 2:39 PM Xiao Yao <xiaokeqinhealth@126.com> wrote:
>> From: Xiao Yao <xiaoyao@rock-chips.com>
>>
>> ---
>>   profiles/audio/avctp.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
>> index 8ad146df1..6199ee951 100644
>> --- a/profiles/audio/avctp.c
>> +++ b/profiles/audio/avctp.c
>> @@ -1597,12 +1597,6 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
>>          if (session == NULL)
>>                  return;
>>
>> -       if (btd_device_get_service(device, AVRCP_REMOTE_UUID) == NULL)
>> -               btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
>> -
>> -       if (btd_device_get_service(device, AVRCP_TARGET_UUID) == NULL)
>> -               btd_device_add_uuid(device, AVRCP_TARGET_UUID);
> Patch description makes no sense to me, this code is adding the UUIDs
> of AVCTP if the device over its PSM because at this point perhaps SDP
> discovery is not complete.
In the scenario encountered, the SDP service discovery has already
been completed, with the SDP record only containing AVRCP_REMOTE_UUID.
At this point, the device is added support for AVRCP_TARGET_UUID,
which leads to the following code being executed:
   controller_init(session);
     //avrcp.c:controller_init() 0x55bcdbd690 version 0x0000
     session->controller = controller;
However, avrcp_set_volume relies on session->controller, erroneously
issuing the AVRCP_SET_ABSOLUTE_VOLUME command.

Perhaps add a check to verify that SDP discovery has completed before
adding the UUID?

Additionally, there is another concern: is it appropriate to add support
for both AVRCP_REMOTE_UUID and AVRCP_TARGET_UUID before the completion
of SDP? if one of the UUIDs is not supported,how should it be handled?

>
>>          switch (psm) {
>>          case AVCTP_CONTROL_PSM:
>>                  avctp_control_confirm(session, chan, device);
>> --
>> 2.34.1
>>
>>
>

