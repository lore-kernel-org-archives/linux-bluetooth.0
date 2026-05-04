Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115A3F0ABD
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922122; cv=none; b=Lw9LkHlRhHab18jKCl6XpiwzW+6wZhh9kutOGYcj+t3KwNUH8zHsGKgdEygsJUp1ONo4eS/evsaIM2dLgpam/0aHm1eoDcC4zzPUMa18ys8tP1nx4sKa/DjKHF1pZb6g/y5f2MFjFNcP3XKazGE30Y66wX8FJTaxckyPrwqbLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922122; c=relaxed/simple;
	bh=FFrSjGwnCtxxwXfZRZwIggvLznEua3M4D0NmJppo3vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y10xsY6hKCZhYXhNdztOXm5Iu01ezw63gV0n/lUnbKn+9IMEv9MpNgOO+roU06T1Fmvsbf9oztlKWZ5Ceb+SM085+QdWLlLtmkIT6u68wdPp9m3LcQdXiSx18FL9QfGimVYzp0zxS8E20TTyNA+Jz9ocka0ibcNcfCocY9smxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNezXvK6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNezXvK6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f15e900586so216273785a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777922120; x=1778526920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bHM58iZB/5xfd8+kwVFVIpH2DE/utsDRP2HGxHR2Jo=;
        b=rNezXvK6Znw0XilODGIkt8bCoG96n+w90MrpGgCEBGUGa2se4Y22DSseMBsMkK13Xb
         joJ24xOxVWcL7hg5VBYLl5AhM7cgHcckA7Js5xsKQchsGUVOu7bcI8qS7ZMc3eF/9dHK
         udrxeOZpBKCP75DGI9B55/jc7/A9mih1EipVJO0WQpTc8gHGond8oqqu3uqH1+kjPaXs
         rNIPKP8zxDeraXGEkC4petuYFCzEZ01cNfTcadYI34cUZaTHOIN3SOg0ZaDWWZJq0fdf
         UKO62NHxVA2BQ9KWURRHbSn4Viz58rsug0z/Ytk/LO8kTjGBfIJk7FGqKlxW6rhMG9Ku
         qVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922120; x=1778526920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bHM58iZB/5xfd8+kwVFVIpH2DE/utsDRP2HGxHR2Jo=;
        b=mbw90l+HCeQn5PYmH7JxXAlIewHZ/GGlYUNulksEXBnZisw440CVF+9JdS/+jwE0w8
         w5vQmUZqFCHKvfLVrw+IO8TPeJHSA3VDOG2x+GybcXTYs5eeG6cVwTOlu8fuaYvwcPJ5
         2tWmSjhc+rH/KknhUqc6k8JIn0nzT1v8Sp6uYvIYkpqgG29lLJuyROPbP+EgaktdigV+
         HziKwANMDFZZQQBn1W2FaJNYf+nonzhonjZJRC/HXlAADItPTBI2dfYcw1a8r3gffsYI
         zniHBOCM5TwJa+MmbAO1DPde02pn3kBAul59xOWDuUhwqerZjsr0khw6SK1hMAc8iqw8
         OTvw==
X-Forwarded-Encrypted: i=1; AFNElJ+IMGGMeDsVTxnpQVc83iNVhv7gENQi/l8/FZIs9tNZ7D8vLN+A+JdkBHxUto5nmtH9HSTUkCmebeqaZlt0jF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkl5KnxyRgy4+fTUD6d8YMeE+AkecPaev+0FK37jFLWIbBHCu8
	MHAiwVxhciIdz3gnE4N8Tdf9yj8DzgLpw8vzwBTLgDgzHiC18ZwU+aGEQf2ndEbn
