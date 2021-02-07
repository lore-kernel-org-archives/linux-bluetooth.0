Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_LITECOIN_ID,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D5C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837FD64E40
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Feb 2021 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBGVAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Feb 2021 16:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGVAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Feb 2021 16:00:01 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1BC06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Feb 2021 12:59:20 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 63so12380745oty.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Feb 2021 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tU6BbMqjEaitdyZJszOVpD7ndDOu3xAl7ppZyHvpYYk=;
        b=r+L/DxmXF4WbCe4RPN8OZeTSA/wg+6o44QM5OGaTqj4SsWxTSNMWwHUO3Bs7ZU/pbC
         w9J8V+OytXx8UVVcfl4yJL461OdrapxOzMrXEvsKF6aWwAqKQ54Ze6FM6AmUyoNpDKnM
         GqQFrU+xzO63OOi6uZsJ61YZDHStAEtyIqEROmJMqF3ekYJPRYl4yxK0Hr//CObpQYJJ
         MibIoLuswHk63T4DPmIPkNgE2R+Gdmi31od6RyKaAK74fSkGnRcQ/QCuuQBSn6lrYpqJ
         QMVNRJSisJA1zNWNzdprhPV5G2rxnbFpdX1RNj4kYYL3cjT6K8XJeH6x2bIUnSsHbKAq
         cweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tU6BbMqjEaitdyZJszOVpD7ndDOu3xAl7ppZyHvpYYk=;
        b=l0TpB7DizOMyUFevHxDqiKhddNU1ruhUAsjeNZe9tAZTFKuFoxEkv4gEs9ldM4hMKB
         8/7l3Bfr+zaStZklLOEonIDM+5K7XLUw10bYVPeQ9nPJk67fnvDuKPS6xmTa3W6y6Bqi
         oCGU3IQvJbJlFFgiWzC3EMZHBSRkMGF0/1DTdrMCfXZa2Iqyj40K84f97NT7h/uJkqoY
         +GG8FNra8FVNB9jx5FgDDUCPAnbmoq8azfkKbSvjbCvHQ5csK5BcdqkCyDJAiiR4u2a3
         AC54vGYBu50AZu32ik5K4yPrAoURLtt291WGZMSyXu3SuYRvSadt0F0AzdufgRaJYnex
         KUdA==
X-Gm-Message-State: AOAM532KRef+GtBjyYIVo579CsbBMtGOMPmC9irenpuoJKMo/QGvm088
        wZ878lJ3FfChKKiNXU6ann1WkCpl1jTdIg5L1qqsSz7ojqk=
X-Google-Smtp-Source: ABdhPJyU7QbY2AaMrm3vMrytPegqp43WcYzHIXsO1WhQRGwsK5eiPR1bWggA2O1Wf/CKaUw8w4db4n09ZIu2mXjept4=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr11003432otp.128.1612731559974;
 Sun, 07 Feb 2021 12:59:19 -0800 (PST)
MIME-Version: 1.0
From:   KeithG <ys3al35l@gmail.com>
Date:   Sun, 7 Feb 2021 14:59:09 -0600
Message-ID: <CAG17S_Nhp2DtP0jqHkdq51ZXOgGmLwRhzvqH0wmj2jSao7pZLQ@mail.gmail.com>
Subject: keyboard pairing railures
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have an HP keyboard and have paired it with my RPI3B. I can
eventually get it to pair, but it takes many many attempts until it
finally pairs so I can trust it and use it. The latest bluez on Arch
Linux is 5.55 which is installed and bluez-tools is 0.2.0 I get this
when I attempt a pair:
[bluetooth]# pair  08:B7:38:11:A6:C2
Attempting to pair with 08:B7:38:11:A6:C2
[CHG] Device 08:B7:38:11:A6:C2 Connected: yes
[agent] Passkey: 104817
[agent] Passkey: 104817
[agent] Passkey: 104817
[agent] Passkey: 104817
[agent] Passkey: 104817
[agent] Passkey: 104817
[agent] Passkey: 104817
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device 08:B7:38:11:A6:C2 Connected: no
I restart bluetooth, restart the keyboard and still get this. I keep
trying until it finally pairs. It feels like some sort of race
condition or timing or something that it sometimes connects and
sometimes not. Once paired/trusted, it seems to always work.

