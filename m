Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F05C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 09:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjFBJqJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFBJqI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 05:46:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C22134
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 02:46:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9745c5fed21so115462766b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=athom.nl; s=google; t=1685699164; x=1688291164;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0lt0mtX5Af0bz+uQwtronJyLa7qinDTnPxE5AHba4Y=;
        b=C1IyYmDf9hOQ0bDNH9kjv9Z5gc46t0e7HtrDhl/UlA1A2TeXNxAN6Zw9Bk9BpzFR3O
         YBKVnmgB8vdyWoB603fdiX7VCVrbSuurtLGPzjFAOaPpKTLUuy+rY+lbBW/4UEr2+5hz
         bi+57u6XH26Zn7kexVS9IG1FGOa/VeG8F6CHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699164; x=1688291164;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0lt0mtX5Af0bz+uQwtronJyLa7qinDTnPxE5AHba4Y=;
        b=PR0/cZipMyOSoOY7dvRL/qyNM3Mcy8aIg9xC39SAQ1GRUDTb5Ir8EPHIzYnOhLIzZi
         nMVSUx+EOQESgwNsiO9oeqnsADfk9XYX6eW39uKZDjOSYz6HdoAkakAcn5rGL8FfKG3C
         ON6TINWaaiScjkZZMoqB8hh1JXIJvlLW/RsaEbk3oqA7EKTbIjvepmnS86oCj9CsipD2
         kIF6fOqOgU8sS3lDDELb+DiqXW0TdxZjJiyH6hcHrqdzaog3o6u79A9/GQYzG1P5fQtW
         cs+xVomWuSlTPHHKFD6s3h7kul61QMDRWi8EOyyiBDAeQAOLhA09WxHIHUvBwxq3NYmB
         g1oA==
X-Gm-Message-State: AC+VfDxVTTihREa3pkqDF2GIeEwiN5nkr5+4ILeNEZZCqIMA2C38/Cmm
        Tfx21n5ej6RTqPhkdx+YAGPUVq8w4//Sej++rGzWKN4u
X-Google-Smtp-Source: ACHHUZ4wdmbSd4AUGroHAuous6GdJnt7qUVitOhufVstCyTefXhWKKf10R2aeUBtnJQA4vagQCXHPw==
X-Received: by 2002:a17:907:9718:b0:96a:90bb:a2d3 with SMTP id jg24-20020a170907971800b0096a90bba2d3mr9715654ejc.71.1685699164210;
        Fri, 02 Jun 2023 02:46:04 -0700 (PDT)
Received: from smtpclient.apple ([37.153.225.197])
        by smtp.gmail.com with ESMTPSA id rk9-20020a170907214900b0096f8c4b1911sm545987ejb.130.2023.06.02.02.46.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:46:03 -0700 (PDT)
From:   Herman Meerlo <herman.meerlo@athom.nl>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Intermittent Not connectable devices reported 
Message-Id: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
Date:   Fri, 2 Jun 2023 11:45:53 +0200
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm working on a Raspberry Pi device that performs periodic BLE =
discovery and tries to connect to multiple devices. Most of the times =
this goes fine but especially in BLE heavy environments every now and =
then it fails because it says that the device is not found. I have been =
debugging this issue for a few weeks now and it comes down to this:

   =E2=80=A2 Connect to DBus to start the discovery
   =E2=80=A2 Devices are found, interfacesAdded callbacks are made, =
everything looks fine
   =E2=80=A2 Stop discovery
   =E2=80=A2 Directly some devices are removed by the interfacesRemoved =
callback
   =E2=80=A2 My code does not get the device it searches for -> unhappy =
user

What happens under the hood is that DBus removes all devices from it's =
cache that have been indicated by Bluez as being Not connectable. I.e. =
there is no use in keeping them around, you can't connect to them =
anyway. But... this is not true for the device I'm looking for. It is =
marked as Not connectable incorrectly.
So to chase down the problem I create a btmon dump which shows indeed =
that the device is reported to be Not connectable after having received =
a SCAN_RSP:

> HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
LE Advertising Report (0x02)
Num reports: 1
Event type: Scan response - SCAN_RSP (0x04)
Address type: Public (0x00)
Address: F4:B8:5E:64:02:55 (Texas Instruments)
Data length: 26
Name (complete): BeeWi SmartLite
Peripheral Conn. Interval: 0x0028 - 0x0050
TX power: 0 dBm
RSSI: -42 dBm (0xd6)
@ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] 34.360057
LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
RSSI: -42 dBm (0xd6)
Flags: 0x00000004
Not Connectable
Data length: 26
Name (complete): BeeWi SmartLite
Peripheral Conn. Interval: 0x0028 - 0x0050
TX power: 0 dBm

But all ADV_IND PDU's before that clearly indicate that the device is =
connectable, it is only after this SCAN_RSP that it is reported as Not =
connectable:

> HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
LE Advertising Report (0x02)
Num reports: 1
Event type: Connectable undirected - ADV_IND (0x00)
Address type: Public (0x00)
Address: F4:B8:5E:64:02:55 (Texas Instruments)
Data length: 15
Flags: 0x06
LE General Discoverable Mode
BR/EDR Not Supported
Company: Texas Instruments Inc. (13)
Data: 06030108b0e408f7
RSSI: -43 dBm (0xd5)
@ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] 34.152905
LE Address: 44:6E:FF:00:0D:65 (Resolvable)
RSSI: -74 dBm (0xb6)
Flags: 0x00000000
Data length: 17
Flags: 0x1a
LE General Discoverable Mode
Simultaneous LE and BR/EDR (Controller)
Simultaneous LE and BR/EDR (Host)
TX power: 9 dBm
Company: Apple, Inc. (76)
Type: Unknown (16)
Data: 01188898dc
> HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
LE Advertising Report (0x02)
Num reports: 1
Event type: Connectable undirected - ADV_IND (0x00)
Address type: Random (0x01)
Address: FA:BD:8D:12:26:BF (Static)
Data length: 29
Name (short): P mesh
Flags: 0x04
BR/EDR Not Supported
128-bit Service UUIDs (partial): 1 entry
Vendor specific
RSSI: -47 dBm (0xd1)
@ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] 34.157030
LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
RSSI: -43 dBm (0xd5)
Flags: 0x00000000
Data length: 15
Flags: 0x06
LE General Discoverable Mode
BR/EDR Not Supported
Company: Texas Instruments Inc. (13)
Data: 06030108b0e408f7

So I am heavily doubting whether the Linux kernel code has a bug in =
handling the SCAN_RSP. Please look at this part of the kernel:=20

=
https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee38f724=
594dc/net/bluetooth/hci_event.c#L6326

It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will =
overwrite it with any flags it has received with a previous ADV_IND. But =
it does not seem to take into account that in BLE heavy environments the =
previous ADV_IND might be of a totally different device. So every now =
and then it will enter the first path where it will just report the =
device with a NOT_CONNECTABLE flag. Or am I missing something here?=
