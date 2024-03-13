Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648B3E48C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342769; cv=none; b=OgIEdTvjJVqUt+oANyyMPOHnHkMzLWi17TC94ngSKYJGJdd3O4sw3+NO/Sc4w3hNK21W6dv3PLU3VCH0dUTPjo0hNfd3jWM0+zl5dVp/+6i+HORaVCvDN0u8W1H3eOpUNfGFJrCUYRGx/AyjormKjl3z5I2iYvs3jxdEupjj56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342769; c=relaxed/simple;
	bh=n5ZRuxq+mrHO2vZrIkAFHnhCP9PXZ4om0K1L6v3SJrM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoZWqBijbJywMvp5590li2WX8fbterYyNiEgtfulFaL35qOoEwLflle3b6BeRaAPCnVdOXZlP3mwjlVvcLc062SSUob+jX7ALVzw/uEAhbX6AO+dxCvVH1C4xIWnrdVGlolDEvaGfMCJYL8B+SiTDPYRpqGE+d8ZO6KIZIjwCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0FaRXQd; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0FaRXQd"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4727e38ec10so1084271137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710342765; x=1710947565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25OGvpsp6THQWKK3GYGhEVbIQHg3IxpvYP6eWlw3O94=;
        b=C0FaRXQd4IM4IicEP0txBiA57mXZFFAkcTUSgxPMG0SIIvzErRI3bgGiSfh0MJhKlc
         ajrCoUcclX4TeqaM3gLwK5hUSgdQvrHplMiUsM+tBNj4MNeque27G/L9PAbrnmNWuq+3
         asCul7Hj4faTLchK2UR5eMCjPFSOVukesS4ov2Muev1ulYJwzRcTnK9PYcQjVU3hldN3
         MR4v5YW7gxbP1Dfx0nLYlGI19hiDtynuMM7QYC5gB2Fmv8o/7pV9rlWfEXUcOeweJkbx
         zMLwJddOWMlAq8BlkMO1uS3qm4hh/FdaC8mq8KGw2t6JNavYR+wg1czrcUFfVADnUmHM
         R5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342765; x=1710947565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25OGvpsp6THQWKK3GYGhEVbIQHg3IxpvYP6eWlw3O94=;
        b=Gae446K0d3GMYOFmH87a//T7Geoj/YaKry+V/lNlTV52fG3S+3w5ZCLPLtrJfsbKNR
         uZyri5fSgwBcSpi2c2rCaojQIeIMTG3ouu6LQWe/P9Wio7cP8vcF5xkJoSxgVVtmrhzd
         425adwLk7Fh8oWn86Mi0hOFDCbA8W9W5qhnbAfHvsQan9U2Mkkhrvup2vYLu2vkmbPQf
         AFeO45+hVNRAqlPzSGxfStMEs9KfczX/RQgSkbeDIhafj2VJ2qhV2GKGS6dqZmL4qwi4
         /MlwsU8BgLh4J9TuhJ+g/BcUUHIPzWoG+ec3E6xhj6u38CO3S/cCLlheAWHvEx9rWg95
         B4Kg==
X-Gm-Message-State: AOJu0Yyq3vy28W3Ut1llExO1WUJnHApK0luqPBv9C1py2AkwpMeEL+vi
	bWsvk5ISXaaLxRet9ga/U7urH/I1XSmMXuQYIEOKTQLeRUbyZTTMQ1gWnri+
X-Google-Smtp-Source: AGHT+IE0yrWsNGFThRpTHhEcy2DnMubZsIKV0l5OqGa+rMIlSG8kiYsJ0TeHdrALrb2QlhztLPB5QA==
X-Received: by 2002:a05:6102:c8a:b0:474:c843:a2df with SMTP id f10-20020a0561020c8a00b00474c843a2dfmr171593vst.13.1710342764757;
        Wed, 13 Mar 2024 08:12:44 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id j27-20020a0561023e1b00b0046d5dbea599sm1759452vsv.6.2024.03.13.08.12.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:12:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] shared/lc3: Add definition for broadcast configurations
