Return-Path: <SRS0=BvBO=6Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E7C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DDC2082E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 10 May 2020 18:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=espindo.la header.i=@espindo.la header.b="oVz4Twag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgEJSG3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 10 May 2020 14:06:29 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:15083 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgEJSG3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 10 May 2020 14:06:29 -0400
Date:   Sun, 10 May 2020 18:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la;
        s=protonmail; t=1589133984;
        bh=ddFGWYdTElVa3ioIpGKxscsXx0XToFeJ9IukXmB0XRQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=oVz4Twag/ntpvEj1Vds6hoU4NsAiqxAqdt35XB/Q44Ft3savjOY3q8Fkc4lyO5vIQ
         fGbbQvLPbT94H4wmx5nSWCIUaiw/IYcc7F/xvxAGPtiv/nUZ3/IZQG+sM9Rixs1K2i
         bfAtjp8IFwtdiwkKQuMQBNqP2UljXi+pq5eYn+F8=
To:     linux-bluetooth@vger.kernel.org
From:   Rafael Avila de Espindola <rafael@espindo.la>
Reply-To: Rafael Avila de Espindola <rafael@espindo.la>
Subject: git bluetoothd getting disconnected from dbus
Message-ID: <875zd33bsf.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="b1_bc04763d9c1f5551357c30930d0111d9"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.

--b1_bc04763d9c1f5551357c30930d0111d9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I compiled a new version of bluez to try help test an
issue
(https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/880), but
now bluetoothd is being disconnected from dbus.

This is on a fedora 32, so the dbus is actually
https://github.com/bus1/dbus-broker.

The bluz revision is 3146b7a0785758be2d4e894d44e99d29c0db983e.

The behavior is that I can start bluetoothd with

$ sudo ./src/bluetoothd -n --debug=3D'*' -f ./src/main.conf

and pulse audio with

$ ./src/pulseaudio -p $(pwd)/src/ --daemonize=3Dno -v -v -v

Everything looks fine until I turn on a bluetooth device that was
already paired and trusted. As far as I can tell, it connects correctly,
but then the bluetoothd log shows

May 10 10:18:41 raspberrypi.local bluetoothd[3127]: profiles/audio/transpor=
t.c:transport_update_playing() /org/bluez/hci0/dev_EC_81_93_4A_C7_7E/fd0 St=
ate=3DTRANSPORT_STATE_ACTIVE Playing=3D1
May 10 10:18:41 raspberrypi.local bluetoothd[3127]: Disconnected from D-Bus=
. Exiting.

I can't quite figure out what is going on, but dbus-monitor around the
time shows:

signal time=3D1589131121.073746 sender=3Dorg.freedesktop.DBus -> destinatio=
n=3D:1.65 serial=3D4294967295 path=3D/org/freedesktop/DBus; interface=3Dorg=
.freedesktop.DBus; member=3DNameLost
   string "org.bluez"
signal time=3D1589131121.073832 sender=3Dorg.freedesktop.DBus -> destinatio=
n=3D(null destination) serial=3D4294967295 path=3D/org/freedesktop/DBus; in=
terface=3Dorg.freedesktop.DBus; member=3DNameOwnerChanged
   string "org.bluez"
   string ":1.65"
   string ""

Which is suspicious. I have attached the full logs starting just before
the bluetooth speaker is turned on.

What I have checked so far

* I removed the system bluez and pulse audio
* I checked that ./src/bluetooth.conf has been copied to /etc/dbus-1/system=
.d/bluetooth.conf

Any suggestions as to where I should look next?

Thanks,
Rafael



--b1_bc04763d9c1f5551357c30930d0111d9
Content-Type: application/gzip; name="journalctl.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=journalctl.log.gz

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


--b1_bc04763d9c1f5551357c30930d0111d9
Content-Type: application/gzip; name="dbus.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=dbus.log.gz

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


--b1_bc04763d9c1f5551357c30930d0111d9--

