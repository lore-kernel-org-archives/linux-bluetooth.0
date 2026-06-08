Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3B355055
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917431; cv=none; b=WO9deZW4hEw4efkpM21jZn457y0WabgL7F1DojTPZAwIFf8d6ZoPYoip+rmSi4D3wGdF794Yk1ZPx25Dp60b6b8ZA73mMOvtB3pKtrTR/BDy9hNOsj0y1aiPxlKwTJ5xRqCeGJvStOqnELlLeEMh4mHOnVo9OiSoJFwc4PGQCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917431; c=relaxed/simple;
	bh=S5e9YOaqvNq979UUcnMBgFqqMUFbh0/iPY2Pq/qY8/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyuQehxeKB1XZdnwXGj44EatLMDw8eBKCim4LmXi9Xfy2qzhUQVu4qLAHsENZcCcFOynL2f2HdEhWBBoTTrXJhZIg9jiEMXUvSR2znzDMsTePLSUbdSh4bZ2YfLDLCIx56cHTnYQU84ias+F3v7tDIOSKzp6ljw89WhdSGubMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=hlknlrTP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="hlknlrTP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ac10e337so38669875e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780917428; x=1781522228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qA0XFgyRMis53NeLOn0e3G0zsFo48aEvQQVVBgLP8ks=;
        b=hlknlrTPBh1IX7CCKW+p7pmCscR5f4+W4xtFVX5WgYIEyUD287zVLfyDYPCAqHMc+R
         xAfRKGvUeXf9b3hsAyaRsYJztYlI62yOtsDKDrE3s0ScLAMflb2t7PLoZh+A3uY7sJeW
         GRBwmoIQ8cXHlLqSwdfTslp69dPaHgRPgUXVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917428; x=1781522228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0XFgyRMis53NeLOn0e3G0zsFo48aEvQQVVBgLP8ks=;
        b=UIMRemNLmJbGJJYR2S7rtuqzgHRbtY9nbkIL3JJUMjpSmkb2Mse9mW1IAOCQHpCwqP
         IKsDDa4MMNkN4VqF0RHpYSDOZ9puBxYMSDx78Jyp6XTJoHy9lYi2ULCto5xoTjxNeU5I
         TUc1ynOJoMPyEsGMDtFwgOm+We4VTSE+XKCq8Jce8atuwi+/eEckxZAj8MNieTthBGzX
         Pj3Lud+8OxiqEd1F8OH2u78TqfPW6ZFjZTPuMMSG0PzrfCtu0uy+LSQ9v8in128MvtUv
         ADTA6x/hy4EDhxaXvpTRjLLKDgaEljeVggqwKqGGLMNv1dJ7qLIh2bT7JP81JS6DSNtz
         OfOA==
X-Gm-Message-State: AOJu0YyFsWT5JvJ6OcWjIyVNv6BuUMSsSINIzncrDK7aMT3aAW/ses84
	bqBpnSCWoHS0R87U8AJbmDsKfq4pxXGVEKEPKAQbt3VGNIBVWyhUX6ay0vDJSpOVJLCD/7rstTN
	/Mb6P
X-Gm-Gg: Acq92OHxtwrD7sy0jJOdXAHTphHncv99VS3NSdJh/eVTAKJBir04dDrakOlc44Ga7b/
	SUTHaYkMq43bFGIlTqjNkkHiydcp35fIrEl8AdYLhAjir0MobtqFbsr2bjRLZc8gYoRpBa7HG4F
	JKs1lHhgJqP2pmdETaN6xJt3xk8CJTxxJp5YH1OsVXoJNyUfNk+THKwGn5TWjzjNn0+AiX0UkWQ
	i4PVsxw8ciCZWraSj+OWIzfHZE/a/SM0TTTAqhMVqjrpliNkk1Ugf70LNtgW2ITvUMzxVO970HE
	QbZy2R8PQoUh94poyN+1Tn4H7cDVJAbto230LdbG6AowQiscRdCrhUArHWRYUn+dWtbGPaU7qJg
	aOIJUU87PXC+dFM1Ab30ZkpFXLcD19n8f5Q5fEBYkMgVyMjnyxMl0G/3xzVULLMeTAd8vLNWwAj
	YaJL2Jg1y5FBsZTUbW1jyffce/VnNHx6diqqtALslxqhf5z2AM6gBeYg1kLUOb4sOC
X-Received: by 2002:a05:600c:8208:b0:490:bb37:9d49 with SMTP id 5b1f17b1804b1-490c25b136amr250358425e9.11.1780917428377;
        Mon, 08 Jun 2026 04:17:08 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ea37sm441841115e9.0.2026.06.08.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:17:08 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] a2dp: Add codec prioritization
Date: Mon,  8 Jun 2026 13:16:58 +0200
Message-ID: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change will select best codec when connecting to A2DP:
LDAC > AptX HD > AptX > AAC > SBC
---
 profiles/audio/avdtp.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d475a545e..a8733a7e1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -42,6 +42,8 @@
 #include "sink.h"
 #include "source.h"
 
+#include "a2dp-codecs.h"
+
 #define AVDTP_PSM 25
 
 #define MAX_SEID 0x3E
@@ -1293,10 +1295,49 @@ static struct avdtp_stream *find_stream_by_lseid(struct avdtp *session,
 	return find_stream_by_lsep(session, sep);
 }
 
+static unsigned int get_codec_priority(
+				struct avdtp_media_codec_capability *codec_cap)
+{
+	unsigned int priority = codec_cap->media_codec_type;
+
+	if (codec_cap->media_codec_type == A2DP_CODEC_VENDOR) {
+		a2dp_vendor_codec_t *vendor_codec = (void *) codec_cap->data;
+
+		switch (A2DP_GET_VENDOR_ID(*vendor_codec)) {
+		case APTX_VENDOR_ID:
+			return priority + 100;
+		case APTX_HD_VENDOR_ID:
+			return priority + 200;
+		case LDAC_VENDOR_ID:
+			return priority + 300;
+		}
+	}
+
+	return priority;
+}
+
+static int sep_codec_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct avdtp_remote_sep *sep1 = a;
+	struct avdtp_service_capability *cap1 = sep1->codec;
+	unsigned int priority1 = get_codec_priority((void *) cap1->data);
+
+	const struct avdtp_remote_sep *sep2 = b;
+	struct avdtp_service_capability *cap2 = sep2->codec;
+	unsigned int priority2 = get_codec_priority((void *) cap2->data);
+
+	if (priority1 < priority2)
+		return 1;
+	if (priority1 > priority2)
+		return -1;
+	return 0;
+}
+
 struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 						struct avdtp_local_sep *lsep)
 {
 	GSList *l;
+	GSList *sorted = NULL;
 
 	for (l = session->seps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_remote_sep *sep = l->data;
@@ -1325,7 +1366,15 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 				continue;
 
 		if (sep->stream == NULL)
-			return sep;
+			sorted = g_slist_insert_sorted(sorted, sep,
+							sep_codec_cmp);
+	}
+
+	if (sorted) {
+		struct avdtp_remote_sep *sep = sorted->data;
+
+		g_slist_free(sorted);
+		return sep;
 	}
 
 	return NULL;
-- 
2.43.0

