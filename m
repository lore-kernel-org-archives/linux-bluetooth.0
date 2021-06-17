Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57140C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE59611CE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFQIlb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQIlb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 04:41:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75CBC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 01:39:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k5so2213198iow.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matthazley-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=gqAwpM4BgCvf8ImaTuciLF5O32HOtJsz5dARflceJOI=;
        b=ldv+nAB41k/lkLZsb3x8X0pT/VBb/wvE7q5CDGXYMafkq0/H8s4yH5j7SsWciE3Kj9
         RqAFSoEUjqoMOYoDQ6Sp/nc6eJf4AIgM0XS/PWKnlienag7t07IkbY3+9Z8otBnJs0vD
         NgNRCw4GrpKqXxHA3pv0BnELnTFaNhk+K4zJlL4csdKbm1xo+UZcPhDhIs3BYNh7EM4p
         YxUc/Fk5P2cvNmPeRrZa+Dr69NlPkW+UA8NkmY3+cRz7DMeil6ZBS+mL9GuetdB5AGwP
         p2X92+sFTDTGCifTs2CtzpzjlYRf22J7jGwKh2grXnMjVn0Tx7OgSUrd4z9S7Pxnkw2s
         Foqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gqAwpM4BgCvf8ImaTuciLF5O32HOtJsz5dARflceJOI=;
        b=SyE0AaQ6wsSCGW6bx0i1VSFTMmzCpRxT8lrBpSUKWywMMEFcZF7BKYm75KjIBFq+U+
         eWi+aL9LFZCkoAY+2XK7UnD1+o3xjtFjNkfXjdyLJ82+1WAE2RYjPccE0W9kRC0E2OCR
         J/j1B1mAczPJJuH4uMmm3tdcY+VRCaLlf6HNOxmVUFm9C13u7NSiHVsnWu3lEjcagV0k
         nrMu4dlJ85TFX5g41vKKGi+bxBHao8U7yBQxYwnqzZPINGsbTlI5PHhIA1UFZ1i9GzBZ
         RUEdHe2Jo3ka2DcjMl13egKdb2Ny5RAl3YYFBa/2U71OzOx55w+kPN3AuTZU0UZpvkYe
         ZcQw==
X-Gm-Message-State: AOAM533N42D09qILgSqK0RX64MTjkHWrbGNXLqfOrqMNP+fTa32/VjAf
        5mhajN+N0HwEg0tAjPCE8eG6AZURnr3cauz/6Trc3IYqs7TnGZJBKrY=
X-Google-Smtp-Source: ABdhPJxNdURnNL3+2aCiZpbjn8mZAHxKPXj3cBN14554lg3HdrlScu+ixzNzQmnhCGBXeJC01+c7sYElyOMbOBHVWUs=
X-Received: by 2002:a02:230d:: with SMTP id u13mr3403826jau.138.1623919162128;
 Thu, 17 Jun 2021 01:39:22 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Hazley <lists@matthazley.com>
Date:   Thu, 17 Jun 2021 09:39:11 +0100
Message-ID: <CA+rLJxX4=oLbSO-4RML7+WM6iwxTc50BDbOgNM2CcAsW4NK0Mg@mail.gmail.com>
Subject: iOS Central with BlueZ Peripheral disconnect due to insufficient auth
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In our system, we have a BLE Peripheral (in this example, running on
RPi4) using BlueZ 5.50.

We have an iOS app that connects to this Peripheral as a Central.

This connection can be seen in `btmon`, all looks ok:


> HCI Event: LE Meta Event (0x3e) plen 31                                                                                                                                                                             #189 [hci0] 1157.975252
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Handle: 1
        Role: Slave (0x01)
        Peer address type: Random (0x01)
        Peer address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Connection interval: 30.00 msec (0x0018)
        Connection latency: 0 (0x0000)
        Supervision timeout: 720 msec (0x0048)
        Master clock accuracy: 0x01
@ MGMT Event: Device Connected (0x000b) plen 13


{0x0003} [hci0] 1157.975343
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Flags: 0x00000000
        Data length: 0
@ MGMT Event: Device Connected (0x000b) plen 13


{0x0002} [hci0] 1157.975343
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Flags: 0x00000000
        Data length: 0
@ MGMT Event: Device Connected (0x000b) plen 13


{0x0001} [hci0] 1157.975343
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Flags: 0x00000000
        Data length: 0
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2


 #190 [hci0] 1157.975611
        Handle: 1
> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                                             #191 [hci0] 1157.976191
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                                                                                                                                                                             #192 [hci0] 1158.060347
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 1
        Features: 0xff 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies


The problem that we have is that after a couple of mins, there is a
disconnect. Looking deeper, the `btmon` logging shows the following,
and this loops continually until the eventual disconnect:


< ACL Data TX: Handle 1 flags 0x00 dlen 7


 #301 [hci0] 1159.739498
      ATT: Read Request (0x0a) len 2
        Handle: 0x0016
> ACL Data RX: Handle 1 flags 0x02 dlen 9                                                                                                                                                                             #302 [hci0] 1159.799046
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x0016
        Error: Insufficient Authentication (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                                                #303 [hci0] 1159.799227
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 6


 #304 [hci0] 1159.799388
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)
> ACL Data RX: Handle 1 flags 0x02 dlen 11                                                                                                                                                                            #305 [hci0] 1159.859132
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey IdKey (0x03)
        Responder key distribution: EncKey IdKey (0x03)
@ MGMT Event: Authentication Failed (0x0011) plen 8


{0x0003} [hci0] 1159.859286
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8


{0x0002} [hci0] 1159.859286
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8


{0x0001} [hci0] 1159.859286
        LE Address: 51:A3:4E:3C:B5:D6 (Resolvable)
        Status: Authentication Failed (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                                                #306 [hci0] 1159.859215
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 6


 #307 [hci0] 1159.859348
      SMP: Pairing Failed (0x05) len 1
        Reason: Pairing not supported (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                                                #308 [hci0] 1159.919220
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 11                                                                                                                                                                            #309 [hci0] 1160.999201
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Device Name (0x2a00)
< ACL Data TX: Handle 1 flags 0x00 dlen 19


 #310 [hci0] 1160.999678
      ATT: Read By Type Response (0x09) len 14
        Attribute data length: 13
        Attribute data list: 1 entry
        Handle: 0x0003
        Value: 6d6174742d7562756e7475


Looking at this logging, it appears that the BlueZ side (Peripheral)
is trying to read something from the iOS side (Central).

If we examine the list of services on the iOS device via
`bluetoothctl`, we see that the device has 21 services exposed:


[iPhone]# info DC:08:0F:5B:8D:82
Device DC:08:0F:5B:8D:82 (public)
Name: iPhone
Alias: iPhone
Class: 0x007a020c
Icon: phone
Paired: yes
Trusted: no
Blocked: no
Connected: yes
LegacyPairing: no
UUID: Vendor specific (00000000-deca-fade-deca-deafdecacafe)
UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
UUID: Audio Source (0000110a-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: Advanced Audio Distribu.. (0000110d-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
UUID: NAP (00001116-0000-1000-8000-00805f9b34fb)
UUID: Handsfree Audio Gateway (0000111f-0000-1000-8000-00805f9b34fb)
UUID: Phonebook Access Server (0000112f-0000-1000-8000-00805f9b34fb)
UUID: Message Access Server (00001132-0000-1000-8000-00805f9b34fb)
UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
UUID: Generic Access Profile (00001800-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Current Time Service (00001805-0000-1000-8000-00805f9b34fb)
UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
UUID: Battery Service (0000180f-0000-1000-8000-00805f9b34fb)
UUID: Vendor specific (02030302-1d19-415f-86f2-22a2106a0a77)
UUID: Vendor specific (7905f431-b5ce-4e99-a40f-4b1e122d00d0)
UUID: Vendor specific (89d3502b-0f36-433a-8ef4-c502ad55f8dc)
UUID: Vendor specific (9fa480e0-4967-4542-9390-d343dc5d04ae)
UUID: Vendor specific (d0611e78-bbb4-4591-a5f8-487910ae4366)


This issue seems to be the crux of [this Stack Overflow
question](https://stackoverflow.com/questions/59214524/since-bluez-5-48-iphones-require-pairing-when-connecting-on-a-ble-gap-periphera)
and they have posted a workaround to compile BlueZ without the Battery
Profile.

Applying that workaround, which is to re-compile BlueZ with:


builtin_modules += battery
builtin_sources += profiles/battery/battery.c


removed from `Makefiles.plugin` makes the errors above go away, and
there is no more disconnect.

This is confusing, as according to the spec, there are no security
requirements for The Battery Service:


> "This service defines no security requirements for these characteristics."


So, does anyone know what is causing the above?
Is there a way to stop BlueZ from trying to read in this way?
Does anyone know of a workaround that avoids a recompilation of BlueZ?

Thanks.
Matt
