Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_LITECOIN_ID,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C256EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFBF64E2E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 21:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGVM4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Feb 2021 16:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBGVMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Feb 2021 16:12:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80AFC06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Feb 2021 13:12:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bl23so21544430ejb.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Feb 2021 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pAuJ8RMHlVUhdo66TnvZPdurAujiZLCAegdCTuBKELo=;
        b=JoY37QQtxDyZMO9D7TWWAuQ0UMXLtyuUSEc6u3psGOMM3YEA7NQmi17bf0hNeDqULw
         UMObt5LTw5jaNin2dOMAwUzOjOKDkRhMdi9I8Q7Cz4No0CHX2bzSPLBw4vePo/lxP8Px
         GyKejOcxkzLjDLN/h5VtbYs1vn3tUQi6KnzSbL6XynMWVAWxgLrJMitkzpQI4+pE+MfD
         ifmlMKlWNFi4piKmqsaXBJThuZlFZmmaBl9VvKUOjhDUacOQ7FXJ/9Vg7xefbKZ4jL5c
         BGEXkKAGG3o/JoodtsHRPje2gnifazCrQJDJtYuzbJvZrjRlkjM4zGkjLpVfAgVUyPJu
         OGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pAuJ8RMHlVUhdo66TnvZPdurAujiZLCAegdCTuBKELo=;
        b=BiXwvOGGhLwDUpcLg5PGH3pxpIbAW1CeG5XEMXK05oJdnh5DXKlxGMzcqY5XszblEf
         fC+DGcO50TKg1YVNx1xGbwSqxjDiPK2wfpxuO68FzSP3yxuYmutK2bfZvAf12G2s9k6N
         EYmwEHTirsGFUvzsihS2fDBiBOHtRN84/eTtXICztt7Nvs/f3F5LisJ5bFFoAkMXS3xh
         vw/Q5tkab/L7uQllQdSTnECVy2nUMINZYQdKwcz7y1o/hw/oiyiAYrL5KSspRu87rqkU
         fUfpf+bwIE4t1mn6rHvfgHGyysr6mdmPmcU66jnvDgDfMBQF4rvWrVImWHNdcSFaGP5x
         EjAg==
X-Gm-Message-State: AOAM532N2STMkOApV86Mh5vdY3Am1z4BueTGzcDbrs8JxYpkjmsdZ+0e
        /f1RL++iU2E6MVy+66TPHJr3KLwIfqVxJuOiL3kRL28dMlI=
X-Google-Smtp-Source: ABdhPJyqdGEXC7ir+B4sTa/cXaeY0uUXBR0AFZTOcuwu/FLCxktPF1l/NnWc0oTFOw4VRnKLpb642opE+wCQC/LcuOU=
X-Received: by 2002:a17:906:15c7:: with SMTP id l7mr14070545ejd.226.1612732333509;
 Sun, 07 Feb 2021 13:12:13 -0800 (PST)
MIME-Version: 1.0
References: <CAG17S_Nhp2DtP0jqHkdq51ZXOgGmLwRhzvqH0wmj2jSao7pZLQ@mail.gmail.com>
In-Reply-To: <CAG17S_Nhp2DtP0jqHkdq51ZXOgGmLwRhzvqH0wmj2jSao7pZLQ@mail.gmail.com>
From:   "mathieu.stephan@gmail.com" <mathieu.stephan@gmail.com>
Date:   Sun, 7 Feb 2021 22:12:00 +0100
Message-ID: <CAHdu5-69z1S0YcOmRMn7MnfvSAWt5H5oZzkZNCtj5tVp-MfOfg@mail.gmail.com>
Subject: Re: keyboard pairing railures
To:     KeithG <ys3al35l@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

The Mooltipass team has indeed seen this quite often recently.
https://github.com/mooltipass/minible/issues/205
https://github.com/bluez/bluez/issues/55

We still need to provide the requested trace :/
Mathieu

