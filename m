Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 13:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiC2NZE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiC2NZD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 09:25:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F663DFB8
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 06:23:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 516F41F427D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648560198;
        bh=v7R3zZSI0Pd0F/jDiCT4YUswtf2hj0dUEOs1wAc8nOM=;
        h=From:To:Subject:Date:From;
        b=exZ4OAHUdL15eUfrKVBjMTHfhKM13UbWYrRluYWYcqF7j/4Kl3yz+WnaHCNc02lC6
         BEiE3wU6heLifcuHJvtRIwkjefpvtaVNRbP1Y7vqzGcU1Lh18ZtFz/BrZ/4VFGbtW8
         mxW4iUJqezyDYEHpyrRQtd5nkY5yxvhfG3szPSQVXGLmx1ocn14sNy7/ImoMaGIyGK
         X7gdF5akUeF9vQZmEOb9jkXzXynDIpRms+iV7PaBRzKPCTOuT0pxj6PH430dLrukBd
         vGEjH6h8ryVjtJh/PV6l0kerUoHXUvsG/FayLlDFslknm6WYfe+ko4g6yY8Vb+kVkq
         zW3fIVoy83MeQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] a2dp: Fix crash when SEP codec has not been initialized
Date:   Tue, 29 Mar 2022 15:23:11 +0200
Message-Id: <20220329132311.163117-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If SEP has not been properly discovered avdtp_get_codec may return NULL
thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
AVRCP/TG/RCR/BV-04-C.

The endpoint should not be registered if its codec is not available.

Remove A2DP channel seps queue empty check in store_remote_seps() as it
prevent to remove invalidated checkpoint if this is the only one saved.
---
v3: add a fix for the invalidated sep removale in cache
v2: don't register enpoint if its codec is unavailable

 profiles/audio/a2dp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..7ad34bab9 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -829,9 +829,6 @@ static void store_remote_seps(struct a2dp_channel *chan)
 	char *data;
 	gsize length = 0;
 
-	if (queue_isempty(chan->seps))
-		return;
-
 	ba2str(device_get_address(device), dst_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
@@ -1993,7 +1990,12 @@ static gboolean get_codec(const GDBusPropertyTable *property,
 {
 	struct a2dp_remote_sep *sep = data;
 	struct avdtp_service_capability *cap = avdtp_get_codec(sep->sep);
-	struct avdtp_media_codec_capability *codec = (void *) cap->data;
+	struct avdtp_media_codec_capability *codec;
+
+	if (!cap)
+		return FALSE;
+
+	codec = (void *) cap->data;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
 						&codec->media_codec_type);
@@ -2006,10 +2008,16 @@ static gboolean get_capabilities(const GDBusPropertyTable *property,
 {
 	struct a2dp_remote_sep *sep = data;
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
-	struct avdtp_media_codec_capability *codec = (void *) service->data;
-	uint8_t *caps = codec->data;
+	struct avdtp_media_codec_capability *codec;
+	uint8_t *caps;
 	DBusMessageIter array;
 
+	if (!service)
+		return FALSE;
+
+	codec = (void *) service->data;
+	caps = codec->data;
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_BYTE_AS_STRING, &array);
 
@@ -2074,6 +2082,11 @@ static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
 	if (sep)
 		return sep;
 
+	if (!avdtp_get_codec(rsep)) {
+		error("Unable to get remote sep codec");
+		return NULL;
+	}
+
 	sep = new0(struct a2dp_remote_sep, 1);
 	sep->chan = chan;
 	sep->sep = rsep;
-- 
2.25.1