X-Gm-Gg: AeBDiesK/vFUAYK1SwngWmzMKOiEBSv0kIMNnTAXUgTWrJxjzUvQBmxoRtnBpUkjyLQ
	ls8hwWvum2d7TD1iYDccGRQirIjY9EWZqG8BqJ+Zh7MbjKgL/5HqCfbuwhDTaOD1K5FidkqtiQP
	OVZARcBvQKOu8456j7UCx2Oz/I8ujgtDsVX/b580fLd9Vxb2yyKS0OYD99vNTuye+MjIMzaYK0B
	sYLzACpRPO0Qya+caiR/OHzsmMYJnv1LjBlPqsPJ/eL//ePacBhKDURrHm3k8hEow7Ecbq+v34s
	2JqyPLT+l2FzKJEZMPYYRxjg/ajhtBUbnbJMy37hSwkDffy/PZ8NeEr9HXTVQILbpx2qoIJ+dw7
	Awcun/1WFWFJfq7eAYEXaPDRWQuQJ+m2GUmuUg4w02R7GXnBHRa2i/mYWrIgempxsb5RgbfBG4g
	PXrBwvFpgdvl0kV5Z0pj1OCI13mlAeickNvYuNuG0=
X-Received: by 2002:a05:620a:7106:b0:8ed:d6df:c779 with SMTP id af79cd13be357-8fd181377fdmr1610514685a.35.1777922117782;
        Mon, 04 May 2026 12:15:17 -0700 (PDT)
