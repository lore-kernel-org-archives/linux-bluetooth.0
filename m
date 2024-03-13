Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BB45BF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342437; cv=none; b=GhpHENlrn8z9MB6L2p6DAD2yA6EmhcdrjrvTffujHAH5+ULGr7PkI7YGtH5hYKJskxMkh4nq66vVHknusDCxVhCHsgeow4a5HO3IDJ6AHykP+hDtSMVMLojg6ocymnNOn+1uZMpJvuL+Qzy1z/GWMybgVbhbO1PLT2KW/8bOk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342437; c=relaxed/simple;
	bh=5YFf7okjs2u0/6jnyzg/Fczgw9WsIIgUxrcV9ADawPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPpm1hT8gFGLAOdh9OlOGcl2yQJa6R4BihviwqGsFesbwkFSffKdnf0iwkAxQ9w8Ukqz7BGEW20U8KPhbLWAD0wDMifqPJ5+tjpd1t9R5TQDrfWXqM8si8Rr+AePcxOrIOdPGUyp4d0yF5VqlX0aEpjpC0418WF6USOyI6KlcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPrXZRfj; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPrXZRfj"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso530909e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342433; x=1710947233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFqkOlrlD9l8od2nf4iVUx9e4lpYZkfntREwQL72MVM=;
        b=FPrXZRfjAtQsqO5tYz6iw6cl/8nfq/PgzTHWYuHrPLsMfFi6krAVdu3lta+PcRas60
         WEv85qO0k4SJNtJgqNgJ4t4gk2O8QnAvN7iNJmtf9XsfCcynBT1/OBDUB4wttymdZEc1
         K0elSn27ocyhYBQMOrPbS9fr6Gm4a78Hy/9kMGtscfvHV2u/Ss57xvhqI04QnqA1miuh
         7lsaHZjSPSOi/PtdRWw+3vFUFAAQKA4PY9CbrGG/bKvcFW1+qkrTG7SPfMTDL+TcporM
         A6HRF3qTq0hHLOvTpG1xFJs7g6KLmOvzk7q6Ht0McjM6SytuaZRNUViycpQLCZTSVdNZ
         5DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342433; x=1710947233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFqkOlrlD9l8od2nf4iVUx9e4lpYZkfntREwQL72MVM=;
        b=vceMoAinK3WitKa58eyEiahzuWz9YT0E1i3j/m/eNFplGqUf4g4DsHIOb3RizTmKwt
         eBYKDGKKDrJRcAqpRp0B+ijAn9etuLGlQw1lHPIw7AUEZy9B/1R4egIGjk+aPd0pRcT+
         BTY2TmQvnVlMl1XUnrqjh5N8kM5km90WEontn02xIXK/NhNwMlfLnJrzxpfrRJfV9KhQ
         qR8bsOHZCYsoOyqO3OSa9Jkg0vMiOsuUp1vER9FzufZqn5Z/B1feUr8Lhu2nfpmT9pGa
         XDQIE6tvfVrWcL/OfgYKG6lhxmfoxy36IQrcB3eRn32Sx3EcPzyHuhdv37/6FIegJlOk
         x9Gw==
X-Gm-Message-State: AOJu0YyDXeP0JlABLo5QruT9b/RfpJRsYZAiFRp+RjczlI4z/hPlB2y/
	7mJbQu/0gXPgbI7e/TIAKRQV6pTZnIkt4oI0ILjPfhifbaug6DMHpaOmEzqO
X-Google-Smtp-Source: AGHT+IEyKwrd4gpjIevqbflf57jtsumWoI9M9tgN1DUWQWNJIEp3MA94+xlI0sVeQhCyXkSfw0PGYQ==
X-Received: by 2002:a05:6122:1685:b0:4c9:b45:7e74 with SMTP id 5-20020a056122168500b004c90b457e74mr83461vkl.6.1710342433037;
        Wed, 13 Mar 2024 08:07:13 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id bi47-20020a05612218af00b004cd29aaccd6sm1205610vkb.2.2024.03.13.08.07.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:07:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] shared/lc3: Add definition for broadcast configurations
