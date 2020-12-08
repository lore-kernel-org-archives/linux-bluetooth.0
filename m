Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DAEC4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 21:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7823B1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 21:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgLHV1s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:27:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLHV1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 16:27:48 -0500
Received: from [192.168.100.1] ([82.252.152.214]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MiIhU-1kGAsk2zZu-00fR0h for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec
 2020 22:25:16 +0100
To:     linux-bluetooth@vger.kernel.org
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Bluetooth printer connection error
Message-ID: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
Date:   Tue, 8 Dec 2020 22:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a3cy5OvoWr98REq5CVtd4QZc5axTjNCfJfU1hlqnYvQTaI4fude
 QIibP/IK4xUQK9C7YAGk4xwyZRwy6sHRphKMxfXHaoYFsox3RhHkxcT+1vOU0qWBoDgoOJe
 6BPDIDnkn9rVZA4lB7NiNXPQxlo9GSZUpp/b8iInRJdpFzgBZjooHwaoVzDclU1h7hbVvn4
 2oKJWHaYNtuHq9hH3wPZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IDwZhaNGnIg=:4pSWZxR9lcW4m0sJTl3tK5
 gt1G/g0jSeDW3fJauixYwWmAUtlcZm0X+KReE9rQpICVRWjLe45X2lfq7bNUpf14EDAjBWM+X
 FmyswfMejRuhPMof9lK8eXl6n3NBiz372/zPlrWeCaAUWkUyUTXL0ZodvGMgaGtp/33TYCUi8
 XUgoIw2NQtMp2wUfVkYQk6IA4ZphH7+Xe1a/IfUGwMWYbXSl1nqja+C+RkpPyL66WirJM9Z2A
 9gf9H7v7zrXbK6gIw9EFit4tRURFzzFsMx/f3SV0Rsfaoc10tTJGQCYGwvLmbwCVdHQkkljyL
 ynUEYxvZpBv3JxafGmurSyDnQ0FcrG8D1wGLxP5ML2RRFjM12qWmBXfBYtIoDi8oBLHiWwMqG
 dCEn2WcyQdb74X9z/iwxu/d7imcCzosQfP7YElp6nZT2p7JW6VaOP5JaOEgC2W+Ev4sldDlz3
 GCjNAVZt9E7q5aeYfIzWBQzSUwELGWTeaiYu5y7U4yghkqGY2G5k
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

TL;DR:

I can pair my bluetooth printer but it fails to connect:

  $ bluetoothctl connect DC:0D:30:90:23:C7

  Attempting to connect to DC:0D:30:90:23:C7
  [CHG] Device DC:0D:30:90:23:C7 Connected: yes
  [CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
  Failed to connect: org.bluez.Error.NotAvailable

What do I need to add to my system to have this working?





----------------------------------------------------------------------
The full story:

I cannot connect my bluetooth printer using "bluetoothctl connect" (I'm
testing with git commitid b446ed8e8).

1. Start the bluetooth printer
2. bluetoothctl devices

Device DC:0D:30:90:23:C7 Mr.in_M02
...

3. bluetoothctl info DC:0D:30:90:23:C7

Device DC:0D:30:90:23:C7 (public)
        Name: Mr.in_M02
        Alias: Mr.in_M02
        Class: 0x00040680
        Icon: printer
        Paired: no
        Trusted: no
        Blocked: no
        Connected: no
        LegacyPairing: yes
        RSSI: -81

4. bluetoothctl pair DC:0D:30:90:23:C7

Attempting to pair with DC:0D:30:90:23:C7
[CHG] Device DC:0D:30:90:23:C7 Connected: yes
[CHG] Device DC:0D:30:90:23:C7 UUIDs: 00001101-0000-1000-8000-00805f9b34fb
[CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
[CHG] Device DC:0D:30:90:23:C7 Paired: yes
Pairing successful

5. bluetoothctl info DC:0D:30:90:23:C7

Device DC:0D:30:90:23:C7 (public)
        Name: Mr.in_M02
        Alias: Mr.in_M02
        Class: 0x00040680
        Icon: printer
        Paired: yes
        Trusted: no
        Blocked: no
        Connected: no
        LegacyPairing: yes
        UUID: Serial Port
(00001101-0000-1000-8000-00805f9b34fb)


6. bluetoothctl paired-devices

Device DC:0D:30:90:23:C7 Mr.in_M02

7. bluetoothctl connect DC:0D:30:90:23:C7

Attempting to connect to DC:0D:30:90:23:C7
[CHG] Device DC:0D:30:90:23:C7 Connected: yes
[CHG] Device DC:0D:30:90:23:C7 ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable

If I use hcitool/rfcomm I can send data to the printer. It works fine in
this case.

$ hcitool scan
Scanning ...
        DC:0D:30:90:23:C7       Mr.in_M02

$ sdptool  browse DC:0D:30:90:23:C7
Browsing DC:0D:30:90:23:C7 ...

$ sdptool records DC:0D:30:90:23:C7
Service Name: SPP Dev
Service RecHandle: 0x10001
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

^C [the command hangs here]

$ sudo rfcomm connect 0 DC:0D:30:90:23:C7
Connected /dev/rfcomm0 to DC:0D:30:90:23:C7 on channel 1
Press CTRL-C for hangup

Thanks,
Lauren
