Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D942C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjFHQdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFHQdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A32119
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 09:33:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso1015342e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686241983; x=1688833983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjR1VXcn9zF31lfQtEdXfr8wK4MLRUCXJRS83/+MZjA=;
        b=JsTni4gLFQmvm/W/OP9g119/RF5TfFnrCf2gMVkVkTlfQifPC8e6XPyTTj21qzZa0v
         ueqpC9tRNLWduE00tIw2WChmayVN5Wq990K3M/2kgQVRogWYJT8ottuTSPbUaxWolBUJ
         KGSDwVAfNuuoc8AYA2nw0zn2LlHbscb+lZoIpopOd4g4uR0V4Gqseh8wGgeAuZCbWRqX
         OHEOVGhTkcy6BAyH9poJzc87A/ulxGTjOs6TMk0ROC+jyPSd3vamDWAVgMFbJIp47Y4h
         +RByP8hklUuokVHJIN1HWNY1Msxpblor8cwb/XQXlMDgA6RlQUB1fe8imZqJFTpR6oHK
         kICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241983; x=1688833983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjR1VXcn9zF31lfQtEdXfr8wK4MLRUCXJRS83/+MZjA=;
        b=g2M8prx3j8b06bvlwYa1nYo/JTfW2VM34uExzKXJRqmxYVxgjEqoQLaoxenXpJPJNr
         kjV9kqmyZmbA6rMNV/M2DGJ1k8AptYJnMyjSslCeWp96PTEkZt1PdvQxE/I2oeL/QJ0H
         E3i1UqG4m4anbokoa7A84pLoOxlujLTvdpQhd2/nR6INsXC49N3B73h13NDedtPLwOC7
         MS3Xa+7mqR6DeD92FuiTO2Z4OTsuCR4xbT4Eui3/Tw7/YmcuVDIfMgmpXjbYMh8ipoSV
         C/p5PeooFnLjSRzP+hYX5V04HOF1xt3lmYPu97XlEq3UU+qScXHseTa2r9tmsCkx+lbO
         sVzA==
X-Gm-Message-State: AC+VfDxDQAq1fU0RR+Q5zsYgeJBi+76WwgY3hUFwHKE2tg2E91wJKMWo
        K1GgqlSt2HK2W/G5Y1zjxwFP16dtQ1LcTHWbNbgq56bKbCs=
X-Google-Smtp-Source: ACHHUZ7xHrRozwwRQIzHQm7pRx8rUQL4+dUtytgFdvtsDWBRbdeUL551zhaNFbNp/k68T291TP08p4Wv5tBOwnGX7O8=
X-Received: by 2002:a2e:8687:0:b0:2b1:d210:10d5 with SMTP id
 l7-20020a2e8687000000b002b1d21010d5mr3504206lji.33.1686241982454; Thu, 08 Jun
 2023 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl> <CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com>
In-Reply-To: <CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jun 2023 09:32:49 -0700
Message-ID: <CABBYNZLrdKqsYUqu7uN63DWiR4uKxdpFucNNbgM8rFZTpP=Cgg@mail.gmail.com>
Subject: Re: Intermittent Not connectable devices reported
To:     Herman Meerlo <herman.meerlo@athom.nl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Herman,

On Wed, Jun 7, 2023 at 12:21=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Herman,
>
> On Fri, Jun 2, 2023 at 2:51=E2=80=AFAM Herman Meerlo <herman.meerlo@athom=
.nl> wrote:
> >
> > I'm working on a Raspberry Pi device that performs periodic BLE discove=
ry and tries to connect to multiple devices. Most of the times this goes fi=
ne but especially in BLE heavy environments every now and then it fails bec=
ause it says that the device is not found. I have been debugging this issue=
 for a few weeks now and it comes down to this:
> >
> >    =E2=80=A2 Connect to DBus to start the discovery
> >    =E2=80=A2 Devices are found, interfacesAdded callbacks are made, eve=
rything looks fine
> >    =E2=80=A2 Stop discovery
> >    =E2=80=A2 Directly some devices are removed by the interfacesRemoved=
 callback
> >    =E2=80=A2 My code does not get the device it searches for -> unhappy=
 user