Date: Wed, 13 Mar 2024 11:07:05 -0400
Message-ID: <20240313150706.1279036-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313150706.1279036-1-luiz.dentz@gmail.com>
References: <20240313150706.1279036-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds defines for broadcast settings as they don't really match
unicast when it comes to RTN and Latency.
---
 src/shared/bap-defs.h |  97 +++++++++++
 src/shared/bap.h      |  84 +---------
 src/shared/lc3.h      | 372 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 469 insertions(+), 84 deletions(-)
 create mode 100644 src/shared/bap-defs.h

diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
new file mode 100644
index 000000000000..2467e816ffa9
--- /dev/null
+++ b/src/shared/bap-defs.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023-2024 NXP
+ *
+ */
+
+#ifndef SRC_SHARED_BAP_DEFS_H_
+#define SRC_SHARED_BAP_DEFS_H_
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#define BT_BAP_SINK			0x01
+#define	BT_BAP_SOURCE			0x02
+#define	BT_BAP_BCAST_SOURCE		0x03
+#define	BT_BAP_BCAST_SINK		0x04
+
+#define BT_BAP_STREAM_TYPE_UCAST	0x01
+#define	BT_BAP_STREAM_TYPE_BCAST	0x02
+
+#define BT_BAP_STREAM_STATE_IDLE	0x00
+#define BT_BAP_STREAM_STATE_CONFIG	0x01
+#define BT_BAP_STREAM_STATE_QOS		0x02
+#define BT_BAP_STREAM_STATE_ENABLING	0x03
+#define BT_BAP_STREAM_STATE_STREAMING	0x04
+#define BT_BAP_STREAM_STATE_DISABLING	0x05
+#define BT_BAP_STREAM_STATE_RELEASING	0x06
+
+#define BT_BAP_CONFIG_LATENCY_LOW	0x01
+#define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
+#define BT_BAP_CONFIG_LATENCY_HIGH	0x03
+
+#define BT_BAP_CONFIG_PHY_1M		0x01
+#define BT_BAP_CONFIG_PHY_2M		0x02
+#define BT_BAP_CONFIG_PHY_CODEC		0x03
+
+struct bt_bap_codec {
+	uint8_t  id;
+	uint16_t cid;
+	uint16_t vid;
+} __packed;
+
+struct bt_ltv {
+	uint8_t  len;
+	uint8_t  type;
+	uint8_t  value[];
+} __packed;
+
+struct bt_bap_io_qos {
+	uint32_t interval;	/* Frame interval */
+	uint16_t latency;	/* Transport Latency */
+	uint16_t sdu;		/* Maximum SDU Size */
+	uint8_t  phy;		/* PHY */
+	uint8_t  rtn;		/* Retransmission Effort */
+};
+
+struct bt_bap_ucast_qos {
+	uint8_t  cig_id;
+	uint8_t  cis_id;
+	uint8_t  framing;		/* Frame framing */
+	uint32_t delay;			/* Presentation Delay */
+	uint8_t  target_latency;	/* Target Latency */
+	struct bt_bap_io_qos io_qos;
+};
+
+struct bt_bap_bcast_qos {
+	uint8_t  big;
+	uint8_t  bis;
+	uint8_t  sync_factor;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	struct iovec *bcode;
+	uint8_t  options;
+	uint16_t skip;
+	uint16_t sync_timeout;
+	uint8_t  sync_cte_type;
+	uint8_t  mse;
+	uint16_t timeout;
+	uint8_t  pa_sync;
+	struct bt_bap_io_qos io_qos;
+	uint32_t delay;			/* Presentation Delay */
+};
+
+struct bt_bap_qos {
+	union {
+		struct bt_bap_ucast_qos ucast;
+		struct bt_bap_bcast_qos bcast;
+	};
+};
+
+#endif /* SRC_SHARED_BAP_DEFS_H_ */
diff --git a/src/shared/bap.h b/src/shared/bap.h
index b2826719f84f..9839e324905a 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -10,94 +10,12 @@
 
 #include <stdbool.h>
 #include <inttypes.h>
