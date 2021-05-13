Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A2C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF63F611C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhEMPSI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 11:18:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32873 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhEMPSF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 11:18:05 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 74460CED28;
        Thu, 13 May 2021 17:24:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: btusb: Fix failing to init controllers with
 operation firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLEiBzgM=Ur6YuFCNWu0w3E5nYN4ZBmQm95V=s9W9D8Aw@mail.gmail.com>
Date:   Thu, 13 May 2021 17:16:52 +0200
Cc:     youling257 <youling257@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E8C3B5BB-502E-410D-84F9-74014A24D38A@holtmann.org>
References: <20210430230501.603111-1-luiz.dentz@gmail.com>
 <20210511042654.8549-1-youling257@gmail.com>
 <CABBYNZLEiBzgM=Ur6YuFCNWu0w3E5nYN4ZBmQm95V=s9W9D8Aw@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> I test this patch no help. rmmod btusb, modprobe btusb.
>> 
>> 
>> [    7.661739] Bluetooth: Core ver 2.22
>> [    7.661762] NET: Registered protocol family 31
>> [    7.661763] Bluetooth: HCI device and connection manager initialized
>> [    7.661767] Bluetooth: HCI socket layer initialized
>> [    7.661768] Bluetooth: L2CAP socket layer initialized
>> [    7.661772] Bluetooth: SCO socket layer initialized
>> [    7.686106] usbcore: registered new interface driver btusb
>> [    7.689317] iwlwifi 0000:07:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
>> [    7.689789] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
>> [    7.694911] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2
>> 
>> [  230.746397] usbcore: registered new interface driver btusb
>> [  230.750827] Bluetooth: hci0: Firmware revision 0.0 build 118 week 15 2021
>> [  230.756450] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2
> 
> The error shall be ignored in this case since it comes from
> request_firmware we can't prevent it, if you don't see another error
> after that means it can be ignored, that said perhaps we detect it
> sooner by either attempting to stat the file or perhaps check if
> revision comes back as all 0.

any reason you don’t use firmware_request_nowarn()?

Regards

Marcel

