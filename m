Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C15C4167B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E8D23407
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgLILRM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:17:12 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgLILRH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 06:17:07 -0500
Received: from [192.168.100.1] ([82.252.152.214]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTiHb-1khmNz10pR-00U2eJ; Wed, 09 Dec 2020 12:14:34 +0100
To:     Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
 <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: Bluetooth printer connection error
Message-ID: <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
Date:   Wed, 9 Dec 2020 12:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SnQMCylCz5RWRrbCDoUhtxpmODyqF+8xS2aOv5nj1Ak7MtTrkZg
 hY5CL3JYTU+UXKQr4JUwYwXc6uUGwL63dQNbPfCu9HYZpkFEb871OZ+U3Vn3pqB9aRiGyM6
 mEqFOLcQ7/2ctnEaNrLzU2xXijQClr+iKLcXS8mXKYoA6hzJW+YzCldYPR9EZUg1cHGiTeZ
 RihKhd/C+KBtSHjuhV1ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pAeZHpbG/WA=:CvtOAZgoqcclHOCUIIJ0aX
 5RntHoB3V0JXVCoolO5XgqQaDdjzGiX2BpV5B+sPEKAAvDgtRdxF2krnvfIDmhywFETIdEnDK
 3cE8ln/NhMy0aywM7I78i2G2Z1Tnvx+RobzulO7x2bSGPParGZB7KT1syxvBkMdqcR86RDqi2
 Rw7nVHxWxlDcUeSDEAz1o2L+nlPd0AzgFVfnPzkqH1hcmQyqROmgoH+1CbK6/6rn4i3HeiP3t
 k733PXztGhhse1C1JqgueoMe4Q45bSxQuXEkGbHlB++Jaj2qiIwyXUzNPqlj8SXveW82OoGlF
 0l0rBFF+u9RCla8Wdrq/O15oNDdB28V++IH0IRBdTaBnnzGG7Y7V/E/waUy14ToJDDR28saQo
 kxYe9ex/AZPBsbI8EqaA85hfjQOEpGH8Q5+5/kwn9I2Ivj3xV+rsvhNKjpvpMqz338jH0dEzE
 pWL6MhXvqw==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Le 09/12/2020 à 12:00, Bastien Nocera a écrit :
> On Tue, 2020-12-08 at 22:25 +0100, Laurent Vivier wrote:
>> Hi,
>>
>> TL;DR:
>>
>> I can pair my bluetooth printer but it fails to connect:
>>
>>   $ bluetoothctl connect DC:0D:30:90:23:C7
>>
>>   Attempting to connect to DC:0D:30:90:23:C7
>>   [CHG] Device DC:0D:30:90:23:C7 Connected: yes
>>   [CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
>>   Failed to connect: org.bluez.Error.NotAvailable
>>
>> What do I need to add to my system to have this working?
> 
> As I mentioned in the original bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=1904686
> 
> I don't expect the "connect" command to do anything. There's nothing to
> "connect" to, as bluez doesn't create rfcomm device nodes automatically
> when "connecting" to devices with serial profiles (otherwise one
> couldn't connect to them with other applications without going through
> the device node...).

Yes, I didn't understand what you meant...

My question is: what piece of code I need to write or modify to have the
"connect" operation working?

> If the printer has uses the SPP or HCRP printing profiles, you should
> see it when using:
> /usr/lib/cups/backend/bluetooth
> without any arguments.

As I don't see it once it is paired, I guess it is not using one of
these profiles.

> Otherwise any apps or driver that supports the printer should be able
> to create a serial link directly to the device without creating a
> device node in /dev.
> 
> FWIW, looks like the printer uses a proprietary protocol between their
> own app and the printer, and that they don't provide Linux support.
> Short of reverse engineering that protocol, the printer is unlikely to
> work with Linux.

I've written the CUPS driver that works fine with the rfcomm device.
In fact, it's not proprietary, it's ESC/POS protocol.

https://github.com/vivier/phomemo-tools

I'm working on my code to use python-escpos rather than my hack and I'd
like to integrate smoothly the printer in the bluetooth stack.

It works also with USB, but it's a shame not to use bluetooth with a
printer that has an internal battery.


Thanks,
Laurent
