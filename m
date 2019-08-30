Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13027C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 03:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD32E21874
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 03:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI2j7Fxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH3Dpq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:45:46 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39718 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH3Dpq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 23:45:46 -0400
Received: by mail-ot1-f53.google.com with SMTP id b1so5620681otp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RF/ne96MgoymbOHOluSC7JryFOpqR+LpPNO7XcQ8h/E=;
        b=LI2j7FxiudzhdL+rO8W3gWbmb2xCVCTEz05+6+8wDJ1s4Sg/+kOQfOQJfQGEKVpctq
         OKYLAn6JhGRPk5yvL4mDEqcPYMDWeNikUw2HleQvn038RTt0ytrStHkMjQysFSvNcCNb
         k+evjKOCHf0Q/mNxfyS4eH8d+n5KdfNahPs+cPja0BoOXsfI9v858rs9cuuH5E/oVIdS
         vLGZ7WTIGFdjsoIAfl5YmItfCq8pjVSPeO8mwOoy4dOilS53Vr8iQpju0tRvx9Zt05sP
         Ama7Lor/ZU9t4CLTw8TrfHtvzSwq8JmipV3jhnfSlu/FobDoaw6tg7Mym614E1cxkK9Z
         MTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=RF/ne96MgoymbOHOluSC7JryFOpqR+LpPNO7XcQ8h/E=;
        b=FZsTklcTMBnzBK3ajVx8L/d7JR0uA9jIVf1bR+9mobeeRhQq5EHnORBFqViR298YkI
         iSqAUlEY2/0gZUvD+mJ9fId1aPHFPNlWhm+/mZSWZFO7Y6FWm1tRwt2n7ftx8ccV0ORC
         MWT2wUm51Hbm3G9Hvj7dBi2TFvG/3aGyZIfYqBtb2hk0nEBmxWaSofpZ13c11AaFFBGL
         WeN7JPjH3MHxeBh239LBtO7izdda+iDH3wQP9lgVnFt061qkBaNotAqIWDPu+dCO0pWe
         cmbt61wiegwOTYpgmkQ9llBX09PFH+7J8iZAcRUJ2pP+EoaYWddsC9yz+Ifl8fMIdAZW
         13BA==
X-Gm-Message-State: APjAAAWGHSzusKcmSt62twa9bsfjOAr6pajKRG3c7GjmPBxstHlWbpy5
        x2h1GhyGkp6yStC4aTi6IRp+LAdGe0ed0NHcS7w=
X-Google-Smtp-Source: APXvYqyYztE0Ccfq/c6xl1zz/C2czX0E38ZC+GExZEq7MpcBBfSS+9jYP65gJ3+4D44/T2JLqGSwFIHOSdddQiTlkBw=
X-Received: by 2002:a9d:7343:: with SMTP id l3mr10821312otk.268.1567136744976;
 Thu, 29 Aug 2019 20:45:44 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Fri, 30 Aug 2019 00:45:08 -0300
Message-ID: <CA+A7VXUkWFpQvnAbEy_eEJbriUAceHo=EUCthzA8sSW1t0=Oew@mail.gmail.com>
Subject: Inconsistent SDP database after HSP AG registered
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz, Johan, Marcel!

(cc'ing pulseaudio-discuss for awareness, but I believe nothing is
wrong on PulseAudio side)

I'm investigating a problem on to the interaction of more than one
PulseAudio instance with bluetoothd, specifically when registering the
HSP external profiles (oFono is not being used). On my setup, one
PulseAudio instance is started for GDM, and when the user logs in,
another instance is started for the user session. A few moments later
the GDM session finishes and the first PulseAudio instance exits.

The first instance is able to register support for HSP AG just fine,
and a SDP record is added to the server. When the second instance
starts, while the first one is already active, the RFCOMM server fails
to bind the socket, but the profile probe does not fail. From
PulseAudio's perspective everything worked just fine, but a SDP record
is not added to the server. This does not have any symptoms at this
point, since the record from the first instance is still active. You
can find the logs when that happens bellow.

Aug 29 20:03:40 mimieux pulseaudio[3166]: D: [pulseaudio]
backend-native.c: Bluetooth Headset Backend API support using the
native backend
Aug 29 20:03:40 mimieux pulseaudio[3166]: D: [pulseaudio]
backend-native.c: Registering Profile /Profile/HSPAGProfile
00001112-0000-1000-8000-00805f9b34fb
Aug 29 20:03:40 mimieux pulseaudio[3166]: I: [pulseaudio]
backend-ofono.c: Failed to register as a handsfree audio agent with
ofono: org.freedesktop.DBus.Error.ServiceUnknown: The name org.ofono
was not provided by any .service files
Aug 29 20:03:40 mimieux pulseaudio[3166]: D: [pulseaudio]
bluez5-util.c: oFono is running: no
Aug 29 20:03:40 mimieux bluetoothd[796]:
src/profile.c:register_profile() sender :1.864
Aug 29 20:03:40 mimieux bluetoothd[796]: src/profile.c:create_ext()
Created "Headset Voice gateway"
Aug 29 20:03:40 mimieux bluetoothd[796]:
src/profile.c:ext_adapter_probe() "Headset Voice gateway" probed
Aug 29 20:03:40 mimieux bluetoothd[796]: RFCOMM server failed for
Headset Voice gateway: rfcomm_bind: Address already in use (98)
Aug 29 20:03:40 mimieux bluetoothd[796]:
src/profile.c:ext_device_probe() Headset Voice gateway probed with
UUID 00001108-0000-1000-8000-00805f9b34fb
Aug 29 20:03:40 mimieux bluetoothd[796]: src/service.c:change_state()
0x556fa9e9f470: device 00:16:94:0B:1B:8B profile Headset Voice gateway
state changed: unavailable -> disconnected (0)

The problem happens when the first instance finally exits, and its SDP
record is removed. At this point there is a valid agent for the
profile (the second PulseAudio instance), but its UUID is not in list
of supported UUIDs on the SDP server for that adapter, and not on the
UUIDs property on the adapter object on D-Bus either.

While pairing and re-connections to headsets seem to be working fine
even after that failure, this is causing problems with a downstream
change we carry on PulseAudio at Endless, where we look at the
supported UUIDs from both the adapter and the device to device whether
a certain profile is supported, and then only create card profiles for
supported Bluetooth profiles. So in this case we end up without a card
profile for HSP even though the profile is actually supported. This
change is pending upstream review on
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/merge_requests/50,
but in any case the SDP database and UUIDs property should be
consistent with the list of supported profiles.

I'm not familiar with BlueZ' RFCOMM implementation, and haven't really
touched on BlueZ' code in a while, so I don't know what is the right
fix for this problem. I can write patches if given a general direction
of how to approach it, but I'm happy to test someone else's patches as
well.

Thanks!

--
Jo=C3=A3o Paulo Rechi Vita
