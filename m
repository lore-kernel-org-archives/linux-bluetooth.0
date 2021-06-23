Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B14C4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B665C6112D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 10:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWKNC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 06:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWKNB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17311C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 03:10:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f13so2203038ljp.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 03:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ICtxP+9PXwNsZ17MmvB2AxO67fZ7ZgkQIg1AW32i3oI=;
        b=e1CO3APWRxIkIUhxe8Ido2hF/8ZHkymLQeB5PLOqPtjiBvF83qiqwo4EOyoFNx1mye
         FV0FP+ynPvyXDue+BukhgkxpZsed+42DV6P3lHnJiwQI94iTm4c658TbNBmIJTMdEZ8L
         JE2Scb2N15kIWovlVkCPmbcaLzSzoB+PVHCT94KuBJ528zkVOL18tknvfAROK+SdJhf3
         RRWcUGuUDmGozez0a4B4J6WFN7KeuH4umt6GNQ0vgthdTRbGz8pYtIZ5O+mlz/DRnhBj
         4JsIs9TH+F5e0eln/NndmH4uX5biVrIqpSsIFtyZD4qvPaISTOry73BcqGEI2oHuIzgI
         rRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ICtxP+9PXwNsZ17MmvB2AxO67fZ7ZgkQIg1AW32i3oI=;
        b=h6uCKDjd1KbYtyrZUWMKyayJgRwdmdg86EqvTFQWDy3lYZeUd00E02l6/ZleZc6ha7
         s+YuHNGlYNa6gsJdfSNOM993EsvI7Obi02Frx2EzHHxdqSkZt3Olv3+b2W2EU41TJvon
         vLA01TFY6RZrv8Hk7EWTUTmYBIDiIHSP663QKSkvKHR8oPJ7ZMc8iDyPQKApmPrJUYdB
         uOUfdTsJPLaKcOyJzx1BGHkJN8r2By8VuRd/jU4cRi23LbHELUELXhv7JdcRlUsZllGw
         rnzFcspGHmnD+bKGDyX1YPGXrs7X8KzSnjKVoVWr9rsc111I7RjYuUrIw26e4ZnSeptW
         OdUQ==
X-Gm-Message-State: AOAM533xg6X1r2yvjj2DwCzrxo24VZ14CL3SNQZp1ehjfL0BJbKwuPyv
        63VyXjC/J4Q+owgs12Nz+hIirF75ZSRpGJjebosQdtyv4ZQ=
X-Google-Smtp-Source: ABdhPJzUvhD8qziRPN+OoobBpQGxRLr1see/od1JgF1osvjKge2lokYuFtQ1/eW2B/dcr0/Sb4wNcBzso6IbGLhZWvs=
X-Received: by 2002:a2e:7513:: with SMTP id q19mr7374561ljc.309.1624443040933;
 Wed, 23 Jun 2021 03:10:40 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Shaforostoff <shaforostoff@gmail.com>
Date:   Wed, 23 Jun 2021 12:10:30 +0200
Message-ID: <CAPNBayJJA7uYZb_oGHVw3ydasYwdCh_2VXLsNDJeippqX=frRw@mail.gmail.com>
Subject: A2DP Sink, problem reading data from mediatransport
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi! I am implementing audio sink on my desktop linux (as a first step;
second step is linux embedded). My application uses Qt 5.15, and also
bluez-qt library from KDE project. I am using bluez 5.55

On my laptop I have organized registering of endpoint to accept sbc
audio from my android smartphone. When I receive
BluezQt::MediaTransport::stateChanged signal with state =3D
BluezQt::MediaTransport::State::Pending, I call transport->acquire().

In reply I get file descriptor 33, mtu read 672, mtu write 1008.

But then, when I start new thread that reads from this file
descriptor, I get errno 9 (returned length being -1) all the time (on
each for(;;) loop iteration).

On smartphones's side everything looks good - it streams audio over
bluetooth (in youtube application) and I can change bluetooth volume.

I found out that bluetooth documentation is scarce. The only detailed
document I found besides *-api.txt files is
https://www.lightofdawn.org/blog/?viewDetailed=3D00032 but it talks
about bluez 4

Could you please give me advice on where to look to fix this problem?

This is the log from bluetoothd -d:

Jun 23 10:52:52 debian-e330 bluetoothd[629]: Endpoint registered:
sender=3D:1.170 path=3D/MediaEndpoint/Sink/Sbc

Jun 23 10:52:52 debian-e330 bluetoothd[629]:
src/adapter.c:dev_class_changed_callback() Class: 0x14010c