> >
> > What happens under the hood is that DBus removes all devices from it's =
cache that have been indicated by Bluez as being Not connectable. I.e. ther=
e is no use in keeping them around, you can't connect to them anyway. But..=
. this is not true for the device I'm looking for. It is marked as Not conn=
ectable incorrectly.
> > So to chase down the problem I create a btmon dump which shows indeed t=
hat the device is reported to be Not connectable after having received a SC=
AN_RSP:
> >
> > > HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
> > LE Advertising Report (0x02)
> > Num reports: 1
> > Event type: Scan response - SCAN_RSP (0x04)
> > Address type: Public (0x00)
> > Address: F4:B8:5E:64:02:55 (Texas Instruments)
> > Data length: 26
> > Name (complete): BeeWi SmartLite
> > Peripheral Conn. Interval: 0x0028 - 0x0050
> > TX power: 0 dBm
> > RSSI: -42 dBm (0xd6)
> > @ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] 34.360057
> > LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> > RSSI: -42 dBm (0xd6)
> > Flags: 0x00000004
> > Not Connectable
> > Data length: 26
> > Name (complete): BeeWi SmartLite
> > Peripheral Conn. Interval: 0x0028 - 0x0050
> > TX power: 0 dBm
> >
> > But all ADV_IND PDU's before that clearly indicate that the device is c=
onnectable, it is only after this SCAN_RSP that it is reported as Not conne=
ctable:
> >
> > > HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
> > LE Advertising Report (0x02)
> > Num reports: 1
> > Event type: Connectable undirected - ADV_IND (0x00)
> > Address type: Public (0x00)
> > Address: F4:B8:5E:64:02:55 (Texas Instruments)
> > Data length: 15
> > Flags: 0x06
> > LE General Discoverable Mode
> > BR/EDR Not Supported
> > Company: Texas Instruments Inc. (13)
> > Data: 06030108b0e408f7
> > RSSI: -43 dBm (0xd5)
> > @ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] 34.152905
> > LE Address: 44:6E:FF:00:0D:65 (Resolvable)
> > RSSI: -74 dBm (0xb6)
> > Flags: 0x00000000
> > Data length: 17
> > Flags: 0x1a
> > LE General Discoverable Mode
> > Simultaneous LE and BR/EDR (Controller)
> > Simultaneous LE and BR/EDR (Host)
> > TX power: 9 dBm
> > Company: Apple, Inc. (76)
> > Type: Unknown (16)
> > Data: 01188898dc
> > > HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
> > LE Advertising Report (0x02)
> > Num reports: 1
> > Event type: Connectable undirected - ADV_IND (0x00)
> > Address type: Random (0x01)
> > Address: FA:BD:8D:12:26:BF (Static)
> > Data length: 29
> > Name (short): P mesh
> > Flags: 0x04
> > BR/EDR Not Supported
> > 128-bit Service UUIDs (partial): 1 entry
> > Vendor specific
> > RSSI: -47 dBm (0xd1)
> > @ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] 34.157030
> > LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> > RSSI: -43 dBm (0xd5)
> > Flags: 0x00000000
> > Data length: 15
> > Flags: 0x06
> > LE General Discoverable Mode
> > BR/EDR Not Supported
> > Company: Texas Instruments Inc. (13)
> > Data: 06030108b0e408f7
> >
> > So I am heavily doubting whether the Linux kernel code has a bug in han=
dling the SCAN_RSP. Please look at this part of the kernel:
> >
> > https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee38f=
724594dc/net/bluetooth/hci_event.c#L6326
> >
> > It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will ove=
rwrite it with any flags it has received with a previous ADV_IND. But it do=
es not seem to take into account that in BLE heavy environments the previou=
s ADV_IND might be of a totally different device. So every now and then it =
will enter the first path where it will just report the device with a NOT_C=
ONNECTABLE flag. Or am I missing something here?
>
> You are saying that the controller would interleave ADV_IND of
> different peers before SCAN_RSP, in that case yes that would be
> possible that the device would be marked as NOT_CONNECTABLE, usually
> that is not really the case which is why we end up adding the code
> above:
>
>      * In the really unlikely case that a controller get confused
>      * and just sends a scan response event, then it is marked as
>      * not connectable as well.
>
> I guess it is not really unlikely after all, so perhaps we need a flag
> indicating this is a standalone SCAN_RSP e.g. MGMT_DEV_FOUND_SCAN_RSP,
> then we can treat it accordingly in userspace.

Can you try with the following change:

https://patchwork.kernel.org/project/bluetooth/patch/20230607194518.2901376=
-1-luiz.dentz@gmail.com/

--=20
Luiz Augusto von Dentz