-
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
-#define BT_BAP_SINK			0x01
-#define	BT_BAP_SOURCE			0x02
-#define	BT_BAP_BCAST_SOURCE		0x03
-#define	BT_BAP_BCAST_SINK		0x04
-
-#define BT_BAP_STREAM_TYPE_UCAST	0x01
-#define	BT_BAP_STREAM_TYPE_BCAST	0x02
-
-#define BT_BAP_STREAM_STATE_IDLE	0x00
-#define BT_BAP_STREAM_STATE_CONFIG	0x01
-#define BT_BAP_STREAM_STATE_QOS		0x02
-#define BT_BAP_STREAM_STATE_ENABLING	0x03
-#define BT_BAP_STREAM_STATE_STREAMING	0x04
-#define BT_BAP_STREAM_STATE_DISABLING	0x05
-#define BT_BAP_STREAM_STATE_RELEASING	0x06
-
-#define BT_BAP_CONFIG_LATENCY_LOW	0x01
-#define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
-#define BT_BAP_CONFIG_LATENCY_HIGH	0x03
-
-#define BT_BAP_CONFIG_PHY_1M		0x01
-#define BT_BAP_CONFIG_PHY_2M		0x02
-#define BT_BAP_CONFIG_PHY_CODEC		0x03
+#include "src/shared/bap-defs.h"
 
 struct bt_bap;
 struct bt_bap_pac;
 struct bt_bap_stream;
 
-struct bt_bap_codec {
-	uint8_t  id;
-	uint16_t cid;
-	uint16_t vid;
-} __packed;
-
-struct bt_ltv {
-	uint8_t  len;
-	uint8_t  type;
-	uint8_t  value[0];
-} __packed;
-
-struct bt_bap_io_qos {
-	uint32_t interval;	/* Frame interval */
-	uint16_t latency;	/* Transport Latency */
-	uint16_t sdu;		/* Maximum SDU Size */
-	uint8_t  phy;		/* PHY */
-	uint8_t  rtn;		/* Retransmission Effort */
-};
-
-struct bt_bap_ucast_qos {
-	uint8_t  cig_id;
-	uint8_t  cis_id;
-	uint8_t  framing;		/* Frame framing */
-	uint32_t delay;			/* Presentation Delay */
-	uint8_t  target_latency;	/* Target Latency */
-	struct bt_bap_io_qos io_qos;
-};
-
-struct bt_bap_bcast_qos {
-	uint8_t  big;
-	uint8_t  bis;
-	uint8_t  sync_factor;
-	uint8_t  packing;
-	uint8_t  framing;
-	uint8_t  encryption;
-	struct iovec *bcode;
-	uint8_t  options;
-	uint16_t skip;
-	uint16_t sync_timeout;
-	uint8_t  sync_cte_type;
-	uint8_t  mse;
-	uint16_t timeout;
-	uint8_t  pa_sync;
-	struct bt_bap_io_qos io_qos;
-	uint32_t delay;			/* Presentation Delay */
-};
-
-struct bt_bap_qos {
-	union {
-		struct bt_bap_ucast_qos ucast;
-		struct bt_bap_bcast_qos bcast;
-	};
-};
-
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index 1db46217b76e..dcaa50ad531f 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -8,6 +8,8 @@
  *
  */
 
+#include "src/shared/bap-defs.h"
+
 #define LC3_ID			0x06
 
 #define LC3_BASE		0x01
@@ -280,6 +282,7 @@
 { \
 	.ucast.cig_id = 0x00, \
 	.ucast.cis_id = 0x00, \
+	.ucast.framing = _frame, \
 	.ucast.delay = _pd, \
 	.ucast.target_latency = _t_lat, \
 	.ucast.io_qos.interval = _interval, \
@@ -358,6 +361,14 @@
 					LC3_QOS_16_1_2_RTN)
 #define LC3_QOS_16_1_2 LC3_QOS_16_1_2_AC(1)
 
+#define LC3_QOS_16_1_GS_LATENCY 15u
+#define LC3_QOS_16_1_GS_RTN 1u
+#define LC3_QOS_16_1_GS \
+	LC3_QOS_UCAST_7_5_UNFRAMED(60000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_16_1_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_GS_RTN)
+
 #define LC3_QOS_16_2_1_LATENCY 10u
 #define LC3_QOS_16_2_1_RTN 2u
 
