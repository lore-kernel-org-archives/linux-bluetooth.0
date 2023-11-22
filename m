Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9zqJzls"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB28112
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d76904928so1440756d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687252; x=1701292052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=h9zqJzlsB2IdMrXajDleCM/hhD8KdHUlXgzdultnlz16zVO1+x9kmw6ef0dybKJt9y
         8bzbM68CbOW+jVMH9SuJTNrqB1l9vN4N2ZMa9aI0caB5PQObelPxYQDUOkiLAzdxxMVh
         TnV3diLMokpJutrvLsgyiPT92EhYePT1raHW2dcpvo0SIBBs9MLtlLq1SC3uc0pBFO3v
         pEk5c7kAUkmW9+PCAem/Hdqhaw3lf5Hbtiy6QYNAwCimyewBZKdnp/V+WdyRTIzlejFZ
         hako+GA5ms3mhMaTokXTgG0Vmd607vMb0iosFQP2YteIMgyG0+fFBotljpRxTFM81xcz
         l6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687252; x=1701292052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=uftndZ11Hjqv+kr+zt5un66PCVwpBlro2sVfn9JjnO/Atb0XVjro9vZ06VSBYsA9b0
         YJH4K3GLFyzD/Q4o9d1SQjQZdsARAgscbWk89DTWr9XjkZ3Y8jqN+N0HMuXTPDHIXmyK
         mQU4wFrQO4CyJoGd88DpAe4NQ9u1f0AttvNCSQUz/no0CmdyeMFJDZAfEgYRjHpNzgCM
         hB0X2roUsL+FtgGU8mUZLMwsxaO8R+7FSWfJvMARbE9g6YtneEGJVaXtNBVJiOj2GaET
         c+15ScnpFbVUoETUEp0jIgXBs56C8XecKNT8DPKw9E0d3gaJmrYJS7oAiciULd0TvPTo
         /uCA==
X-Gm-Message-State: AOJu0YwYcOD5LIbvFJxILYTNsj3pWHtPCamCUIjk+6O2GfEXMbVJr6p1
	WhvWHjdX5ZCexkGHSMgZ8SGUFWZ0d9DaJ1kB
X-Google-Smtp-Source: AGHT+IE9UVKGPm1FdT+JLpkPweOpxIpcqF5lsgiKQcICf5zktWHhAAVyengiofMoDkGFt4gEltT/2g==
X-Received: by 2002:ad4:5763:0:b0:677:f803:8183 with SMTP id r3-20020ad45763000000b00677f8038183mr3950965qvx.64.1700687252247;
        Wed, 22 Nov 2023 13:07:32 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w2-20020a0ca802000000b006781b67abaasm94384qva.109.2023.11.22.13.07.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:07:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] monitor/att: Add GMAS attribute decoders
Date: Wed, 22 Nov 2023 16:07:24 -0500
Message-ID: <20231122210727.893872-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122210727.893872-1-luiz.dentz@gmail.com>
References: <20231122210727.893872-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GMAS attribute decoders.
---
 monitor/att.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 39ea5d6dac5a..9db273223352 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -3195,6 +3195,140 @@ static void bcast_audio_scan_cp_write(const struct l2cap_frame *frame)
 	print_bcast_audio_scan_cp_cmd(frame);
 }
 
+static const struct bitfield_data gmap_role_table[] = {
+	{  0, "Unicast Game Gateway (UGG) (0x0001)"	},
+	{  1, "Unicast Game Terminal (UGT) (0x0002)"	},
+	{  2, "Broadcast Game Sender (BGS) (0x0004)"	},
+	{  3, "Broadcast Game Receiver (BGR) (0x0008)"	},
+	{ }
+};
+
+static void gmap_role_read(const struct l2cap_frame *frame)
+{
+	uint8_t role;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &role)) {
+		print_text(COLOR_ERROR, "    invalid size");
+		return;
+	}
+
+	print_field("    Role: 0x%2.2x", role);
+
+	mask = print_bitfield(6, role, gmap_role_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+static const struct bitfield_data ugg_features_table[] = {
+	{  0, "UGG Multiplex (0x0001)"	},
+	{  1, "UGG 96 kbps Source (0x0002)"	},
+	{  2, "UGG Multilink (0x0004)"	},
+	{ }
+};
+
+static void ugg_features_read(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    invalid size");
+		return;
+	}
+
+	print_field("    Value: 0x%2.2x", value);
+
+	mask = print_bitfield(6, value, ugg_features_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+static const struct bitfield_data ugt_features_table[] = {
+	{  0, "UGT Source (0x0001)"		},
+	{  1, "UGT 80 kbps Source (0x0002)"	},
+	{  2, "UGT Sink (0x0004)"		},
+	{  3, "UGT 64 kbps Sink (0x0008)"	},
+	{  4, "UGT Multiplex (0x0010)"		},
+	{  5, "UGT Multisink (0x0020)"		},
+	{  6, "UGT Multisource (0x0040)"	},
+	{ }
+};
+
+static void ugt_features_read(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    invalid size");
+		return;
+	}
+
+	print_field("    Value: 0x%2.2x", value);
+
+	mask = print_bitfield(6, value, ugt_features_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+static const struct bitfield_data bgs_features_table[] = {
+	{  0, "BGS 96 kbps (0x0001)"		},
+	{ }
+};
+
+static void bgs_features_read(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    invalid size");
+		return;
+	}
+
+	print_field("    Value: 0x%2.2x", value);
+
+	mask = print_bitfield(6, value, bgs_features_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+static const struct bitfield_data bgr_features_table[] = {
+	{  0, "BGR Multisink (0x0001)"		},
+	{  1, "BGR Multiplex (0x0002)"		},
+	{ }
+};
+
+static void bgr_features_read(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    invalid size");
+		return;
+	}
+
+	print_field("    Value: 0x%2.2x", value);
+
+	mask = print_bitfield(6, value, bgr_features_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+#define GMAS \
+	GATT_HANDLER(0x2c00, gmap_role_read, NULL, NULL), \
+	GATT_HANDLER(0x2c01, ugg_features_read, NULL, NULL), \
+	GATT_HANDLER(0x2c02, ugt_features_read, NULL, NULL), \
+	GATT_HANDLER(0x2c02, bgs_features_read, NULL, NULL), \
+	GATT_HANDLER(0x2c03, bgr_features_read, NULL, NULL)
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -3255,6 +3389,7 @@ struct gatt_handler {
 	GATT_HANDLER(0x2bc7, NULL, bcast_audio_scan_cp_write, NULL),
 	GATT_HANDLER(0x2bc8, bcast_recv_state_read, NULL,
 					bcast_recv_state_notify),
+	GMAS
 };
 
 static struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
-- 
2.42.0

