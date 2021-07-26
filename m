Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6532C603E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 15:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhGZOyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhGZOx7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 10:53:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2ECC061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 08:34:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso10361739otf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lEVdgMxVQfW479xF/fF4Zr1iJ9mab+EHvy7NYzxMa/Q=;
        b=nC9vsrAul5/WZewGBX8WPSwCAhVXJEvp92MF13bHZlPvEROboITBYUumxXfskxSfVk
         RBFGkK3yDZgmQjKM82cQ976JhsVotzjovqJ7WG9W9h6B8N18+UgljL6t6gJ37nG/FOWk
         /V6SRvULfCci8S8CBRzJyD9QOiePJuaycmx6OiyLTgTLW0PWFmQYxRn3oM1Ke7N3cNxf
         Ke8NavZIR1heQEpo38nSbAV4tcm3PSxN72xnAootA7Mml/Nau2+6AwWh8O7z5RqS48zM
         nHR8FU7w3MP2Q5sXK5+sb99bx4DZUnw1/OVFPIyykJWIZ735NEhnDI9e4py4q8w2CyXM
         sRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lEVdgMxVQfW479xF/fF4Zr1iJ9mab+EHvy7NYzxMa/Q=;
        b=UQlpTZ5daswnHEKOT2aoYR95+35ExCAwm/tve/1hs+Hts5RTpg93V5U5r1RcePRpA/
         /MDIOBYxmFI2QEq6e+HyKIDKIyUmVC6kwDk6wKb+ANjkQM3xcG0ZGid+h7LeJWb6eH3S
         DUXvH2MqRk+W8VEPIvLhNSuQfhudDHITl0ty8+JZ6Ar4Mk41CCeEBmjc6jFKCWtTIcl6
         FhjOhaupD4dMNOACkOLA/5cQsHooxYxYiPKfN7n/If/WMETSPxTG9iWpvhu1aGfe5d0C
         cGbO4Yjq5RzaiQZVNHVkUkaZ+8jE8nCrw0E0V9K6OYm+15owczcMRLu6LJZ7PiVjaRYU
         VtCA==
X-Gm-Message-State: AOAM531v5+lqLKB1HSKgr4Z04dwScGQ+DO9ZC9sKGCyWVkMTFFY10j5u
        3wW9+GemqZk5WUMo690XN3HBZL6OrfRTnipCPS0FMPJtlVQ=
X-Google-Smtp-Source: ABdhPJz2rhSt+vzbr/ktUPz2/+u/7Tk+iXgNZEBTHn1zJOktpvRUj0gC1icULUJIYSBBAkHvM96jj9qqdGgzKEZtZT4=
X-Received: by 2002:a9d:6344:: with SMTP id y4mr12414326otk.145.1627313667515;
 Mon, 26 Jul 2021 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
 <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
In-Reply-To: <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 26 Jul 2021 17:34:22 +0200
Message-ID: <CAO1O6sfBB53qMnB-K+ZLaGrrD3ZFy00Zn+u1GqTavNX7fZCzBw@mail.gmail.com>
Subject: Re: Instable BLE connection - MTU Request, Attribute not found
To:     =?UTF-8?Q?Peter_H=C3=B6ller?= <drmedvet.hoeller@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

