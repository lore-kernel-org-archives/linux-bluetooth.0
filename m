Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3322764F6D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBCVnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:43:45 -0500
Received: from mout01.posteo.de ([185.67.36.65]:45885 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBCVnm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 16:43:42 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DB08B160060
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Feb 2021 22:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1612388563; bh=aasp9tIBVQE7cNs4ArnnjJG5+1KqmwcA5AKvaB4P9vc=;
        h=Subject:From:To:Date:From;
        b=bX8ysqHl5Yu8lM/hsuXlDxIsK0AujHb4U6wBtI7NVC2npmSS2G2ygEPEdsOBWWA1E
         LV/daLYRToHwNEh1r/eTizu57tj8qveI0jttYIEO6v8vFEdeRN1bkGd38ltbIciZr/
         uQUzidg5aO8ELL1t1kfzMbeY7gbGRtqg1NQYNN1tqnG9DcFJwDfUc8w1G3Dl8C4Axb
         BD9aQ75a55k3zJf4ZNch6ESJ7kKinEZQThs1l5N+hADefhvglZNFni/amF76h4xd7l
         36N/KdvF0lOL2PzIR/7/dGm4ulF4fq2QmRyMJXZjDg9FSSthijIFpdQzvqB/RRNdue
         uf5c09hIE74Xw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DWFXM2FBQz9rxN
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Feb 2021 22:42:43 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Dualshock 4 usb issues
From:   "shhhum" <shum@posteo.net>
To:     <linux-bluetooth@vger.kernel.org>
Date:   Wed, 03 Feb 2021 23:43:24 +0300
Message-Id: <C906S5DXOPDO.28FTLRVJTQB56@shum>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello. I'm using BlueZ 5.55 and Linux 5.10.12.

After following Gentoo guide to connect DS4 with bluetooth -
https://wiki.gentoo.org/wiki/Sony_DualShock#DualShock_4 - I was able to
successfully pair, trust and connect the gamepad.

[bluetooth]# pair A4:53:85:AF:F5:05=20
Attempting to pair with A4:53:85:AF:F5:05
[CHG] Device A4:53:85:AF:F5:05 Connected: yes
[CHG] Device A4:53:85:AF:F5:05 UUIDs: 00001124-0000-1000-8000-00805f9b34fb
[CHG] Device A4:53:85:AF:F5:05 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
[CHG] Device A4:53:85:AF:F5:05 ServicesResolved: yes
[CHG] Device A4:53:85:AF:F5:05 Paired: yes
Pairing successful
[CHG] Device A4:53:85:AF:F5:05 WakeAllowed: yes
Authorize service
[agent] Authorize service 00001124-0000-1000-8000-00805f9b34fb (yes/no): ye=
s
[Wireless Controller]# trust A4:53:85:AF:F5:05=20
[CHG] Device A4:53:85:AF:F5:05 Trusted: yes
Changing A4:53:85:AF:F5:05 trust succeeded
[Wireless Controller]# info
Device A4:53:85:AF:F5:05 (public)
	Name: Wireless Controller
	Alias: Wireless Controller
	Class: 0x00002508
	Icon: input-gaming
	Paired: yes
	Trusted: yes
	Blocked: no
	Connected: yes
	WakeAllowed: yes
	LegacyPairing: no
	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information (00001200-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v054Cp09CCd0100

However, recently I've started to notice that after plugging my DS4 with us=
b I
can no longer connect my DS4 with bluetooth. After some "debugging" I've
noticed that for some reason plugging DS4 with usb cable prints those lines=
 in bluetoothctl:

[CHG] Device A4:53:85:AF:F5:05 Connected: no
[CHG] Device A4:53:85:AF:F5:05 Trusted: no
Authorize service
[agent] Authorize service 00001124-0000-1000-8000-00805f9b34fb (yes/no):

And after some time:

[agent] Authorize service 00001124-0000-1000-8000-00805f9b34fb (yes/no): Re=
quest canceled
[DEL] Device A4:53:85:AF:F5:05 Wireless Controller

So my guess is while I'm doing my "buisness", authorization request gets
cancelled and BlueZ automatically deletes the device. But why BlueZ request=
ing
authorization in the first place if I'm plugging my gamepad through usb?
Inetestingly, authorization is requested  every time I plug my gamepad with=
 USB,
no matter if my device is already in "trusted" state.

I'm not sure if this is bug with BlueZ, Linux kernel or if it's even a bug =
at all,
but since BlueZ deletes my device, I decided to write this to linux-bluetoo=
th=20
mailing list. I am happy to provide further information if required.

Thanks.
