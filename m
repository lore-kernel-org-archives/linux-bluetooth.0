Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8842EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjFNQ5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbjFNQ5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 12:57:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176E1FDD
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:57:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b39bf8d5faso3445791fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686761829; x=1689353829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GraWYcd5TT8IQnjh81lqRfjdrx5N1OO9lRecaxuLn0Y=;
        b=LmNccYmcqrwdhVzbta0vHnz8oThpM4jzzpKfGQQX+dC4j2JXeJKVwMUTiG3MyzV1b/
         MUSbwv34H5kjGhPcAWe93slvA07LB4f5RBKkpZnuQqTIZoPDoMGYqQIrkA5MZLJmqSK4
         3w+xDDmkZNcw0mjmjlbShQv5nrT2JO8NAGJ3jg3j8U95r1dA0rRP/DM4cilFtpm4Ll0S
         b9ODvbT9KqEVzyETxWlBr1dB/P/3WhPZ1fcJTYnm8SQaIkWbJNxqJCZi60uFGw5tSZ3i
         1HLX6lRYpKJhuXjfmNhFyw0szrM6yv+TflNXLjeJWQ3P5i+MtkWkpRddGg2IN0Wh1+lv
         +tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761829; x=1689353829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GraWYcd5TT8IQnjh81lqRfjdrx5N1OO9lRecaxuLn0Y=;
        b=FLHrqQvUXVQ256GXX4mklT2LnVtu+9YnU8OWG22K3JIaE5T/zTa/q8vZL8CW19fKLX
         ZuwKsjVM+9SelEDrMYomXbs5q9adlylt5xjhMTOo3fj92vJc8HPUzrXkIu0IuXG8Sqyj
         b+fpTg5ODH06n74o++l5Zyk57cLntd2rgfTep6KdM3P6lSgHkBrx8+g8jN4t/SQPF3TX
         9+7dN3Q4059nd4MznuBbL8DbpCcoDMj01JTfXu2TD6U9Iw0llc0I1S6UP/wBq79c3W5G
         PS3Xu+2c8MTKsvtdiAJOFHkAjPK8apH7iUs/AVOs50mYXGR5/TaKtan09Q+a+mh2q98B
         NK1A==
X-Gm-Message-State: AC+VfDye6KxSo8vLt+xNyQlBFr6PIs0x1JJj/Djq0OrAls0yNyHSX/AG
        tThiLgmXchjomn4UQsz52RplaPvJ9WlFXeJJROs=
X-Google-Smtp-Source: ACHHUZ4Bih8arMD6vpidQY2HvlLthr8ZA91LNnj2Augg9sxItlCDSs/szSAqwrdu0MObzz8IBkkVz5sPACP51lzGTEc=
X-Received: by 2002:a2e:3602:0:b0:2b1:ec1a:88bc with SMTP id
 d2-20020a2e3602000000b002b1ec1a88bcmr7820731lja.43.1686761828735; Wed, 14 Jun
 2023 09:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
 <CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com>
 <CABBYNZLrdKqsYUqu7uN63DWiR4uKxdpFucNNbgM8rFZTpP=Cgg@mail.gmail.com> <0D5B7799-4F61-4D69-A3DA-EF4DE2C443BC@athom.nl>
In-Reply-To: <0D5B7799-4F61-4D69-A3DA-EF4DE2C443BC@athom.nl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jun 2023 09:56:56 -0700
Message-ID: <CABBYNZLtauz4Psxb8k8=Gy6GrMaqS5OiLvKW54=2Ek32Xw1t3w@mail.gmail.com>
Subject: Re: Intermittent Not connectable devices reported
To:     Herman Meerlo <herman.meerlo@athom.nl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Herman,

On Wed, Jun 14, 2023 at 1:29=E2=80=AFAM Herman Meerlo <herman.meerlo@athom.=
nl> wrote:
>
>
>
> > On 8 Jun 2023, at 18:32, Luiz Augusto von Dentz <luiz.dentz@gmail.com> =
wrote:
> >
> > Hi Herman,
> >
> > On Wed, Jun 7, 2023 at 12:21=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Herman,
> >>
> >> On Fri, Jun 2, 2023 at 2:51=E2=80=AFAM Herman Meerlo <herman.meerlo@at=
hom.nl> wrote:
> >>>
> >>> I'm working on a Raspberry Pi device that performs periodic BLE disco=
very and tries to connect to multiple devices. Most of the times this goes =
fine but especially in BLE heavy environments every now and then it fails b=
ecause it says that the device is not found. I have been debugging this iss=
ue for a few weeks now and it comes down to this:
> >>>
> >>>   =E2=80=A2 Connect to DBus to start the discovery
> >>>   =E2=80=A2 Devices are found, interfacesAdded callbacks are made, ev=
erything looks fine
> >>>   =E2=80=A2 Stop discovery
> >>>   =E2=80=A2 Directly some devices are removed by the interfacesRemove=
d callback
> >>>   =E2=80=A2 My code does not get the device it searches for -> unhapp=
y user
> >>>
> >>> What happens under the hood is that DBus removes all devices from it'=
s cache that have been indicated by Bluez as being Not connectable. I.e. th=
ere is no use in keeping them around, you can't connect to them anyway. But=
... this is not true for the device I'm looking for. It is marked as Not co=
nnectable incorrectly.
> >>> So to chase down the problem I create a btmon dump which shows indeed=
 that the device is reported to be Not connectable after having received a =
