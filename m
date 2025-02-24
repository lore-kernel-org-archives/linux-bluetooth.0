Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A81DE3AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434213; cv=none; b=Cl3fi08wR+MCW7zbAxcZGZ2SuxnruFDTP/lY38slP+3/AGIW1OZCMCsiq9rMqX0++n/wEVQ2B+sev4Oo3plcfNdp5tvIR2WVdYqf12+ciSZkrjx3SDKxt0yL0HtBAvQuplZ0KH9O9/e6Jr0d/NAJzL342eP7Dqi2T6EZJZ9Zkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434213; c=relaxed/simple;
	bh=Q6OY56ZoGEG/qRio48ZV5oDg6NS4ZaiJEDs4yZ4YQD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAR7T3z44exCx8z8/JWqVPP1b+EnCoVChwylgG53362tgvkEts3I3Da/hvySD/buew0OFIhDbjdlXs2ytxlgQQB9TbV5a/xZ2hTdVIlCG5TifSvxx2nQ2WOoXly/xGWwt3KbdUNar2MaHGtNz9bXDu00qXypU5kWTPKZ5depK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af521.dynamic.kabel-deutschland.de [95.90.245.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 58AE061E64788;
	Mon, 24 Feb 2025 22:56:43 +0100 (CET)
Message-ID: <611c7ddf-69d6-49c6-9e37-abf359307052@molgen.mpg.de>
Date: Mon, 24 Feb 2025 22:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: Fix regression in the
 initialization of fake Bluetooth controllers
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
 <20250222050439.1494-2-nishiyama.pedro@gmail.com>
 <95d0f052-c931-45f5-8212-60f9308a2672@molgen.mpg.de>
 <CANoxumjLBd5hfNb+FsXN68A0u3oCk96fJragB4LHVBt1TQ1Kqw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CANoxumjLBd5hfNb+FsXN68A0u3oCk96fJragB4LHVBt1TQ1Kqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pedro,


Am 22.02.25 um 07:35 schrieb Pedro Nishiyama:

> On Sat, Feb 22, 2025 at 2:29 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 22.02.25 um 06:04 schrieb Pedro Nishiyama:
>>> Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
>>> These features are falsely reported as supported.
>>
>> Please list the affected controllers.
>>
>>> Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
>>
>> As the summary/title says, that it’s a regression, could you please
>> elaborate, that it worked before, and how it regressed? Were these
>> quirks present before?
> 
> Sorry, I realized I put the wrong commit in the fixes tag. The error
> originated after
> commit c8992cffbe74 (“Bluetooth: hci_event: Use of a function table to
> handle Command Complete”).
> When the min/max length of the commands began to be checked. The clone
> I have here returns
> a smaller buffer than expected by the command.
> Since I'll need to fix the version tag, I'll put this information in
> the description in the next version.

Thank you for the reply and explanation. I also saw your v3 already. 
Awesome.


>>> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
>>> ---
>>>    drivers/bluetooth/btusb.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 8149e53fd0a7..903361456acf 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -2436,6 +2436,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>>>                set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
>>>                set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
>>>                set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
>>> +             set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks);
>>> +             set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks);
>>>
>>>                /* Clear the reset quirk since this is not an actual
>>>                 * early Bluetooth 1.1 device from CSR.

Kind regards,

Paul
