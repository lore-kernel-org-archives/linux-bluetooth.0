Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21E41586C7
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563247; cv=none; b=JKuARxt9MuM5J+Ef9XCCNgE9Fw29n7H9IQhQMVWfmJXOtlAzrrIO9OdTtvtMetMzpdED/wIZAa2ydleKXAwgml4Sc3DVd4JvlFoO5sR8VV97xM1jVAOrVAM0zHHbJVPnoSrTl4frsWxvu8eCZ6fkAMgq5TKWfhLR/tNlhC/r9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563247; c=relaxed/simple;
	bh=w0jVmTXZFbgyjVLgQeuGl/Z5pxW7MYc8BKxN5v4ABiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gth1kwwi05TfPkAZfYOZ8n0ff6IX8mmRWHuvOGENnidgnB025p33CuOr+IrTV8lY+5y0xqL3gVJTuqSvFdTP9pugvaUETynCyxP6oKiRqudoG5jQjsnA42BC8GDFz1NTHKhzcl6CpiVAuD9vkrqDZVzxC0yOzGAfGogUPDer62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiWmeIE5; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiWmeIE5"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5edfcba97e3so36194747b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706563244; x=1707168044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gnfr2H4NFAsroEwXj3aaG54N3pcmoalaRYfTL0HDQhI=;
        b=KiWmeIE5rr4PWCSzDXlm7k1ONvwsnTqNKCg/g8qy6iW9YXJpFf1mD8Nkow4JXMkQZA
         /Zqbf1dCfin9ZX6okjiC0iCGzq7qSrFK9I4qo8IhE45RP4fQX36zLE4nKrV9TwiwMqKW
         K5Hy8yAdLysIlKQykSXtUh+L4UzujwR2q6uoMXA8P8IbhsuvgZH84DTS4cLceQlYEzGD
         AvIip3nd1Hdp1fczfR0qI8iEoaMr3Odd23Vuyh7gtJbGFBRonxlfQzt+VuZWHw4fgMvk
         FdMBVjYAhW/n8ExdZUtLRgvIn/ejzhq52QqdiyrE0ipyrWR+LzrJ5iRcJNQBLg2FV4re
         2uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563244; x=1707168044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gnfr2H4NFAsroEwXj3aaG54N3pcmoalaRYfTL0HDQhI=;
        b=l8vbKr6Z1NkWyYmu/Doi7yy7DD2Fvwo7XH6LIfdgkYaTM4tuJassE6mXsikcbza0eB
         bbJonYDHJ69W8ATgDUB7j6wb+XCCWjy4MQwvykEB/P83PJ54bMVuMe5mYDYQ8jMALQEL
         B9rEGAOQMsErXq1ZUl5F3lb3F3CkmJpYIUHr7E/DCgr75ozad8a3Kr50wlSf82OSR2Md
         6Jz41AAH/0msm+DC0yi7r1oUZzCZv5Qdf8a8N7PzUPHqpTuRFqX7UVYP9I9KsYkGqUgt
         gQGwkS3DP0KX8Ym6MEUGtgxh8kWw5lIptB5zKP4pjkodrV0//ZGba8K74577GbINb2Te
         J0zA==
X-Gm-Message-State: AOJu0Yz6lUxvGs3og30vpFGnZSftRVovSpTj4H3DF0b/EQwA6cXNqFwm
	ok7+JeRyNHrVXDco8jDLByZR+Yx9q+Z1bsWUqFXXR9CGo1WyTWAGZRV7ooUU
X-Google-Smtp-Source: AGHT+IFMaow3XvN9r4tSfEIRgZ/CsCCn8VgXFwAperALO67BVAitfi4cFMxc6Xi+xR1nQG3ndP5Tww==
X-Received: by 2002:a81:ad61:0:b0:5ea:1eb8:c37 with SMTP id l33-20020a81ad61000000b005ea1eb80c37mr4138183ywk.24.1706563243846;
        Mon, 29 Jan 2024 13:20:43 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l198-20020a0de2cf000000b005fff75780f3sm2704904ywe.66.2024.01.29.13.20.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:20:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] client/player: Add .name field to struct capabilities
