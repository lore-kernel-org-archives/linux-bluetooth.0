Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A2C1975A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 05:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D72820714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 05:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Wi5kgFLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgCYF7B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:59:01 -0400
Received: from mout.web.de ([217.72.192.78]:40259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgCYF7A (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 01:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585115939;
        bh=aKZdMuu02dgCWIUwE7ox7pBEw0Hhv5T6B3WvcFmPNz0=;
        h=X-UI-Sender-Class:From:Date:Subject:To;
        b=Wi5kgFLBkp3FuJ54ZOZZH1rKwa3oHGwG1hwUwGR4plmx6i6x4+ZwPEaqMaK1q2P3F
         K+ikKu4siHPFz7V9WlHKOvz7iR2Jhp8pwYSMweegVl2xSD9LGikb5E8L2kqEChhwXQ
         gluWb4g4GDwzw8RH7es8CL1z7DXhOj9rmHqiRRyM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.188.43] ([79.251.37.20]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lh6QF-1jdcV21djz-00oUnS for
 <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 06:58:59 +0100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Christian Fischer <panig291088@web.de>
Mime-Version: 1.0 (1.0)
Date:   Wed, 25 Mar 2020 06:58:58 +0100
Subject: a2dp stream delayed if playback started immediately after connect
Message-Id: <9ADFBCB6-94B9-49D1-92AD-2211B8F7A9C6@web.de>
To:     linux-bluetooth@vger.kernel.org
X-Mailer: iPhone Mail (17D50)
X-Provags-ID: V03:K1:865bGIVVZ9kIf6E6wgxwKO/fwFT0IBajl6dV1gst7RJYVQk9Y0t
 uQi/FXATQBN8Iz40V+jANag/qktUE0Dywcc9eawCbq0b4dkaxiX9QRGOcbY21/zLEyLgMXl
 7XUIdfiv521DRlX7wzZ22OdAvAmE2hhQVmHjnFzUQAflAvJEYH3IE7tecqHIqIHWJuYKAFc
 R7EGlbtra7l/VK21jlyCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ypbCyxrG+Co=:60l8aXjdGkVB9vLEvnDlxu
 +qQZbRVlEuIFz+ghCCi2d0k9WK9MENgRM3iGnr9/ltmoA1AXG8rDHhnjtwTH+G6cqNRQN7i9i
 FUVy5qANp5K7Dnen6qnQTULAFfCuDxj3/ay5US2T3dfxgX6qkERa9qtxpN9n4OqBpXauxWm9p
 hCaEOeSM2FEwY7Ex9cjgzr5mR3+pBfHx0156YiwSBjQhZn1v0RhpdaDucueBKYRSPMpB3Ph7P
 5UZ1Fc1C2RtMIwnOtU7g170iD0CYKcrTbwDaLJ1Y2ivAbcrhtKtamuyMoZ4VGd2sEo9rbMHqE
 ddRvMCHgEnAJDTtMq1PiCvjPA/Cya+KdsNAaAnRizFFD9HlBmqh9HWUdwzHXYwGreeP2jUSvA
 IMwS8ZZL4MCgPj9SgCEH4QVPrw0AP+Ek37ES0tAPX+FP20zWy/Pvf2MF8f/2MYkjgJuV/lVGV
 C8VXpX1uM2VcUt5Gc6aQjtjID0XfkdPTVX9x1plf1+gtbaRfsLbRaglYuF8jUuQxHyvGSJ479
 /MageBXByEDRbTNMFIG0krb5S4IqboEzjicKNkxfJBkYBB2Q1oJKkw5pZEw9GqdvbLXc5tOGD
 CTbmUVVjzz11EBKhXViPI4agFVXRUpTvLVa8X7Gb2omXn8UKFL3f1JxMizI/kMAzwWauJZcub
 vuu6HrAtUSd9PY+GNJrM1/L6nnzZYw6RdC8Y3mk0rWWRYqS5j7qlVOUFqd7wX+AcSCejZhg4g
 1EnK3RlfYQ+7P5xpPr0gB3c5Fimc2uwDG95+pqxvdko4ZIUx9FYelYsZsv3MfXsLBqLx/0EeO
 jZTzrpNLcmWAZ9et0oNaI+dPrSCa/6NdUuJ3GQ2YwEGIy0rTLzfW77UGriCljujqGh4rc768l
 HN78tGRrDZ9kLcXMpHqE0lJq34ilBXF3VYAXnR4YnDQPCt/MzzFkEBPRv9QXvoCprv+BVVNZP
 zUhmAYmpcM3btbYwdvQ49nT5k9bt5UatXhY3WR3Z/DJPMp4+X+SMVXLJP9p+Jk1hr//0x+IKj
 xbb69aKrymxLdTkz38scPMyZI/oZZwH9dCBRcIfKNj2EqCiUuOftw2vdY/5Pwj0NWj2DlG/7s
 QnaX4VqVsxbwRdsnQTA2MaJdL3g199emzjsPeUaiEs/cvm4foHmktnJX9oLEVyJdCUlh7l4Xp
 a+dDm7JK5ZoqXdUj5OA3HdmGce6tFGPZG/cQCPgmoWTe5ZhnOPcM6lbozGVL62O6YaTDmOVXF
 WkpXh6YkUP7mz3zbB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello guys, i have a little problem a2dp related.
I've written a mono c# application which will wait for a specific device (ph=
one) is connected and will then start the music playback immediatly.
Pulseaudio is playing the music on its connected usb-soundcard. So at the mo=
ment when my phone gets connected the stream starts playing.
So when i press forward at the phone its command is delayed by approx. 2 sec=
onds, so in the bluetoothd debug output i can see that AVRCP command is rece=
ived immediatly. But the stream got a delay.
When i press pause and wait till this:
bluetoothd[20399]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state=
 changed: STREAMING -> OPEN
bluetoothd[20399]: profiles/audio/source.c:source_set_state() State changed /=
org/bluez/hci0/dev_F0_98_9D_D8_46_19: SOURCE_STATE_PLAYING -> SOURCE_STATE_C=
ONNECTED
bluetoothd[20399]: profiles/audio/transport.c:transport_update_playing() /or=
g/bluez/hci0/dev_F0_98_9D_D8_46_19/sep1/fd1 State=3DTRANSPORT_STATE_ACTIVE P=
laying=3D0
bluetoothd[20399]: profiles/audio/transport.c:media_transport_remove_owner()=
 Transport /org/bluez/hci0/dev_F0_98_9D_D8_46_19/sep1/fd1 Owner :1.56
bluetoothd[20399]: profiles/audio/transport.c:media_owner_free() Owner :1.56=

bluetoothd[20399]: profiles/audio/transport.c:transport_set_state() State ch=
anged /org/bluez/hci0/dev_F0_98_9D_D8_46_19/sep1/fd1: TRANSPORT_STATE_ACTIVE=
 -> TRANSPORT_STATE_IDLE
bluetoothd[20399]: profiles/audio/a2dp.c:a2dp_sep_unlock() SEP 0x114f798 unl=
ocked
bluetoothd[20399]: src/device.c:connect_profiles() /org/bluez/hci0/dev_F0_98=
_9D_D8_46_19 (all), client :1.73
=20
And start again, all commands and streams are back in sync.
Any tips? Is that Maybe pulseaudio related?
=20
Thanks in advice,
chris=

