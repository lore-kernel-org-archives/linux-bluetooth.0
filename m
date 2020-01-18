Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F4C32771
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 19:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6924680
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 19:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+XzbOso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgARTtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:49:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34656 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgARTtt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 14:49:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so11837104wmi.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2020 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuskuInYv7N8uJRw5NS75RZA2eDShoZ2nwXfzXtCKAg=;
        b=M+XzbOsoQ3mQ596Nds6VJrYmPzzOsOGMqckmM7Cx8xTox8fgWbp+tRW7SdrncH2isp
         0yaH175HxVUFbDtRFPs8bFdRJRTQ9LXBc8saz4l2TVhxFTW8W17MDv/HUnwG+X0AuHBR
         OvotqEdXWFSvj3LwQRPmq4POvaEzya1fjxpfLuDjLbBFzaLW5eNe8z+/Nov2EXJ4+KXT
         KibRuD5CAP91H455PmfoKa/iblD+P2yoBeo21c3VyqUKnGLvgmWMkQZ32PFjYiINByzY
         7iXVQ3fAA0R7+FVyxvDcPYf53j1aOcfq1gj4Ev/i4u32o51QgDLEDAHFXLda+2veUCSd
         B+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WuskuInYv7N8uJRw5NS75RZA2eDShoZ2nwXfzXtCKAg=;
        b=XdGvt1GD2GEZmBCczI+IMKcRPuzfpUY4UWtMC8wYS1Q6TKHZ+1FC6BFmiPP64ArZ/3
         B5kVQacmIeMLd42BXE3hNWMNM6ML/Nk6DL091Lm1KVIjPncgPOvdwr2TiOfa9qMMSo0T
         gnDkx/reIX0P147jZuF7G9cAZ4lHqGuuFv5+8EVyqHfiLVQ828uOGS4suP/3LQRa19d9
         01yLgSsQcV2gC4H8RhRldNpZPbHu4WkSIzhuiaGUfvo/OHZSGTHe3kj9+Y/pE0YTEBgn
         c2w4532i6TN0VEZwYO/Sq53FaNxjEHKzEuSIwNeQj31ZA9gx/sXP9N4fWreu3q5xLkuk
         4Svw==
X-Gm-Message-State: APjAAAUdnByu4omu01C6Hm2PLtX3Y+a0tPuldGyIpaQ3hCqNlrnFv0dQ
        EDBY0n5YtwdLzbq6+OLit1ItNcWe
X-Google-Smtp-Source: APXvYqyNg+5ZedunP2iCObrAPRanEvDwj6PNRQBg+plNobe3EV9wiBwTvo4CSX06CfSQcsZuhMCcZA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr11074331wmg.110.1579376986471;
        Sat, 18 Jan 2020 11:49:46 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id l15sm38210681wrv.39.2020.01.18.11.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 11:49:46 -0800 (PST)
From:   Marijn Suijten <marijns95@gmail.com>
X-Google-Original-From: Marijn Suijten
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Marijn Suijten <marijns95@gmail.com>
Subject: [BlueZ PATCH] audio: avrcp: Ignore peer RT supported_events when being the RT.
Date:   Sat, 18 Jan 2020 20:48:41 +0100
Message-Id: <20200118194841.439036-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marijn Suijten <marijns95@gmail.com>

Remove the check of a received event against supported_events in
avrcp_handle_register_notification, which is only called when BlueZ is
the RT even though supported_events is only valid when BlueZ is the TG.

supported_events is assigned in target_init with events that the
corresponding RT on the other side of the Bluetooth connection supports,
to ensure the local TG will never report anything unexpected in
avrcp_handle_get_capabilities. This value is specific to what the target
should support to be compatible with the peer RT, but a locally running
RT has nothing to do with the external device being the RT.

This addresses the case where Absolute Volume notification registrations
are rejected when audio is played from an Android device to a computer
running BlueZ. The Android BT stack report an RT of version 1.3 [1]
which does not include Absolute Volume support. The RT on the Android
device is not involved in such a playback session, instead the computer
is the RT and the Android device the TG.

This has been tested by disabling registration of the RT service in
Android, to make the device a "pure" media player that cannot receive
audio: target_init does not get called and supported_events stays 0
which would have caused any notification registration to be rejected in
the above case.

[1]: https://android.googlesource.com/platform/system/bt/+/android-10.0.0_r25/bta/av/bta_av_main.cc#712
---
Hi,

I have a separate patch lying around that - instead of removing
supported_events - splits it up in two variables; one for the target and
another for the controller. Let me know if this extra safety is desired.

According to the AVRCP 1.3 specification GetCapabilities is mandatory,
which I have included in that patch. However the documentation also
mentions that this function is only supposed to be called by the CT
meaning that the call in target_init (introduced in 27efc30f0) is not
valid. What is your view on this?
Unfortunately even the small pair of in-ears I have lying around report
AVRCP TG functionality while they are not nearly capable of being a
target/media-source, so I have not been able to confirm how a pure RT
device would respond in such case.

- Marijn Suijten

 profiles/audio/avrcp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 7fb8af608..820494d2a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1529,10 +1529,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	if (len != 5)
 		goto err;
 
-	/* Check if event is supported otherwise reject */
-	if (!(session->supported_events & (1 << pdu->params[0])))
-		goto err;
-
 	switch (pdu->params[0]) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		len = 2;
-- 
2.25.0

