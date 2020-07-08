Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E12C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 04:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E7220720
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 04:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxI29Sz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgGHETm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHETm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 00:19:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEEC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 21:19:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7so35296078ybk.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 21:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IgLPwFPJVaB1oc0Pd9NiOCIHkZRJPlObT0iPNSI37aQ=;
        b=XxI29Sz53C4fa2qizmf+lhuIIKSTAOmfn/gtlMYndgCPQXKmqrLaA2ofJy9unue41w
         t9Y845lAdWMewYd+4MdGdCrwBuCVBskg41ROWi3M9CZ6qVyd6CqB5lWSiqAxLFvJTC3v
         jHO7dbZNSaWzg+2FOam/r+y/gVn3T88pbYyA7BaYMOmtjtnOUUG0yX4sFeZvLHQuqv6O
         tHvEB/la8YM2/8XCcBUm4KalWlfRwlBvJXDmyFO5DEyswJkrsRWtwBG+lqDM5fyFyrvI
         /bH/7alLYQHf/btXrk/zQxUKndyvPtgVPfv+AXd44ZctIEu4ddLDZhxMR3HGtdtcbecg
         unxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IgLPwFPJVaB1oc0Pd9NiOCIHkZRJPlObT0iPNSI37aQ=;
        b=DB3qG2uTAC5G+1GrhXgU63FGPfIVDvZwxpQLhwySJTdXd08YdFRhKmG8ymYbMjd8wb
         0izQE+c4uEPKqLjMGqygLKEAFz5NWpjliS7pFACkyje26PSakPPHTdTtUycR5UiUpGG2
         msXFfWXpKJaLsnTXffzLcgVZVvIPei0ST3cK6iF9jg5zFT6P+XBBXyvnAxQUz07sUijw
         YWtACfnlBamAq1ufRBAQGi/LH9+g97eHdxSToebwMeDbnlKdOT2BMl+HdHSxCwNaOVoF
         OQNrjK4NRO99cOQUuMd3b4RGCKSlb2w7uXXtI7gtrfMy2MnGFOH0+WMWEPN9zH7x/YtO
         PPGg==
X-Gm-Message-State: AOAM531t7qZmsY8pnxFJGCgkDJP8k/4svi+EiLXmSs59IIiQgFnDpy2k
        rkJGd3v47gzaxfJ5Gr5x8QEipzc87Re6v37v6vGCiJb8ULRrmUOTbMkPBwKnXcFxILjrOwqJG78
        T/VNox2ymxlw5h+krCnABEGGj/McGLNd2g1zvxUgwqawV0pV+TRRgMnFQ8RJWorkBvmumFzyjYV
        k/X/33Zd66vr8=
X-Google-Smtp-Source: ABdhPJwOm6ZZ1/S0Seu5p6Soe7jzFJMn3HauEmEs1GHcMABxksPmbEDLz/zI2L0mam6JBJ+2IHUX/yIcBZs3moPtww==
X-Received: by 2002:a25:c711:: with SMTP id w17mr10971154ybe.465.1594181981156;
 Tue, 07 Jul 2020 21:19:41 -0700 (PDT)
Date:   Wed,  8 Jul 2020 12:19:32 +0800
Message-Id: <20200708121928.bluez.v2.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [bluez PATCH v2] avrcp: include all player settings in notif event
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Howard Chung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to AVRCP 1.6.2 spec section 6.7.2 table 6.39, all player
application settings should be returned to the CT and let CT to
determine which settings have changed. Currently bluez only returns
the changed attribute instead. This patch also addresses a potential
issue on which the number of application settings mismatches with
the actual number returned.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v2:
- Fixed unused variables

 profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e2428250e..a4de7530e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -369,6 +369,7 @@ static uint32_t company_ids[] = {
 };
 
 static void avrcp_register_notification(struct avrcp *session, uint8_t event);
+static GList *player_list_settings(struct avrcp_player *player);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -743,6 +744,35 @@ static int play_status_to_val(const char *status)
 	return -EINVAL;
 }
 
+static uint16_t player_settings_changed(struct avrcp_player *player,
+						struct avrcp_header *pdu)
+{
+	GList *settings = player_list_settings(player);
+	int size = 2;
+
+	for (; settings; settings = settings->next) {
+		const char *key = settings->data;
+		int attr;
+		int val;
+
+		attr = attr_to_val(key);
+		if (attr < 0)
+			continue;
+
+		val = player_get_setting(player, attr);
+		if (val < 0)
+			continue;
+
+		pdu->params[size++] = attr;
+		pdu->params[size++] = val;
+	}
+
+	g_list_free(settings);
+
+	pdu->params[1] = (size - 2) >> 1;
+	return size;
+}
+
 void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 							const void *data)
 {
@@ -751,8 +781,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 	uint8_t code;
 	uint16_t size;
 	GSList *l;
-	int attr;
-	int val;
 
 	if (player->sessions == NULL)
 		return;
@@ -791,19 +819,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		size = 1;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		size = 2;
-		pdu->params[1] = 1;
-
-		attr = attr_to_val(data);
-		if (attr < 0)
-			return;
-
-		val = player_get_setting(player, attr);
-		if (val < 0)
-			return;
-
-		pdu->params[size++] = attr;
-		pdu->params[size++] = val;
+		size = player_settings_changed(player, pdu);
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		size = 5;
@@ -1595,7 +1611,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	struct btd_device *dev = session->dev;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
-	GList *settings;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -1626,29 +1641,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		len = 1;
-		settings = player_list_settings(player);
-
-		pdu->params[len++] = g_list_length(settings);
-		for (; settings; settings = settings->next) {
-			const char *key = settings->data;
-			int attr;
-			int val;
-
-			attr = attr_to_val(key);
-			if (attr < 0)
-				continue;
-
-			val = player_get_setting(player, attr);
-			if (val < 0)
-				continue;
-
-			pdu->params[len++] = attr;
-			pdu->params[len++] = val;
-		}
-
-		g_list_free(settings);
-
+		len = player_settings_changed(player, pdu);
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		len = 5;
-- 
2.27.0.383.g050319c2ae-goog

