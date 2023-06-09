Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279FAC7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 11:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbjFILMH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjFILLe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 07:11:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94630EC
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 04:11:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9786fc23505so250000266b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=athom.nl; s=google; t=1686309090; x=1688901090;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SOtEx2BYQaQphphQj9bdm2l9NurLycH4gGWBi6kDYw=;
        b=EUAin/Hwjwr+jWNOJQSZGCodzqsBWmFfaiRkJuOf8necmZ/BQ7cs/WpWEA4Lv3cN4c
         3efa7gzgvIcwATGi3vxDdnc9gkbYIY0BdXVCaWLmev/hLxHkuGu9iDNqE86E5Kan0MSx
         9lCIE1Ao8R95Ik6YrG3QoBwQ9RwwptMQXrln0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309090; x=1688901090;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SOtEx2BYQaQphphQj9bdm2l9NurLycH4gGWBi6kDYw=;
        b=Mg87sxZ9kc54cvaQl0QgI9iGUKoCNor6Ul74gqSjL4TS+8LOPnoDQ2+YHiqobaoQrz
         ZRC4Odg9Jjxq11RToOIHa0tnH3y5J5HOVZfFunEshBxuTx/mKw++WBaxY2S2hzfpvpk6
         +i+BX3VWNPQZeTSTv9DZ1HJ7plXNkQcy1QzReiUXkEk7Or/qIGjzccRWbo60NI09+t6p
         pUwfdhxfG5Sm9CsF4uGJwoETbtayKxxl4eBh1bPAWvTEP38yIUxMf2XOj5YIzZutGjUm
         quXl6ANVlju8PSFlMsoIiOToOUSjeqTRlqOGyLpVsv0Hnp3zzzTIfu86GRzZObLoQrdQ
         K9Ug==
X-Gm-Message-State: AC+VfDxWRx9u4TMx2PfxiGAps4U1ULKC3bcVxrf8CsMqd28vekvFsEHW
        +AYBFpjb37tY/vHAvYxynl280Ia6cs7ngKRYc9alGA==
X-Google-Smtp-Source: ACHHUZ5BpRfZP82WCr73HMWys8V2bKepnaE1zuP6cJke5MSzBwN7vtdPV7JyPa7tX0ESYKZOUh6poA==
X-Received: by 2002:a17:907:1622:b0:96a:90bb:a2d3 with SMTP id hb34-20020a170907162200b0096a90bba2d3mr1365228ejc.71.1686309090556;
        Fri, 09 Jun 2023 04:11:30 -0700 (PDT)
Received: from smtpclient.apple ([37.153.225.197])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090627cd00b0096f6647b5e8sm1158677ejc.64.2023.06.09.04.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:11:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Intermittent Not connectable devices reported
From:   Herman Meerlo <herman.meerlo@athom.nl>
In-Reply-To: <CABBYNZLrdKqsYUqu7uN63DWiR4uKxdpFucNNbgM8rFZTpP=Cgg@mail.gmail.com>
Date:   Fri, 9 Jun 2023 13:11:19 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A1B62F6-03CF-445B-AA63-C6717D246EAC@athom.nl>
References: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
 <CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com>
 <CABBYNZLrdKqsYUqu7uN63DWiR4uKxdpFucNNbgM8rFZTpP=Cgg@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



