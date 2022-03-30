Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbiC3Ja4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbiC3Jaz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 05:30:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433122ED47
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 02:29:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 165471F44489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648632547;
        bh=FfgtYDL2l9wpGYKqYLpfFrAk9rn6nO9x4D9vcKaDIFc=;
        h=From:To:Subject:Date:From;
        b=crK3hh/69PX3uHD7hsyYKApythp51rqCAQNZs6qLX1Vc9qR75lpkSlCMEn58rTUNl
         hYE7LRys2PwW/QsvDEKeSlA8p6yzV0FCrAY4hb1HYSAoXTin9I4qBzONF+NjvhG55C
         +70yD6EuypFhU1D36a5/P2T0hxqWAXdEDxc/k2R520RBJp+dkfTp8HGaApq/cN00jE
         lpD8gBJBZ7ntpYrOLDqu5HCaccYrqxzhDQserN/v754Hpj/xwWDHy2voxHFFbN1Pa7
         2M5M95s3XsCOhKj6lHGTGwmYypTu/Wdn7ipR8ie78TltFz0BoFaevVfGomLSwrhIaj
         hGdhC2AQV+2ww==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ,v5] a2dp: Fix crash when SEP codec has not been initialized
Date:   Wed, 30 Mar 2022 11:28:44 +0200
Message-Id: <20220330092844.44762-1-frederic.danis@collabora.com>
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

Prevent remote endpoint registration if its codec is not available.

Remove queue_isempty check from store_remote_seps since that prevents
cleaning up if no seps could be registered.
---
v5: fix avdtp_get_codec() check

 profiles/audio/a2dp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c3ac432a7..21b3faa47 100644
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
@@ -2074,6 +2071,11 @@ static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
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
@@ -2148,6 +2150,7 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 	struct avdtp_remote_sep *rsep;
 	uint8_t lseid, rseid;
 	char *value;
+	bool update = false;
 
 	if (!seids)
 		return;
@@ -2206,10 +2209,19 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 		}
 
 		sep = register_remote_sep(rsep, chan);
-		if (sep)
-			sep->from_cache = true;
+		if (!sep) {
+			avdtp_unregister_remote_sep(chan->session, rsep);
+			update = true;
+			continue;
+		}
+
+		sep->from_cache = true;
 	}
 
+	/* Update cache */
+	if (update)
+		store_remote_seps(chan);
+
 	value = g_key_file_get_string(key_file, "Endpoints", "LastUsed", NULL);
 	if (!value)
 		return;
-- 
2.25.1

