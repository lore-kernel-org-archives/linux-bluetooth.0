Return-Path: <SRS0=Gzv7=AE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_HELO_IP_MISMATCH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1AFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422932080C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkTC8nW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgFWT7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733302AbgFWT7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 15:59:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30284C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 12:59:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so1848929wrw.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZ1iKlAc/IEocaLk2Xiy2KYcNQxdoRPt7Am/MmSokP4=;
        b=MkTC8nW5dc0alTbYXr7KZPEd94UEDagD4q/gQEjHLTr33hHfrmxv92jj8s/yie3h6c
         j+vUZVYcEbqwu4RasVJvpcUKAY41FMzcxE1NNendEgD9sdvoDI6HbCdb+oG8nZB15CLq
         L0emI0yd0PxySC0XKq04DWgnIBzFUAqnn/VzjjzHffGiNaLzCX32lzjB/afBxvOPnYi0
         dDpfzTwl2LGJzXE2jEqWBokzOxdGrnuDkNr46p2lsjSb67S20L9nLoM5QeP+d1CfxJju
         jXNCNuN7icJ11T3ixoKDzcLgXKP6Vm9f3cmXBeljW0M2e9O65uPe2AK8daYE76lsaBNb
         5ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZ1iKlAc/IEocaLk2Xiy2KYcNQxdoRPt7Am/MmSokP4=;
        b=Rw6hFFjW3S/2BeGRVemapPJQYShBDDzJhi6idqPdD96UTLImI3glZ2zBnk93LkiqTI
         PNMt7Ry1bo5FidO63mBaP7BMTawqY5m4HMIszOUiSXaDoVinsnChS28hymhtQ1dHURDm
         KVsdg/5SOqQytBxV4BcSbQalcjs4DLz5nWGL4T6vvdLItokZRvOJoFQaTA/HqDlN1syT
         mhzBGpM3eH64443qOB5V9waAsInQaXTgj6wpi+RRPN0zWamDwbujjnIYwMzmypbk2KDt
         cs5XgBCcNI7jNqEjdFYn108Lt5l91217MvIxR9xmcaDm7MHrhqEsfq0+OubxaSWplTqr
         cXMg==
X-Gm-Message-State: AOAM530C18pJrla10ViVxY80iRO8+TD8nH3Cn0SmBr6hHv1d4NdTRXsB
        dLg66OC/NFzDBvqEu+CT2Yk=
X-Google-Smtp-Source: ABdhPJxO+sUCMXnmaUcPaoNnBDI54kd0eAz/0OyT/yw6Mgrve/qmCzJZXKs3EXuLb3IGobB7+0NhCw==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr9715201wrv.177.1592942379844;
        Tue, 23 Jun 2020 12:59:39 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id r10sm7166494wrm.17.2020.06.23.12.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 12:59:39 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btusb: Fix and detect most of the Chinese
 Bluetooth controllers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
References: <0018a41a-5a46-2db6-5df2-e1b026b81bae@gmail.com>
 <AFE45DF6-8803-4613-9F7C-F9EB9894C4AD@holtmann.org>
From:   Swyter <swyterzone@gmail.com>
Message-ID: <90ead351-ef10-1fe4-21cf-b5913384786a@gmail.com>
Date:   Tue, 23 Jun 2020 21:59:58 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
In-Reply-To: <AFE45DF6-8803-4613-9F7C-F9EB9894C4AD@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 23/06/2020 8:08, Marcel Holtmann wrote:
> Hi Ismael,

Hi, Marcel. Thanks for reviewing my (first ever) patch.


>
>> PS: I'm wondering how flexible the new 100-column limit really is,
>>    I tried to trim the comment a bit but it looked ugly. :)
> 
> it might be in general for Linus, but here lets try to keep it at 80.
> 

Okay, understood. I'll keep in in mind for the second version. I was curious. 