@@ -378,13 +389,22 @@
 					LC3_QOS_16_2_2_RTN)
 #define LC3_QOS_16_2_2 LC3_QOS_16_2_2_AC(1)
 
+#define LC3_QOS_16_2_GS_LATENCY 20u
+#define LC3_QOS_16_2_GS_RTN 1u
+#define LC3_QOS_16_2_GS \
+	LC3_QOS_UCAST_10_UNFRAMED(60000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_16_2_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_GS_RTN)
+
 #define LC3_QOS_24_1_1_LATENCY 8u
 #define LC3_QOS_24_1_1_RTN 2u
 
 #define LC3_QOS_24_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_24_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_24_1, 2u)
+					_ac * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_1_RTN)
 #define LC3_QOS_24_1_1 LC3_QOS_24_1_1_AC(1)
 
 #define LC3_QOS_24_1_2_LATENCY 75u
@@ -437,6 +457,23 @@
 					LC3_QOS_32_1_2_RTN)
 #define LC3_QOS_32_1_2 LC3_QOS_32_1_2_AC(1)
 
+#define LC3_QOS_32_1_GS_LATENCY 15u
+#define LC3_QOS_32_1_GS_RTN 1u
+#define LC3_QOS_32_1_GS \
+	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_32_1_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_GS_RTN)
+
+#define LC3_QOS_32_1_GR_LATENCY 15u
+#define LC3_QOS_32_1_GR_RTN 1u
+#define LC3_QOS_32_1_GR_AC(_ac) \
+	LC3_QOS_UCAST_7_5_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_32_1_GS_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_GS_RTN)
+#define LC3_QOS_32_1_GR LC3_QOS_32_1_GR_AC(1)
+
 #define LC3_QOS_32_2_1_LATENCY 10u
 #define LC3_QOS_32_2_1_RTN 2u
 
@@ -457,6 +494,23 @@
 					LC3_QOS_32_2_2_RTN)
 #define LC3_QOS_32_2_2 LC3_QOS_32_2_2_AC(1)
 
+#define LC3_QOS_32_2_GS_LATENCY 20u
+#define LC3_QOS_32_2_GS_RTN 1u
+#define LC3_QOS_32_2_GS \
+	LC3_QOS_UCAST_10_UNFRAMED(60000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_32_2_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_GS_RTN)
+
+#define LC3_QOS_32_2_GR_LATENCY 20u
+#define LC3_QOS_32_2_GR_RTN 1u
+#define LC3_QOS_32_2_GR_AC(_ac) \
+	LC3_QOS_UCAST_10_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_32_2_GR_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_GR_RTN)
+#define LC3_QOS_32_2_GR LC3_QOS_32_2_GR_AC(1)
+
 #define LC3_QOS_44_1_INTERVAL 8163u
 #define LC3_QOS_44_1_1_LATENCY 24u
 #define LC3_QOS_44_1_1_RTN 5u
@@ -523,6 +577,25 @@
 					LC3_QOS_48_1_2_RTN)
 #define LC3_QOS_48_1_2 LC3_QOS_48_1_2_AC(1)
 
+#define LC3_QOS_48_1_GS_LATENCY 15u
+#define LC3_QOS_48_1_GS_RTN 1u
+
+#define LC3_QOS_48_1_GS \
+	LC3_QOS_UCAST_7_5_UNFRAMED(60000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_48_1_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_GS_RTN)
+
+#define LC3_QOS_48_1_GR_LATENCY 15u
+#define LC3_QOS_48_1_GR_RTN 1u
+
+#define LC3_QOS_48_1_GR_AC(_ac) \
+	LC3_QOS_UCAST_7_5_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_1_GR_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_GR_RTN)
+#define LC3_QOS_48_1_GR LC3_QOS_48_1_GR_AC(1)
+
 #define LC3_QOS_48_2_1_LATENCY 20u
 #define LC3_QOS_48_2_1_RTN 5u
 
@@ -543,6 +616,25 @@
 					LC3_QOS_48_2_2_RTN)
 #define LC3_QOS_48_2_2 LC3_QOS_48_2_2_AC(1)
 