Date: Wed, 13 Mar 2024 11:12:37 -0400
Message-ID: <20240313151238.1294526-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313151238.1294526-1-luiz.dentz@gmail.com>
References: <20240313151238.1294526-1-luiz.dentz@gmail.com>
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
 src/shared/bap-defs.h |  97 ++++++++++
 src/shared/bap.h      |  84 +-------
 src/shared/lc3.h      | 434 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 500 insertions(+), 115 deletions(-)
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
index 1db46217b76e..d74412719306 100644
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
@@ -304,7 +307,7 @@
 #define LC3_QOS_8_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_8_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_1, \
 					LC3_QOS_8_1_1_RTN)
 #define LC3_QOS_8_1_1 LC3_QOS_8_1_1_AC(1)
 
@@ -314,7 +317,7 @@
 #define LC3_QOS_8_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_8_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_8_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_1, \
 					LC3_QOS_8_1_2_RTN)
 #define LC3_QOS_8_1_2 LC3_QOS_8_1_2_AC(1)
 
@@ -324,7 +327,7 @@
 #define LC3_QOS_8_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_8_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_2, \
 					LC3_QOS_8_2_1_RTN)
 #define LC3_QOS_8_2_1 LC3_QOS_8_2_1_AC(1)
 
@@ -334,7 +337,7 @@
 #define LC3_QOS_8_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_8_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_8_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_2, \
 					LC3_QOS_8_2_2_RTN)
 #define LC3_QOS_8_2_2 LC3_QOS_8_2_2_AC(1)
 
@@ -344,7 +347,7 @@
 #define LC3_QOS_16_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_16_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_1, \
 					LC3_QOS_16_1_1_RTN)
 #define LC3_QOS_16_1_1 LC3_QOS_16_1_1_AC(1)
 
@@ -354,17 +357,25 @@
 #define LC3_QOS_16_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_16_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_16_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_1, \
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
 
 #define LC3_QOS_16_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_16_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_2, \
 					LC3_QOS_16_2_1_RTN)
 #define LC3_QOS_16_2_1 LC3_QOS_16_2_1_AC(1)
 
@@ -374,17 +385,26 @@
 #define LC3_QOS_16_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_16_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_16_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_2, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_1_RTN)
 #define LC3_QOS_24_1_1 LC3_QOS_24_1_1_AC(1)
 
 #define LC3_QOS_24_1_2_LATENCY 75u
@@ -393,7 +413,7 @@
 #define LC3_QOS_24_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_24_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_24_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_1, \
 					LC3_QOS_24_1_2_RTN)
 #define LC3_QOS_24_1_2 LC3_QOS_24_1_2_AC(1)
 
@@ -403,7 +423,7 @@
 #define LC3_QOS_24_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_24_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_2, \
 					LC3_QOS_24_2_1_RTN)
 #define LC3_QOS_24_2_1 LC3_QOS_24_2_1_AC(1)
 
@@ -413,7 +433,7 @@
 #define LC3_QOS_24_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_24_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_24_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_2, \
 					LC3_QOS_24_2_2_RTN)
 #define LC3_QOS_24_2_2 LC3_QOS_24_2_2_AC(1)
 
@@ -423,7 +443,7 @@
 #define LC3_QOS_32_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_32_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_32_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_1, \
 					LC3_QOS_32_1_1_RTN)
 #define LC3_QOS_32_1_1 LC3_QOS_32_1_1_AC(1)
 
@@ -433,17 +453,34 @@
 #define LC3_QOS_32_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_32_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_32_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_1, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_1, \