SCAN_RSP:
> >>>
> >>>> HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
> >>> LE Advertising Report (0x02)
> >>> Num reports: 1
> >>> Event type: Scan response - SCAN_RSP (0x04)
> >>> Address type: Public (0x00)
> >>> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> >>> Data length: 26
> >>> Name (complete): BeeWi SmartLite
> >>> Peripheral Conn. Interval: 0x0028 - 0x0050
> >>> TX power: 0 dBm
> >>> RSSI: -42 dBm (0xd6)
> >>> @ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] 34.360057
> >>> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> >>> RSSI: -42 dBm (0xd6)
> >>> Flags: 0x00000004
> >>> Not Connectable
> >>> Data length: 26
> >>> Name (complete): BeeWi SmartLite
> >>> Peripheral Conn. Interval: 0x0028 - 0x0050
> >>> TX power: 0 dBm
> >>>
> >>> But all ADV_IND PDU's before that clearly indicate that the device is=
 connectable, it is only after this SCAN_RSP that it is reported as Not con=
nectable:
> >>>
> >>>> HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
> >>> LE Advertising Report (0x02)
> >>> Num reports: 1
> >>> Event type: Connectable undirected - ADV_IND (0x00)
> >>> Address type: Public (0x00)
> >>> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> >>> Data length: 15
> >>> Flags: 0x06
> >>> LE General Discoverable Mode
> >>> BR/EDR Not Supported
> >>> Company: Texas Instruments Inc. (13)
> >>> Data: 06030108b0e408f7
> >>> RSSI: -43 dBm (0xd5)
> >>> @ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] 34.152905
> >>> LE Address: 44:6E:FF:00:0D:65 (Resolvable)
> >>> RSSI: -74 dBm (0xb6)
> >>> Flags: 0x00000000
> >>> Data length: 17
> >>> Flags: 0x1a
> >>> LE General Discoverable Mode
> >>> Simultaneous LE and BR/EDR (Controller)
> >>> Simultaneous LE and BR/EDR (Host)
> >>> TX power: 9 dBm
> >>> Company: Apple, Inc. (76)
> >>> Type: Unknown (16)
> >>> Data: 01188898dc
> >>>> HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
> >>> LE Advertising Report (0x02)
> >>> Num reports: 1
> >>> Event type: Connectable undirected - ADV_IND (0x00)
> >>> Address type: Random (0x01)
> >>> Address: FA:BD:8D:12:26:BF (Static)
> >>> Data length: 29
> >>> Name (short): P mesh
> >>> Flags: 0x04
> >>> BR/EDR Not Supported
> >>> 128-bit Service UUIDs (partial): 1 entry
> >>> Vendor specific
> >>> RSSI: -47 dBm (0xd1)
> >>> @ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] 34.157030
> >>> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> >>> RSSI: -43 dBm (0xd5)
> >>> Flags: 0x00000000
> >>> Data length: 15
> >>> Flags: 0x06
> >>> LE General Discoverable Mode
> >>> BR/EDR Not Supported
> >>> Company: Texas Instruments Inc. (13)
> >>> Data: 06030108b0e408f7
> >>>
> >>> So I am heavily doubting whether the Linux kernel code has a bug in h=
andling the SCAN_RSP. Please look at this part of the kernel:
> >>>
> >>> https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee3=
8f724594dc/net/bluetooth/hci_event.c#L6326
> >>>
> >>> It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will o=
verwrite it with any flags it has received with a previous ADV_IND. But it =
does not seem to take into account that in BLE heavy environments the previ=
ous ADV_IND might be of a totally different device. So every now and then i=
t will enter the first path where it will just report the device with a NOT=
_CONNECTABLE flag. Or am I missing something here?
> >>
> >> You are saying that the controller would interleave ADV_IND of
> >> different peers before SCAN_RSP, in that case yes that would be
> >> possible that the device would be marked as NOT_CONNECTABLE, usually
> >> that is not really the case which is why we end up adding the code
> >> above:
> >>
> >>     * In the really unlikely case that a controller get confused
> >>     * and just sends a scan response event, then it is marked as
> >>     * not connectable as well.
> >>
> >> I guess it is not really unlikely after all, so perhaps we need a flag
> >> indicating this is a standalone SCAN_RSP e.g. MGMT_DEV_FOUND_SCAN_RSP,
> >> then we can treat it accordingly in userspace.
> >
> > Can you try with the following change:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20230607194518.290=
1376-1-luiz.dentz@gmail.com/
> >
> > --
> > Luiz Augusto von Dentz
>
> I can confirm this change works. I see this now in the batman logs instea=
d of the =E2=80=9CNot Connectable=E2=80=9D:
>
>
> @ MGMT Event: Device Found (0x0012) plen 34           {0x0001} [hci0] 37.=
727785
>         LE Address: E1:A1:94:4C:15:D8 (Static)
>         RSSI: -80 dBm (0xb0)
>         Flags: 0x00000020. <=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
 the new flag!
>           Unknown device flag (0x00000020)
>         Data length: 20
>         Name (complete): F48F92CBE54430A8EA
>

Yeah, that is to be expected, I will document and add support to btmon
to print the flag properly.

--=20
Luiz Augusto von Dentz
