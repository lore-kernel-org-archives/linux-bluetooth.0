Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E5C47082
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A385360232
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGSsi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGSsh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 14:48:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB2C061766
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jun 2021 11:46:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4so952879pjk.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kZK+3h7rVTTYPy/8oySHeLNn9zpdgbrouedAN/VdPM=;
        b=mOff/L1s1Sfr8NlUJCa75U9AqWVppWRFla7OkwXXhniiF3kYkWMLT3mmZIGniJqtnU
         mhLjCgGzWvQjgmkof1WznAAIvy/ScZLRyn236H1o6pJJmMQJHrD4WGTt8Tl8tEPndrVY
         VFeLkJTii58b7g1AJGjW9Tkk1bZ88HTfOOXJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kZK+3h7rVTTYPy/8oySHeLNn9zpdgbrouedAN/VdPM=;
        b=TksYM1ajz9+FqX7oJJTg8zgDcw1K/W/0G5hAA1JP62D2ICgA2+yxCHxZ36IZ0S9hva
         DerCyJt88HLrVKRFARUr1IAc3gIKOVqSVjGdwdynAiVAaSxu1AEfjwJ10F8xrmtB7OhC
         X6GjSJfzG6moiFgzu037eLnm5BFVD0rTYHTt/BzXfA3IRLZfi9f0o8Mi4jAsq8dpVHPt
         HwZWDj8NlvLJxeHjginyfbbGE7TunfUBBGOVNatYsiduvjLpL9sj+cjiqvwWGiBE5VoR
         X4bS/oW9IH6OzxraAcxgw+yMc91vlb/a/JakSxqvs/Qdl2n3Mq8C0ANDxuQckQQYkeWw
         tFOQ==
X-Gm-Message-State: AOAM532rKLI4Tnh/XZndwYusVz3fJs2vIDiDn/Uj1a8TTltQKAQB9017
        Hy2ack6wu+cNAwcfMiyoWnyng1PEDVKb0g==
X-Google-Smtp-Source: ABdhPJweHaX+ZluB6SBYxkt9CkdgNpC11F0Xy1n+7tH+tkEe0Q7FHx+gmDrogCw/PbcxHcxgubt7pg==
X-Received: by 2002:a17:90a:1688:: with SMTP id o8mr21759796pja.92.1623091589075;
        Mon, 07 Jun 2021 11:46:29 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:8278:2ea0:83a1:6148])
        by smtp.gmail.com with ESMTPSA id g29sm9257203pgm.11.2021.06.07.11.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 11:46:28 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
Date:   Mon,  7 Jun 2021 11:46:16 -0700
Message-Id: <20210607184616.22051-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SetAbsoluteVolume command may receive late response for Target Device
that have high latency processing. In that case we may send the next
SetAbsoluteVolume commands before the previous SetAbsoluteVolume
response is received. This causes the media transport volume to jitter.

The solution in this patch is to not send any SetAbsoluteVolume command
if there is an in-progress one. Instead we should queue this command to
be executed after the in-progress one receives the response.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 profiles/audio/avrcp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ccf34b220..c6946dc46 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -256,6 +256,11 @@ struct avrcp_data {
 	GSList *players;
 };
 
+struct set_volume_command {
+	uint8_t volume;
+	bool notify;
+};
+
 struct avrcp {
 	struct avrcp_server *server;
 	struct avctp *conn;
@@ -275,6 +280,12 @@ struct avrcp {
 	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
+	// Whether there is a SetAbsoluteVolume command that is still waiting
+	// for response.
+	bool is_set_volume_in_progress;
+	// If this is non-null, then we need to issue SetAbsoluteVolume
+	// after the current in-progress SetAbsoluteVolume receives response.
+	struct set_volume_command *queued_set_volume;
 };
 
 struct passthrough_handler {
@@ -4252,6 +4263,24 @@ static void target_destroy(struct avrcp *session)
 	g_free(target);
 }
 
+void update_queued_set_volume(struct avrcp *session, uint8_t volume,
+				bool notify)
+{
+	if (!session->queued_set_volume)
+		session->queued_set_volume = g_new0(struct set_volume_command,
+							1);
+	session->queued_set_volume->volume = volume;
+	session->queued_set_volume->notify = notify;
+}
+
+void clear_queued_set_volume(struct avrcp *session)
+{
+	if (!session->queued_set_volume)
+		return;
+	g_free(session->queued_set_volume);
+	session->queued_set_volume = NULL;
+}
+
 static void session_destroy(struct avrcp *session, int err)
 {
 	struct avrcp_server *server = session->server;
@@ -4295,6 +4324,8 @@ static void session_destroy(struct avrcp *session, int err)
 	if (session->browsing_id > 0)
 		avctp_unregister_browsing_pdu_handler(session->browsing_id);
 
+	clear_queued_set_volume(session);
+
 	g_free(session);
 }
 
@@ -4486,6 +4517,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	struct avrcp_header *pdu = (void *) operands;
 	int8_t volume;
 
+	session->is_set_volume_in_progress = false;
+
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED ||
 								pdu == NULL)
 		return FALSE;
@@ -4495,6 +4528,13 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 	/* Always attempt to update the transport volume */
 	media_transport_update_device_volume(session->dev, volume);
 
+	if (session->queued_set_volume) {
+		avrcp_set_volume(session->dev,
+					session->queued_set_volume->volume,
+					session->queued_set_volume->notify);
+		clear_queued_set_volume(session);
+	}
+
 	if (player != NULL)
 		player->cb->set_volume(volume, session->dev, player->user_data);
 
@@ -4570,6 +4610,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 	if (session == NULL)
 		return -ENOTCONN;
 
+	// If there is an in-progress SetAbsoluteVolume, just update the
+	// queued_set_volume. Once the in-progress SetAbsoluteVolume receives
+	// response, it will send the queued SetAbsoluteVolume command.
+	if (session->is_set_volume_in_progress) {
+		update_queued_set_volume(session, volume, notify);
+		return 0;
+	}
+
 	if (notify) {
 		if (!session->target)
 			return -ENOTSUP;
@@ -4589,6 +4637,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 	pdu->params[0] = volume;
 	pdu->params_len = htons(1);
 
+	session->is_set_volume_in_progress = TRUE;
 	return avctp_send_vendordep_req(session->conn,
 					AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
 					buf, sizeof(buf),
-- 
2.31.0

