Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB58C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DCA221F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 21:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLVVGx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 16:06:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59283 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgLVVGx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 16:06:53 -0500
Received: from marcel-macbook.holtmann.net (p4ff9fbc9.dip0.t-ipconnect.de [79.249.251.201])
        by mail.holtmann.org (Postfix) with ESMTPSA id 33E4DCECC3;
        Tue, 22 Dec 2020 22:13:29 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJcUJKTgzrv0Tw+8M41SsAZohAYrYYDbhEr5BuGgKahiQ@mail.gmail.com>
Date:   Tue, 22 Dec 2020 22:06:10 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <699D4C67-1E6B-4AE9-8F9C-A8854F84CFC8@holtmann.org>
References: <20201222124651.101063-1-marcel@holtmann.org>
 <CABBYNZJcUJKTgzrv0Tw+8M41SsAZohAYrYYDbhEr5BuGgKahiQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> ---
>> doc/mgmt-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 86 insertions(+)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 1736ef009e75..47686ae32629 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2187,6 +2187,7 @@ Read Controller Configuration Information Command
>> 
>>                0       External configuration
>>                1       Bluetooth public address configuration
>> +               2       Runtime firmware configuration
>> 
>>        It is valid to call this command on controllers that do not
>>        require any configuration. It is possible that a fully configured
>> @@ -3132,6 +3133,10 @@ Read Controller Capabilities Command
>>                0x02            Max Encryption Key Size (BR/EDR)
>>                0x03            Max Encryption Key Size (LE)
>>                0x04            Supported Tx Power (LE)
>> +               0x05            Complete firmware name
>> +               0x06            Shortened firmware name
>> +               0x07            Firmware info string
>> +               0x08            Hardware info string
>> 
>>        Flags (data type 0x01)
>> 
>> @@ -3155,6 +3160,23 @@ Read Controller Capabilities Command
>>                field is not available, it indicates that the LE Read
>>                Transmit Power HCI command was not available.
>> 
>> +       Firmware name (date types 0x05 and 0x06)
>> +
>> +               Only one of these will be present if the device is loading
>> +               some sort of runtime firmware. Only in the firwmare name
>> +               happens to exceed the 255 charaters, the shortened type
>> +               shall be used.
>> +
>> +               This value represents the driver chosen default firmware
>> +               for a controller. In case it is changed via Set Runtime
>> +               Firmware command that change will not be reflected here.
>> +
>> +       Firmware and hardware info (data types 0x07 and 0x08)
>> +
>> +               When provided by the hardware and the driver, these fields
>> +               will contain string of the firmware or the hardware for
>> +               debug or indentification purposes.
>> +
>>        This command generates a Command Complete event on success or
>>        a Command Status event on failure.
>> 
>> @@ -3852,6 +3874,70 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
>>                                Invalid Parameters
>> 
>> 
>> +Set Runtime Firmware Command
>> +============================
>> +
>> +       Command Code:           0x0057
>> +       Controller Index:       <controller id>
>> +       Command Parameters:     Action (1 Octet)
>> +                               Firmware_Length (2 Octets)
>> +                               Firmware (0-65535 Octets)
> 
> My only concern with this command is that it seems to limit the
> firmware size to 64K which perhaps is too small going forward in time
> I suspect we might need 128K or even 256K if we want to be safe, so
> perhaps it would be a better alternative to just have a different
> location given which perhaps is even easier to parse given that by
> default the drivers already load the firmware as a file so much of the
> logic about uploading the firmware remains the same with the only
> difference being the location. Btw, if we do change this to be file
> based I guess it could be updated in the Firmware name which would
> probably be great for the likes of bluetoothd so it can identify if an
> alternative firmware has been loaded and skip loading it again, though
> perhaps you intended the info to be used to match the loaded firmware
> the problem with that is then the likes o bluetoothd will need to be
> able to parse the firmware files to be able to tell if the info
> matches.

right, I was thinking this is filename used in the request_firmware(). However now I remember that we talked about passing the actual blob via mgmt for development purposes. Now doing an actual blob loading larger then around 63k is impossible with mgmt since our frame size field is only 16-bit.

Seems like I have to go back to thinking board.

Regards

Marcel

