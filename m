Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA78C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 22:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41811241A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 22:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AczFD9Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506609AbgJUWTk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506551AbgJUWTk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Oct 2020 18:19:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD88C0613CE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 15:19:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so5440431ejy.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieWTu+uvtztBXLyExgB6EMB6I2rBPb0/2wjsEBzIWDM=;
        b=AczFD9NvxONBsErfMJ/CidD0kkbtN4Eq1NSFxL/e5LpOTkS2i7Ly10PjOWeTFnaK8J
         HgwS4J9ebvLT7ZtwTmgzl+SRHzouy+kAw94vINCyaejhayWU5iPjvF2az+9eJg05rWB5
         McdWvJ9d7loQ2fhuOogS74Lk9qXsiqgA9077pH4audg0jOsSLoxFdgoWV2HwBMPyzQxA
         6JVu2G1GAyd+kZzx7DmOGVBuwHOBATV5cyc+oQygKYcbP+iAtiU8AVNXe5LTl5JaJ6oV
         XbGQQmm3yZKRXbiLZrteDK2/NoE03sGMBVcJp5pxuYjOcPppd0FiDf3lnqrjkzSzXMtH
         J0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieWTu+uvtztBXLyExgB6EMB6I2rBPb0/2wjsEBzIWDM=;
        b=SnCz5N4W9OPqBJKzybbR2XJ7//Cgfbb9scLUbfBY51KIRKXxUXx7y6pLhZeEcVNpwa
         T12zg+HVsHjDJoppNyiUjfLLu60f2EHkWTIFx1vFfqy0V6lM9Z1kymOOiq/VkAXxME2K
         ourNCusokKvJq0JvaQcO1UWgCpKUvjY3S9ElWV2zspDosyRTqfNjV6wUoKbzqbM1Q9Xu
         U5J9LAsz30zFY9c8mu/EBbWgjMpEznoAiaYw+fB4LPgwtF1cvUEMwBOFrXGeeLBnYaid
         DhvaRLTaTGmenE01S/kMKO1YRz0HkkjXofFaOLoHkXDgVig+WtsIaSM3fKvkD6pzYxk8
         Wrmg==
X-Gm-Message-State: AOAM5311RFuCkWS4YFKCngqqrX6VpHUZ3PCMchyp3HaHR9VJLtSyj60m
        bLNuFu7Yw+Crwub33fUVKks=
X-Google-Smtp-Source: ABdhPJwxT7hTMa+9HWQgpOJ5Vg8Wm9mLz8WmBiJ9bGC/SqN+BpaE7ZUmpajdljpqJEsMaFvB6K8QqA==
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr5403455ejc.339.1603318778273;
        Wed, 21 Oct 2020 15:19:38 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id k21sm2584227edv.31.2020.10.21.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 15:19:37 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     ma.czerski@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH BlueZ] audio: avrcp: Split supported events between target and controller
Date:   Thu, 22 Oct 2020 00:19:31 +0200
Message-Id: <20201021221931.931878-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com>
References: <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

supported_events was previously initialized based on whatever the AV
Remote Controller profile running on the peer device could request based
on its version, and assumes BlueZ is running in the AV Remote Target
profile.
If however BlueZ runs the Remote Controller profile (is an audio sink)
against a Remote Target profile on the peer (the audio source) this
version is incorrectly taken into account: a Remote Controller profile
on the peer is not involved in this connection.  If its version is too
low supported_events will not contain all events the peer might
rightfully attempt to register.

This is particularly problematic with Android phones as an A2DP audio
source playing back to BlueZ which is the sink.  Most Android phones
report their Remote Controller profile version as 1.3 when initializing
as audio source [1] meaning that AVRCP_EVENT_VOLUME_CHANGED is
inadvertently rejected in avrcp_handle_register_notification.  As
mentioned above this profile is of no relevance to the connection, only
the Remote Target on the phone (source) and Remote Controller on BlueZ
(sink) take part.

The problem is addressed by splitting supported_events in two variables:
target_supported_events containing all events the peer Remote Controller
might attempt to register with the local Remote Target profile, and
controller_supported_events containing all events the Remote Target
might attempt to register with the local Remote Controller profile.

In addition the possible notifications going either way have been
limited.  An audio source is in control over media playback and will
never request playback state changes from the Remote Controller.
Likewise the audio sink is in control over its rendering volume and will
never have to request volume notifications from the Remote Target.
This does however still allow the Remote Controller to send playback
control messages to the source, and the Remote Target to send
SetAbsoluteVolume to the sink; both of which are not notifications.