+					LC3_QOS_32_1_GS_RTN)
+#define LC3_QOS_32_1_GR LC3_QOS_32_1_GR_AC(1)
+
 #define LC3_QOS_32_2_1_LATENCY 10u
 #define LC3_QOS_32_2_1_RTN 2u
 
 #define LC3_QOS_32_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_32_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_2, \
 					LC3_QOS_32_2_1_RTN)
 #define LC3_QOS_32_2_1 LC3_QOS_32_2_1_AC(1)
 
@@ -453,10 +490,27 @@
 #define LC3_QOS_32_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_32_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_32_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_2, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_GR_RTN)
+#define LC3_QOS_32_2_GR LC3_QOS_32_2_GR_AC(1)
+
 #define LC3_QOS_44_1_INTERVAL 8163u
 #define LC3_QOS_44_1_1_LATENCY 24u
 #define LC3_QOS_44_1_1_RTN 5u
@@ -465,7 +519,7 @@
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_44_1_INTERVAL, \
 					LC3_QOS_44_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_1, \
 					LC3_QOS_44_1_1_RTN)
 #define LC3_QOS_44_1_1 LC3_QOS_44_1_1_AC(1)
 
@@ -476,7 +530,7 @@
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_44_1_INTERVAL, \
 					LC3_QOS_44_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_44_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_1, \
 					LC3_QOS_44_1_2_RTN)
 #define LC3_QOS_44_1_2 LC3_QOS_44_1_2_AC(1)
 
@@ -488,7 +542,7 @@
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_44_2_INTERVAL, \
 					LC3_QOS_44_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_2, \
 					LC3_QOS_44_2_1_RTN)
 #define LC3_QOS_44_2_1 LC3_QOS_44_2_1_AC(1)
 
@@ -499,7 +553,7 @@
 	LC3_QOS_UCAST_FRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_44_2_INTERVAL, \
 					LC3_QOS_44_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_44_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_2, \
 					LC3_QOS_44_2_2_RTN)
 #define LC3_QOS_44_2_2 LC3_QOS_44_2_2_AC(1)
 
@@ -509,7 +563,7 @@
 #define LC3_QOS_48_1_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_1_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_1,\
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_1,\
 					LC3_QOS_48_1_1_RTN)
 #define LC3_QOS_48_1_1 LC3_QOS_48_1_1_AC(1)
 
@@ -519,17 +573,36 @@
 #define LC3_QOS_48_1_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_1_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_1, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_1, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_GR_RTN)
+#define LC3_QOS_48_1_GR LC3_QOS_48_1_GR_AC(1)
+
 #define LC3_QOS_48_2_1_LATENCY 20u
 #define LC3_QOS_48_2_1_RTN 5u
 
 #define LC3_QOS_48_2_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_2_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_2, \
 					LC3_QOS_48_2_1_RTN)
 #define LC3_QOS_48_2_1 LC3_QOS_48_2_1_AC(1)
 
@@ -539,17 +612,36 @@
 #define LC3_QOS_48_2_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_2_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_2, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_2, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_GR_RTN)
+#define LC3_QOS_48_2_GR LC3_QOS_48_2_GR_AC(1)
+
 #define LC3_QOS_48_3_1_LATENCY 15u
 #define LC3_QOS_48_3_1_RTN 5u
 
 #define LC3_QOS_48_3_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_3_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_3, \
 					LC3_QOS_48_3_1_RTN)
 #define LC3_QOS_48_3_1 LC3_QOS_48_3_1_AC(1)
 
@@ -559,17 +651,27 @@
 #define LC3_QOS_48_3_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_3_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_3, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_3, \
 					LC3_QOS_48_3_2_RTN)
 #define LC3_QOS_48_3_2 LC3_QOS_48_3_2_AC(1)
 
