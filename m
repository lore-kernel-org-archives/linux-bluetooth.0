Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBB1EB1AA
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781430974; cv=none; b=Ax7pDUSCgzzM3JXEJLAbTZiZ6G78hBIFSFQsgmmF3rWtoNCLVHa/BcnggowJq+1sKoyS80ioOWhGnDOMsktEPysEcjCTKTcpd/OHx5oKq0Mpdkrvr4QCMf7S1fq2vNiHDeVWJK/ALMpb4cr8FQLFfmmG2Gn/KmZz/F1m0YzTmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781430974; c=relaxed/simple;
	bh=PiviOExPN8uyToYfhic4Ee1/V7ervyJCpvKl6Czynlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNueMjEQLil6pMFJIGbHkU/xIIZ5XM/xDgRkRZ7I0O6VRf+ujTYD2adsh97OGZPUQh2/VNCDUwl7vnII+qD27s3CKkxi7wkffiW4iFIY1autDPu3bJ58zd6DzyfVFTLatgjPkmOvGAnS2lfbvc/bPXd+Y5QdikzdFdX+NRhWmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=QGiGsahI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="QGiGsahI"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49222fb062bso11955805e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781430970; x=1782035770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kGYX22OIpUR1+z2X94uqmCWIzmzJk7Ebcch9aGHBEY=;
        b=QGiGsahIfgQetqSm+1AO/JJfxuIWsZrbQr0a2jm3vunkucNbxAbp5r4uvb7ItroaZR
         Hqn3R3lT0H5jFL1v+xSCXlgzlx+V1aYv8sWloW3TKuWIg3zjMR8vPf8/w8YQsAGXeDqT
         hmgcFWbZ+CZMercnYREhuNcQYDYL98l45DV9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781430970; x=1782035770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kGYX22OIpUR1+z2X94uqmCWIzmzJk7Ebcch9aGHBEY=;
        b=LJ1cc/edAenC/ERXi66VRHACdIoJqFqB+jrHzhOEXkBAdC2eEqANsvcSPeMV0n8VNL
         QcF9MCgZ0b0QMVGyTMZ/AzkAyuKuSmHlbwiKaWcPqUD/BzrtvrGB2lnzBh7Te+jtIS+5
         lRg+nlKz3jaXLSs2+HaowhHYnMZxT1pUINesBpgCebwHlgOM4w69hFIeJY3heeYio0Vz
         GeYh5Euz9sxbtJS2yiHDCm3dDxQHMDECimu6+w4yoXy0I6elpU0tcnNloL9Wzk654urk
         Zw0Bao50l+6PMF7UzASa2lh7+fH7InDmbH4mmzcPAqHm7LOzUs3OPun2lsG4vvqOUI//
         SJhA==
X-Gm-Message-State: AOJu0YzaZKOEyLws+Fn5VaM1lRgPOVKGDsxo3NyzEqPS1c35qhEQIW8Q
	25wx8utTplX3x/64R6DEnNkL8ZDQ+lChf/lxLND70LAjySQ9V4SD3vRbpCiPLaL+HIF4ThsgMTN
	wisfR
X-Gm-Gg: Acq92OFclLt+El8RnEhHXVclSqSPTFGTdmreiZI36xx+jSPS4+EbBai27rXYvH0STVH
	EK+p4I0KroIxB7TbJMuPQayqQkhFiofnRQRT+VVP5Pt5Q6wzSJu6Wg/hmtHv0jjmtwa2CW5CsSt
	KENGGha7xdQiSiheCNXQHxUGP/B3toRzDt1TrL2XSFnhLxGXDgP7FgoaGN5X1Kob05vcKWf9gBN
	YOZvQDgdq7LYHGU6lITjahF0UWijAUeSlP4CWbOGbg/E4yJJ1Dn/oWg3KItTYZtF1Bpy1wxe17P
	ClT+m3fntKHlzZBV9sX937YofFVxU48vnYa5f45juK6qv6Na62AooRPWJ8rVtMQNrh8GuCXqEfk
	YTup167dOJpiWwRCeCv9pACa1HckMbB+K+POaCf8TcmOWwoS1UzwRgxhPoGUiHPAmOjKLATjewX
	HhdZSjq9Emcs/MZEJOdl/rcUCOFg4CaREZePUMz3O6Ssne
X-Received: by 2002:a05:600c:8b18:b0:490:e1a6:25d with SMTP id 5b1f17b1804b1-490ec4fb514mr109835565e9.26.1781430970500;
        Sun, 14 Jun 2026 02:56:10 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922033dd3esm144084915e9.8.2026.06.14.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 02:56:10 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] shared/bap: Initialize ucast/bcast IDs as unset
Date: Sun, 14 Jun 2026 11:55:19 +0200
Message-ID: <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
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
 src/shared/bap.c | 4 ++++
 unit/test-bap.c  | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..41139181b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2901,6 +2901,10 @@ static struct bt_bap_stream *bap_stream_new(struct bt_bap *bap,
 	stream->client = client;
 	stream->ops = bap_stream_new_ops(stream);
 	stream->pending_states = queue_new();
+	stream->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+	stream->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+	stream->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+	stream->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 
 	queue_push_tail(bap->streams, stream);
 
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

