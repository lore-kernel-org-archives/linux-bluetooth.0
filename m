Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911640D576
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781431378; cv=none; b=UN8CKOYD4OBe84Fh1JxJACV2T26KX4inFbPwqD76yGTGXsrZBMgK6LVZOAN7rCMTBPAqzKqL5qHZPhl9oUOzWYQubX/a4Ct5IxT7rvvmh4DNWTA/XdkCURRrJCMbdlWGWaIS9DPJMar7X5+7+KIVFoPAMHNVrFhVrcbXavi42Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781431378; c=relaxed/simple;
	bh=gjCzS7IFqwhjlAXv9WHfRLgnCtC1jup88Oo867Nke5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bswkkE92rXFg1EMLXZNXRcLR78ggoaLskHKug92O+sYegI0F0hy18Ox8ZUX4sN1OqC3wGqvWDsfN91t0mtEEnk4vl/RLyeOoDrB9kjVnLEJIRaU0dYZ8Q6ihC6D/1DOmC5+2SByPctdT84WAjSZ/pG8tGhQA8qPfZms/ZT7xbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=RIsepnlj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="RIsepnlj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eeba68948so1720482f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781431375; x=1782036175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CPJrSKECkbJ6anRoC/FyQcgRpzvI1Zu4XDd6fM4BXM=;
        b=RIsepnljA2jCkk8OekuKeYHkHJ4BBH0QG//QR2oj9fEniRu1zmByVXGASthlE4obDJ
         P0bZ5P94EpIW0eVWyM3THp9VekhPTBDwh9eTTDqV3GO0REdBB4i6ROLrd6OiVIqFtjrM
         7zYXCc87449g13EA2IUIcRkEMw36pqZ1hak3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781431375; x=1782036175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/CPJrSKECkbJ6anRoC/FyQcgRpzvI1Zu4XDd6fM4BXM=;
        b=Rc3mr6tWiKUYmbMx9Q2plAvPdpqF83WLlfx/iSyISlZfQoExQHCvFtNProzg6KF+wb
         GDB/nV+VVJgHaMUG5tc2Vv6b6XtTSnd7Vfi2b1/uGtlQpFuzXrPNlygsQg0yT42Jov9O
         ValZ6V7Qq8SXhexK/VdAvA/hUUpmTVHox0FSGI4ja8fGoOPNGfQLMjscv3nQNyAGzGOf
         mjqf1Fypbu0JAaL8EG5O6K/rGVg5X0A1J8LJuMxXIlIRk0llsPhvaL/M1l5lyHdvYqkr
         J6aVbVMD7ExQc+G2RBad2TqhUPeRjJyCqbiyLVUWzQO09TmSbWfjoQgkVscEehUqEbpa
         5WRg==
X-Gm-Message-State: AOJu0YyGGSAr3DGQGz51KaBFoGR79ApwpHTbZB68GfkMGF8JuhkrVrw3
	iDgYjoFVAgYkVZoOfulE2ZCqTNoLOjWIik8VQYURYy5nsNS2MzM0GpZuCY41jZAA6uY2EBet1wh
	B9JuP
X-Gm-Gg: Acq92OGqokXzlA/G/w2pIPWBy5H0eZw/iqV2KNAQ2uULOCx6yyxtcRAwXihXvfreSNw
	EGcmqGKgXhqTbMvq28EIgTcvja79DzXhLb+vkwOQJ1yiD0De3ABZZ9Zi1GTkw5UjMQsCq8HvN2N
	yYTEniCNUNVKvg9+kg3ePCz7VlqhqMNWizyOUcpPvVHWjnVt83Gdialg5f1ywM0Q3YA+cM8av32
	eS7zdxKq4tKdoJKZNojmLjJeJiULB2Q00hwDheVUgNEIoFTjrblHkrAVU3p0nqVkRF+5kifIe/h
	0isnu5TvF0eG6ddWwGwcHoBbzlcTBua46+fUCLoByKXrt9OO/rbb1I+uBHNdAbEHy3qNHqEuDLF
	cVABIi9qqG42tMrdAeGNVsx+ZUvYYssb/MtTwRXk3rEAILn+HR1nUm6Vjo9JHpoZAEECX416A5m
	3K/T2avrQYh0rtbephwNiiTm9dTvWwf1uWHD/CL7dS8E2I
X-Received: by 2002:a05:600d:6452:10b0:490:e913:656a with SMTP id 5b1f17b1804b1-490ec4fc150mr93464775e9.27.1781431375561;
        Sun, 14 Jun 2026 03:02:55 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm154231055e9.13.2026.06.14.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 03:02:55 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] shared/bap: Transition ASE to QoS Configured on CIS loss
Date: Sun, 14 Jun 2026 12:02:07 +0200
Message-ID: <20260614100208.1091560-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZ+3vm1APyYtKYbXSVYMDC4YjXDrZEmNHeTKEGMg_Stpyg@mail.gmail.com>
References: <CABBYNZ+3vm1APyYtKYbXSVYMDC4YjXDrZEmNHeTKEGMg_Stpyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stream_io_disconnected() only handled the Releasing state, leaving
Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
unexpectedly.

The ASE shall autonomously move to QoS Configured on loss of the
CIS and notify the peer

Fixes PTS test BAP/USR/SCC/BV-167-C
---
 src/shared/bap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..8d1f25719 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6776,8 +6776,16 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 		return false;
 	}
 
-	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_RELEASING:
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		break;
+	case BT_ASCS_ASE_STATE_ENABLING:
+	case BT_ASCS_ASE_STATE_STREAMING:
+	case BT_ASCS_ASE_STATE_DISABLING:
+		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+		break;
+	}
 
 	bt_bap_stream_set_io(stream, -1);
 	return false;
-- 
2.43.0