In the journal, I always get these messages when I start bluetooth. My
main.conf has only one change from the repo "AutoEnable=3Dtrue" added at
the end:
Feb 07 14:04:46 rune64 systemd[1]: Starting Bluetooth service...
Feb 07 14:04:46 rune64 bluetoothd[4106]: Bluetooth daemon 5.55
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRPageScanType=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRPageScanInterval=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRPageScanWindow=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRInquiryScanType=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRInquiryScanInterval=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRInquiryScanWindow=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRLinkSupervisionTimeout=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRPageTimeout=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRMinSniffInterval=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CBRMaxSniffInterval=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEMinAdvertisementInterval=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEMaxAdvertisementInterval=E2=80=9D in group =E2=80=9CController=
=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEMultiAdvertisementRotationInterval=E2=80=9D in group =E2=80=9CCo=
ntroller=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanIntervalAutoConnect=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanWindowAutoConnect=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanIntervalSuspend=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanWindowSuspend=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanIntervalDiscovery=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanWindowDiscovery=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanIntervalAdvMonitor=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanWindowAdvMonitor=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanIntervalConnect=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEScanWindowConnect=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEMinConnectionInterval=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEMaxConnectionInterval=E2=80=9D in group =E2=80=9CController=E2=
=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEConnectionLatency=E2=80=9D in group =E2=80=9CController=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEConnectionSupervisionTimeout=E2=80=9D in group =E2=80=9CControll=
er=E2=80=9D
Feb 07 14:04:46 rune64 bluetoothd[4106]:
src/main.c:parse_controller_config() Key file does not have key
=E2=80=9CLEAutoconnecttimeout=E2=80=9D in group =E2=80=9CController=E2=80=
=9D
Feb 07 14:04:46 rune64 systemd[1]: Started Bluetooth service.
Feb 07 14:04:46 rune64 bluetoothd[4106]: Starting SDP server
Feb 07 14:04:46 rune64 bluetoothd[4106]: Bluetooth management
interface 1.14 initialized

When I finally connect it I get this which looks normal:
Feb 07 14:09:19 rune64 bluetoothd[4106]: Set device flags return
status: Unknown Command
Feb 07 14:09:50 rune64 kernel: Bluetooth: HIDP (Human Interface
Emulation) ver 1.2
Feb 07 14:09:50 rune64 kernel: Bluetooth: HIDP socket layer initialized
Feb 07 14:09:50 rune64 kernel: hid-generic 0005:04CA:0079.0001:
unknown main item tag 0x0
Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
Keyboard as /devices/platform/soc/3f201000.serial/serial0/serial0-0/bluetoo=
th/hci0/hci0:11/0005:04CA:0079.0001/input/in>
Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
Consumer Control as
/devices/platform/soc/3f201000.serial/serial0/serial0-0/bluetooth/hci0/hci0=
:11/0005:04CA:0079.0001/>
Feb 07 14:09:50 rune64 kernel: input: HP Bluetooth Keyboard K4000
System Control as
/devices/platform/soc/3f201000.serial/serial0/serial0-0/bluetooth/hci0/hci0=
:11/0005:04CA:0079.0001/in>
Feb 07 14:09:50 rune64 kernel: hid-generic 0005:04CA:0079.0001:
input,hidraw0: BLUETOOTH HID v5.01 Keyboard [HP Bluetooth Keyboard
K4000] on 43:45:c0:00:1f:ac

I do not remember this being a problem in the past.

Thanks!
