Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 10:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AC360E09
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGZKQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhGZKQI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 06:16:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D7C061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 03:56:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oz16so7246477ejc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=52DWTy9iIz9fNDflVc/w1UTO/73ieM2WoTDwOVNsWSI=;
        b=ABWld91ReceeyxGXC9sxmgZ7GX0lud7VCKgYfZz+mkbONmFU2zL1OVyBOj1RsiM85m
         3Ew/ppCEYomxr0ChZ4WvPkyDFXGqpAwOeoOGC3+sbhyYSOpMuGx7bujyNkfhZPTcBIRT
         pNc91KqoIasNQKAjsZIzUcIpo/0+b14Ln+9Y89aISIIKNhnogZZWfjvDDgYXthlLmR7S
         gO5rV6PzinHouNoUgCLJwx8lBihdHY+IEJ07a78jiUJ9HqwiNpLKIQ3NfBjyKhFTtfnf
         LmawPFXBHKVdzBwY0itQfenn/3tdgyQqVA7b4LIIPuXCJebBRZ6DBZxt5U52fzI5OjH9
         BYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=52DWTy9iIz9fNDflVc/w1UTO/73ieM2WoTDwOVNsWSI=;
        b=j0/WYKH/PTHzZs3gQsfDTLzIhVTkCAX5yjW0qG/fT0jYOMic5MDgdbrAebwvBg6MaT
         epuNFMnznHQHn+4gniuDqi8zvwG5APXSoAdW+KwJ2SDrr+bIT9R2Co5nwEKR2v3mUCP0
         T7TOqTgAj6AMxSKcjraT00YOW90PXeRJdEC8hkRsbx4c80SAXR/At8f25uabuH9YSmCJ
         2989Wi6APBZ+oI9HO5vZgdjp5e8UVhcjrGvQ7//OGV6HmJzjOxrJ+cPZvzTg1mfSRhAe
         S+8jHAwYBCAaigxf+BwH3UX10EkfTUZCJSKVj9cpY1rI/pjzuA4X8y/saIpmTz3rbf3M
         fk+Q==
X-Gm-Message-State: AOAM532EibJEoe5xBILPNSpWytrnht63bVyaS+Tu/tJO0nNOBwJ3DhXG
        k8I86ctNNhnPZ5kEqAuBimLBrSZ/Y6hpGJXuCZkpP/38Xzo=
X-Google-Smtp-Source: ABdhPJyv+WANeEg9nVJiKifginGa7svIGVQDOY8qEETdB/kN3BN2JEEmt3JU/GyQqQ2qFHltFSVSsSuySpQzIlDai4c=
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr2893752ejc.9.1627296995741;
 Mon, 26 Jul 2021 03:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
In-Reply-To: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
From:   =?UTF-8?Q?Peter_H=C3=B6ller?= <drmedvet.hoeller@gmail.com>
Date:   Mon, 26 Jul 2021 12:56:24 +0200
Message-ID: <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
Subject: Instable BLE connection - MTU Request, Attribute not found
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

