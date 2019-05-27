Return-Path: <SRS0=yF4w=T3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9093AC282E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 03:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59861206C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 May 2019 03:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3fdrv8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0D04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 May 2019 23:26:56 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38732 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfE0D04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 May 2019 23:26:56 -0400
Received: by mail-pg1-f181.google.com with SMTP id v11so8278786pgl.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 May 2019 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qr1glM/d+eSTP3gc46UAkt+ICoq7j7cfUX/ED90JBjY=;
        b=i3fdrv8PyNc4eAS6AiuSMKFCrFpdJmCeAhU/lXQZw+75KMQZ6Ryu9Bgkb+MAdNGVNv
         /cAeEbIQRvcWCIQrYLSUt7UayAm9jghPaVjMedncyy7uVcPPsKgIoHGy7Vj7PrDrzCob
         t4D51HuPjegh2fDFcDMrC3sIr92/SA5YTSdX83TqktNa0Ff+jGlV9KcJ3YLcIEezOfFZ
         PN1iHJWbA30MFG6NlyAg0v2vfGMmY5fAKccwrWkhpCyOOl6CuM9q8FRceodRbQpY2Ivh
         Pk2b1wgmaQBWYDbXFhNpf/k8bpcebWKmounXmYVyftQNt24sbOwM1dmvOcydK0yS4KO8
         6+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Qr1glM/d+eSTP3gc46UAkt+ICoq7j7cfUX/ED90JBjY=;
        b=KtWdsJu/XvukjQjJVukPfODhhwLPC+20IWf4afgZneDPfpK2Bah2ygF8DgDOdID5Fa
         OW6Ra3FyopTFSJ1gfaVRpeO+dFmt6Y56kAjO3VEPA4viZrSsAdV8aVQQxOtRQOg32/pi
         FYdD7b5PeLcum6akS9xv+F96ZOaueX9o0V9S3r0EGV7Uy/mHZH63P48lUuU0LS1SABMi
         W4AwDPR7HwhsarjD6QtXGu1v3uo9/xdfCDP89AHN/++x8MTn8tDqizDOTu6jcpssz5bl
         RKnGD7M6MSdQQnuojm6WjHw+UlmqE/166nVZSbkseWlYf6Y2dIAY2cTTYnl5eRlsAcMx
         eO5A==
X-Gm-Message-State: APjAAAW2IsOR2exab6GWCKgTSfpmEfuTeVynkL0EZq1GIOgiVnVV7wzg
        GDz1B01qMLIYQXHTkZ/QDMKK9o0QcQpvMYbi/O4HEuA2
X-Google-Smtp-Source: APXvYqz2yyFD57uJyLMQWcjm5mM+LSzMHWz9UVnBJVFdsxJ328sSb0LFV8HyZnrG+JwrbkW77kqC+AsdL2yaYUDMjS4=
X-Received: by 2002:a63:2c50:: with SMTP id s77mr35961092pgs.175.1558927615410;
 Sun, 26 May 2019 20:26:55 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0JDQvdGC0L7QvSDQkdGD0YLQsNC90LDQtdCy?= 
        <anton.butanaev@gmail.com>
Date:   Mon, 27 May 2019 10:26:50 +0700
Message-ID: <CAFQJfnynNPQbew4dDTZnQ1JTvciNA5X24oOSPLrA6WUjuc=i9w@mail.gmail.com>
Subject: Kernel driver for MT6622
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, bluetooth developers!

I=E2=80=99m working on bluetooth driver for MT6622 bluetooth chip on MSB 25=
31
board. I need to be able to forward sound from that device to
bluetooth headset using A2DP profile. That MT6622 chip has UART line
for HCI control commands and I2S line for sound. I use bluez 5.50,
bluez-alsa 1.4.0 and kernel 3.10.69 in buildroot. I=E2=80=99ve already gone=
 so
far that scanning devices, paring and connecting headset works now:

# bluetoothctl -- info C0:7A:A5:01:48:F0
Device C0:7A:A5:01:48:F0 (public)
Name: SVEN SEB-B270MV
Alias: SVEN SEB-B270MV
Class: 0x00240404
Icon: audio-card
Paired: yes
Trusted: no
Blocked: no
Connected: yes
LegacyPairing: no
UUID: Headset (00001108-0000-1000-8000-00805f9b34fb)
UUID: Audio Sink (0000110b-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
UUID: A/V Remote Control (0000110e-0000-1000-8000-00805f9b34fb)
UUID: Handsfree (0000111e-0000-1000-8000-00805f9b34fb)

But when I try to play sound, I see that I=E2=80=99m almost there: state
changed to SINK_STATE_PLAYING, then Starting IO loop: A2DP Source, but
after that I got =E2=80=9CBroken pipe=E2=80=9D error (here is some logs wit=
h debug
info):

# aplay -D btheadset /my/maybe-next-time.wav
../shared/ctl-client.c:108: Connecting to socket: /var/run/bluealsa/hci0
bluealsa: ctl.c:596: Received new connection: 8
bluealsa: ctl.c:609: New client accepted: 8
bluealsa: ctl.c:634: +-+-
../shared/ctl-client.c:238: Getting transport for C0:7A:A5:01:48:F0 type 0x=
41
bluealsa: ctl.c:634: +-+-
bluealsa-pcm.c:583: Setting constraints: 3
Playing WAVE '/my/maybe-next-time.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo
bluealsa-pcm.c:307: Initializing HW: 3
../shared/ctl-client.c:397: Requesting PCM open for C0:7A:A5:01:48:F0
bluealsa: ctl.c:329: PCM requested for C0:7A:A5:01:48:F0 type 0x41
bluetoothd[668]: profiles/audio/transport.c:media_owner_create() Owner
created: sender=3D:1.1
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_ref() 0x1ecc348: ref=3D2
bluetoothd[668]: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x1ec7cd8 locked
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_ref() 0x1ecc348: ref=3D3
bluetoothd[668]: profiles/audio/a2dp.c:setup_ref() 0x1ecc2a8: ref=3D1
bluetoothd[668]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0:
TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
bluetoothd[668]: profiles/audio/transport.c:media_request_create()
Request created: method=3DAcquire id=3D4
bluetoothd[668]: profiles/audio/transport.c:media_owner_add() Owner
:1.1 Request Acquire
bluetoothd[668]:
profiles/audio/transport.c:media_transport_set_owner() Transport
/org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0 Owner :1.1
bluetoothd[668]: profiles/audio/avdtp.c:session_cb()
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_parse_resp() START
request succeeded
bluetoothd[668]: profiles/audio/a2dp.c:start_cfm() Source 0x1ec7cd8: Start_=
Cfm
bluetoothd[668]: /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0: fd(17) ready
bluetoothd[668]: profiles/audio/transport.c:media_owner_remove() Owner
:1.1 Request Acquire
bluetoothd[668]: profiles/audio/transport.c:transport_set_state()
State changed /org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0:
TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_ACTIVE
bluetoothd[668]: profiles/audio/a2dp.c:setup_unref() 0x1ecc2a8: ref=3D0
bluetoothd[668]: profiles/audio/a2dp.c:setup_free() 0x1ecc2a8
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_unref() 0x1ecc348: ref=3D2
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream
state changed: OPEN -> STREAMING
bluetoothd[668]: profiles/audio/sink.c:sink_set_state() State changed
/org/bluez/hci0/dev_C0_7A_A5_01_48_F0: SINK_STATE_CONNECTED ->
SINK_STATE_PLAYING
bluetoothd[668]: profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_C0_7A_A5_01_48_F0/fd0 State=3DTRANSPORT_STATE_ACTIVE
Playing=3D1
bluealsa: ba-transport.c:669: New transport: 18 (MTU: R:672 W:895)
bluealsa: ctl.c:634: +-+-
bluealsa-pcm.c:330: FIFO buffer size: 4096
bluealsa-pcm.c:336: Selected HW buffer: 6 periods x 16380 bytes <=3D 98284 =
bytes
bluealsa-pcm.c:351: Initializing SW: 3
bluealsa-pcm.c:351: Initializing SW: 3
bluealsa-pcm.c:351: Initializing SW: 3
bluealsa-pcm.c:373: Prepared: 3
bluealsa-pcm.c:351: Initializing SW: 3
bluealsa: bluez.c:1396: Signal: PropertiesChanged:
org.bluez.MediaTransport1: State
bluealsa: ba-transport.c:546: State transition: 0 -> 2
bluealsa: ba-transport.c:105: Created new IO thread: A2DP Source (SBC)
bluealsa: io.c:428: Starting IO loop: A2DP Source (SBC)
bluealsa-pcm.c:228: Starting: 3
../shared/ctl-client.c:444: Requesting PCM resume for C0:7A:A5:01:48:F0
bluealsa: ba-transport.c:546: State transition: 2 -> 2
bluealsa: ctl.c:634: +-+-
bluealsa-pcm.c:122: Starting IO loop: 6
bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
media_endpoint_exit
bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
media_endpoint_exit
bluetoothd[668]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[668]: src/adapter.c:remove_uuid() sending remove uuid
command for index 0
bluetoothd[668]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10004
bluetoothd[668]: profiles/audio/media.c:release_endpoint() sender=3D:1.1
path=3D/hci0/A2DP/SBC/Sink/1
bluetoothd[668]: Endpoint unregistered: sender=3D:1.1 path=3D/hci0/A2DP/SBC=
/Sink/1
bluetoothd[668]: profiles/audio/media.c:media_endpoint_destroy()
sender=3D:1.1 path=3D/hci0/A2DP/SBC/Sink/1
bluetoothd[668]: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP
0x1ec7d00 unregistered: type:1 codec:0 seid:2
bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
media_endpoint_exit
ALSA lib bluealsa-pcm.c:201:(io_thread) PCM FIFO write error: Broken pipe
bluealsa-pcm.c:92: IO thread cleanup: 3
underrun!!! (at least 22.550 ms long)
aplay: xrun:1642: xrun: prepare error: No such device
bluealsa-pcm.c:268: Stopping: 3

Now I=E2=80=99m struggling at debugging the problem. It=E2=80=99s actually =
quite hard
for me since bluez uses event driven architecture and call stacks in
debugger usually point to some event dispatcher and it=E2=80=99s difficult =
to
understand what code actually triggered what action.
It=E2=80=99s unclear for me, what cased what, whether media_endpoint_exit()=
 call:

bluetoothd[668]: profiles/audio/media.c:media_endpoint_exit()
media_endpoint_exit

cased broken pipe:

ALSA lib bluealsa-pcm.c:201:(io_thread) PCM FIFO write error: Broken pipe

since it appears earlier in logs, or vice versa.

I suspect that kernel bluetooth driver for MT6622 chip which I develop
should provide some channel for bluetoothd daemon to be able to
forward PCM data to the chip and without such channel broken pipe
happens.
The main obstacle for me now is that I=E2=80=99m having hard time finding a=
ny
documentation about what low level interface should kernel driver
provide for bluez for A2DP sound playing via I2S. I also miss big
picture of how bluez communicates with bluetooth chip via UART and I2S
lines, what should be done at kernel driver level and how. Do I need
to integrate with sound kernel driver? I=E2=80=99ve found some presentation=
 in
youtube but it was too general for me, I need more details about
bluetooth audio.
After spending some time debugging bluetoothd daemon code I suspect
that bluetoothd opens a socket or pipe for PCM data, and passes its
handle to bluez-alsa to put PCM data into. But since kernel driver
doesn=E2=80=99t implement such socket the problem arises.
Could you please point me to some documentation, presentation,
tutorial or, best of all, example kernel driver code? Any help would
be very appreciated.

Anton
