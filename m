Return-Path: <SRS0=q/Kg=T6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74023C28CC0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 02:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2571624436
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 02:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJxSD3+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE3CaP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 22:30:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33829 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE3CaP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 22:30:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so1060588pgg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GNqtiL1jaAD6M309CptJMiwjkWMG4oWsxU+FRiJ3ZB8=;
        b=QJxSD3+9JOeZqkI2HkgdOtn3UYKciSQ7Gw605ZhmbgI+93zH4CzqiURIjP9zr9/inN
         fWcAu8y4AcSycOtEc2+xg28e4/J/UmDU5SD9Leot1rVbAD0M74HMBdHQSBHxbh2ughC3
         2oCtoX00k+PeJKlf9rMm2GQRzAnYCsJmVGk9R3RLbxJXBCcIPN73MxTn9ITnFVNpretn
         POVS/lfUNFNs6/sh/yU7UD1PrFFB6tlA+vrTt7xQKjSsjNDMIbXs55rBaaXOzofkMofV
         2sBKJm9EtgKt3W0G/KJL2F2WkPWCA2q+ruBP0r+zOduosQtVmRg3M/XkRV0PiSwYRWdK
         ANGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=GNqtiL1jaAD6M309CptJMiwjkWMG4oWsxU+FRiJ3ZB8=;
        b=oOZx65XIRK1uxKMPAfnOfpe1KNNF6T1iperrLnkSQ4Svm1jX1FZCLgyhm01WvHxk1J
         1f8O5sJ1WAiNkODbkb6seJhuTg3uwk8rwP/1fqWOMoigu+wCd2N5IcmL5d5zmtU2ZgBB
         vzBILCVn3ACPaUJSE75rziOSkzcVwgiuZMvsnMRHZqDAtee8f4o7G0D3ASXQrP1cd3/T
         jxQeeaQWTMUJrFjekZ3+k1nJFBbE+QnUHDj7MOmrVdj9kGdd69j4CGogxWL7N9kTMh9h
         1r38svZcqMKgN0YdRopMH00lvJ0RLB+q7e+zdO9FS6AbgdN82jdL9AeWrPn8B2Hc07sq
         ygew==
X-Gm-Message-State: APjAAAUg+8vu2NWKXv2PgLd8ukbAY3fkgFB55/oWDnL/XHWwrQ6JDYrO
        04bQJJm/2JEKcdEIpNk7bQnNzKMBdQ5kQWHlOr5W5Yzt
X-Google-Smtp-Source: APXvYqxzfd638urdF1+r24MNSN6ZV9ljt8uyAIqoh0JL+UrHgJAWlGxUPcGJaUWz8LnsJyvXVLz7/8Ymplt+dkaHryk=
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr1182991pff.104.1559183414171;
 Wed, 29 May 2019 19:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQJfnynNPQbew4dDTZnQ1JTvciNA5X24oOSPLrA6WUjuc=i9w@mail.gmail.com>
In-Reply-To: <CAFQJfnynNPQbew4dDTZnQ1JTvciNA5X24oOSPLrA6WUjuc=i9w@mail.gmail.com>
From:   =?UTF-8?B?0JDQvdGC0L7QvSDQkdGD0YLQsNC90LDQtdCy?= 
        <anton.butanaev@gmail.com>
Date:   Thu, 30 May 2019 09:30:11 +0700
Message-ID: <CAFQJfnzqgBbL3a3=oTOwSpXYV_c=sw75JP1L2BdHca5KZ=M5kg@mail.gmail.com>
Subject: Re: Kernel driver for MT6622
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The problem was in SBC: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=
=3D856487
The following patch fixes it.

diff --git a/Linux/Chicago/buildroot/package/sbc/0001-Add-config.h-in-sbc-s=
bc_primitives.h.patch
b/Linux/Chicago/buildroot/package/sbc/0001-Add-config.h-in-sbc-sbc_primitiv=
es.h.patch
new file mode 100644
index 000000000..3ed5d8b4a
--- /dev/null
+++ b/Linux/Chicago/buildroot/package/sbc/0001-Add-config.h-in-sbc-sbc_prim=
itives.h.patch
@@ -0,0 +1,33 @@
+From e460c51017a7d1e04511ea4d293296a3d422049a Mon Sep 17 00:00:00 2001
+From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+Date: Mon, 3 Apr 2017 01:42:26 +0900
+Subject: [PATCH] Add config.h in sbc/sbc_primitives.h
+
+When we use "--enable-high-precision" option of configure, this does not w=
ork
+effectively. Because SBC_HIGH_PRECISION enabled by this option is not avai=
lable
+in "sbc/sbc_primitives.h".
+This adds config.h to "sbc/sbc_primitives.h" to use SBC_HIGH_PRECISION.
+
+Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+---
+ sbc/sbc_primitives.h | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
+index e01c957..b060484 100644
+--- a/sbc/sbc_primitives.h
++++ b/sbc/sbc_primitives.h
+@@ -27,6 +27,10 @@
+ #ifndef __SBC_PRIMITIVES_H
+ #define __SBC_PRIMITIVES_H
+
++#ifdef HAVE_CONFIG_H
++#include <config.h>
++#endif
++
+ #define SCALE_OUT_BITS 15
+ #define SBC_X_BUFFER_SIZE 328
+
+--
+2.11.0
+
diff --git a/Linux/Chicago/buildroot/package/sbc/sbc.mk
b/Linux/Chicago/buildroot/package/sbc/sbc.mk
index 77661c189..fbba27902 100644
--- a/Linux/Chicago/buildroot/package/sbc/sbc.mk
+++ b/Linux/Chicago/buildroot/package/sbc/sbc.mk
@@ -11,5 +11,6 @@ SBC_INSTALL_STAGING =3D YES
 SBC_DEPENDENCIES =3D libsndfile host-pkgconf
 SBC_LICENSE =3D GPL-2.0+ (programs), LGPL-2.1+ (library)
 SBC_LICENSE_FILES =3D COPYING COPYING.LIB