Jun 23 10:52:53 debian-e330 bluetoothd[629]:
src/adapter.c:device_found_callback() hci0 addr 60:AB:67:17:74:03,
rssi -79 flags 0x0000 eir_len 170
Jun 23 10:52:53 debian-e330 bluetoothd[629]:
src/device.c:device_set_legacy() legacy 0
Jun 23 10:52:53 debian-e330 bluetoothd[629]:
src/device.c:device_set_rssi_with_delta() rssi -79




Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:discovering_callback() hci0 type 7 discovering 0 method
1
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:trigger_start_discovery()
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:cancel_passive_scanning()
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:start_discovery_timeout()
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter =3D=3D 1
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:start_discovery_complete() status 0x00
Jun 23 10:52:57 debian-e330 bluetoothd[629]:
src/adapter.c:discovering_callback() hci0 type 7 discovering 1 method
1
Jun 23 10:53:02 debian-e330 bluetoothd[629]:
src/adapter.c:connected_callback() hci0 device 60:AB:67:17:74:03
connected eir_len 12
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming connect from
60:AB:67:17:74:03
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/source.c:source_set_state() State changed
/org/bluez/hci0/dev_60_AB_67_17_74_03: SOURCE_STATE_DISCONNECTED ->
SOURCE_STATE_CONNECTING
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling
channel to 60:AB:67:17:74:03
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=3D672, omtu=3D672
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_register_remote_sep() seid 1 type 0 media
0 delay_reporting true
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:register_remote_sep() Found remote SEP:
/org/bluez/hci0/dev_60_AB_67_17_74_03/sep1
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D1
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:set_disconnect_timer() timeout 1
Jun 23 10:53:03 debian-e330 bluetoothd[629]: profiles/audio/avdtp.c:session=
_cb()
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
Jun 23 10:53:03 debian-e330 bluetoothd[629]: profiles/audio/avdtp.c:session=
_cb()
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_parse_cmd() Received
GET_ALL_CAPABILITIES_CMD
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x560dcaeb1050:
Get_Capability_Ind
Jun 23 10:53:03 debian-e330 bluetoothd[629]: profiles/audio/avdtp.c:session=
_cb()
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_parse_cmd() Received
SET_CONFIGURATION_CMD
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:caps_to_list() Invalid capability data in
getcap resp
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:endpoint_setconf_ind() Sink 0x560dcaeb1050:
Set_Configuration_Ind
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D2
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_unref() 0x560dcaedf8a0: ref=3D1
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_ref() 0x560dcaec4cc0: ref=3D1
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_ref() 0x560dcaec4cc0: ref=3D2
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/media.c:media_endpoint_async_call() Calling
SetConfiguration: name =3D :1.170 path =3D /MediaEndpoint/Sink/Sbc
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D2
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
IDLE -> CONFIGURED
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_unref() 0x560dcaec4cc0: ref=3D1
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_unref() 0x560dcaec4cc0: ref=3D0
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_free() 0x560dcaec4cc0
Jun 23 10:53:03 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_unref() 0x560dcaedf8a0: ref=3D1
Jun 23 10:53:05 debian-e330 bluetoothd[629]: profiles/audio/avdtp.c:session=
_cb()
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:open_ind() Sink 0x560dcaeb1050: Open_Ind
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D2
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_ref() 0x560dcaec4cc0: ref=3D1
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming connect from
60:AB:67:17:74:03
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
CONFIGURED -> OPEN
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
src/service.c:change_state() 0x560dcaebb5a0: device 60:AB:67:17:74:03
profile a2dp-source state changed: disconnected -> connected (0)
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
plugins/policy.c:service_cb() Added a2dp-source reconnect 1
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/source.c:source_set_state() State changed
/org/bluez/hci0/dev_60_AB_67_17_74_03: SOURCE_STATE_CONNECTING ->
SOURCE_STATE_CONNECTED
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1 State=3DTRANSPORT_STATE_IDLE
Playing=3D0
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_unref() 0x560dcaec4cc0: ref=3D0
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_free() 0x560dcaec4cc0
Jun 23 10:53:05 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_unref() 0x560dcaedf8a0: ref=3D1
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:stop_discovery() sender :1.170
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:discovering_callback() hci0 type 7 discovering 0 method
1
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:trigger_start_discovery()
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:cancel_passive_scanning()
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:stop_discovery_complete() status 0x00
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:discovery_remove() owner :1.170
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/device.c:device_set_rssi_with_delta() rssi 0
Jun 23 10:53:07 debian-e330 bluetoothd[629]:
src/adapter.c:trigger_passive_scanning()