[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761

---

Hi Luiz, Marek,

This is a preliminary version of the patch that aims to address the
issues covered in our mail thread.  Keep in mind it is "intentionally"
messy; I commented out unexpected events based on logically deriving the
possibilities (as described in the message above) without checking if
this is in accordance with the documentation.

I still have to test this between two devices that can both run an audio
sink and source, such as two machines running BlueZ.  Playing back audio
both ways should never make this collapse on its own, though I think at
that point multiple transports are associated with a device and
media_transport_is_source would be lying, based on whichever transport
comes first in the list.  Likewise registered_events needs to be split
in two variables as well.

I'm not sure what's causing the race condition Marek was observing.  I
assume the call to avrcp_get_capabilities or avrcp_connect_browsing in
controller_init triggers the peer to start requesting capabilities and
registering for notifications, before target_init is called (which would
previously be too late to initialize supported_events).  That case will
also be addressed in this patch, but if it happens "at random" because
the pdu handler is registered before supported_events is assigned I
propose to split session_init_control in 3 steps instead:

1. Retrieve remote profile versions and set up *_supported_events;
2. Register pdu and passthrough handler;
3. The rest from {controller,target}_init.

Looking forward to hearing your suggestions.

Best regards,
Marijn Suijten

 profiles/audio/avrcp.c     | 58 +++++++++++++++++++++++++++++++-------
 profiles/audio/transport.c | 20 +++++++++++++
 profiles/audio/transport.h |  1 +
 3 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c093deac8..af5dc4212 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -269,7 +269,13 @@ struct avrcp {
 	unsigned int control_id;
 	unsigned int browsing_id;
 	unsigned int browsing_timer;
-	uint16_t supported_events;
+	// TODO: Swap names to make them represent the name of the peer profile,
+	// instead of the opposite local profile?
+	/* Events the Remote Target expects based on peer Remote Controller version */
+	uint16_t target_supported_events;
+	/* Events the Remote Controller expects based on peer Remote Target version */
+	uint16_t controller_supported_events;
+	// TODO: Registered_events should be split across controller/target too!
 	uint16_t registered_events;
 	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
@@ -1060,7 +1066,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = ntohs(pdu->params_len), supported_events;
 	unsigned int i;

 	if (len != 1)
@@ -1068,6 +1074,11 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,

 	DBG("id=%u", pdu->params[0]);

+	if (media_transport_is_source(session->dev))
+		supported_events = session->target_supported_events;
+	else
+		supported_events = session->controller_supported_events;
+
 	switch (pdu->params[0]) {
 	case CAP_COMPANY_ID:
 		for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
@@ -1082,7 +1093,7 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 	case CAP_EVENTS_SUPPORTED:
 		pdu->params[1] = 0;
 		for (i = 1; i <= AVRCP_EVENT_LAST; i++) {
-			if (session->supported_events & (1 << i)) {
+			if (supported_events & (1 << i)) {
 				pdu->params[1]++;
 				pdu->params[pdu->params[1] + 1] = i;
 			}
@@ -1607,7 +1618,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 {
 	struct avrcp_player *player = target_get_player(session);
 	struct btd_device *dev = session->dev;
-	uint16_t len = ntohs(pdu->params_len);
+	uint16_t len = ntohs(pdu->params_len), supported_events;
 	uint64_t uid;
 	int8_t volume;

@@ -1620,7 +1631,12 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		goto err;

 	/* Check if event is supported otherwise reject */
-	if (!(session->supported_events & (1 << pdu->params[0])))
+	if (media_transport_is_source(session->dev))
+		supported_events = session->target_supported_events;
+	else
+		supported_events = session->controller_supported_events;
+
+	if (!(supported_events & (1 << pdu->params[0])))
 		goto err;

 	switch (pdu->params[0]) {
@@ -4129,7 +4145,11 @@ static void target_init(struct avrcp *session)
 		media_transport_update_device_volume(session->dev, init_volume);
 	}

-	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
+	if (target->version < 0x0103)
+		return;
+
+	session->target_supported_events |=
+				(1 << AVRCP_EVENT_STATUS_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
@@ -4138,10 +4158,13 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;

-	session->supported_events |=
+	session->target_supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
-				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
+				// Does not make sense here; the remote is the
+				// rendering device and in control, it'll never
+				// request this notification.
+				// (1 << AVRCP_EVENT_VOLUME_CHANGED);

 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
@@ -4180,11 +4203,26 @@ static void controller_init(struct avrcp *session)
 	if (controller->version < 0x0103)
 		return;

-	avrcp_get_capabilities(session);
+	// Players should only run on the remote target; they
+	// should never request notifications about their own
+	// playback status.
+	// session->controller_supported_events |=
+	// 			(1 << AVRCP_EVENT_STATUS_CHANGED) |
+	// 			(1 << AVRCP_EVENT_TRACK_CHANGED) |
+	// 			(1 << AVRCP_EVENT_TRACK_REACHED_START) |
+	// 			(1 << AVRCP_EVENT_TRACK_REACHED_END) |
+	// 			(1 << AVRCP_EVENT_SETTINGS_CHANGED);

 	if (controller->version < 0x0104)
 		return;

+	session->controller_supported_events |=
+				// (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
+				// (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
+				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+
+	avrcp_get_capabilities(session);
+
 	if (!(controller->features & AVRCP_FEATURE_BROWSING))
 		return;

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8248014ae..f5226776f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -980,3 +980,23 @@ void media_transport_update_device_volume(struct btd_device *dev,
 			media_transport_update_volume(transport, volume);
 	}
 }
+
+gboolean media_transport_is_source(struct btd_device *dev)
+{
+	GSList *l;
+	const char *uuid;
+
+	if (dev == NULL)
+		return FALSE;
+
+	for (l = transports; l; l = l->next) {
+		struct media_transport *transport = l->data;
+		if (transport->device != dev)
+			continue;
+
+		uuid = media_endpoint_get_uuid(transport->endpoint);
+		return strcasecmp(uuid, A2DP_SOURCE_UUID) == 0;
+	}
+
+	return FALSE;
+}
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 51a67ea74..eb1621813 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -30,3 +30,4 @@ void transport_get_properties(struct media_transport *transport,
 int8_t media_transport_get_device_volume(struct btd_device *dev);
 void media_transport_update_device_volume(struct btd_device *dev,
 								int8_t volume);
+gboolean media_transport_is_source(struct btd_device *dev);
--
2.29.0