On Sun, Feb 7, 2021 at 10:01 PM KeithG <ys3al35l@gmail.com> wrote:
>
> I have an HP keyboard and have paired it with my RPI3B. I can
> eventually get it to pair, but it takes many many attempts until it
> finally pairs so I can trust it and use it. The latest bluez on Arch
> Linux is 5.55 which is installed and bluez-tools is 0.2.0 I get this
> when I attempt a pair:
> [bluetooth]# pair  08:B7:38:11:A6:C2
> Attempting to pair with 08:B7:38:11:A6:C2
> [CHG] Device 08:B7:38:11:A6:C2 Connected: yes
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> [agent] Passkey: 104817
> Failed to pair: org.bluez.Error.AuthenticationFailed
> [CHG] Device 08:B7:38:11:A6:C2 Connected: no
> I restart bluetooth, restart the keyboard and still get this. I keep
> trying until it finally pairs. It feels like some sort of race
> condition or timing or something that it sometimes connects and
> sometimes not. Once paired/trusted, it seems to always work.
>
> In the journal, I always get these messages when I start bluetooth. My
> main.conf has only one change from the repo "AutoEnable=3Dtrue" added at
> the end:
> Feb 07 14:04:46 rune64 systemd[1]: Starting Bluetooth service...
> Feb 07 14:04:46 rune64 bluetoothd[4106]: Bluetooth daemon 5.55
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRPageScanType=E2=80=9D in group =E2=80=9CController=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRPageScanInterval=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRPageScanWindow=E2=80=9D in group =E2=80=9CController=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRInquiryScanType=E2=80=9D in group =E2=80=9CController=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRInquiryScanInterval=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRInquiryScanWindow=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRLinkSupervisionTimeout=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRPageTimeout=E2=80=9D in group =E2=80=9CController=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRMinSniffInterval=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CBRMaxSniffInterval=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEMinAdvertisementInterval=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEMaxAdvertisementInterval=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEMultiAdvertisementRotationInterval=E2=80=9D in group =E2=80=9C=
Controller=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanIntervalAutoConnect=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanWindowAutoConnect=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanIntervalSuspend=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanWindowSuspend=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanIntervalDiscovery=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanWindowDiscovery=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanIntervalAdvMonitor=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanWindowAdvMonitor=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanIntervalConnect=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEScanWindowConnect=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEMinConnectionInterval=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEMaxConnectionInterval=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEConnectionLatency=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEConnectionSupervisionTimeout=E2=80=9D in group =E2=80=9CContro=
ller=E2=80=9D
> Feb 07 14:04:46 rune64 bluetoothd[4106]:
> src/main.c:parse_controller_config() Key file does not have key
> =E2=80=9CLEAutoconnecttimeout=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
> Feb 07 14:04:46 rune64 systemd[1]: Started Bluetooth service.
> Feb 07 14:04:46 rune64 bluetoothd[4106]: Starting SDP server
> Feb 07 14:04:46 rune64 bluetoothd[4106]: Bluetooth management
> interface 1.14 initialized
>
> When I finally connect it I get this which looks normal:
> Feb 07 14:09:19 rune64 bluetoothd[4106]: Set device flags return
> status: Unknown Command
> Feb 07 14:09:50 rune64 kernel: Bluetooth: HIDP (Human Interface
> Emulation) ver 1.2
> Feb 07 14:09:50 rune64 kernel: Bluetooth: HIDP socket layer initialized
> Feb 07 14:09:50 rune64 kernel: hid-generic 0005:04CA:0079.0001:
> unknown main item tag 0x0
> Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
> Keyboard as /devices/platform/soc/3f201000.serial/serial0/serial0-0/bluet=
ooth/hci0/hci0:11/0005:04CA:0079.0001/input/in>
> Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
> Consumer Control as
> /devices/platform/soc/3f201000.serial/serial0/serial0-0/bluetooth/hci0/hc=
i0:11/0005:04CA:0079.0001/>
> Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
> System Control as
> /devices/platform/soc/3f201000.serial/serial0/serial0-0/bluetooth/hci0/hc=
i0:11/0005:04CA:0079.0001/in>
> Feb 07 14:09:50 rune64 kernel: hid-generic 0005:04CA:0079.0001:
> input,hidraw0: BLUETOOTH HID v5.01 Keyboard [HP Bluetooth Keyboard
> K4000] on 43:45:c0:00:1f:ac
>
> I do not remember this being a problem in the past.
>
> Thanks!