+#define LC3_QOS_48_2_GS_LATENCY 20u
+#define LC3_QOS_48_2_GS_RTN 1u
+
+#define LC3_QOS_48_2_GS \
+	LC3_QOS_UCAST_10_UNFRAMED(60000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
+					LC3_QOS_48_2_GS_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_GS_RTN)
+
+#define LC3_QOS_48_2_GR_LATENCY 20u
+#define LC3_QOS_48_2_GR_RTN 1u
+
+#define LC3_QOS_48_2_GR_AC(_ac) \
+	LC3_QOS_UCAST_10_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_2_GR_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_GR_RTN)
+#define LC3_QOS_48_2_GR LC3_QOS_48_2_GR_AC(1)
+
 #define LC3_QOS_48_3_1_LATENCY 15u
 #define LC3_QOS_48_3_1_RTN 5u
 
@@ -563,6 +655,16 @@
 					LC3_QOS_48_3_2_RTN)
 #define LC3_QOS_48_3_2 LC3_QOS_48_3_2_AC(1)
 
+#define LC3_QOS_48_3_GR_LATENCY 15u
+#define LC3_QOS_48_3_GR_RTN 1u
+
+#define LC3_QOS_48_3_GR_AC(_ac) \
+	LC3_QOS_UCAST_7_5_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_3_GR_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_GR_RTN)
+#define LC3_QOS_48_3_GR LC3_QOS_48_3_GR_AC(1)
+
 #define LC3_QOS_48_4_1_LATENCY 20u
 #define LC3_QOS_48_4_1_RTN 5u
 
@@ -583,6 +685,16 @@
 					LC3_QOS_48_4_2_RTN)
 #define LC3_QOS_48_4_2 LC3_QOS_48_4_2_AC(1)
 
+#define LC3_QOS_48_4_GR_LATENCY 20u
+#define LC3_QOS_48_4_GR_RTN 1u
+
+#define LC3_QOS_48_4_GR_AC(_ac) \
+	LC3_QOS_UCAST_10_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_4_GR_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_GR_RTN)
+#define LC3_QOS_48_4_GR LC3_QOS_48_4_GR_AC(1)
+
 #define LC3_QOS_48_5_1_LATENCY 15u
 #define LC3_QOS_48_5_1_RTN 5u
 
@@ -622,3 +734,261 @@
 					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
 					LC3_QOS_48_6_2_RTN)
 #define LC3_QOS_48_6_2 LC3_QOS_48_6_2_AC(1)
