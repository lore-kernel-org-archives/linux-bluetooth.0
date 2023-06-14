Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954DEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 08:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjFNI3i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbjFNI3e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 04:29:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4015611F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 01:29:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98276e2a4bbso35975866b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=athom.nl; s=google; t=1686731372; x=1689323372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8H62R/XZqS1qG78DlzbjF8IusbF8/jqWzyjlAo0nzA=;
        b=cq7ggcct5zOwoTVfgE/mxmjJ9kTet/+gQ3aImP6RGViCwJHhjEcnnOcKXJiGQ+JPSI
         UM4QTeESd/g/53PjTfTZwrJ2/dd1L8haUnoGbMGa4eANiCa8L7/55eJUjVf/uHiOfWEd
         otgeStTvNrYJT9x5EVN8aB7Qs+MFUmiSEu6nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686731372; x=1689323372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8H62R/XZqS1qG78DlzbjF8IusbF8/jqWzyjlAo0nzA=;
        b=DAjvi01cKQXxsFkDchyAXiC5PNf6i3ygviIF86z9pAlSWwUA/gmtaCrYhyahDSP/Up
         QHJ3sdYuufJtjGsu7GbPlLrwt+Ao/XNGVAB1Pn6HWLNmL1/+1I+Oa8pU5jkLByvyOYPp
         I2h2wQtVSKVapUnZB4RTaceFpNFkGvWer6jPlzfWWVEzEU+4/ytTL6gWwpxqlII8orFL
         wBftKp7U/1WRh7ran+mEvQt462VA66PXzb9VqBzpttp07/LqMxLrJ5fRSiy/qRioQMwJ
         E3X4uLkh/aYmqyRPZQxsBLZ8IBX4HlmhPyrshINR8DUe5ze5ImvoXv3H354JHL+hjfJu
         NCow==
X-Gm-Message-State: AC+VfDy5LsDS42ja3aIdxHvsDmCNhWgE9/5GmGqwd5AfOuNaTSe1XGqv
        96F4adJ7hTud+E1fwEQqKU6b4X9GTzwTAA0MYqCHKA==
X-Google-Smtp-Source: ACHHUZ7xhkJ/1Tb0NHMlQtJf1p1hcbKMcBun1jwvrpT9V+k9vMHn8z2+4jyWcBZYUplBmFbR5O/isw==
X-Received: by 2002:a17:907:16a4:b0:974:216f:dc36 with SMTP id hc36-20020a17090716a400b00974216fdc36mr14466974ejc.17.1686731371670;
        Wed, 14 Jun 2023 01:29:31 -0700 (PDT)
Received: from smtpclient.apple ([37.153.225.197])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906455300b00978993e0d21sm7670281ejq.78.2023.06.14.01.29.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:29:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Intermittent Not connectable devices reported
From:   Herman Meerlo <herman.meerlo@athom.nl>
In-Reply-To: <CABBYNZLrdKqsYUqu7uN63DWiR4uKxdpFucNNbgM8rFZTpP=Cgg@mail.gmail.com>
Date:   Wed, 14 Jun 2023 10:29:19 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D5B7799-4F61-4D69-A3DA-EF4DE2C443BC@athom.nl>
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

I can confirm this change works. I see this now in the batman logs =
instead of the =E2=80=9CNot Connectable=E2=80=9D:


@ MGMT Event: Device Found (0x0012) plen 34           {0x0001} [hci0] =
37.727785
        LE Address: E1:A1:94:4C:15:D8 (Static)
        RSSI: -80 dBm (0xb0)
        Flags: 0x00000020. <=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94 =
the new flag!
          Unknown device flag (0x00000020)
        Data length: 20
        Name (complete): F48F92CBE54430A8EA

