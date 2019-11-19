Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80882C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B06222D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIolBxGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfKSJVf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:21:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56027 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfKSJVf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 04:21:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2309659wmb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2019 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iWRnqXG9dU1icNm86Zp4oZIPcGtpMH+JgYjZRSXsV5k=;
        b=BIolBxGU/R9Rmiau8XtohUzeu31mwmBj+FpZ8PqKhdSVlSIpV22RV4qfYi3xNvy6kp
         I4v6EVwOk6E0PvdEZVGqxPX8K453XDmcEsZ+cxNGGgBqMvi/pRpgdFV5gAHm9pnKOc0F
         fadtWnW4kR9vrxYzezVbEMKFuxydZTllZHIU7e1IVkZx7B4aYiv4EESqRTMuqY3aVUEB
         +IQEuRHre9EIpnyyIdlrCR5J2Cjgmcjj5kEHVIJ193FLAlbvNrxQ7r13TFxaL+uzOLrO
         oSnC0YV7o+WwnLshIuslNaaoug0kHnkygjL/i7f3ZvqGr/Z0evWYjaaDhBBRkUbWm4M2
         s+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWRnqXG9dU1icNm86Zp4oZIPcGtpMH+JgYjZRSXsV5k=;
        b=YTvL2vqpyPThbtCRf2rrdpEbecTe+VHv9pnGtLOhLEtZDOH2dH40ms3PBZzC3h0e2V
         HTOP2vy4APZAmL2a3Q/+I77c5AeL2k+Wl5r+1rc7fXtT+cBZGo+bDnZ33JIYdG5KBk5S
         D7UlC6nukB25dgKlzrsJ1BEvkg2d3O1L8T4cWgmFrgHetAN0e1cG3k29RG/p4Ar6two5
         Qbd7oAf6BKs8Em2w7WOcrY+amS7sQt3ud9ohK2u3GXP2vQv7d6kKBvaU4GAA5IBK66ju
         hunZBlocfH70mDAWN8lZjldICPeL9l0qkXqzyVudeaU2A/Vjp4RbF+tHelhLF6pzuKuD
         S11g==
X-Gm-Message-State: APjAAAUNRH1D1TUslkK0pFpNcL8Ge3RMARUP+DkBqrSEuT22aeKYTwWJ
        J7VGBxl3O2VQ/en+1K0TkhwFaP3D
X-Google-Smtp-Source: APXvYqzrmFFB9I9zfLKw8kMQcYeTyPOarZ5OOQyeDJ49tv/ybWFsCnAE5bQD5r8qqu4jLzAc/ELYzg==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr4569484wmk.62.1574155293170;
        Tue, 19 Nov 2019 01:21:33 -0800 (PST)
Received: from mamamia.internal (a89-183-91-150.net-htp.de. [89.183.91.150])
        by smtp.gmail.com with ESMTPSA id a2sm22872362wrt.79.2019.11.19.01.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 01:21:32 -0800 (PST)
Subject: Re: [PATCH v2] bluetooth: bcm: Use HCI_QUIRK_USE_BDADDR_PROPERTY
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <20191119060221.3297340-1-a.heider@gmail.com>
 <4DB6C9B7-8454-449C-90B4-4A1B3AD82495@holtmann.org>
 <e813a126-f0fc-afe8-ad4c-5296f0a2dc06@gmail.com>
 <F632534C-C9CC-4F4F-AA58-F4FC053D4226@holtmann.org>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <ffa83108-2c0f-26eb-3860-892f65a6e9bd@gmail.com>
Date:   Tue, 19 Nov 2019 10:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <F632534C-C9CC-4F4F-AA58-F4FC053D4226@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 19/11/2019 09:16, Marcel Holtmann wrote:
> Hi Andre,
> 
>>>> Some devices ship with the controller default address, like the
>>>> Orange Pi 3 (BCM4345C5).
>>>>
>>>> Allow the bootloader to set a valid address through the device tree.
>>>>
>>>> Signed-off-by: Andre Heider <a.heider@gmail.com>
>>>> ---
>>>> drivers/bluetooth/btbcm.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>>>> index 2d2e6d862068..9d16162d01ea 100644
>>>> --- a/drivers/bluetooth/btbcm.c
>>>> +++ b/drivers/bluetooth/btbcm.c
>>>> @@ -439,6 +439,7 @@ int btbcm_finalize(struct hci_dev *hdev)
>>>> 	btbcm_check_bdaddr(hdev);
>>>>
>>>> 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>>> +	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>>>
>>>> 	return 0;
>>>> }
>>> have you actually tested this? I might be mistaken, but the code that I read in hci_dev_do_open() would drop this into unconfigured state since HCI_QURIK_INVALID_BDADDR is still set.
>>
>> I thought so, but double-checking something obviously failed...
>>
>> What would be an acceptable solution to this HCI_QUIRK_USE_BDADDR_PROPERTY|HCI_QUIRK_INVALID_BDADDR situation?
>>
>> Getting rid of the quirk in the driver in e.g. set_bdaddr() doesn't sound right.
>>
>> How about:
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 04bc79359a17..7bc384be89f8 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1470,7 +1470,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>          * start up as unconfigured.
>>          */
>>         if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
>> -           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
>> +           (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
>> +            !test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)))
>>             hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
>>
>>         /* For an unconfigured controller it is required to
>>
>> That works for me (double-checked this time ;)
> 
> I am not sure yet. I mean we define what HCI_QUIRK_USE_BDADDR_PROPERTY actually means. Right now it means this:
> 
> 1) Run though ->setup
> 2) If no public BD_ADDR is set, then try to read from DT
> 3) If found, try to set, if set fails, abort dev_up
> 
> Now there is also another problem that no public BD_ADDR means BDADDR_ANY right now. Which means, for Broadcom chips that is never the case. So HCI_QUIRK_USE_BDADDR_PROPERTY doesn’t even work since their invalid addresses are not BDDADDR_ANY.
> 
> The first change needs to be something along these lines:
> 
>                  if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> -                       if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> +                       if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
> +                           test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks))
>                                  hci_dev_get_bd_addr_from_property(hdev);
> 

Maybe I misunderstood, but just for the record: It works for me even 
without this hunk (with just my hunk above and the v2 bcm patch). The 
bdaddr via dt is used and the controller works without any userland 
interaction.

> But that is not fully correct either. We also have to consider HCI_QUIRK_NON_PERSISTENT_SETUP.
> 
> So this is not an easy fix since we need to spell out the semantics of the interactions of these 3 quirks first.
> 
> Regards
> 
> Marcel
> 

