Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288CC2BA17
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937B206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 18:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDFSgf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:36:35 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60247 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 14:36:35 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9107DCECCA;
        Mon,  6 Apr 2020 20:46:08 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
Date:   Mon, 6 Apr 2020 20:36:34 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org>
References: <20200406180331.891822-1-marcel@holtmann.org>
 <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>> ---
>> doc/mgmt-api.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 96 insertions(+)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 39f23c456080..ac5b6c97d64a 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -3138,6 +3138,74 @@ Read Security Information Command
>>                                Invalid Index
>> 
>> 
>> +Get Device Flags Command
>> +========================
>> +
>> +       Command Code:           0x0049
>> +       Controller Index:       <controller id>
>> +       Command Parameters:     Address (6 Octets)
>> +                               Address_Type (1 Octet)
>> +       Return Parameters:      Address (6 Octets)
>> +                               Address_Type (1 Octet)
>> +                               Supported_Flags (4 Octets)
>> +                               Current_Flags (4 Octets)
>> +
>> +       This command is used to retrieve additional flags and settings
>> +       for devices that are added via Add Device command.
>> +
>> +       Possible values for the Address_Type parameter:
>> +               0       BR/EDR
>> +               1       LE Public
>> +               2       LE Random
>> +
>> +       The Flags parameters are a bitmask with currently the following
>> +       available bits:
>> +
>> +               0       Remote Wakeup enabled
>> +
>> +       This command generates a Command Complete event on success
>> +       or a Command Status event on failure.
>> +
>> +        Possible errors:       Invalid Parameters
>> +                               Invalid Index
>> +
>> +
> 
> Get device flags looks good to me.
> 
>> +Set Device Flags Command
>> +========================
>> +
>> +       Command Code:           0x004a
>> +       Controller Index:       <controller id>
>> +       Command Parameters:     Address (6 Octets)
>> +                               Address_Type (1 Octet)
>> +                               Current_Flags (4 Octets)
> 
> I would prefer to use a mask and value rather than current_flags here.
> 
>> +       Return Parameters:      Address (6 Octets)
>> +                               Address_Type (1 Octet)
> 
> Prefer to also return an updated_mask and current_flags. This
> simplifies completion for userspace. Otherwise, we would need to keep
> a "pending flags" value on the device structure.

I saw your “mask” proposal and I am not a fan of that. I want to keep the design of the API somewhat consistent. Hence the Device Flags Changed event should be send after Add Device completed and also after Device Added has been sent out.

One other option is to keep Get Device Flags as is and then instead of adding Set Device Flags, add one command per flag and rename Device Flags Changed to New Device Flags.

Set Device Wakeable Command
===========================

        Command Code:           0x004a
        Controller Index:       <controller id>
        Command Parameters:     Address (6 Octets)
                                Address_Type (1 Octet)
                                Wakeable (1 Octet)
        Return Parameters:      Address (6 Octets)
                                Address_Type (1 Octet)
				Current_Flags (4 Octets)

Maybe this is not a bad idea either and is similar on how we handle settings. I need to sleep about this.

Regards

Marcel

