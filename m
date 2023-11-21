Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0lVHOye"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97311191
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 12:14:08 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d63b733e4so3105585a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700597646; x=1701202446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=X0lVHOyecGISaBcfcD32Gb1b1LtYqD5+J3c0bCteOhW0Uc+3WOV1355RdzaZulP5W6
         PslU3OMEtvRb4SliXp7uBw2CmRS/ciO4zCWvPlC27exbT8mQoezBPApGaor8ZW4399+M
         UB0eFr4GRxbqwN5HjmIqzG8/P83gcK5WXL/t8Xj+N2kNfFoUfhhLwVr87tWWTT0w8nbl
         x6zIV5m7LLgjQUXrBsM/to+9SEn6ZucXey8GFvJ8wNE3vRRAaC8uApGHr6YC3HPjdsyZ
         VkQ0jGP2awdHzvLEnajbygAHahcPXJXDKF06lStSOHMfKYU2UEC1fSTKRe4DhnagD/BJ
         MRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700597646; x=1701202446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=e94MZiCu78A2JFxW6WGOVXTf3dfgVWZW43+CoN5xh8wvsxWX1G0DOpVtXgLdB+yOW6
         LdiADOmjeU3dR+8IGJvC2Eeb/ykCFuADCqVXAVKlcEr/N3Zmv4RmlrYpIlConazulx6t
         3K77HGemrKnPyKsxOfKk4RGO/eJmbUUGJ9VWY2uDAgAaS/Xu/Dqea/CHguI2r8ebXCTW
         j5AWPzoxaNU9GkovZ/UorPTDmYol1gf5vfyppZfiPq6z3GVrmNYU8JG5UQ60xiJnZJ71
         Gy1xqbzHux7qOUblmUP1ifbvXa1tQWrrP+i6JfqidK3FEI2eU6MLPxxf773guElH8iIo
         eOPQ==
X-Gm-Message-State: AOJu0YzhaupsjsmLCYt2x0/hO5I4lSF4BuwsqtUoXnUfAIfnx7L3sFdO
	tlT3BF6J2VzNgYQXqepToGyAlnRbqNQ8Gw==
X-Google-Smtp-Source: AGHT+IHf5VmuZm+RHVyJRb8aGMPBktbps2hGxCDJVQlRfXO9m0EXGb7bw9MM4AzINMj0lgYBPvnKOg==
X-Received: by 2002:a05:620a:2491:b0:76f:1eac:e726 with SMTP id i17-20020a05620a249100b0076f1eace726mr154738qkn.15.1700597646457;
        Tue, 21 Nov 2023 12:14:06 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a090100b0077d63ac6447sm40382qkv.109.2023.11.21.12.14.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:14:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor/att: Add GMAS attribute decoders
Date: Tue, 21 Nov 2023 15:14:02 -0500
Message-ID: <20231121201402.617067-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121201402.617067-1-luiz.dentz@gmail.com>
References: <20231121201402.617067-1-luiz.dentz@gmail.com>
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