Den m=C3=A5n 26 juli 2021 kl 12:58 skrev Peter H=C3=B6ller <drmedvet.hoelle=
r@gmail.com>:
>
> Hello!
>
> My name is peter. This is probably a bit off topic but:
> Since about 2 years I am working ambitiously on connecting a GoPro to
> an Odroid via HTTP, UDP and BLE in order to get a powerful node-red
> controlled dashcam/balckbox for my cars (fleet control).
> (please see: https://github.com/cepoon/GoProRemote,
> https://github.com/KonradIT/goprowifihack,
> https://github.com/sepp89117/GoPro-Multiple-Smart-Remote-ESP8266)
>
> However I stumbled over a thread: #96, which's owner forwarded me to
> your mailing list as my last resort:
>
> and figured that you are deep into debugging of BLE connections.
>
> because of our long developement period we are "stuck" in a somewhat
> older hardware/kernel  config, unfortunately:
>
> Odroid C2 with BluetoothModule2 (CSR8510 A10)
> Ubuntu 18.04 (Kernel 3.16.85+)
> WifiModule 5A (concurrent mode (STA+Client) on hostapd 2.9)
> Bluez 5.53
> btusb 0.7
> (- GoPro Hero5 black)
>
> However, we do suffer from an comparable annoying problem since more
> than a year(!). We do have an unstable BLE Connection between Dongle
> and Gopro. When just paired, the first connection stays up for about
> 30mins (abortion the is not btmon-itored yet, but can be done), but
> the reconnect is a problem: gets connected but after 2 - 15 sec:
> disconnect. Mainly because of:
>
> #Issue 1: (btmon) Why is it disconnecting after MTU request?
> @ Discovering: 0x00 (6)
>
> HCI Event: Command Status (0x0f) plen 4 #111 [hci0] 55.051270
> LE Create Connection (0x08|0x000d) ncmd 1
> Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19 #112 [hci0] 55.626431
> LE Connection Complete (0x01)
> Status: Success (0x00)
> Handle: 71
> Role: Master (0x00)
> Peer address type: Random (0x01)
> Peer address: C9:0F:D9:47:48:B4 (Static)
> Connection interval: 70.00 msec (0x0038)
> Connection latency: 0 (0x0000)
> Supervision timeout: 420 msec (0x002a)
> Master clock accuracy: 0x00
> @ Device Connected: C9:0F:D9:47:48:B4 (2) flags 0x0000
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #113 [hci0] 55.627789
> ATT: Exchange MTU Request (0x02) len 2
> Client RX MTU: 517
> HCI Event: Disconnect Complete (0x05) plen 4 #114 [hci0] 56.035562
> Status: Success (0x00)
> Handle: 71
> Reason: Connection Failed to be Established (0x3e)
> @ Device Disconnected: C9:0F:D9:47:48:B4 (2) reason 0
>
> #issue 2: btmon: Error: Timeout/ Disconnect after attribute not
> found!? (main issue obviously)
> @ Discovering: 0x00 (6)
> << HCI Command: LE Create Connect.. (0x08|0x000d) plen 25 #102 [hci0] 21.=
277573
> Scan interval: 60.000 msec (0x0060)
> Scan window: 30.000 msec (0x0030)
> Filter policy: White list is not used (0x00)
> Peer address type: Random (0x01)
> Peer address: C9:0F:D9:47:48:B4 (Static)
> Own address type: Public (0x00)
> Min connection interval: 50.00 msec (0x0028)
> Max connection interval: 70.00 msec (0x0038)
> Connection latency: 0 (0x0000)
> Supervision timeout: 420 msec (0x002a)
> Min connection length: 0.000 msec (0x0000)
> Max connection length: 0.000 msec (0x0000)
>
> HCI Event: Command Status (0x0f) plen 4 #103 [hci0] 21.281234
> LE Create Connection (0x08|0x000d) ncmd 1
> Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19 #104 [hci0] 21.474300
> LE Connection Complete (0x01)
> Status: Success (0x00)
> Handle: 71
> Role: Master (0x00)
> Peer address type: Random (0x01)
> Peer address: C9:0F:D9:47:48:B4 (Static)
> Connection interval: 70.00 msec (0x0038)
> Connection latency: 0 (0x0000)
> Supervision timeout: 420 msec (0x002a)
> Master clock accuracy: 0x00
> @ Device Connected: C9:0F:D9:47:48:B4 (2) flags 0x0000
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #105 [hci0] 21.475604
> ATT: Exchange MTU Request (0x02) len 2
> Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5 #106 [hci0] 21.78638=
7
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 7 #107 [hci0] 21.849441
> ATT: Exchange MTU Response (0x03) len 2
> Server RX MTU: 517
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #108 [hci0] 21.849849
> ATT: Read Request (0x0a) len 2
> Handle: 0x0004
> HCI Event: Number of Completed Packets (0x13) plen 5 #109 [hci0] 21.91944=
8
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 15 #110 [hci0] 21.989485
> ATT: Read Response (0x0b) len 10
> Value: 476f50726f2038353339
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #111 [hci0] 21.989865
> ATT: Read Request (0x0a) len 2
> Handle: 0x0006
> HCI Event: Number of Completed Packets (0x13) plen 5 #112 [hci0] 22.05947=
6
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 7 #113 [hci0] 22.135894
> ATT: Read Response (0x0b) len 2
> Value: 8000
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #114 [hci0] 22.136253
> ATT: Read Request (0x0a) len 2
> Handle: 0x000e
> HCI Event: Number of Completed Packets (0x13) plen 5 #115 [hci0] 22.19950=
8
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 6 #116 [hci0] 22.269695
> ATT: Read Response (0x0b) len 1
> Value: 05
> << ACL Data TX: Handle 71 flags 0x00 dlen 7 #117 [hci0] 22.270106
> ATT: Read Request (0x0a) len 2
> Handle: 0x0020
> HCI Event: Number of Completed Packets (0x13) plen 5 #118 [hci0] 22.33955=
4
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 12 #119 [hci0] 22.409721
> ATT: Read Response (0x0b) len 7
> Value: 00000000000000
> << ACL Data TX: Handle 71 flags 0x00 dlen 11 #120 [hci0] 22.410113
> ATT: Read By Group Type Request (0x10) len 6
> Handle range: 0x0001-0xffff
> Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5 #121 [hci0] 22.47959=
2
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 27 #122 [hci0] 22.549760
> ACL Data RX: Handle 71 flags 0x01 dlen 9 #123 [hci0] 22.551041
> ATT: Read By Group Type Response (0x11) len 31
> Attribute data length: 6
> Attribute group list: 5 entries
> Handle range: 0x0001-0x0001
> UUID: Generic Attribute Profile (0x1801)
> Handle range: 0x0002-0x0008
> UUID: Generic Access Profile (0x1800)
> Handle range: 0x0009-0x000b
> UUID: Tx Power (0x1804)
> Handle range: 0x000c-0x000f
> UUID: Battery Service (0x180f)
> Handle range: 0x0010-0x0020
> UUID: Device Information (0x180a)
> << ACL Data TX: Handle 71 flags 0x00 dlen 9 #124 [hci0] 22.551281
> ATT: Write Request (0x12) len 4
> Handle: 0x000f
> Data: 0100
> HCI Event: Number of Completed Packets (0x13) plen 5 #125 [hci0] 22.69565=
5
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 5 #126 [hci0] 22.759830
> ATT: Write Response (0x13) len 0
> << ACL Data TX: Handle 71 flags 0x00 dlen 11 #127 [hci0] 22.760241
> ATT: Read By Group Type Request (0x10) len 6
> Handle range: 0x0021-0xffff
> Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5 #128 [hci0] 22.82969=
8
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 26 #129 [hci0] 22.899859
> ATT: Read By Group Type Response (0x11) len 21
> Attribute data length: 20
> Attribute group list: 1 entry
> Handle range: 0x0021-0x002c
> UUID: Vendor specific (b5f90001-aa8d-11e3-9046-0002a5d5c51b)
> << ACL Data TX: Handle 71 flags 0x00 dlen 11 #130 [hci0] 22.900311
> ATT: Read By Group Type Request (0x10) len 6
> Handle range: 0x002d-0xffff
> Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5 #131 [hci0] 23.03975=
4
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 12 #132 [hci0] 23.109915
> ATT: Read By Group Type Response (0x11) len 7
> Attribute data length: 6
> Attribute group list: 1 entry
> Handle range: 0x002d-0x0041
> UUID: GoPro, Inc. (0xfea6)
> << ACL Data TX: Handle 71 flags 0x00 dlen 11 #133 [hci0] 23.110286
> ATT: Read By Group Type Request (0x10) len 6
> Handle range: 0x0042-0xffff
> Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5 #134 [hci0] 23.18578=
5
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 26 #135 [hci0] 23.319981
> ATT: Read By Group Type Response (0x11) len 21
> Attribute data length: 20
> Attribute group list: 1 entry
> Handle range: 0x0042-0x0047
> UUID: Vendor specific (b5f90090-aa8d-11e3-9046-0002a5d5c51b)
> << ACL Data TX: Handle 71 flags 0x00 dlen 11 #136 [hci0] 23.320349
> ATT: Read By Group Type Request (0x10) len 6
> Handle range: 0x0048-0xffff
> Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5 #137 [hci0] 23.38983=
8
> Num handles: 1
> Handle: 71
> Count: 1
> ACL Data RX: Handle 71 flags 0x02 dlen 9 #138 [hci0] 23.458793
> ATT: Error Response (0x01) len 4
> Read By Group Type Request (0x10)
> Handle: 0x0048
> Error: Attribute Not Found (0x0a)
> HCI Event: Disconnect Complete (0x05) plen 4 #139 [hci0] 24.160066
> Status: Success (0x00)
> Handle: 71
> Reason: Connection Timeout (0x08)
> @ Device Disconnected: C9:0F:D9:47:48:B4 (2) reason 1
>
> for sure there are Authentification failures too, but I cannot
> btmon-capture 'em right now.
>
> However, it is really hard to find somebody who has a glue what is
> going on here, and where the best, we should start to debug.
>
> So please can you help us any further.
>
> We are struggeling for a solution on this for years.
>
> greets
>
> peter

To understand the "Connection failed to be established" disconnect
reason, let me first explain the connection process in BLE:
1. Peripheral emits ADV_IND advertising packets repeatedly with some
interval, containing its Bluetooth device address and some optional
advertising data.
2. A central device which is currently in the initiating state scans
for these advertising packets and when one is found with the correct
target address, it will reply after exactly 150 microseconds with a
CONNECT_IND packet.
3. The central is now in the "connected" state and this fact is sent
to the host using a "LE Connection Complete Event".
4. At the peripheral side, the "connected" state is entered when it
receives the CONNECT_IND packet.

In the connected state, the central emits one packet (possibly empty)
once per connection interval and the peripheral must respond within
150 microseconds. If there is no response for the first six packets in
a connection, the central will treat the connection disconnected with
the reason "Connection failed to be established". If the peripheral
responds at least once, but after that at any time it doesn't respond
to a central's packet within the set supervision timeout, the
"Connection Timeout" disconnect reason will happen.

We can derive a few reasons why "Connection failed to be established" occur=
s:

1. If the CONNECT_IND packet is lost in the air, the peripheral does
not enter the connected state, but the central does. In this case the
peripheral will not respond to any other packet the central sends,
since the peripheral is not in the connected state.
2. The peripheral could use white listing to allow connections from
only specific centrals. In this case the central will always see a
connection complete immediately followed by a connection failed to be
established.
3. Bad signal quality could mean the peripheral detects the
CONNECT_IND but not any of the first six packets sent by the central.
4. A bad link layer scheduler in any of the two bluetooth controllers
could skip the first six connection events.

With the new extended advertising packet format introduced in
Bluetooth 5.0 that not many devices use, an extra acknowledgement is
sent from the peripheral after it receives the CONNECT_IND to mitigate
this confusion a bit.

Common reasons for the Connection Timeout are bad signal quality or a
bad link layer scheduler, or possibly too much overlapping work
scheduled for the radio.

Anyway, nothing is wrong at the host side (BlueZ) for these problems.
It just happened that the MTU Request and Attribute Not Found packets
were the last ones before the disconnection occurred. You should use
an air sniffer for BLE to maybe get some more insight.

/Emil