+SBC_CONF_OPTS =3D --enable-high-precision

 $(eval $(autotools-package))

=D0=BF=D0=BD, 27 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 10:26, =D0=90=D0=BD=
=D1=82=D0=BE=D0=BD =D0=91=D1=83=D1=82=D0=B0=D0=BD=D0=B0=D0=B5=D0=B2 <anton.=
butanaev@gmail.com>:
>
> Hi, bluetooth developers!
>
> I=E2=80=99m working on bluetooth driver for MT6622 bluetooth chip on MSB =
2531
> board. I need to be able to forward sound from that device to
> bluetooth headset using A2DP profile. That MT6622 chip has UART line
> for HCI control commands and I2S line for sound. I use bluez 5.50,
> bluez-alsa 1.4.0 and kernel 3.10.69 in buildroot. I=E2=80=99ve already go=
ne so
> far that scanning devices, paring and connecting headset works now:
>
> # bluetoothctl -- info C0:7A:A5:01:48:F0
> Device C0:7A:A5:01:48:F0 (public)
> Name: SVEN SEB-B270MV
> Alias: SVEN SEB-B270MV
> Class: 0x00240404
> Icon: audio-card
> Paired: yes
> Trusted: no
> Blocked: no
> Connected: yes
> LegacyPairing: no
> UUID: Headset (00001108-0000-1000-8000-00805f9b34fb)
> UUID: Audio Sink (0000110b-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
> UUID: Handsfree (0000111e-0000-1000-8000-00805f9b34fb)
>
> But when I try to play sound, I see that I=E2=80=99m almost there: state
> changed to SINK_STATE_PLAYING, then Starting IO loop: A2DP Source, but
> after that I got =E2=80=9CBroken pipe=E2=80=9D error (here is some logs w=
ith debug
> info):
>
> # aplay -D btheadset /my/maybe-next-time.wav
> ../shared/ctl-client.c:108: Connecting to socket: /var/run/bluealsa/hci0
> bluealsa: ctl.c:596: Received new connection: 8
> bluealsa: ctl.c:609: New client accepted: 8
> bluealsa: ctl.c:634: +-+-
> ../shared/ctl-client.c:238: Getting transport for C0:7A:A5:01:48:F0 type =
0x41
> bluealsa: ctl.c:634: +-+-
> bluealsa-pcm.c:583: Setting constraints: 3
> Playing WAVE '/my/maybe-next-time.wav' : Signed 16 bit Little Endian,
> Rate 44100 Hz, Stereo
> bluealsa-pcm.c:307: Initializing HW: 3
> ../shared/ctl-client.c:397: Requesting PCM open for C0:7A:A5:01:48:F0
> bluealsa: ctl.c:329: PCM requested for C0:7A:A5:01:48:F0 type 0x41
> bluetoothd[668]: profiles/audio/transport.c:media_owner_create() Owner
> created: sender=3D:1.1
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_ref() 0x1ecc348: ref=3D2
> bluetoothd[668]: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x1ec7cd8 lock=
ed
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_ref() 0x1ecc348: ref=3D3
> bluetoothd[668]: profiles/audio/a2dp.c:setup_ref() 0x1ecc2a8: ref=3D1
> bluetoothd[668]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0:
> TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
> bluetoothd[668]: profiles/audio/transport.c:media_request_create()
> Request created: method=3DAcquire id=3D4
> bluetoothd[668]: profiles/audio/transport.c:media_owner_add() Owner
> :1.1 Request Acquire
> bluetoothd[668]:
> profiles/audio/transport.c:media_transport_set_owner() Transport
> /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0 Owner :1.1
> bluetoothd[668]: profiles/audio/avdtp.c:session_cb()
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_parse_resp() START
> request succeeded
> bluetoothd[668]: profiles/audio/a2dp.c:start_cfm() Source 0x1ec7cd8: Star=
t_Cfm
> bluetoothd[668]: /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0: fd(17) ready
> bluetoothd[668]: profiles/audio/transport.c:media_owner_remove() Owner
> :1.1 Request Acquire
> bluetoothd[668]: profiles/audio/transport.c:transport_set_state()
> State changed /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0:
> TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_ACTIVE
> bluetoothd[668]: profiles/audio/a2dp.c:setup_unref() 0x1ecc2a8: ref=3D0
> bluetoothd[668]: profiles/audio/a2dp.c:setup_free() 0x1ecc2a8
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_unref() 0x1ecc348: ref=3D2
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
> state changed: OPEN -> STREAMING
> bluetoothd[668]: profiles/audio/sink.c:sink_set_state() State changed
> /org/bluez/hci0/dev_C0_7A_A5_01_48_F0: SINK_STATE_CONNECTED ->
> SINK_STATE_PLAYING
> bluetoothd[668]: profiles/audio/transport.c:transport_update_playing()
> /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0 State=3DTRANSPORT_STATE_ACTIVE
> Playing=3D1
> bluealsa: ba-transport.c:669: New transport: 18 (MTU: R:672 W:895)
> bluealsa: ctl.c:634: +-+-
> bluealsa-pcm.c:330: FIFO buffer size: 4096
> bluealsa-pcm.c:336: Selected HW buffer: 6 periods x 16380 bytes <=3D 9828=
4 bytes
> bluealsa-pcm.c:351: Initializing SW: 3
> bluealsa-pcm.c:351: Initializing SW: 3
> bluealsa-pcm.c:351: Initializing SW: 3
> bluealsa-pcm.c:373: Prepared: 3
> bluealsa-pcm.c:351: Initializing SW: 3
> bluealsa: bluez.c:1396: Signal: PropertiesChanged:
> org.bluez.MediaTransport1: State
> bluealsa: ba-transport.c:546: State transition: 0 -> 2
> bluealsa: ba-transport.c:105: Created new IO thread: A2DP Source (SBC)
> bluealsa: io.c:428: Starting IO loop: A2DP Source (SBC)
> bluealsa-pcm.c:228: Starting: 3
> ../shared/ctl-client.c:444: Requesting PCM resume for C0:7A:A5:01:48:F0
> bluealsa: ba-transport.c:546: State transition: 2 -> 2
> bluealsa: ctl.c:634: +-+-
> bluealsa-pcm.c:122: Starting IO loop: 6
> bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
> media_endpoint_exit
> bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
> media_endpoint_exit
> bluetoothd[668]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
> bluetoothd[668]: src/adapter.c:remove_uuid() sending remove uuid
> command for index 0
> bluetoothd[668]: src/sdpd-service.c:remove_record_from_server()
> Removing record with handle 0x10004
> bluetoothd[668]: profiles/audio/media.c:release_endpoint() sender=3D:1.1
> path=3D/hci0/A2DP/SBC/Sink/1
> bluetoothd[668]: Endpoint unregistered: sender=3D:1.1 path=3D/hci0/A2DP/S=
BC/Sink/1
> bluetoothd[668]: profiles/audio/media.c:media_endpoint_destroy()
> sender=3D:1.1 path=3D/hci0/A2DP/SBC/Sink/1
> bluetoothd[668]: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP
> 0x1ec7d00 unregistered: type:1 codec:0 seid:2
> bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
> media_endpoint_exit
> ALSA lib bluealsa-pcm.c:201:(io_thread) PCM FIFO write error: Broken pipe
> bluealsa-pcm.c:92: IO thread cleanup: 3
> underrun!!! (at least 22.550 ms long)
> aplay: xrun:1642: xrun: prepare error: No such device
> bluealsa-pcm.c:268: Stopping: 3
>
> Now I=E2=80=99m struggling at debugging the problem. It=E2=80=99s actuall=
y quite hard
> for me since bluez uses event driven architecture and call stacks in
> debugger usually point to some event dispatcher and it=E2=80=99s difficul=
t to
> understand what code actually triggered what action.
> It=E2=80=99s unclear for me, what cased what, whether media_endpoint_exit=
() call:
>
> bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
> media_endpoint_exit
>
> cased broken pipe:
>
> ALSA lib bluealsa-pcm.c:201:(io_thread) PCM FIFO write error: Broken pipe
>
> since it appears earlier in logs, or vice versa.
>
> I suspect that kernel bluetooth driver for MT6622 chip which I develop
> should provide some channel for bluetoothd daemon to be able to
> forward PCM data to the chip and without such channel broken pipe
> happens.
> The main obstacle for me now is that I=E2=80=99m having hard time finding=
 any
> documentation about what low level interface should kernel driver
> provide for bluez for A2DP sound playing via I2S. I also miss big
> picture of how bluez communicates with bluetooth chip via UART and I2S
> lines, what should be done at kernel driver level and how. Do I need
> to integrate with sound kernel driver? I=E2=80=99ve found some presentati=
on in
> youtube but it was too general for me, I need more details about
> bluetooth audio.
> After spending some time debugging bluetoothd daemon code I suspect
> that bluetoothd opens a socket or pipe for PCM data, and passes its
> handle to bluez-alsa to put PCM data into. But since kernel driver
> doesn=E2=80=99t implement such socket the problem arises.
> Could you please point me to some documentation, presentation,
> tutorial or, best of all, example kernel driver code? Any help would
> be very appreciated.
>
> Anton
