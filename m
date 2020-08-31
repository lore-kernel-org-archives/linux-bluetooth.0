Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB8C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78650208DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hAylWT8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgHaHhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgHaHhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 03:37:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48055C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:37:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so8544261ybg.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eAXlDAAz5TFmeza+8DaCP4za8yezvOdPfYr8LC/+Kmw=;
        b=hAylWT8i1IGKX+hEyZI7h86gg8wiK9hGw71IsOt0+YkYjstQ1Sf+cDEV0mC8CdB8mW
         RKDhXHbQsILpanxY+qIo+u86MyI/NJn+Boa4Ig1rV0MA4mftdT4VLkwUIuWYdjKW0ta9
         vAaHyQlQVy+YLgMeP3UZ0ODICGJ9RjIloK3vlR0v1XmMu1NXAxRkzDwFUWLtWtAY0BZJ
         CEwT1O+nKOBQn1dKiTPy3Z6o7+dabtMyKbDPs4XQW9p3uXWZos0F2t1AAEzoTKt0YGl4
         +O9WNzBjuPOOvTfZNhEAv/qpP4M7B0s+LIfUYkcfjaSZDBczLgx5Z/qlDIssllr7jXRK
         tkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eAXlDAAz5TFmeza+8DaCP4za8yezvOdPfYr8LC/+Kmw=;
        b=aevI4xcOBjMwwhHY5EZ38mAqC8ZjxNa+gnPfYJ0/B23fPuUPsOUCG7Ti0QLOEOuU4R
         5WZBIeRhNz+WWp2N01IkLvC6Xe5SbtD5SA96Oh9OgQXVb8TOWcQ5gc6cY+kRw7WLF0kS
         JrnTJgSwRDXKdtPqqma8CYpEisB3BbUvsOEvdLZXU5JN0AjYCPz3fhajWRawml95I85m
         AGfj5iaeDgPNIndsmx+wEwWSaPN5dP7EZ5VSTn854sn/G6HzHeKBn7SKdps3te0UX/mS
         ofVQDK59pAszGvHiET8hbPby6IoJHMP5NTKFH1ux7/el0AqM/+etEdx3T1j7MH2SkACf
         iTQA==
X-Gm-Message-State: AOAM5303F+AEgkPKr/cn70PlJRIPFigbEmWIx4xISaSHvl4zlYqbHPNF
        kxskHwSxQCEl897PQm2/p0ih9bltH+J9z02rM6M/la5rWRDlPEzNW+TVBeO//KIYhRJiKXIdFc2
        Qmrvvc6gOQjgnVAsBWzvnGwyrPFewJC+n8GGR8eDtMoyu4tH8eKVilDrcfTNRBopiSUzM9flHwn
        Th
X-Google-Smtp-Source: ABdhPJy44ZKx+DKs66rlS6hLJ1rCg6GgZzOEkcdeLWTmk3p65pMOuW/wQOPYPABnk4C3FNmvbxj3g0NyysDS
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:8290:: with SMTP id
 r16mr562048ybk.122.1598859436245; Mon, 31 Aug 2020 00:37:16 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:36:33 +0800
In-Reply-To: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
Message-Id: <20200831153544.Bluez.v1.2.Ia9ec99e1edde324e55c91828218268bc1b614136@changeid>
Mime-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v1 2/2] avrcp: Implement Press method for MediaPlayer1
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This allows us to send any passthrough command.

Reviewed-by: Michael Sun <michaelfsun@google.com>
---

 profiles/audio/avrcp.c  |  9 +++++++++
 profiles/audio/player.c | 24 ++++++++++++++++++++++++
 profiles/audio/player.h | 30 ++++++++++++++++--------------
 3 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5d0256c52..b6f4ef90d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3043,6 +3043,14 @@ static int ct_rewind(struct media_player *mp, void *user_data)
 	return ct_press(player, AVC_REWIND);
 }
 
