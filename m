Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E66C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 09:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353168AbiCYJ2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiCYJ2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 05:28:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84124CFB89
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 02:27:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 0859E1F45EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648200435;
        bh=i9LuKLlzH0fxl/BSwn0Tj0VhZdeKEBN5qkn0KF0tmaM=;
        h=From:To:Subject:Date:From;
        b=dQtMQB6amNzkZR/Yvg+d5Lz4AOiue49Vrn6aKTivTQvgttIav7Vdcpd04xWUCtNde
         gk4Gncc+aXOqbjpE6HqCAZlSY5vXOgxSvXIjxTKjOv4MN/fJ7sAFKnIlhxiXatfJqq
         kCwcQEKYiggnFVUfxon/1uB7rXovknAjcYFnKmgNYkb+zq1GkfEvzvOuIaPtmJHcW+
         jygh83JB7QphRRtirJxAz2cDqo9eNJkI9FLIoOfZ/nPlIdF2rZZ9aIdUtwhHO4lXIb
         YOCQETDXwPRAKL6dnOSBzKg6ulsQKN4OA8FvzxNMgqGtgtenJ7uGdxGZJCmZd4204g
         LZxc0yrHmSfvg==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] a2dp: Fix crash when SEP codec has not been initialized
Date:   Fri, 25 Mar 2022 10:27:06 +0100
Message-Id: <20220325092706.17135-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If SEP has not been properly discovered avdtp_get_codec may return NULL
thus causing crashes such as when running AVRCP/TG/VLH/BI-01-C after
AVRCP/TG/RCR/BV-04-C
---
 profiles/audio/a2dp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f761dbe54..7da008071 100644
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
 
-- 
2.25.1