>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 5f022e9cf..880fe46aa 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -1739,9 +1739,22 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>>
>> 	rp = (struct hci_rp_read_local_version *)skb->data;
>>
>> -	/* Detect controllers which aren't real CSR ones. */
>> +	/* Detect a wide host of Chinese controllers that aren't CSR. Some of these clones even
>> +	 * respond with the correct HCI manufacturer, and their bcdDevice tags are all over the place,
>> +	 * which may be another good angle to look into if we really want to have really long quirk lists.
>> +	 *
>> +	 * Known fake bcdDevices: 0x0100, 0x0134, 0x1915, 0x2520, 0x7558, 0x8891
>> +	 * IC markings on 0x7558: FR3191AHAL 749H15143 (???)
>> +	 *
>> +	 * But the main thing they have in common is that these are really popular low-cost
>> +	 * options that support newer Bluetooth versions but rely on heavy VID/PID
>> +	 * squatting of this poor old Bluetooth 1.1 device. Even sold as such.
>> +	 */
>> 	if (le16_to_cpu(rp->manufacturer) != 10 ||
>> -	    le16_to_cpu(rp->lmp_subver) == 0x0c5c) {
>> +	    le16_to_cpu(rp->lmp_subver) == 0x0c5c ||
>> +	    le16_to_cpu(rp->hci_ver) >= BLUETOOTH_VER_1_2) {
> 
> This check will also catch actually Bluetooth 2.0 and later made devices from CSR.

Yeah, you are right. I have been comparing HCI and lsusb dumps for this VID/PID
pair and I've found a much better way of distinguishing which is which.

Without breaking actual CSR chips. Turns out my dongle is legit.


>> +		bt_dev_info(hdev, "CSR: Unbranded CSR clone detected; adding workaround");
>> +
>> 		/* Clear the reset quirk since this is not an actual
>> 		 * early Bluetooth 1.1 device from CSR.
>> 		 */
>> @@ -1751,6 +1764,9 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>> 		 * stored link key handling and so just disable it.
>> 		 */
>> 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
>> +	} else {
>> +		/* Only apply these quirks to the actual, old CSR devices */
>> +		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>> 	}
>>
>> 	kfree_skb(skb);
>> @@ -3995,17 +4011,13 @@ static int btusb_probe(struct usb_interface *intf,
>>
>> 	if (id->driver_info & BTUSB_CSR) {
>> 		struct usb_device *udev = data->udev;
>> -		u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
>>
>> 		/* Old firmware would otherwise execute USB reset */
>> -		if (bcdDevice < 0x117)
>> +		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
>> 			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
> 
> Keep this as is.

Okay, makes sense. Keeps things tidy.

For the next version I think I'll keep all the quirk logic in the btusb_setup_csr()
function instead. As it will require to know bcdDevice, hci_rev, lmp_subver
and manufacturer in advance.


> 
>>
>> 		/* Fake CSR devices with broken commands */
>> -		if (bcdDevice <= 0x100 || bcdDevice == 0x134)
>> -			hdev->setup = btusb_setup_csr;
>> -
>> -		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>> +		hdev->setup = btusb_setup_csr;
> 
> Frankly, I rather add a switch statement and list all the known broken bcdDevice instead of trying to penalize real CSR devices.
> 
> Regards
> 
> Marcel
> 

Yeah, and I have also found a better list of bcdDevice elements. I looked a bit 
more in-depth and I have found out that there are actually three classes of 
controllers reusing the same 0A12:0001 VID/PID:

  * Old CSR Bluetooth 1.1 devices (BlueCore?):
      = bcdDevice < 0x117
      HCI_QUIRK_SIMULTANEOUS_DISCOVERY
      HCI_QUIRK_RESET_ON_CLOSE

  * New CSR Bluetooth devices CSR8510 A10 (BlueSoleil?):
      = bcdDevice with 0134 1915 1958 3164 4839 5276 7558 8891
      HCI_QUIRK_BROKEN_STORED_LINK_KEY

  * Unbranded CSR clone:
      = Their HCI chip uses a different manufacturer number;
        real CSR chips use manufacturer 10 and the HCIRevision
        and LMP Subversion always matches.
      No quirks, varies depending on the real manufacturer.


I'll post a more throughout explanation in the work-in-progress patch.
Thanks again for your time, I'll submit a second version in a jiffy.

Hopefully we can get this old issue sorted out without breaking anything. 

--swyter
