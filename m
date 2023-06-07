Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A07C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 06:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbjFGGqP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjFGGqO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 02:46:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C5C172B
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 23:46:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977e0fbd742so430213266b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jun 2023 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=athom.nl; s=google; t=1686120370; x=1688712370;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxcrTAAvlR4kLkCkfmA6SB4omNozZ2B6/f70n4cgm0E=;
        b=Tm2ZjF5GUjreWkzx/byh5Cay9J+hO9n1NPYk4sXG8haEi92siRIqQX6jLLtaUgGigG
         YLh+TAjyMJf6xpGrPevCjn1QX/yv5y0BCONn9U/OKv7/z//p4/0JID74/4Z6UKIp+tmZ
         uSqfE9nEJ7leVuk+szMXxXnCpfJ7KtCt7X/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120370; x=1688712370;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxcrTAAvlR4kLkCkfmA6SB4omNozZ2B6/f70n4cgm0E=;
        b=AorUkRLZfvDSQPJwNSHZK8GoFWsCPigID5aZUh41X/7ci9jnK5fqHl/OYs3V6WHP0F
         ZB+Ir/r2q1U9CkU9Xp98RWqoFk+T8Ao43ToT4WBB4OeGg4FwWWcZlBgWMGRMhdaMluWR
         IgiCEE4uXNpN8nr3AKCR+MmAYAuMHiRIlVAKS2DnIVRJB4HWyIwSbuOy9ccOo22SV5kn
         tLnoy07eMH2NYLT3eS0LToRaAKicDZ9ukHNVwaqiK//pbs0LZjpCHfaQN3I2d9gMO145
         45/7y8tSG2brCaeR7IW9rX0ccO+iAfK7xgTcDDw4gtiFjWP/7prtXj8IrA9NDcIBD7YB
         +A5w==
X-Gm-Message-State: AC+VfDyBv4492G3TMrFChrlPsh7yVGvdSRyz9G/g/eZ4eRSatNKlJhQy
        TNg7/4dKgTqDeSpDeLGZduhT+siy7+eYhUYMX+wVYMtQ
X-Google-Smtp-Source: ACHHUZ6JLwZWCD62T0uWP4n6ZuyOXzkATuQm7xOI3WdwHM4b+poufzDU5F7Hyrw2OQRcZqNzqNXAMA==
X-Received: by 2002:a17:907:783:b0:974:1c90:a097 with SMTP id xd3-20020a170907078300b009741c90a097mr4135279ejb.12.1686120370561;
        Tue, 06 Jun 2023 23:46:10 -0700 (PDT)
Received: from smtpclient.apple ([37.153.225.197])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709064b0100b00978874e833bsm146889eju.168.2023.06.06.23.46.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2023 23:46:10 -0700 (PDT)
From:   Herman Meerlo <herman.meerlo@athom.nl>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Intermittent Not connectable devices reported
Date:   Wed, 7 Jun 2023 08:45:57 +0200
References: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
To:     linux-bluetooth@vger.kernel.org
In-Reply-To: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
Message-Id: <E77E2C1D-70F1-4F4E-8B3F-CDA306A02A3B@athom.nl>
X-Mailer: Apple Mail (2.3731.500.231)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


> On 2 Jun 2023, at 11:45, Herman Meerlo <herman.meerlo@athom.nl> wrote:
>=20
> I'm working on a Raspberry Pi device that performs periodic BLE =
discovery and tries to connect to multiple devices. Most of the times =
this goes fine but especially in BLE heavy environments every now and =
then it fails because it says that the device is not found. I have been =
debugging this issue for a few weeks now and it comes down to this:
>=20
>   =E2=80=A2 Connect to DBus to start the discovery
>   =E2=80=A2 Devices are found, interfacesAdded callbacks are made, =
everything looks fine
>   =E2=80=A2 Stop discovery
>   =E2=80=A2 Directly some devices are removed by the interfacesRemoved =
callback
>   =E2=80=A2 My code does not get the device it searches for -> unhappy =
user
>=20
> What happens under the hood is that DBus removes all devices from it's =
cache that have been indicated by Bluez as being Not connectable. I.e. =
there is no use in keeping them around, you can't connect to them =
anyway. But... this is not true for the device I'm looking for. It is =
marked as Not connectable incorrectly.
> So to chase down the problem I create a btmon dump which shows indeed =
that the device is reported to be Not connectable after having received =
a SCAN_RSP:
>=20
>> HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Scan response - SCAN_RSP (0x04)
> Address type: Public (0x00)
> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> Data length: 26
> Name (complete): BeeWi SmartLite
> Peripheral Conn. Interval: 0x0028 - 0x0050
> TX power: 0 dBm
> RSSI: -42 dBm (0xd6)
> @ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] 34.360057
> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> RSSI: -42 dBm (0xd6)
> Flags: 0x00000004
> Not Connectable
> Data length: 26
> Name (complete): BeeWi SmartLite
> Peripheral Conn. Interval: 0x0028 - 0x0050
> TX power: 0 dBm
>=20
> But all ADV_IND PDU's before that clearly indicate that the device is =
connectable, it is only after this SCAN_RSP that it is reported as Not =
connectable:
>=20
>> HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Connectable undirected - ADV_IND (0x00)
> Address type: Public (0x00)
> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> Data length: 15
> Flags: 0x06
> LE General Discoverable Mode
> BR/EDR Not Supported
> Company: Texas Instruments Inc. (13)
> Data: 06030108b0e408f7
> RSSI: -43 dBm (0xd5)
> @ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] 34.152905
> LE Address: 44:6E:FF:00:0D:65 (Resolvable)
> RSSI: -74 dBm (0xb6)
> Flags: 0x00000000
> Data length: 17
> Flags: 0x1a
> LE General Discoverable Mode
> Simultaneous LE and BR/EDR (Controller)
> Simultaneous LE and BR/EDR (Host)
> TX power: 9 dBm
> Company: Apple, Inc. (76)
> Type: Unknown (16)
> Data: 01188898dc
>> HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Connectable undirected - ADV_IND (0x00)
> Address type: Random (0x01)
> Address: FA:BD:8D:12:26:BF (Static)
> Data length: 29
> Name (short): P mesh
> Flags: 0x04
> BR/EDR Not Supported
> 128-bit Service UUIDs (partial): 1 entry
> Vendor specific
> RSSI: -47 dBm (0xd1)
> @ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] 34.157030
> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> RSSI: -43 dBm (0xd5)
> Flags: 0x00000000
> Data length: 15
> Flags: 0x06
> LE General Discoverable Mode
> BR/EDR Not Supported
> Company: Texas Instruments Inc. (13)
> Data: 06030108b0e408f7
>=20
> So I am heavily doubting whether the Linux kernel code has a bug in =
handling the SCAN_RSP. Please look at this part of the kernel:=20
>=20
> =
https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee38f724=
594dc/net/bluetooth/hci_event.c#L6326
>=20
> It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will =
overwrite it with any flags it has received with a previous ADV_IND. But =
it does not seem to take into account that in BLE heavy environments the =
previous ADV_IND might be of a totally different device. So every now =
and then it will enter the first path where it will just report the =
device with a NOT_CONNECTABLE flag. Or am I missing something here?

Can someone take a look at this? It is happening quite often and I can =
not imagine that I=E2=80=99m the only one with this issue.


