Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3734DC0502C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH2Ubl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiH2Ubi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128086061
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:31:36 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E75886601EFA
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 21:31:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661805095;
        bh=P3yg9pjA4JOGOzvo6fS5tNf8wsT314FCGhpxG7buljY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RsspMYT1Iynw8WzMbsChiRxZh4Fm7PQzh1AumRGqEdf7iXAh2lZkq1GKOrgB7LQL5
         H1SttnXXVWoYXlHDafR49Qz6/RkM5iDw2QOka6kjRgL2yDS4fOBVqGCoh1b/i67SX1
         3Q6+VBFF1WWgoZ7yezi5P77bu1Ju7K7yEsz5aLz+Ehlz7pwHji9CY1MhKNoj295SrX
         cTkVxahisFeh4rJ3m5X0UiYXq0UKcISSqux/TtljRcXd09Jlaq58ZWoc80QZTRMwwP
         aFcKNvsyv4OehUf2pjsNNBFUD/pypuiKnlNcmf+fNOk4FzzHFEJpQaeA2PM+1zfHJy
         Rm6jnejHJrJGg==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] profiles: Add remote endpoint path to SelectProperties
Date:   Mon, 29 Aug 2022 22:31:21 +0200
Message-Id: <20220829203122.51343-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829203122.51343-1-frederic.danis@collabora.com>
References: <20220829203122.51343-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/bap.c   | 2 +-
 profiles/audio/media.c | 3 +++
 src/shared/bap.c       | 2 ++
 src/shared/bap.h       | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d388afe56..cf27ec0ae 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -613,7 +613,7 @@ static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	/* TODO: Cache LRU? */
 	if (btd_service_is_initiator(service))
-		bt_bap_select(lpac, rpac, select_cb, ep);
+		bt_bap_select(lpac, rpac, ep->path, select_cb, ep);
 
 	return true;
 }
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ff3fa197b..8d777eedd 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -891,6 +891,7 @@ done:
 
 static int pac_select(struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,
 			struct iovec *caps, struct iovec *metadata,
+			const char *remote_ep_path,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -917,6 +918,8 @@ static int pac_select(struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,
 
 	dbus_message_iter_init_append(msg, &iter);
 
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &remote_ep_path);
+
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
 	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8edc7b72e..691fec2fa 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4058,6 +4058,7 @@ static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 }
 
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			const char *remote_ep_path,
 			bt_bap_pac_select_t func, void *user_data)
 {
 	if (!lpac || !rpac || !func)
@@ -4067,6 +4068,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return -EOPNOTSUPP;
 
 	lpac->ops->select(lpac, &rpac->qos, rpac->data, rpac->metadata,
+					remote_ep_path,
 					func, user_data, lpac->user_data);
 
 	return 0;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index ff4bac330..da5fe1431 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -122,6 +122,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 struct bt_bap_pac_ops {
 	int (*select) (struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,
 			struct iovec *caps, struct iovec *metadata,
+			const char *remote_ep_path,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
 	int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
@@ -188,6 +189,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint8_t *id,
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			const char *remote_ep_path,
 			bt_bap_pac_select_t func, void *user_data);
 
 struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
-- 
2.25.1