Jun 23 10:53:08 debian-e330 bluetoothd[629]:
plugins/policy.c:policy_connect()
/org/bluez/hci0/dev_60_AB_67_17_74_03 profile audio-avrcp-target
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avrcp.c:avrcp_connect() path
/org/bluez/hci0/dev_60_AB_67_17_74_03
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
src/service.c:change_state() 0x560dcaeba730: device 60:AB:67:17:74:03
profile audio-avrcp-target state changed: disconnected -> connecting
(0)
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to
60:AB:67:17:74:03
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avctp.c:init_uinput() AVRCP: uinput initialized for Mi
A3
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avrcp.c:controller_init() 0x560dcaeae780 version 0x0103
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
src/service.c:change_state() 0x560dcaeba730: device 60:AB:67:17:74:03
profile audio-avrcp-target state changed: connecting -> connected (0)
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
src/device.c:device_profile_connected() audio-avrcp-target Success (0)
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_controller_create()
/org/bluez/hci0/dev_60_AB_67_17_74_03/player0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avrcp.c:target_init() 0x560dcaee0d00 version 0x0103
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
src/service.c:change_state() 0x560dcaea88d0: device 60:AB:67:17:74:03
profile avrcp-controller state changed: disconnected -> connected (0)
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU 0x31, company
0x001958 len 0x0005
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU parameters
length don't match
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_setting() Repeat: off
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_setting() Shuffle: off
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_position() 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_status() stopped

Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_playlist_item() 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() Title:
CIAO, 2020! =D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D1=8F
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() Artist: =D0=92=D0=B5=D1=
=87=D0=B5=D1=80=D0=BD=D0=B8=D0=B9
=D0=A3=D1=80=D0=B3=D0=B0=D0=BD=D1=82
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() Album: =D0=92=D0=B5=D1=
=87=D0=B5=D1=80=D0=BD=D0=B8=D0=B9
=D0=A3=D1=80=D0=B3=D0=B0=D0=BD=D1=82
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() TrackNumber: 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() NumberOfTracks: 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() Genre:
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_metadata() Duration: 3184000
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_duration() 3184000
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_position() 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_status() stopped
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_duration() 3184000
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_position() 0
Jun 23 10:53:08 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_status() stopped

Jun 23 10:53:09 debian-e330 bluetoothd[629]: profiles/audio/avdtp.c:session=
_cb()
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:start_ind() Sink 0x560dcaeb1050: Start_Ind
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D2
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
OPEN -> STREAMING
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/source.c:source_set_state() State changed
/org/bluez/hci0/dev_60_AB_67_17_74_03: SOURCE_STATE_CONNECTED ->
SOURCE_STATE_PLAYING
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:transport_update_playing()
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1 State=3DTRANSPORT_STATE_IDLE
Playing=3D1
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:transport_set_state() State changed
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1: TRANSPORT_STATE_IDLE ->
TRANSPORT_STATE_PENDING
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:media_owner_create() Owner created:
sender=3D:1.170
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D3
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x560dcaeb1050 locked
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_ref() 0x560dcaedf8a0: ref=3D4
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_ref() 0x560dcaed05b0: ref=3D1
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_unref() 0x560dcaedf8a0: ref=3D3
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:media_request_create() Request created:
method=3DAcquire id=3D3
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:media_owner_add() Owner :1.170 Request
Acquire
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:media_transport_set_owner() Transport
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1 Owner :1.170
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1: fd(37) ready
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:media_owner_remove() Owner :1.170 Request
Acquire
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/transport.c:transport_set_state() State changed
/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1: TRANSPORT_STATE_PENDING ->
TRANSPORT_STATE_ACTIVE
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_unref() 0x560dcaed05b0: ref=3D0
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/a2dp.c:setup_free() 0x560dcaed05b0
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/avdtp.c:avdtp_unref() 0x560dcaedf8a0: ref=3D2
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_status() playing
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_duration() 3184000
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_position() 0
Jun 23 10:53:09 debian-e330 bluetoothd[629]:
profiles/audio/player.c:media_player_set_status() playing











=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
And this is the output of my application, Mi A3 is my smartphone.

Change "org.bluez.Device1" QMap(("RSSI", QVariant(short, -79)))
Change "org.bluez.Device1" QMap(("Connected", QVariant(bool, true)))
isInSet false isConnected  true
CONNECTED
configurationSet "/org/bluez/hci0/dev_60_AB_67_17_74_03/fd1"
Change "org.bluez.Device1" QMap()
Change "org.bluez.Adapter1" QMap(("Discovering", QVariant(bool, false)))
Change "org.bluez.MediaControl1" QMap(("Connected", QVariant(bool,
true))("Player", QVariant(QDBusObjectPath, )))
MediaTransportPrivate::onPropertiesChanged key "State"
QVariant(QString, "pending")
Transport state: BluezQt::MediaTransport::State::Pending "Mi A3"
Transport state: BluezQt::MediaTransport::State::Pending "Mi A3"
fd:  33 mtu read: 672 mtu write: 1008
fd reply err 0
fd reply mtu read write 672 1008
fd reply fd 33
MediaTransportPrivate::onPropertiesChanged key "State"
QVariant(QString, "active")
Transport state: BluezQt::MediaTransport::State::Active "Mi A3"
Transport state: BluezQt::MediaTransport::State::Active "Mi A3"
BluetoothAudioRead len errno -1 9

I use read() call:
uint8_t payload[2 * 512];
ssize_t len =3D read(bluetooth_fd, payload, sizeof(payload));
qDebug()<<"BluetoothAudioRead len errno"<<len<<errno;

I also tried using recvmsg() the way it is done in pulseaudio, but
result is the same.