> On 8 Jun 2023, at 18:32, Luiz Augusto von Dentz <luiz.dentz@gmail.com> =
wrote:
>=20
> Hi Herman,
>=20
> On Wed, Jun 7, 2023 at 12:21=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>=20
>> Hi Herman,
>>=20
>> On Fri, Jun 2, 2023 at 2:51=E2=80=AFAM Herman Meerlo =
<herman.meerlo@athom.nl> wrote:
>>>=20
>>> I'm working on a Raspberry Pi device that performs periodic BLE =
discovery and tries to connect to multiple devices. Most of the times =
this goes fine but especially in BLE heavy environments every now and =
then it fails because it says that the device is not found. I have been =
debugging this issue for a few weeks now and it comes down to this:
>>>=20
>>>   =E2=80=A2 Connect to DBus to start the discovery
>>>   =E2=80=A2 Devices are found, interfacesAdded callbacks are made, =
everything looks fine
>>>   =E2=80=A2 Stop discovery
>>>   =E2=80=A2 Directly some devices are removed by the =
interfacesRemoved callback
>>>   =E2=80=A2 My code does not get the device it searches for -> =
unhappy user
>>>=20
>>> What happens under the hood is that DBus removes all devices from =
it's cache that have been indicated by Bluez as being Not connectable. =
I.e. there is no use in keeping them around, you can't connect to them =
anyway. But... this is not true for the device I'm looking for. It is =
marked as Not connectable incorrectly.
>>> So to chase down the problem I create a btmon dump which shows =
indeed that the device is reported to be Not connectable after having =
received a SCAN_RSP:
>>>=20
>>>> HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
>>> LE Advertising Report (0x02)
>>> Num reports: 1
>>> Event type: Scan response - SCAN_RSP (0x04)
>>> Address type: Public (0x00)
>>> Address: F4:B8:5E:64:02:55 (Texas Instruments)
>>> Data length: 26
>>> Name (complete): BeeWi SmartLite
>>> Peripheral Conn. Interval: 0x0028 - 0x0050
>>> TX power: 0 dBm
>>> RSSI: -42 dBm (0xd6)
>>> @ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] =
34.360057
>>> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
>>> RSSI: -42 dBm (0xd6)
>>> Flags: 0x00000004
>>> Not Connectable
>>> Data length: 26
>>> Name (complete): BeeWi SmartLite
>>> Peripheral Conn. Interval: 0x0028 - 0x0050
>>> TX power: 0 dBm
>>>=20
>>> But all ADV_IND PDU's before that clearly indicate that the device =
is connectable, it is only after this SCAN_RSP that it is reported as =
Not connectable:
>>>=20
>>>> HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
>>> LE Advertising Report (0x02)
>>> Num reports: 1
>>> Event type: Connectable undirected - ADV_IND (0x00)
>>> Address type: Public (0x00)
>>> Address: F4:B8:5E:64:02:55 (Texas Instruments)
>>> Data length: 15
>>> Flags: 0x06
>>> LE General Discoverable Mode
>>> BR/EDR Not Supported
>>> Company: Texas Instruments Inc. (13)
>>> Data: 06030108b0e408f7
>>> RSSI: -43 dBm (0xd5)
>>> @ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] =
34.152905
>>> LE Address: 44:6E:FF:00:0D:65 (Resolvable)
>>> RSSI: -74 dBm (0xb6)
>>> Flags: 0x00000000
>>> Data length: 17
>>> Flags: 0x1a
>>> LE General Discoverable Mode
>>> Simultaneous LE and BR/EDR (Controller)
>>> Simultaneous LE and BR/EDR (Host)
>>> TX power: 9 dBm
>>> Company: Apple, Inc. (76)
>>> Type: Unknown (16)
>>> Data: 01188898dc
>>>> HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
>>> LE Advertising Report (0x02)
>>> Num reports: 1
>>> Event type: Connectable undirected - ADV_IND (0x00)
>>> Address type: Random (0x01)
>>> Address: FA:BD:8D:12:26:BF (Static)
>>> Data length: 29
>>> Name (short): P mesh
>>> Flags: 0x04
>>> BR/EDR Not Supported
>>> 128-bit Service UUIDs (partial): 1 entry
>>> Vendor specific
>>> RSSI: -47 dBm (0xd1)
>>> @ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] =
34.157030
>>> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
>>> RSSI: -43 dBm (0xd5)
>>> Flags: 0x00000000
>>> Data length: 15
>>> Flags: 0x06
>>> LE General Discoverable Mode
>>> BR/EDR Not Supported
>>> Company: Texas Instruments Inc. (13)
>>> Data: 06030108b0e408f7
>>>=20
>>> So I am heavily doubting whether the Linux kernel code has a bug in =
handling the SCAN_RSP. Please look at this part of the kernel:
>>>=20
>>> =
https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee38f724=
594dc/net/bluetooth/hci_event.c#L6326
>>>=20
>>> It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will =
overwrite it with any flags it has received with a previous ADV_IND. But =
it does not seem to take into account that in BLE heavy environments the =
previous ADV_IND might be of a totally different device. So every now =
and then it will enter the first path where it will just report the =
device with a NOT_CONNECTABLE flag. Or am I missing something here?
>>=20
>> You are saying that the controller would interleave ADV_IND of
>> different peers before SCAN_RSP, in that case yes that would be
>> possible that the device would be marked as NOT_CONNECTABLE, usually
>> that is not really the case which is why we end up adding the code
>> above:
>>=20
>>     * In the really unlikely case that a controller get confused
>>     * and just sends a scan response event, then it is marked as
>>     * not connectable as well.
>>=20
>> I guess it is not really unlikely after all, so perhaps we need a =
flag
>> indicating this is a standalone SCAN_RSP e.g. =
MGMT_DEV_FOUND_SCAN_RSP,
>> then we can treat it accordingly in userspace.
>=20
> Can you try with the following change:
>=20
> =
https://patchwork.kernel.org/project/bluetooth/patch/20230607194518.290137=
6-1-luiz.dentz@gmail.com/
>=20
> --=20
> Luiz Augusto von Dentz

Yes of course, I am going to give it a try. It will require a complete =
new build setup so it will probably take a while. But really thankful =
that you made a potential fix for this problem. I=E2=80=99ll keep you =
posted.

