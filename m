Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D71152187
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165569; cv=none; b=ozaf5/b6Js7bvD1YEhlB8OcfJQErv6p1T+IF3hmMSTDjb1NebMVrAojdShMP8h76qceCbliforicvRcNLa28m7qXk8kOFNwyoJCji0zkd4X9U+IHZr3RWJo7vf9zVFtxPhKeZBorYl2kZFEHgpZRmmvssbp7cRjFWiOeUV5eJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165569; c=relaxed/simple;
	bh=p2MY0oYE0BdehlhQIU11n7CS8rT0srtYbxj/rlbgyFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRjiqYEHleE5chL6TM2fve1W8u42zijyWwXM6ahazkaHrFWWjog/uRDuP/Y/hqGvAwaajlDPkjvZwoB9fVuSqSU3Pn7M0jQzimj4IZM02a61HKx3b/CwPi8353RJK3Kt4ZgTVO8jQOEWQ47godt+ePXIcFCS+AHlQqDWFUmuawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=TgA0gmhU; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="TgA0gmhU"
Received: from [192.168.42.20] (p5b164b56.dip0.t-ipconnect.de [91.22.75.86])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 97EF12FC0064;
	Wed,  3 Apr 2024 19:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712165563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsYtlgX4H8Lnf7nDA9d4DGU/VUChSBTFLvN8JaBLeRw=;
	b=TgA0gmhUevA0S4Kxdm9gW+flq6i83Xn12Lcb68d4XaukfIQlqNsmw9ytVeMEAlc9xLvfcI
	WYUD8MqOlP16kScWTIorr3Gml4vYlRrDHLMWbLWKu6JYf/ykZYfcWnV9nuPDv7SLOCN73t
	cjZBl22VM6rcVrW1J/bdQbio6dwfpVA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d32c669a-3782-49ef-9ece-e654bbb82123@tuxedocomputers.com>
Date: Wed, 3 Apr 2024 19:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
 <CABBYNZ+OaJ9QVE_KmBNL8QbBv4r5erL57u3BzFv0AnmUzY=PTA@mail.gmail.com>
 <29d54137-f3b9-4556-b99e-61a0f681f164@tuxedocomputers.com>
 <0fd88d1ed7704938f54460e0e42a2f934690bf01.camel@iki.fi>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <0fd88d1ed7704938f54460e0e42a2f934690bf01.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 02.04.24 um 19:16 schrieb Pauli Virtanen:
> pe, 2024-03-29 kello 00:20 +0100, Werner Sembach kirjoitti:
>> Hi Luiz,
>>
>> Am 28.03.24 um 15:17 schrieb Luiz Augusto von Dentz:
>>> Hi Werner,
>>>
>>> On Thu, Mar 28, 2024 at 9:18 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>>> From: Christoffer Sandberg <cs@tuxedo.de>
>>>>
>>>> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
>>>> connection issues when enabled. This patch disables it through
>>>> the existing quirk.
>>>>
>>>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>>    drivers/bluetooth/btintel.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>>>> index cdc5c08824a0a..6dbfb74d0adf9 100644
>>>> --- a/drivers/bluetooth/btintel.c
>>>> +++ b/drivers/bluetooth/btintel.c
>>>> @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>>>>           case 0x17:
>>>>           case 0x18:
>>>>           case 0x19:
>>>> +               /* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is enabled */
>>>> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
>>> If it is just these 3 then we are missing a break here.
>> The cases are not added by the patch, the fallthrough was here before. This
>> patch just adds this quirk for these 3 cases on top to the other things done
>> below, aka the fallthrough is intentional.
> See
>
> https://docs.kernel.org/next/process/deprecated.html#implicit-switch-case-fall-through
Thanks for the link, will add the explicit fallthrough in a v2.
>
>
>> Best regards,
>>
>> Werner
>>
>>>>           case 0x1b:
>>>>           case 0x1c:
>>>>                   /* Display version information of TLV type */
>>>> --
>>>> 2.34.1
>>>>