+#define LC3_QOS_48_3_GR_LATENCY 15u
+#define LC3_QOS_48_3_GR_RTN 1u
+
+#define LC3_QOS_48_3_GR_AC(_ac) \
+	LC3_QOS_UCAST_7_5_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_3_GR_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_GR_RTN)
+#define LC3_QOS_48_3_GR LC3_QOS_48_3_GR_AC(1)
+
 #define LC3_QOS_48_4_1_LATENCY 20u
 #define LC3_QOS_48_4_1_RTN 5u
 
 #define LC3_QOS_48_4_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_4_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_4, \
 					LC3_QOS_48_4_1_RTN)
 #define LC3_QOS_48_4_1 LC3_QOS_48_4_1_AC(1)
 
@@ -579,17 +681,27 @@
 #define LC3_QOS_48_4_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_4_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_4, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_4, \
 					LC3_QOS_48_4_2_RTN)
 #define LC3_QOS_48_4_2 LC3_QOS_48_4_2_AC(1)
 
+#define LC3_QOS_48_4_GR_LATENCY 20u
+#define LC3_QOS_48_4_GR_RTN 1u
+
+#define LC3_QOS_48_4_GR_AC(_ac) \
+	LC3_QOS_UCAST_10_UNFRAMED(10000u, BT_BAP_CONFIG_LATENCY_LOW, \
+					LC3_QOS_48_4_GR_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_GR_RTN)
+#define LC3_QOS_48_4_GR LC3_QOS_48_4_GR_AC(1)
+
 #define LC3_QOS_48_5_1_LATENCY 15u
 #define LC3_QOS_48_5_1_RTN 5u
 
 #define LC3_QOS_48_5_1_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_5_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_5, \
 					LC3_QOS_48_5_1_RTN)
 #define LC3_QOS_48_5_1 LC3_QOS_48_5_1_AC(1)
 
@@ -599,7 +711,7 @@
 #define LC3_QOS_48_5_2_AC(_ac) \
 	LC3_QOS_UCAST_7_5_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_5_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_5, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_5, \
 					LC3_QOS_48_5_2_RTN)
 #define LC3_QOS_48_5_2 LC3_QOS_48_5_2_AC(1)
 
@@ -609,7 +721,7 @@
 #define LC3_QOS_48_6_1_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_6_1_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_6, \
 					LC3_QOS_48_6_1_RTN)
 #define LC3_QOS_48_6_1 LC3_QOS_48_6_1_AC(1)
 