+static int ct_press_key(struct media_player *mp, uint8_t avc_key,
+								void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, avc_key);
+}
+
 static int ct_list_items(struct media_player *mp, const char *name,
 				uint32_t start, uint32_t end, void *user_data)
 {
@@ -3388,6 +3396,7 @@ static const struct media_player_callback ct_cbs = {
 	.previous	= ct_previous,
 	.fast_forward	= ct_fast_forward,
 	.rewind		= ct_rewind,
+	.press		= ct_press_key,
 	.list_items	= ct_list_items,
 	.change_folder	= ct_change_folder,
 	.search		= ct_search,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 09ee979e4..4a16f65b3 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -570,6 +570,28 @@ static DBusMessage *media_player_rewind(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *media_player_press(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+	uint8_t avc_key;
+
+	if (cb->cbs->press == NULL)
+		return btd_error_not_supported(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BYTE, &avc_key,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	err = cb->cbs->press(mp, avc_key, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static void parse_folder_list(gpointer data, gpointer user_data)
 {
 	struct media_item *item = data;
@@ -704,6 +726,8 @@ static const GDBusMethodTable media_player_methods[] = {
 	{ GDBUS_METHOD("Previous", NULL, NULL, media_player_previous) },
 	{ GDBUS_METHOD("FastForward", NULL, NULL, media_player_fast_forward) },
 	{ GDBUS_METHOD("Rewind", NULL, NULL, media_player_rewind) },
+	{ GDBUS_METHOD("Press", GDBUS_ARGS({"avc_key", "y"}), NULL,
+							media_player_press) },
 	{ }
 };
 
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 536394ca6..bd24c16ec 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -45,26 +45,28 @@ struct media_player;
 struct media_item;
 
 struct media_player_callback {
-	bool (*set_setting) (struct media_player *mp, const char *key,
+	bool (*set_setting)(struct media_player *mp, const char *key,
 				const char *value, void *user_data);
-	int (*play) (struct media_player *mp, void *user_data);
-	int (*pause) (struct media_player *mp, void *user_data);
-	int (*stop) (struct media_player *mp, void *user_data);
-	int (*next) (struct media_player *mp, void *user_data);
-	int (*previous) (struct media_player *mp, void *user_data);
-	int (*fast_forward) (struct media_player *mp, void *user_data);
-	int (*rewind) (struct media_player *mp, void *user_data);
-	int (*list_items) (struct media_player *mp, const char *name,
+	int (*play)(struct media_player *mp, void *user_data);
+	int (*pause)(struct media_player *mp, void *user_data);
+	int (*stop)(struct media_player *mp, void *user_data);
+	int (*next)(struct media_player *mp, void *user_data);
+	int (*previous)(struct media_player *mp, void *user_data);
+	int (*fast_forward)(struct media_player *mp, void *user_data);
+	int (*rewind)(struct media_player *mp, void *user_data);
+	int (*press)(struct media_player *mp, uint8_t avc_key,
+							void *user_data);
+	int (*list_items)(struct media_player *mp, const char *name,
 				uint32_t start, uint32_t end, void *user_data);
-	int (*change_folder) (struct media_player *mp, const char *path,
+	int (*change_folder)(struct media_player *mp, const char *path,
 						uint64_t uid, void *user_data);
-	int (*search) (struct media_player *mp, const char *string,
+	int (*search)(struct media_player *mp, const char *string,
 						void *user_data);
-	int (*play_item) (struct media_player *mp, const char *name,
+	int (*play_item)(struct media_player *mp, const char *name,
 					uint64_t uid, void *user_data);
-	int (*add_to_nowplaying) (struct media_player *mp, const char *name,
+	int (*add_to_nowplaying)(struct media_player *mp, const char *name,
 					uint64_t uid, void *user_data);
-	int (*total_items) (struct media_player *mp, const char *name,
+	int (*total_items)(struct media_player *mp, const char *name,
 						void *user_data);
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

