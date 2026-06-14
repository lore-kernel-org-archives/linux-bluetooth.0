Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEB1A6810
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781434228; cv=none; b=jF/oV5So37H0zHTr00SBPVhKto1MOL7sCiQKrN14Xd8iUIADfgl1KWewqabncyVLkSJKDGsavqG00g9sZ2jemM3IgvH+dQkzMupkxfLil+9+z9Csx7+To7hkLGP2uyyYnpaHDY8GNQFkIZDc0GVTJlAmGnVnnfvK3t3Xqom21so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781434228; c=relaxed/simple;
	bh=JD3eUL4XbYgIg0bhnu/dA6rIN0ZHvXHZBJ6Azc8cg9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi9STKCV9984p7fAunt/p7YZX3iOzlcdgGhbRZEt1IyAjUtYCLKpqKfErogmsNl15IAw4SrFa7Dm0SxZhiI9L4PtG1DGk7ZUPnufebptZfKSQ8wkVeUxafgz+A5j1q3G7cOi3zuZiuJHBEz5TJo7pIxFyGqtHc/Dmc2CN9yOOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=SPrX8INi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="SPrX8INi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso24936225e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781434225; x=1782039025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIOVRZLorne490rzjixwDV5sM0R6XCv5KQOqfARilfc=;
        b=SPrX8INi5e7zwMeZ80B7xaxQiRCJVq30PQqAuKRc9Z4kCny/DL6nOb8mVHa57g70wv
         XqG2DolnASiyZDmjFJBX0nTZXgqHxTljIMy35EjtlW0ZhYUXsX/yTLt0v+tQABkJXzib
         p8U4EMLXRlImcqZ4gZFyKJYsdXX/jrhNWVsdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781434225; x=1782039025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIOVRZLorne490rzjixwDV5sM0R6XCv5KQOqfARilfc=;
        b=cIR2xHfeetpRaj4MKSVdnVui2AtJewyWBJEogX3daRd0gjUoU3C/VEh7cuwDFkiXAr
         NhQeicU1Gx43q6lHApdxw7Qy/sELscSQVgdNDEqRQzrQzZ6MHUid1nhdunxFvOg0iJao
         q0cMiZRhp/er86SPXI/3flD8ByKxpcNRfUP/PhopE0T1p1MMZ4NdXYkj6bvl+X/FXVm6
         JbfPRMrqs0deODEh3pj8KBEjaVivK0n97e0ZqgLePIEnHWCIq8HZDoIet1/QYUYVlvwW
         LRTsvzTuLpE1KpnR0d4X2ThyJF2u3mafcSfWd9BmWZkkPUtUb0kB/i4e5bzxd19fdocY
         AFUg==
X-Gm-Message-State: AOJu0YwhmldKF2eUsPVqUfSleTDOKtq1QrSjq4BSS3lp0VtvLkNcNIBR
	vlkyY8LDLmqMqNdRS0dH0vD0CJdQXHvzzzlNWbuHJ/AZVHYZwQGB90nbkkx76LAclQTuY4q5H4B
	D0pbq
X-Gm-Gg: Acq92OGgtpySdL1R8coxZ+5yhJrEfFs9C2B1sNuIAasFSyhrGvJuxQT+kRbBaQyUUWB
	/t2mbAgKG3MmqtKHpuCCGmKFMMnt+S/z389phPKw6j7ytwMq6MMa8ygSy593oUNsfsfOZliQGDR
	BuPn6buoGUcjRunhYa1F/HLas2KBxmZDgI5Kwbw+NJJLrzLazhes6MwUf2jIm0QeIosjeMNrXA4
	zR73gA1Dwi+tDDsPtxx1PvQobfYGDUqqHNgl/PsaFD0SZfNF8W9vw7mWbphBgBiqyHhAq0EWKG+
	hhN11Vi3/gw8PBPv272xpqRfD9w57zkUIi6jfT4pL/xdP3Z2d7Ez79RHZkZmkOSK6Ncho1sNqUR
	olBdKsB7keE4G81Wbhjr5HtNXIArKgJCF3D2A8xOVja8uYSD+cNsXFnd5dQI/xQzC+4x1IheAvY
	38a7rA5enH/KM6MfYXtC1f9grzJBgXy22hwGaE2GgBGUDB9LOSAVI1DBg=
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490ec480e65mr105891875e9.4.1781434225451;
        Sun, 14 Jun 2026 03:50:25 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm166655505e9.1.2026.06.14.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 03:50:25 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/2] shared/bap: Initialize ucast/bcast IDs as unset
Date: Sun, 14 Jun 2026 12:50:15 +0200
Message-ID: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
References: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also change some lines where CIS should be used instead of CIG
---
 src/shared/bap.c | 13 +++++++++++++
 unit/test-bap.c  |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..e8fbf0899 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2902,6 +2902,19 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->ops = bap_stream_new_ops(stream);
 	stream->pending_states = queue_new();
 
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_SINK:
+	case BT_BAP_SOURCE:
+		stream->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+		stream->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+		break;
+	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
+		stream->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+		stream->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+		break;
+	}
+
 	queue_push_tail(bap->streams, stream);
 
 	return bt_bap_stream_ref(stream);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 03b19678e..4ac9a207c 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -9894,7 +9894,7 @@ static int streaming_ucl_create_io(struct bt_bap_stream *stream,
 
 	i = qos[0] ? qos[0]->ucast.cis_id : qos[1]->ucast.cis_id;
 
-	if (i == BT_ISO_QOS_CIG_UNSET) {
+	if (i == BT_ISO_QOS_CIS_UNSET) {
 		for (i = 0; i < ARRAY_SIZE(data->fds); ++i) {
 			if (data->fds[i][0] > 0)
 				continue;
@@ -10000,7 +10000,7 @@ static void test_select_cb(struct bt_bap_pac *pac, int err,
 
 	if (!data->cfg->streams) {
 		qos->ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
-		qos->ucast.cis_id = BT_ISO_QOS_CIG_UNSET;
+		qos->ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	} else {
 		/* All streams to separate CIS.
 		 *
-- 
2.43.0