Date: Mon, 29 Jan 2024 16:20:36 -0500
Message-ID: <20240129212036.163298-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129212036.163298-1-luiz.dentz@gmail.com>
References: <20240129212036.163298-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds .name field to struct capabilities which is then used to form
the endpoint object path so it is easier to identify the endpoint
capabilities:

[bluetooth]# endpoint.list local
/local/endpoint/pac_snk/lc3
/local/endpoint/pac_src/lc3
/local/endpoint/bcaa/lc3
---
 client/player.c | 54 ++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/client/player.c b/client/player.c
index b37ed20d7275..b961c0ba223d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1130,11 +1130,13 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	return NULL;
 }
 
-#define CODEC_CAPABILITIES(_uuid, _codec_id, _data, _meta) \
+#define CODEC_CAPABILITIES(_name, _uuid, _codec_id, _data, _meta) \
 	{ \
+		.name = _name, \
 		.uuid = _uuid, \
 		.codec_id = _codec_id, \
 		.data = _data, \
+		.meta = _meta, \
 	}
 
 #define LC3_DATA(_freq, _duration, _chan_count, _len_min, _len_max) \
@@ -1145,6 +1147,7 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 			_len_max, _len_max >> 8)
 
 static const struct capabilities {
+	const char *name;
 	const char *uuid;
 	uint8_t codec_id;
 	struct iovec data;
@@ -1158,9 +1161,10 @@ static const struct capabilities {
 	 * Blocks: 4 8 12 16
 	 * Bitpool Range: 2-64
 	 */
-	CODEC_CAPABILITIES(A2DP_SOURCE_UUID, A2DP_CODEC_SBC,
-					UTIL_IOV_INIT(0xff, 0xff, 2, 64),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("a2dp_src/sbc", A2DP_SOURCE_UUID, A2DP_CODEC_SBC,
+				UTIL_IOV_INIT(0xff, 0xff, 2, 64),
+				UTIL_IOV_INIT()),
+
 	/* A2DP SBC Sink:
 	 *
 	 * Channel Modes: Mono DualChannel Stereo JointStereo
@@ -1169,9 +1173,9 @@ static const struct capabilities {
 	 * Blocks: 4 8 12 16
 	 * Bitpool Range: 2-64
 	 */
-	CODEC_CAPABILITIES(A2DP_SINK_UUID, A2DP_CODEC_SBC,
-					UTIL_IOV_INIT(0xff, 0xff, 2, 64),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("a2dp_snk/sbc", A2DP_SINK_UUID, A2DP_CODEC_SBC,
+				UTIL_IOV_INIT(0xff, 0xff, 2, 64),
+				UTIL_IOV_INIT()),
 
 	/* PAC LC3 Sink:
 	 *
@@ -1180,10 +1184,10 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(PAC_SINK_UUID, LC3_ID,
-					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("pac_snk/lc3", PAC_SINK_UUID, LC3_ID,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+					240),
+				UTIL_IOV_INIT()),
 
 	/* PAC LC3 Source:
 	 *
@@ -1192,10 +1196,10 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(PAC_SOURCE_UUID, LC3_ID,
-					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("pac_src/lc3", PAC_SOURCE_UUID, LC3_ID,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+					240),
+				UTIL_IOV_INIT()),
 
 	/* Broadcast LC3 Source:
 	 *
@@ -1204,10 +1208,10 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(BCAA_SERVICE_UUID, LC3_ID,
-					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("bcaa/lc3", BCAA_SERVICE_UUID, LC3_ID,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+					240),
+				UTIL_IOV_INIT()),
 
 	/* Broadcast LC3 Sink:
 	 *
@@ -1216,10 +1220,10 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
-					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
-						3u, 30, 240),
-					UTIL_IOV_INIT()),
+	CODEC_CAPABILITIES("baa/lc3", BAA_SERVICE_UUID, LC3_ID,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+					240),
+				UTIL_IOV_INIT()),
 };
 
 struct codec_qos {
@@ -4114,8 +4118,8 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
 	ep->codec = cap->codec_id;
-	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
-					g_list_length(local_endpoints));
+	ep->path = g_strdup_printf("%s/%s", BLUEZ_MEDIA_ENDPOINT_PATH,
+				cap->name);
 	/* Copy capabilities */
 	ep->caps = util_iov_dup(&cap->data, 1);
 	/* Copy metadata */
-- 
2.43.0

