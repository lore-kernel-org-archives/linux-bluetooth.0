Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007746537
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359054; cv=none; b=bkXzeYVudF4hywJuVLyossOp5nizKplTqcsN/oR8S1GtNZRaF1CykblsuoWZztrG62uc/fggyY8yrWckSzEh7MrArtZH5ziD6nhLMZggADiT/O+HHVYulwhTH8go1GggsCAu+fdZT0YFLGI9mPjzyDDeqUTCr/eqZu/mFkPYYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359054; c=relaxed/simple;
	bh=KkkYgXSYcPx3PZFYQwyFf1flBkRiAj4QvwNf7IT6Utw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKWm87PLKX+GJByfkSOiIxFBX29W1hZiAPoKvWOJEF+ESA4il+h+nD7PXRHQDqnBKNvbIo8LU+oBQw5xRhjL2uSXkVMLH/H//JVn53K0XjKZFUOAmPyg1V5ZLUO1JPalPoI2Dw5NTfu4JxAi9ZEKdQXuBWHk6cryHadAyfCCu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPzIQftW; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPzIQftW"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7dae66def19so116917241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359051; x=1710963851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zND5AGdO5FgvrcyAaXZw/th9OCUgQhoWphEUq6dFV0Q=;
        b=BPzIQftWEat0IC7Gci6IQRxzRA3j3ssbgL+z7aye6v1DIQzcul1vaikc679W5mp5a4
         UR8wi39iQdi9PDKIHrFDeCjtkG4XEWcJwRJmnWH2cWG0+q9rK21Gxo1DRNBIgC22LWLX
         cOd4rfsgUoInIRcs1E2sXnsxnhH+cG7xqFAxiF8Y94SmbXhQNeMJfPyW7eXNruQrd++J
         ElATvRNnQIHAcEKYhJ5L/YuSsulBTBp/G+xtIytKY0EZoDFoZRGkUwkV6D8EUPaIaCxv
         6dPiA6qFbbOsvpIQElWSUdVvYIulsdPk/HEylyqy9dhsSwc/sslrVV1xJVYFfxamCZSh
         1xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359051; x=1710963851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zND5AGdO5FgvrcyAaXZw/th9OCUgQhoWphEUq6dFV0Q=;
        b=XcWckVmJNeh5DL2Zrqaxxzgzo2inU0KFWtqLtG5kCDZROhTtZl2thXaKKrVk/MAGrG
         uyahHb9GgR6y92Me6+RPRrd29yj3NXEF73ei/twDXCQsN3VMxhJW/TXDoFtqBFKgpk4w
         nN3QHxL5O7e46qvtJ6f3LuRKJ6CB6Vd7LyVD3oGkavUCuHSJr/896tlS9bVsO8BO3pFE
         a0DtKPFtoilwaOJh6/hcdZHdlgDypdnuZVqVWc0g1ZuDSVr6D+L4k9tvVjINa1hi+QhY
         +7+c+QcpAfWxeXhlBYRhPa620vVcaE/KmqWCu+j2ZI1vP2cayexrIxfig8ZMgkysQsxv
         o8/A==
X-Gm-Message-State: AOJu0YxzxgF6u9gCxkeQU0AwFeZUnjMZ8x+qhgFWox6SK5/5UKn9+jz6
	T6B4ev8RfLvBSpuT35H5FHenEt0qtVtMp7iMUgmmgJlCLc+eNX9QC1JMV5Ah
X-Google-Smtp-Source: AGHT+IGi/3LLuzPaZ2yX6x4ypOMfPW5AoXQElY2gI2SiPjh3ziIRR+TLFY62Jlr0zc1KxWkf0A3j0g==
X-Received: by 2002:a67:b60b:0:b0:472:6673:f8ce with SMTP id d11-20020a67b60b000000b004726673f8cemr932667vsm.34.1710359051138;
        Wed, 13 Mar 2024 12:44:11 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id gd6-20020a056102624600b004730db4e873sm1800259vsb.10.2024.03.13.12.44.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:44:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] client/player: Cleanup broadcast QoS
Date: Wed, 13 Mar 2024 15:43:59 -0400
Message-ID: <20240313194400.1397477-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313194400.1397477-1-luiz.dentz@gmail.com>
References: <20240313194400.1397477-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no need to setup broadcast QoS related to PA/BIG as the kernel
already sets these settings.
---
 client/player.c | 89 +++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 54 deletions(-)