My name is peter. This is probably a bit off topic but:
Since about 2 years I am working ambitiously on connecting a GoPro to
an Odroid via HTTP, UDP and BLE in order to get a powerful node-red
controlled dashcam/balckbox for my cars (fleet control).
(please see: https://github.com/cepoon/GoProRemote,
https://github.com/KonradIT/goprowifihack,
https://github.com/sepp89117/GoPro-Multiple-Smart-Remote-ESP8266)

However I stumbled over a thread: #96, which's owner forwarded me to
your mailing list as my last resort:

and figured that you are deep into debugging of BLE connections.

because of our long developement period we are "stuck" in a somewhat
older hardware/kernel  config, unfortunately:

Odroid C2 with BluetoothModule2 (CSR8510 A10)
Ubuntu 18.04 (Kernel 3.16.85+)
WifiModule 5A (concurrent mode (STA+Client) on hostapd 2.9)
Bluez 5.53
btusb 0.7
(- GoPro Hero5 black)

However, we do suffer from an comparable annoying problem since more
than a year(!). We do have an unstable BLE Connection between Dongle
and Gopro. When just paired, the first connection stays up for about
30mins (abortion the is not btmon-itored yet, but can be done), but
the reconnect is a problem: gets connected but after 2 - 15 sec:
disconnect. Mainly because of:

#Issue 1: (btmon) Why is it disconnecting after MTU request?
@ Discovering: 0x00 (6)

HCI Event: Command Status (0x0f) plen 4 #111 [hci0] 55.051270
LE Create Connection (0x08|0x000d) ncmd 1
Status: Success (0x00)
HCI Event: LE Meta Event (0x3e) plen 19 #112 [hci0] 55.626431
LE Connection Complete (0x01)
Status: Success (0x00)
Handle: 71
Role: Master (0x00)
Peer address type: Random (0x01)
Peer address: C9:0F:D9:47:48:B4 (Static)
Connection interval: 70.00 msec (0x0038)
Connection latency: 0 (0x0000)
Supervision timeout: 420 msec (0x002a)
Master clock accuracy: 0x00
@ Device Connected: C9:0F:D9:47:48:B4 (2) flags 0x0000
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #113 [hci0] 55.627789
ATT: Exchange MTU Request (0x02) len 2
Client RX MTU: 517
HCI Event: Disconnect Complete (0x05) plen 4 #114 [hci0] 56.035562
Status: Success (0x00)
Handle: 71
Reason: Connection Failed to be Established (0x3e)
@ Device Disconnected: C9:0F:D9:47:48:B4 (2) reason 0

#issue 2: btmon: Error: Timeout/ Disconnect after attribute not
found!? (main issue obviously)
@ Discovering: 0x00 (6)
<< HCI Command: LE Create Connect.. (0x08|0x000d) plen 25 #102 [hci0] 21.277573
Scan interval: 60.000 msec (0x0060)
Scan window: 30.000 msec (0x0030)
Filter policy: White list is not used (0x00)
Peer address type: Random (0x01)
Peer address: C9:0F:D9:47:48:B4 (Static)
Own address type: Public (0x00)
Min connection interval: 50.00 msec (0x0028)
Max connection interval: 70.00 msec (0x0038)
Connection latency: 0 (0x0000)
Supervision timeout: 420 msec (0x002a)
Min connection length: 0.000 msec (0x0000)
Max connection length: 0.000 msec (0x0000)

HCI Event: Command Status (0x0f) plen 4 #103 [hci0] 21.281234
LE Create Connection (0x08|0x000d) ncmd 1
Status: Success (0x00)
HCI Event: LE Meta Event (0x3e) plen 19 #104 [hci0] 21.474300
LE Connection Complete (0x01)
Status: Success (0x00)
Handle: 71
Role: Master (0x00)
Peer address type: Random (0x01)
Peer address: C9:0F:D9:47:48:B4 (Static)
Connection interval: 70.00 msec (0x0038)
Connection latency: 0 (0x0000)
Supervision timeout: 420 msec (0x002a)
Master clock accuracy: 0x00
@ Device Connected: C9:0F:D9:47:48:B4 (2) flags 0x0000
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #105 [hci0] 21.475604
ATT: Exchange MTU Request (0x02) len 2
Client RX MTU: 517
HCI Event: Number of Completed Packets (0x13) plen 5 #106 [hci0] 21.786387
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 7 #107 [hci0] 21.849441
ATT: Exchange MTU Response (0x03) len 2
Server RX MTU: 517
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #108 [hci0] 21.849849
ATT: Read Request (0x0a) len 2
Handle: 0x0004
HCI Event: Number of Completed Packets (0x13) plen 5 #109 [hci0] 21.919448
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 15 #110 [hci0] 21.989485
ATT: Read Response (0x0b) len 10
Value: 476f50726f2038353339
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #111 [hci0] 21.989865
ATT: Read Request (0x0a) len 2
Handle: 0x0006
HCI Event: Number of Completed Packets (0x13) plen 5 #112 [hci0] 22.059476
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 7 #113 [hci0] 22.135894
ATT: Read Response (0x0b) len 2
Value: 8000
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #114 [hci0] 22.136253
ATT: Read Request (0x0a) len 2
Handle: 0x000e
HCI Event: Number of Completed Packets (0x13) plen 5 #115 [hci0] 22.199508
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 6 #116 [hci0] 22.269695
ATT: Read Response (0x0b) len 1
Value: 05
<< ACL Data TX: Handle 71 flags 0x00 dlen 7 #117 [hci0] 22.270106
ATT: Read Request (0x0a) len 2
Handle: 0x0020
HCI Event: Number of Completed Packets (0x13) plen 5 #118 [hci0] 22.339554
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 12 #119 [hci0] 22.409721
ATT: Read Response (0x0b) len 7
Value: 00000000000000
<< ACL Data TX: Handle 71 flags 0x00 dlen 11 #120 [hci0] 22.410113
ATT: Read By Group Type Request (0x10) len 6
Handle range: 0x0001-0xffff
Attribute group type: Primary Service (0x2800)
HCI Event: Number of Completed Packets (0x13) plen 5 #121 [hci0] 22.479592
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 27 #122 [hci0] 22.549760
ACL Data RX: Handle 71 flags 0x01 dlen 9 #123 [hci0] 22.551041
ATT: Read By Group Type Response (0x11) len 31
Attribute data length: 6
Attribute group list: 5 entries
Handle range: 0x0001-0x0001
UUID: Generic Attribute Profile (0x1801)
Handle range: 0x0002-0x0008
UUID: Generic Access Profile (0x1800)
Handle range: 0x0009-0x000b
UUID: Tx Power (0x1804)
Handle range: 0x000c-0x000f
UUID: Battery Service (0x180f)
Handle range: 0x0010-0x0020
UUID: Device Information (0x180a)
<< ACL Data TX: Handle 71 flags 0x00 dlen 9 #124 [hci0] 22.551281
ATT: Write Request (0x12) len 4
Handle: 0x000f
Data: 0100
HCI Event: Number of Completed Packets (0x13) plen 5 #125 [hci0] 22.695655
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 5 #126 [hci0] 22.759830
ATT: Write Response (0x13) len 0
<< ACL Data TX: Handle 71 flags 0x00 dlen 11 #127 [hci0] 22.760241
ATT: Read By Group Type Request (0x10) len 6
Handle range: 0x0021-0xffff
Attribute group type: Primary Service (0x2800)
HCI Event: Number of Completed Packets (0x13) plen 5 #128 [hci0] 22.829698
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 26 #129 [hci0] 22.899859
ATT: Read By Group Type Response (0x11) len 21
Attribute data length: 20
Attribute group list: 1 entry
Handle range: 0x0021-0x002c
UUID: Vendor specific (b5f90001-aa8d-11e3-9046-0002a5d5c51b)
<< ACL Data TX: Handle 71 flags 0x00 dlen 11 #130 [hci0] 22.900311
ATT: Read By Group Type Request (0x10) len 6
Handle range: 0x002d-0xffff
Attribute group type: Primary Service (0x2800)
HCI Event: Number of Completed Packets (0x13) plen 5 #131 [hci0] 23.039754
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 12 #132 [hci0] 23.109915
ATT: Read By Group Type Response (0x11) len 7
Attribute data length: 6
Attribute group list: 1 entry
Handle range: 0x002d-0x0041
UUID: GoPro, Inc. (0xfea6)
<< ACL Data TX: Handle 71 flags 0x00 dlen 11 #133 [hci0] 23.110286
ATT: Read By Group Type Request (0x10) len 6
Handle range: 0x0042-0xffff
Attribute group type: Primary Service (0x2800)
HCI Event: Number of Completed Packets (0x13) plen 5 #134 [hci0] 23.185785
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 26 #135 [hci0] 23.319981
ATT: Read By Group Type Response (0x11) len 21
Attribute data length: 20
Attribute group list: 1 entry
Handle range: 0x0042-0x0047
UUID: Vendor specific (b5f90090-aa8d-11e3-9046-0002a5d5c51b)
<< ACL Data TX: Handle 71 flags 0x00 dlen 11 #136 [hci0] 23.320349
ATT: Read By Group Type Request (0x10) len 6
Handle range: 0x0048-0xffff
Attribute group type: Primary Service (0x2800)
HCI Event: Number of Completed Packets (0x13) plen 5 #137 [hci0] 23.389838
Num handles: 1
Handle: 71
Count: 1
ACL Data RX: Handle 71 flags 0x02 dlen 9 #138 [hci0] 23.458793
ATT: Error Response (0x01) len 4
Read By Group Type Request (0x10)
Handle: 0x0048
Error: Attribute Not Found (0x0a)
HCI Event: Disconnect Complete (0x05) plen 4 #139 [hci0] 24.160066
Status: Success (0x00)
Handle: 71
Reason: Connection Timeout (0x08)
@ Device Disconnected: C9:0F:D9:47:48:B4 (2) reason 1

for sure there are Authentification failures too, but I cannot
btmon-capture 'em right now.

However, it is really hard to find somebody who has a glue what is
going on here, and where the best, we should start to debug.

So please can you help us any further.

We are struggeling for a solution on this for years.

greets

peter