@@ -619,6 +731,264 @@
 #define LC3_QOS_48_6_2_AC(_ac) \
 	LC3_QOS_UCAST_10_UNFRAMED(40000u, BT_BAP_CONFIG_LATENCY_BALANCED, \
 					LC3_QOS_48_6_2_LATENCY, \
-					_ac * LC3_CONFIG_FRAME_LEN_48_6, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_6, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_1_RTN)
+#define LC3_QOS_8_1_1_B LC3_QOS_8_1_1_B_AC(1)
+
+#define LC3_QOS_8_1_2_B_LATENCY 75u
+#define LC3_QOS_8_1_2_B_RTN 4u
+#define LC3_QOS_8_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_8_1_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_1, \
+					LC3_QOS_8_1_2_B_RTN)
+#define LC3_QOS_48_1_2_B LC3_QOS_48_1_2_B_AC(1)
+
+#define LC3_QOS_8_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_8_2_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_1_RTN)
+#define LC3_QOS_8_2_1_B LC3_QOS_8_2_1_B_AC(1)
+
+#define LC3_QOS_8_2_2_B_LATENCY 60u
+#define LC3_QOS_8_2_2_B_RTN 4u
+#define LC3_QOS_8_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_8_2_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_8_2, \
+					LC3_QOS_8_2_2_B_RTN)
+#define LC3_QOS_8_2_2_B LC3_QOS_8_2_2_B_AC(1)
+
+#define LC3_QOS_16_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_16_1_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_1_RTN)
+#define LC3_QOS_16_1_1_B LC3_QOS_16_1_1_B_AC(1)
+
+#define LC3_QOS_16_1_2_B_LATENCY 45u
+#define LC3_QOS_16_1_2_B_RTN 4u
+#define LC3_QOS_16_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_16_1_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_1, \
+					LC3_QOS_16_1_2_B_RTN)
+#define LC3_QOS_16_1_2_B LC3_QOS_16_1_2_B_AC(1)
+
+#define LC3_QOS_16_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_16_2_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_1_RTN)
+#define LC3_QOS_16_2_1_B LC3_QOS_16_2_1_B_AC(1)
+
+#define LC3_QOS_16_2_2_B_LATENCY 60u
+#define LC3_QOS_16_2_2_B_RTN 4u
+#define LC3_QOS_16_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_16_2_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_16_2, \
+					LC3_QOS_16_2_2_B_RTN)
+#define LC3_QOS_16_2_2_B LC3_QOS_16_2_2_B_AC(1)
+
+#define LC3_QOS_24_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_24_1_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_1_RTN)
+#define LC3_QOS_24_1_1_B LC3_QOS_24_1_1_B_AC(1)
+
+#define LC3_QOS_24_1_2_B_LATENCY 45u
+#define LC3_QOS_24_1_2_B_RTN 4u
+#define LC3_QOS_24_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_24_1_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_1, \
+					LC3_QOS_24_1_2_B_RTN)
+#define LC3_QOS_24_1_2_B LC3_QOS_24_1_2_B_AC(1)
+
+#define LC3_QOS_24_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_24_2_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_2, \
+					LC3_QOS_24_2_1_RTN)
+#define LC3_QOS_24_2_1_B LC3_QOS_24_2_1_B_AC(1)
+
+#define LC3_QOS_24_2_2_B_LATENCY 60u
+#define LC3_QOS_24_2_2_B_RTN 4u
+#define LC3_QOS_24_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_24_2_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_24_2, \
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
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_1_RTN)
+#define LC3_QOS_32_2_1_B LC3_QOS_32_2_1_B_AC(1)
+
+#define LC3_QOS_32_2_2_B_LATENCY 60u
+#define LC3_QOS_32_2_2_B_RTN 4u
+#define LC3_QOS_32_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_32_2_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_32_2, \
+					LC3_QOS_32_2_2_B_RTN)
+#define LC3_QOS_32_2_2_B LC3_QOS_32_2_2_B_AC(1)
+
+#define LC3_QOS_44_1_1_B_RTN 4u
+#define LC3_QOS_44_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_1_B_RTN)
+#define LC3_QOS_44_1_1_B LC3_QOS_44_1_1_B_AC(1)
+
+#define LC3_QOS_44_1_2_B_LATENCY 54u
+#define LC3_QOS_44_1_2_B_RTN 4u
+#define LC3_QOS_44_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_1_INTERVAL, \
+					LC3_QOS_44_1_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_1, \
+					LC3_QOS_44_1_2_B_RTN)
+#define LC3_QOS_44_1_2_B LC3_QOS_44_1_2_B_AC(1)
+
+#define LC3_QOS_44_2_1_B_RTN 4u
+#define LC3_QOS_44_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_1_B_RTN)
+#define LC3_QOS_44_2_1_B LC3_QOS_44_2_1_B_AC(1)
+
+#define LC3_QOS_44_2_2_B_LATENCY 60u
+#define LC3_QOS_44_2_2_B_RTN 4u
+#define LC3_QOS_44_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_FRAMED(40000u, LC3_QOS_44_2_INTERVAL, \
+					LC3_QOS_44_2_2_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_44_2, \
+					LC3_QOS_44_2_2_RTN)
+#define LC3_QOS_44_2_2_B LC3_QOS_44_2_2_B_AC(1)
+
+#define LC3_QOS_48_1_1_B_RTN 4u
+#define LC3_QOS_48_1_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_1_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_1,\
+					LC3_QOS_48_1_1_B_RTN)
+#define LC3_QOS_48_1_1_B LC3_QOS_48_1_1_B_AC(1)
+
+#define LC3_QOS_48_1_2_B_LATENCY 50u
+#define LC3_QOS_48_1_2_B_RTN 4u
+#define LC3_QOS_48_1_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_1_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_1, \
+					LC3_QOS_48_1_2_B_RTN)
+#define LC3_QOS_48_1_2_B LC3_QOS_48_1_2_B_AC(1)
+
+#define LC3_QOS_48_2_1_B_RTN 4u
+#define LC3_QOS_48_2_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_2_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_1_B_RTN)
+#define LC3_QOS_48_2_1_B LC3_QOS_48_2_1_B_AC(1)
+
+#define LC3_QOS_48_2_2_B_LATENCY 65u
+#define LC3_QOS_48_2_2_B_RTN 4u
+#define LC3_QOS_48_2_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_2_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_2, \
+					LC3_QOS_48_2_2_B_RTN)
+#define LC3_QOS_48_2_2_B LC3_QOS_48_2_2_B_AC(1)
+
+#define LC3_QOS_48_3_1_B_RTN 4u
+#define LC3_QOS_48_3_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_3_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_1_B_RTN)
+#define LC3_QOS_48_3_1_B LC3_QOS_48_3_1_B_AC(1)
+
+#define LC3_QOS_48_3_2_B_LATENCY 50u
+#define LC3_QOS_48_3_2_B_RTN 4u
+#define LC3_QOS_48_3_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_3_2_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_3, \
+					LC3_QOS_48_3_2_RTN)
+#define LC3_QOS_48_3_2_B LC3_QOS_48_3_2_B_AC(1)
+
+#define LC3_QOS_48_4_1_B_RTN 4u
+#define LC3_QOS_48_4_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_4_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_1_B_RTN)
+#define LC3_QOS_48_4_1_B LC3_QOS_48_4_1_B_AC(1)
+
+#define LC3_QOS_48_4_2_B_LATENCY 65u
+#define LC3_QOS_48_4_2_B_RTN 4u
+#define LC3_QOS_48_4_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_4_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_4, \
+					LC3_QOS_48_4_2_B_RTN)
+#define LC3_QOS_48_4_2_B LC3_QOS_48_4_2_B_AC(1)
+
+#define LC3_QOS_48_5_1_B_RTN 4u
+#define LC3_QOS_48_5_1_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_5_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_1_B_RTN)
+#define LC3_QOS_48_5_1_B LC3_QOS_48_5_1_B_AC(1)
+
+#define LC3_QOS_48_5_2_B_LATENCY 50u
+#define LC3_QOS_48_5_2_B_RTN 4u
+#define LC3_QOS_48_5_2_B_AC(_ac) \
+	LC3_QOS_BCAST_7_5_UNFRAMED(40000u, LC3_QOS_48_5_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_5, \
+					LC3_QOS_48_5_2_B_RTN)
+#define LC3_QOS_48_5_2_B LC3_QOS_48_5_2_B_AC(1)
+
+#define LC3_QOS_48_6_1_B_RTN 5u
+#define LC3_QOS_48_6_1_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_6_1_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_1_B_RTN)
+#define LC3_QOS_48_6_1_B LC3_QOS_48_6_1_B_AC(1)
+
+#define LC3_QOS_48_6_2_B_LATENCY 65u
+#define LC3_QOS_48_6_2_B_RTN 4u
+#define LC3_QOS_48_6_2_B_AC(_ac) \
+	LC3_QOS_BCAST_10_UNFRAMED(40000u, LC3_QOS_48_6_2_B_LATENCY, \
+					(_ac) * LC3_CONFIG_FRAME_LEN_48_6, \
+					LC3_QOS_48_6_2_B_RTN)
+#define LC3_QOS_48_6_2_B LC3_QOS_48_6_2_B_AC(1)
-- 
2.43.0

