Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DB28DC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681513; cv=none; b=IL+So9pcdo6vrJQvLFQ4gWsUxZ+6IjyfkpPjtDofTrYSDKGxFbzXAG9NwwSDYmL13liF4QAGb/1navev6CYOFb2zqCRmlixMoRvTDJu4jvqSXhei1ayT+Ffw8/PTkVw3byCMLXP3aSazUmPWoOVXz+pO3DeyFbQYeTEgR5mfL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681513; c=relaxed/simple;
	bh=/pHh7BHlMImsbYtPpQzfT+XgSptK3WKkKWt3sst1pTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ipf4tLInn3MbqFm1kimA8Ogjk++X5mHzY4GqtLgZ7sUm6sCgRYoMvy+12KxPkY1F7IH2wY2zB29IXCyCGAVsCuAQRz4KKYVIRyNOWVjmZji71zX23bTUYssbVYgrwjq4eIi/EIsljom4riqvLVk7ys3oTvr+ypT+qR1ckQTCRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwxMP2CM; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwxMP2CM"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48c2d353b01so1643670137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721681510; x=1722286310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOylXU3nEoFVhceX6cR2b0Tm705qNG+arenPHKSTtsM=;
        b=HwxMP2CMHryocRGoNjoar/X5ldIl+iDDfg331pEhDu4ZxdK3qLjI47xVPfa30pMb7j
         ILw+HgZ0LHHPlZ+O9dsteBrkMDzCMRIDMo65waTxgUYayz1YD9QjoOOgXZA/zX12J5/c
         or5NX3w9jBSnPlZEF40BgzTCWT1mWD4COK5MYFEGQBo+yQmJZsY2a20Yc68E3bVOmMLB
         Zn5N2t8WkKzSfyywjA7UgWMtZdqs9nVQbvjKTXRbU/ZfPf+DVWQDKuLWkFceYzL9ij9i
         2gxatBkxTDzQkirz//DKVUTKMj+FL8+zX9MAotf4o/3CEOcpl+pS8Yjq4RCSGi3iAaGY
         NBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681510; x=1722286310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOylXU3nEoFVhceX6cR2b0Tm705qNG+arenPHKSTtsM=;
        b=RarklJVoMM7VC59+leFYJZbjhT4TqdRF26rajgFDWYjYtMglz77ct6DSiTfSIGiSfD
         4S2U0DhyNWRqJDmSPcd8r0Ut588R8KuFRZz1Z9bk5cwhubHV+ERuo3JQRZiKIq7tIvCs
         OU7Ne/MEKDYQ7TnGToxkEWRy6+SLZqFY+025PFa1rlyEv3q9/tO4q3rj5kq4Y+yNayy9
         QP6Ew6+6dcmUVnAH4g81xTdb7KQ4Fm7Jj65R9b7Q1t0a+/kHe1vhTWbJ5W4lVbNQ0e61
         WBWCxsMmWdFEM8P99nXowxrnPLFpqugcepsqX8vJYDyC2GOL+ScanWHaG08X1yfcjg4C
         gL4g==
X-Gm-Message-State: AOJu0YyanLLxbw6wDtRoyvYW26LrMrmb3TUDeL75grWytN+l0QvrxT6g
	OeEeDoZC5OR5GYHtXslwty17TnITSjF9mDtfvoIA20ve8TzqbRb2R/WcVg==
X-Google-Smtp-Source: AGHT+IHMDQoKftMQer8NBcHndBFJVsPSAu3wEzhTo5xepzz3aSSRVFT3k4UcE+kXAzotnD/QSFfKRA==
X-Received: by 2002:a05:6102:f87:b0:492:9d0b:1d58 with SMTP id ada2fe7eead31-4929d0b2040mr5737227137.5.1721681510513;
        Mon, 22 Jul 2024 13:51:50 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4927922bf52sm1946183137.8.2024.07.22.13.51.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:51:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client/player: Set number of channels based on locations
Date: Mon, 22 Jul 2024 16:51:47 -0400
Message-ID: <20240722205148.2273531-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets the number of channels based on the locations set rather than
always hardcoding it to 3 which in certain case is incorrect and can
lead for the same location to be configured multiple times.
---
 client/player.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 5b0b918fb8d7..486629a9add2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1140,10 +1140,9 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 		.meta = _meta, \
 	}
 
-#define LC3_DATA(_freq, _duration, _chan_count, _len_min, _len_max) \
+#define LC3_DATA(_freq, _duration, _len_min, _len_max) \
 	UTIL_IOV_INIT(0x03, LC3_FREQ, _freq, _freq >> 8, \
 			0x02, LC3_DURATION, _duration, \
-			0x02, LC3_CHAN_COUNT, _chan_count, \
 			0x05, LC3_FRAME_LEN, _len_min, _len_min >> 8, \
 			_len_max, _len_max >> 8)
 
@@ -1182,11 +1181,10 @@ static const struct capabilities {
 	 *
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
-	 * Channel count: 3
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_snk/lc3", PAC_SINK_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1198,7 +1196,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_src/lc3", PAC_SOURCE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1210,7 +1208,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("bcaa/lc3", BCAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1222,7 +1220,7 @@ static const struct capabilities {
 	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("baa/lc3", BAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 26,
 					240),
 				UTIL_IOV_INIT()),
 };
@@ -3220,6 +3218,7 @@ static void endpoint_locations(const char *input, void *user_data)
 	struct endpoint *ep = user_data;
 	char *endptr = NULL;
 	int value;
+	uint8_t channels;
 
 	value = strtol(input, &endptr, 0);
 
@@ -3230,6 +3229,10 @@ static void endpoint_locations(const char *input, void *user_data)
 
 	ep->locations = value;
 
+	/* Update LC3_CHAN_COUNT based on the locations */
+	channels = __builtin_popcount(value);
+	util_ltv_push(ep->caps, sizeof(channels), LC3_CHAN_COUNT, &channels);
+
 	bt_shell_prompt_input(ep->path, "Supported Context (value):",
 				endpoint_supported_context, ep);
 }
@@ -4186,6 +4189,8 @@ static const struct bt_shell_menu endpoint_menu = {
 
 static void endpoint_init_bcast(struct endpoint *ep)
 {
+	uint8_t channels;
+
 	if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
 		ep->locations = EP_SNK_LOCATIONS;
 		ep->supported_context = EP_SUPPORTED_SNK_CTXT;
@@ -4193,6 +4198,10 @@ static void endpoint_init_bcast(struct endpoint *ep)
 		ep->locations = EP_SRC_LOCATIONS;
 		ep->supported_context = EP_SUPPORTED_SRC_CTXT;
 	}
+
+	/* Update LC3_CHAN_COUNT based on the locations */
+	channels = __builtin_popcount(ep->locations);
+	util_ltv_push(ep->caps, sizeof(channels), LC3_CHAN_COUNT, &channels);
 }
 
 static void endpoint_init_ucast(struct endpoint *ep)
-- 
2.45.2

