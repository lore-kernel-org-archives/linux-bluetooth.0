Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 18:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiC1S7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbiC1S7q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 14:59:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD46644F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 11:58:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 9655A1F402B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648493882;
        bh=Bp7gnDs7Mr84pc91rAFBicot0w9W370QZLBKw4bpWIg=;
        h=From:To:Subject:Date:From;
        b=McWGK0UcbAAk2VC94UzYIGow2SHASRw/dJhTmctpBHNlQ3ttb6E6qipccRvT6+DpQ
         qXFD0abrW/UxZinLsinx6bChhztmNyPGytYvVt+3L2pm8Dx3t8dp6kZV9stDA+brmL
         Mcczrki/2NocGoxO7SZaSbhroBIUyazPLULf0w4iWqxJsDpXkgUdTBO2IZag2ODNjR
         51Bh3ZjVp7w5FqVVktCIgLyOYDe2qHGqX84rqQk3p8PQ9PufIhRMvJtatLgvFAyUly
         v7lnreArxjhAkDoDUUMeop8yu8Tfqeo0qhMaPJCOg3xu7S0akt5rPW44zisbh2DWbD
         XOZAqZBVNKndg==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] a2dp: Fix crash when SEP codec has not been initialized
Date:   Mon, 28 Mar 2022 20:57:53 +0200
Message-Id: <20220328185753.161203-1-frederic.danis@collabora.com>
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
---
v2: don't register enpoint if its codec is unavailable

 profiles/audio/a2dp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f761dbe54..8c20f22f0 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1995,7 +1995,12 @@ static gboolean get_codec(const GDBusPropertyTable *property,
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
@@ -2008,10 +2013,16 @@ static gboolean get_capabilities(const GDBusPropertyTable *property,
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
 
@@ -2076,6 +2087,11 @@ static struct a2dp_remote_sep *register_remote_sep(void *data, void *user_data)
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