+
+#define LC3_QOS_BCAST(_frame, _pd, _interval, _lat, _sdu, _rtn) \
+{ \
+	.bcast.big = 0x00, \
+	.bcast.bis = 0x00, \
+	.bcast.framing = _frame, \
+	.bcast.delay = _pd, \
+	.bcast.io_qos.interval = _interval, \
+	.bcast.io_qos.latency = _lat, \
+	.bcast.io_qos.sdu = _sdu, \
+	.bcast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.bcast.io_qos.rtn = _rtn, \
+}
+
+#define LC3_QOS_BCAST_7_5_UNFRAMED(_pd, _lat, _sdu, _rtn) \
+	LC3_QOS_BCAST(LC3_QOS_UNFRAMED, _pd, 7500u, _lat, _sdu, _rtn)
+
+#define LC3_QOS_BCAST_10_UNFRAMED(_pd, _lat, _sdu, _rtn) \
+	LC3_QOS_BCAST(LC3_QOS_UNFRAMED, _pd, 10000u, _lat, _sdu, _rtn)
+
+#define LC3_QOS_BCAST_FRAMED(_pd, _interval, _lat, _sdu, _rtn) \
+	LC3_QOS_BCAST(LC3_QOS_FRAMED, _pd, _interval, _lat, _sdu, _rtn)
+
+#define LC3_QOS_8_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_8_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_1_RTN)
+#define LC3_QOS_8_1_1_B LC3_QOS_8_1_1_B_AC(1)
+
+#define LC3_QOS_8_1_2_B_LATENCY 75u
+#define LC3_QOS_8_1_2_B_RTN 4u
+#define LC3_QOS_8_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_8_1_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_2_B_RTN)
+#define LC3_QOS_48_1_2_B LC3_QOS_48_1_2_B_AC(1)
+
+#define LC3_QOS_8_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_8_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_1_RTN)
+#define LC3_QOS_8_2_1_B LC3_QOS_8_2_1_B_AC(1)
+
+#define LC3_QOS_8_2_2_B_LATENCY 60u
+#define LC3_QOS_8_2_2_B_RTN 4u
+#define LC3_QOS_8_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_8_2_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_2_B_RTN)
+#define LC3_QOS_8_2_2_B LC3_QOS_8_2_2_B_AC(1)
+
+#define LC3_QOS_16_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_16_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_1_RTN)
+#define LC3_QOS_16_1_1_B LC3_QOS_16_1_1_B_AC(1)
+
+#define LC3_QOS_16_1_2_B_LATENCY 45u
+#define LC3_QOS_16_1_2_B_RTN 4u
+#define LC3_QOS_16_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_16_1_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_2_B_RTN)
+#define LC3_QOS_16_1_2_B LC3_QOS_16_1_2_B_AC(1)
+
+#define LC3_QOS_16_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_16_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_1_RTN)
+#define LC3_QOS_16_2_1_B LC3_QOS_16_2_1_B_AC(1)
+
+#define LC3_QOS_16_2_2_B_LATENCY 60u
+#define LC3_QOS_16_2_2_B_RTN 4u
+#define LC3_QOS_16_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_16_2_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_2_B_RTN)
+#define LC3_QOS_16_2_2_B LC3_QOS_16_2_2_B_AC(1)
+
+#define LC3_QOS_24_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_24_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_1_RTN)
+#define LC3_QOS_24_1_1_B LC3_QOS_24_1_1_B_AC(1)
+
+#define LC3_QOS_24_1_2_B_LATENCY 45u
+#define LC3_QOS_24_1_2_B_RTN 4u
+#define LC3_QOS_24_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_24_1_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_2_B_RTN)
+#define LC3_QOS_24_1_2_B LC3_QOS_24_1_2_B_AC(1)
+
+#define LC3_QOS_24_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_24_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					LC3_QOS_24_2_1_RTN)
+#define LC3_QOS_24_2_1_B LC3_QOS_24_2_1_B_AC(1)
+
+#define LC3_QOS_24_2_2_B_LATENCY 60u
+#define LC3_QOS_24_2_2_B_RTN 4u
+#define LC3_QOS_24_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_24_2_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					LC3_QOS_24_2_2_B_RTN)
+#define LC3_QOS_24_2_2_B LC3_QOS_24_2_2_B_AC(1)
+
+#define LC3_QOS_32_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_32_1_1_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_1_RTN)
+#define LC3_QOS_32_1_1_B LC3_QOS_32_1_1_B_AC(1)
+
+#define LC3_QOS_32_1_2_B_LATENCY 45u
+#define LC3_QOS_32_1_2_B_RTN 4u
+#define LC3_QOS_32_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_32_1_2_B_LATENCY, \
+					LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_2_B_RTN)
+#define LC3_QOS_32_1_2_B LC3_QOS_32_1_2_B_AC(1)
+
+#define LC3_QOS_32_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_32_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_1_RTN)
+#define LC3_QOS_32_2_1_B LC3_QOS_32_2_1_B_AC(1)
+
+#define LC3_QOS_32_2_2_B_LATENCY 60u
+#define LC3_QOS_32_2_2_B_RTN 4u
+#define LC3_QOS_32_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_32_2_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_2_B_RTN)
+#define LC3_QOS_32_2_2_B LC3_QOS_32_2_2_B_AC(1)
+
+#define LC3_QOS_44_1_1_B_RTN 4u
+#define LC3_QOS_44_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_1_B_RTN)
+#define LC3_QOS_44_1_1_B LC3_QOS_44_1_1_B_AC(1)
+
+#define LC3_QOS_44_1_2_B_LATENCY 54u
+#define LC3_QOS_44_1_2_B_RTN 4u
+#define LC3_QOS_44_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_2_B_RTN)
+#define LC3_QOS_44_1_2_B LC3_QOS_44_1_2_B_AC(1)
+
+#define LC3_QOS_44_2_1_B_RTN 4u
+#define LC3_QOS_44_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_1_B_RTN)
+#define LC3_QOS_44_2_1_B LC3_QOS_44_2_1_B_AC(1)
+
+#define LC3_QOS_44_2_2_B_LATENCY 60u
+#define LC3_QOS_44_2_2_B_RTN 4u
+#define LC3_QOS_44_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_2_RTN)
+#define LC3_QOS_44_2_2_B LC3_QOS_44_2_2_B_AC(1)
+
+#define LC3_QOS_48_1_1_B_RTN 4u
+#define LC3_QOS_48_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_1_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_1,\
+					LC3_QOS_48_1_1_B_RTN)
+#define LC3_QOS_48_1_1_B LC3_QOS_48_1_1_B_AC(1)
+
+#define LC3_QOS_48_1_2_B_LATENCY 50u
+#define LC3_QOS_48_1_2_B_RTN 4u
+#define LC3_QOS_48_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_1_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_2_B_RTN)
+#define LC3_QOS_48_1_2_B LC3_QOS_48_1_2_B_AC(1)
+
+#define LC3_QOS_48_2_1_B_RTN 4u
+#define LC3_QOS_48_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_2_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_1_B_RTN)
+#define LC3_QOS_48_2_1_B LC3_QOS_48_2_1_B_AC(1)
+
+#define LC3_QOS_48_2_2_B_LATENCY 65u
+#define LC3_QOS_48_2_2_B_RTN 4u
+#define LC3_QOS_48_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_2_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_2_B_RTN)
+#define LC3_QOS_48_2_2_B LC3_QOS_48_2_2_B_AC(1)
+
+#define LC3_QOS_48_3_1_B_RTN 4u
+#define LC3_QOS_48_3_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_3_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_1_B_RTN)
+#define LC3_QOS_48_3_1_B LC3_QOS_48_3_1_B_AC(1)
+
+#define LC3_QOS_48_3_2_B_LATENCY 50u
+#define LC3_QOS_48_3_2_B_RTN 4u
+#define LC3_QOS_48_3_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_3_2_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_2_RTN)
+#define LC3_QOS_48_3_2_B LC3_QOS_48_3_2_B_AC(1)
+
+#define LC3_QOS_48_4_1_B_RTN 4u
+#define LC3_QOS_48_4_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_4_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_1_B_RTN)
+#define LC3_QOS_48_4_1_B LC3_QOS_48_4_1_B_AC(1)
+
+#define LC3_QOS_48_4_2_B_LATENCY 65u
+#define LC3_QOS_48_4_2_B_RTN 4u
+#define LC3_QOS_48_4_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_4_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_2_B_RTN)
+#define LC3_QOS_48_4_2_B LC3_QOS_48_4_2_B_AC(1)
+
+#define LC3_QOS_48_5_1_B_RTN 4u
+#define LC3_QOS_48_5_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_5_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_1_B_RTN)
+#define LC3_QOS_48_5_1_B LC3_QOS_48_5_1_B_AC(1)
+
+#define LC3_QOS_48_5_2_B_LATENCY 50u
+#define LC3_QOS_48_5_2_B_RTN 4u
+#define LC3_QOS_48_5_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_5_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_2_B_RTN)
+#define LC3_QOS_48_5_2_B LC3_QOS_48_5_2_B_AC(1)
+
+#define LC3_QOS_48_6_1_B_RTN 5u
+#define LC3_QOS_48_6_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_6_1_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_1_B_RTN)
+#define LC3_QOS_48_6_1_B LC3_QOS_48_6_1_B_AC(1)
+
+#define LC3_QOS_48_6_2_B_LATENCY 65u
+#define LC3_QOS_48_6_2_B_RTN 4u
+#define LC3_QOS_48_6_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_6_2_B_LATENCY, \
+					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_2_B_RTN)
+#define LC3_QOS_48_6_2_B LC3_QOS_48_6_2_B_AC(1)
-- 
2.43.0

