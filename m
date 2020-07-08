Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55558C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327A6206BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 03:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAP0WOMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgGHDcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGHDcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 23:32:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05AC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 20:32:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y3so50233143ybf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 20:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=odnQeCCDeJlo4axhRc7XyOZpCom8cJ2ILuCEO99s6zs=;
        b=dAP0WOMWjSVSsL757K4+s7n5xeRs51KtF4+KBxJSwGYcJlVgT9BAYzSCVGaUdpi5uK
         ydksM3Dg7zrYypgOEDuC3BynbfQjTOLcYb4eNwg7kO2n6dbyTGQ9CpIIHuRiVs3ad+Uz
         CQvxAVh8KSqEvFAcs7w9TGxm/Xqc6A4ruLhU65KwGT/6uxLolCpXpuHYYcUBTjnwcyPe
         m+6noJLuLHnL4nIU+pxTky14zKoPZQtE4fzdnywRIbDvum3mIwTtyfq4E2H1lIa383V+
         L418tai7NfHpzgwRgbUFbV4iN+3WbYoGCtaGltKxOBmaSZB+GXHhVLPCq04lZHmGMe+t
         7rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=odnQeCCDeJlo4axhRc7XyOZpCom8cJ2ILuCEO99s6zs=;
        b=t0QYXKD/49BhxBhP/eADIPj1LYn5bqsU7ZgiouDNWN0r8Ya0QU9ZIqxBhcOiDCq2ya
         0USrtXAdr7iZaDG4AL+jEzfxytmgZ5ss7Yrbax2VXmL+QnWhJozUfSEGAwYIL80njMUF
         n03r1vlrd7F2dcTS4EAFmVIrfijkE+k9qXL6QYWxmmCKrgYq/Srqr0PqiJ9tj+Fvvedy
         ul6FlxUej3ArRZbWjRyoCDoE/V4xBDUT4nYGz4l0TxHrAnchKMLUEJneULGXlkEY/PcJ
         t561VJcbzDCkIu9ItoxmrV6h1JMGChpHO4f3M1r6c2cOw89U3ZHmYvsP1Tc0zGSHmD4y
         SC/g==
X-Gm-Message-State: AOAM533V+hx9Yuac9i8wf4hq3wlDJR80wdlD2miLp7NmmoJng2ciaTJy
        A67JQoz9SxUf6jWTLhhM+MoRk9O2sTDGEjICNRaw4+atxl+dk0SNccBPkCGAldgK6KjdYlt4KJo
        tMYy+YReru+spq8gXZ5QaHIGU6/WLXOgw3hBfcQZGGIchql6jsxc8uznDgxHhcF4MNwMVpKZqeY
        eFOLfE+rL6YOE=
X-Google-Smtp-Source: ABdhPJxLbJuaS3QepNbC3Sa1cThNz7v51z6Icq1ygy3xGHdS22QHClXgD00KSNpBSqQyFovpTGicvSSjKMuVB+lLeQ==
X-Received: by 2002:a25:3342:: with SMTP id z63mr87459609ybz.200.1594179164413;
 Tue, 07 Jul 2020 20:32:44 -0700 (PDT)
Date:   Wed,  8 Jul 2020 11:32:23 +0800
Message-Id: <20200708113139.bluez.v1.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [bluez PATCH v1] avrcp: include all player settings in notif event
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

 profiles/audio/avrcp.c | 69 ++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e2428250e..da0c7c9da 100644
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
@@ -751,6 +781,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 	uint8_t code;
 	uint16_t size;
 	GSList *l;
+	GList *settings;
 	int attr;
 	int val;
 
@@ -791,19 +822,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
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
@@ -1626,29 +1645,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
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