Received: from [10.31.149.146] ([18.29.39.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm1240238785a.32.2026.05.04.12.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 12:15:17 -0700 (PDT)
Message-ID: <76904540-af95-4f8e-897d-845112094512@gmail.com>
Date: Mon, 4 May 2026 15:15:16 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Bluetooth: fix Set Public Address on controller in
 HCI_AUTO_OFF grace period
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430045522.7881-1-danilklishch@gmail.com>
 <CABBYNZKEqRW-7U7y0id8EmFB3LVxaU+FUO6g4AqkuDG_-T6bOg@mail.gmail.com>
Content-Language: en-US
From: Dan Klishch <danilklishch@gmail.com>
In-Reply-To: <CABBYNZKEqRW-7U7y0id8EmFB3LVxaU+FUO6g4AqkuDG_-T6bOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 5/4/26 2:27 PM, Luiz Augusto von Dentz wrote:
> Hi Dan,
> 
> On Thu, Apr 30, 2026 at 12:55 AM Dan Klishch <danilklishch@gmail.com> wrote:
>>
>> When mgmt's Set Public Address command (and Set External Configuration)
>> stages a configuration change, set_public_address() sets HCI_CONFIG and
>> HCI_AUTO_OFF on the device and queues hci_power_on. The intent is for
>> the queued power_on to run hci_dev_init_sync() -- which detects
>> HCI_CONFIG and calls hdev->set_bdaddr() to program the new address into
>> the firmware -- and then re-emit Index Added with the controller back in
>> the boot-init grace period (HCI_UP=1, HCI_AUTO_OFF=1) so userspace can
>> re-push pending config commands and drive a fresh Set Powered 1 cycle.
>>
>> The bug bites when the command is issued while the controller is in
>> that same grace period itself -- the normal post-boot state, before
>> bluetoothd has claimed the controller via Set Powered 1. In that state
>> HCI_UP=1 and HCI_AUTO_OFF=1, so hdev_is_powered() is false (the command
>> is accepted) but hci_power_on()'s "already up" early-return condition
>> HCI_UP && HCI_MGMT && HCI_AUTO_OFF is true. The early-return path runs
>> hci_powered_update_sync() -- which is the wrong thing for this case:
>> neither hci_dev_init_sync() nor mgmt_index_added() runs. The result:
>>
>>    - hdev->public_addr is recorded but never reaches the firmware via
>>      hdev->set_bdaddr(),
>>    - userspace sees Index Removed (from set_public_address) but no
>>      Index Added, leaving the controller invisible to mgmt clients;
>>      it is not in the configured, unconfigured or extended index list
>>      yet remains registered in the kernel.
>>
>> The other two starting states are fine: HCI_UP=0 falls through to the
>> full hci_dev_do_open() path (correct); HCI_UP=1 with HCI_AUTO_OFF=0
>> makes hdev_is_powered() true, so set_public_address() rejects with
>> MGMT_STATUS_REJECTED before queueing power_on at all.
>>
>> Fix: at the top of hci_power_on(), if HCI_CONFIG is pending and we are
>> in the affected grace-period state (HCI_UP, HCI_MGMT, !HCI_RFKILLED),
>> close the device first. The early-return condition then fails and we
>> fall through to hci_dev_do_open() -> hci_dev_init_sync(), which honors
>> HCI_CONFIG by invoking hdev->set_bdaddr(); the post-open block then
>> re-emits Index Added via the existing HCI_CONFIG branch.
>>
>> hci_dev_close_sync() clears HCI_AUTO_OFF as a side effect of going
>> through the regular power-down path, but set_public_address() had set
>> it deliberately so the post-reopen state matches the boot-init grace
>> period that mgmt clients expect ("treat as new one" per the protocol
>> contract). Several mgmt commands -- Set Privacy, Set Wideband Speech,
>> Set LE, Set BR/EDR, etc. -- gate on !hdev_is_powered(), and bluetoothd
>> expects to push them during this window before issuing Set Powered 1
>> itself. Restore HCI_AUTO_OFF after the close so hdev_is_powered() ==
>> false again.
>>
>> This matches the documented behavior for Set Public Address on a
>> fully-configured controller ("Once the address has been successfully
>> changed an Index Added event will be sent.")
>>
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Dan Klishch <danilklishch@gmail.com>
>> ---
>>   net/bluetooth/hci_core.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -948,6 +948,14 @@ static void hci_power_on(struct work_struct *work)
>>
>>          BT_DBG("%s", hdev->name);
>>
>> +       if (hci_dev_test_flag(hdev, HCI_CONFIG) &&
>> +           hci_dev_test_flag(hdev, HCI_MGMT) &&
>> +           !hci_dev_test_flag(hdev, HCI_RFKILLED) &&
>> +           test_bit(HCI_UP, &hdev->flags)) {
>> +               hci_dev_do_close(hdev);
>> +               hci_dev_set_flag(hdev, HCI_AUTO_OFF);
>> +       }
>> +
>>          if (test_bit(HCI_UP, &hdev->flags) &&
>>              hci_dev_test_flag(hdev, HCI_MGMT) &&
>>              hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
>>
>> ---
>>
>> Claude was able to fully convince me that the patch and the explanation
>> are correct. Moreover, this indeed fixed a problem I had with a custom
>> patched bluetoothd that happened to override public-addr in the 2
>> second post-boot window. However, both the patch and commit description
>> are fully AI-generated.
> 
> This doesn't inspire much confidence, though. Have you at least tried
> it yourself? Perhaps we need to ask Claude to first add a test to
> mgmt-tester to ensure it actually fixes something rather than just
> hallucinating. Most models are not actually very critical of their
> proposals if there is nothing to validate their claims with.
> 

I did test this indeed. The bluez patch I mentioned:
https://gist.github.com/DanShaders/4d280096a5f0f2f45ce07028cbd36761
(this is yet another AI slop, sorry!; I just wanted something quick for
myself). Without the kernel patch, MGMT_OP_SET_PUBLIC_ADDRESS is just
silently swallowed, adapter is removed, and then the userspace never
sees it again.

Claude says it cannot easily add an in-tree test for the patch without
additional changes in vhci to support setting public address. Should I
tell it to do a 3 commit series (set public addr on vhci; this; a test)
and send as V2?

One more question: seems like CI is angry on me because I included the
`Assisted-by: Claude:claude-opus-4-7` tag as per
https://docs.kernel.org/process/coding-assistants.html . Should I remove
it?

(Resending since I accidentally chose "Reply" instead of "Reply All" the
first time, I'm not very used to mailing lists)
