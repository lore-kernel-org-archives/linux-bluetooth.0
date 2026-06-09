Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25968346A14
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039484; cv=none; b=koKWLkd8nAoRj1jEOPbKGBXpqg40xqV5itvjtOtSpt8hS+t5zL4wJs4P2TJ4/LXLd+j+9f3Xbmk/Ml5Czn5zNBMqndCtitUUfTO8l1QcIdeDtHstvhQ4wnIc0X+iM45EQASGSsiNwb8DlZlf5W1eSQ8vXaFnvJGG5/LjBbuOVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039484; c=relaxed/simple;
	bh=xPyNKpOvcmVaqFGF9KfJ6xXVFTZGbtriB/NGmeXi+Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgJHePvL2efECoj7hrnb/vvCOihh0+WBCF7mBDorEb6wUvSBcWBOHlnT/u+x0K7AHHW6x/oGmxNmmMYVV4/TbQDq1XNNqyrhy7Lh7d7Bl/f+r0kvV2An/XJsxzdXzDuZOA+iHgCro3nm28ckSSNdj+ns9/ZIQozT0eZLcUJEh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=ElKv/mJA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="ElKv/mJA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4908b92904fso69353285e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781039481; x=1781644281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo2LCUiTKc+EU+TemJ4HpkN6AQ88ay1x2Q3Rlo7+7Fo=;
        b=ElKv/mJAK86orWKe3LBDUGBLkd8dP2kTD3JhTbDcNLfFT1rS/OXxRfAWhkl+LnIwtM
         8nG/M3NIZtRP/qBA9dpv3tFJK07LnnqnyRT1KcRFzNvMyoI1x6IXuM8sr5OZeGchGkQJ
         sYkYVhp6l08xS8IAWFgwQlfwYaPQTqpLE2buI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039481; x=1781644281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo2LCUiTKc+EU+TemJ4HpkN6AQ88ay1x2Q3Rlo7+7Fo=;
        b=VqTMv0zM3qY+2W0qX4nW0I2HRclmGVnOgwAiZ/QHoMAbjFQUId/og8viqOKnLtdlKu
         a1yp/ESeN164OTWQDaE4sWTYtuhMXU/xIcoUBhZSiR4PBoImNoGWyVD3z02CKywaC15R
         xRonTKf/PpQYUg/1D13dzbWQyH8zUNcUoToTNcNICueYfNLXdYe8uZzhI801se8kzbgS
         MthKs4G5oA77pST/VOtx9kbMbDN0Q7iDsxeLLgspHi2wlYn0EvfR9igrhNazR/eIb5BS
         Rh43SfBlRHRBcRnjlRGNlC8BMwkzoPNe85CMAvuxFzZvGwkDCyWJivk+45t1PypBJ8bG
         qKRw==
X-Gm-Message-State: AOJu0Yzlu+niHgVNg/vSCRoqDbSZJ4dtqOrHIT4hG5N2abxzTzLdsXqP
	+/NAoLhHjebvlL1oGrvunRa8wOv9fiYweK1a2rg8ps1rInv1IbtE1aL1mUeDvRMNGTmvn13Z+6j
	ToHhL
X-Gm-Gg: Acq92OE4kvEzcIEIz8gVrCfIvzKVnfcPv5lYOdH3Or/FgE9m0BbT0z3Urs9PiO+1r5V
	o1GVj/HOMdcWjk9aVixV2HA5up7XXhzmXSTO2mDaOQJRmNXkANFkwR1HIXB1POgGshsvVCU8nn0
	fA6coUmHrGk2h/4/ryniGJX2IJaARtXoz05Mxl0CSbbyA2zxI+NuoydVxRYpQoQuBZ5lCM+DdFu
	zCUaI2xyq37Tf3Zv3MeAg9Xk62xczuZAEb/wX/hRpWambz6l7IJIvGDYTO5y90FDDnJtg1sov4l
	z57LMwu+OCkYHGTO63I9sUIIMtm5ml0NMy4cPuM7FanARcdVHPW+NY/BmiBSACVXTBMW+muIdOM
	WgbLKt2sKOI3uG+5+NaYQeMBnoi87qqJgsXvTeKspAQzbO2gKiet/rLZ31NYP7ClnYAGqA7i0mf
	hrAJQCxhsdoyJdppzBILCcIcUGKX4/J7re4FYoaNWXvCv/kQUzUbnWQ200sRhKNq7e8w==
X-Received: by 2002:a05:600c:4ec7:b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-490c26441b6mr365260935e9.29.1781039481596;
        Tue, 09 Jun 2026 14:11:21 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm505061405e9.15.2026.06.09.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:11:21 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] shared/bap: Transition ASE to QoS Configured on CIS loss
Date: Tue,  9 Jun 2026 23:11:20 +0200
Message-ID: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stream_io_disconnected() only handled the Releasing state, leaving
Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
unexpectedly. The ASE shall autonomously move to QoS Configured on loss
of the CIS and notify the peer; add that transition.

Fixes PTS test BAP/USR/SCC/BV-167-C
---
 src/shared/bap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..350ed53d9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6779,6 +6779,14 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
+	/* On loss of the CIS the ASE shall autonomously transition to QoS
+	 * Configured and notify the peer.
+	 */
+	if (stream->ep->state == BT_ASCS_ASE_STATE_STREAMING ||
+			stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
+			stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
+		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+
 	bt_bap_stream_set_io(stream, -1);
 	return false;
 }
-- 
2.43.0