diff --git a/client/player.c b/client/player.c
index 381c5d568103..d26ff9d3a9df 100644
--- a/client/player.c
+++ b/client/player.c
@@ -94,14 +94,6 @@ struct avdtp_media_codec_capability {
 #error "Unknown byte order"
 #endif
 
-/* BAP Broadcast parameters */
-#define BCAST_SYNC_FACTOR	24			/* PA params */
-#define BCAST_OPTIONS		0x00		/* PA Create Sync */
-#define BCAST_SKIP			0x0000		/* PA Create Sync */
-#define BCAST_SYNC_TIMEOUT	0x4000		/* PA Create Sync */
-#define BCAST_SYNC_CTE_TYPE	0x00		/* PA Create Sync */
-#define BCAST_MSE			0x00		/* BIG Create Sync */
-#define BCAST_TIMEOUT		0x4000		/* BIG Create Sync */
 #define BCAST_CODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
 				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
 
@@ -1745,13 +1737,6 @@ struct endpoint_config {
 	struct iovec *meta;		/* Metadata LTVs*/
 	uint8_t target_latency;
 	struct bt_bap_qos qos;		/* BAP QOS configuration parameters */
-	uint8_t  sync_factor;		/* PA parameter */
-	uint8_t  options;		/* PA create sync parameter */
-	uint16_t skip;			/* PA create sync parameter */
-	uint16_t sync_timeout;		/* PA create sync parameter */
-	uint8_t  sync_cte_type;		/* PA create sync parameter */
-	uint8_t  mse;			/* BIG create sync parameter */
-	uint16_t timeout;		/* BIG create sync parameter */
 };
 
 static void append_io_qos(DBusMessageIter *iter, struct bt_bap_io_qos *qos)
@@ -1831,40 +1816,47 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 							&cfg->ep->iso_stream);
 	}
 
-	bt_shell_printf("SyncFactor %u\n", cfg->sync_factor);
+	if (qos->sync_factor) {
+		bt_shell_printf("SyncFactor %u\n", qos->sync_factor);
+		g_dbus_dict_append_entry(iter, "SyncFactor", DBUS_TYPE_BYTE,
+						&qos->sync_factor);
+	}
 
-	g_dbus_dict_append_entry(iter, "SyncFactor", DBUS_TYPE_BYTE,
-						&cfg->sync_factor);
+	if (qos->options) {
+		bt_shell_printf("Options %u\n", qos->options);
+		g_dbus_dict_append_entry(iter, "Options", DBUS_TYPE_BYTE,
+						&qos->options);
+	}
 
-	bt_shell_printf("Options %u\n", cfg->options);
+	if (qos->skip) {
+		bt_shell_printf("Skip %u\n", qos->skip);
+		g_dbus_dict_append_entry(iter, "Skip", DBUS_TYPE_UINT16,
+						&qos->skip);
+	}
 
-	g_dbus_dict_append_entry(iter, "Options", DBUS_TYPE_BYTE,
-						&cfg->options);
+	if (qos->sync_timeout) {
+		bt_shell_printf("SyncTimeout %u\n", qos->sync_timeout);
+		g_dbus_dict_append_entry(iter, "SyncTimeout", DBUS_TYPE_UINT16,
+						&qos->sync_timeout);
+	}
 
-	bt_shell_printf("Skip %u\n", cfg->skip);
+	if (qos->sync_cte_type) {
+		bt_shell_printf("SyncCteType %u\n", qos->sync_cte_type);
+		g_dbus_dict_append_entry(iter, "SyncCteType", DBUS_TYPE_BYTE,
+					&qos->sync_cte_type);
+	}
 
-	g_dbus_dict_append_entry(iter, "Skip", DBUS_TYPE_UINT16,
-						&cfg->skip);
+	if (qos->sync_cte_type) {
+		bt_shell_printf("MSE %u\n", qos->mse);
+		g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
+						&qos->mse);
+	}
 
-	bt_shell_printf("SyncTimeout %u\n", cfg->sync_timeout);
-
-	g_dbus_dict_append_entry(iter, "SyncTimeout", DBUS_TYPE_UINT16,
-						&cfg->sync_timeout);
-
-	bt_shell_printf("SyncCteType %u\n", cfg->sync_cte_type);
-
-	g_dbus_dict_append_entry(iter, "SyncType", DBUS_TYPE_BYTE,
-					&cfg->sync_cte_type);
-
-	bt_shell_printf("MSE %u\n", cfg->mse);
-
-	g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
-						&cfg->mse);
-
-	bt_shell_printf("Timeout %u\n", cfg->timeout);
-
-	g_dbus_dict_append_entry(iter, "Timeout", DBUS_TYPE_UINT16,
-						&cfg->timeout);
+	if (qos->timeout) {
+		bt_shell_printf("Timeout %u\n", qos->timeout);
+		g_dbus_dict_append_entry(iter, "Timeout", DBUS_TYPE_UINT16,
+						&qos->timeout);
+	}
 
 	if (cfg->ep->bcode->iov_len != 0) {
 		const char *key = "BCode";
@@ -3673,17 +3665,6 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 	iov_append(&cfg->ep->bcode, bcast_code,
 			sizeof(bcast_code));
 
-	/* Add periodic advertisement parameters */
-	cfg->sync_factor = BCAST_SYNC_FACTOR;
-	cfg->options = BCAST_OPTIONS;
-	cfg->skip = BCAST_SKIP;
-	cfg->sync_timeout = BCAST_SYNC_TIMEOUT;
-	cfg->sync_cte_type = BCAST_SYNC_CTE_TYPE;
-
-	/* Add BIG create sync parameters */
-	cfg->mse = BCAST_MSE;
-	cfg->timeout = BCAST_TIMEOUT;
-
 	if ((strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) == 0)) {
 		/* A broadcast sink endpoint config does not need
 		 * user input.
-- 
2.43.0

