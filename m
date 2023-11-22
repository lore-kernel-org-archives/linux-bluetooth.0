Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP9jusee"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C1383
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d708e4916so2892685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680014; x=1701284814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=aP9jusee17AgK1Mr64+3PhAfWc9WQup5UfIkMqOTtPnQcW4NogvsoMc9Ri24R3CBIf
         IwkyypKPYkogsUos5OSnnqlGl6t2Ge2vWLPFommrZ8CKeuii/niA48AHdnbnYa8YFLls
         U5OBmVIVJUG7OJ9YKdJrtL/O4+YKJuErvrHoAlwYVg7OHPboazkBZdzDo0KOJ1FLADDs
         /zXwU5N6mJmji3fQJxL+55WCQFtgp7mBrgwasuyPR9BNb4j18XWLumgWqKbvegsxqDc5
         enRD5BHQW+adKYTIUvpHRhQxGDlvMakGkS6E9wk9NLdYgNeFw3Z0a+orwGfo4MVHgavy
         NssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680014; x=1701284814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te9sdhX2UqCHf3FISEMe2Njr7WpzZXYgdE6tsK34ksk=;
        b=mgQHFCOdyY6M5RLGgauYIpJVVhAOlncAzaky7PU4MS+1Z6LCub0G5hMq3RBZxf/AaK
         nz6iOpFimXkTQit9MtksulmilbqCf4d8cSHcaxZaLxamtiKZU+qZP23Py9zAc9zfhVAP
         dLRucTXBF9IQgYcN2eQmCNNfj6DujHv14dpRmSHp4sAora0b76D5+0TiTAvAZLtNPLDM
         UyA+acY0vNcmOf3g+KsLdJoteB+z8GPqIQ6sbBJ+23qPUZsAJHpdRveoekcm5T7YXdlT
         Fwop076xaxPcZM0tN+094dKcbxPpD+sYvHcgat6Dg6heKnDQXL03BeM4GzbE//4q5OD8
         dFzA==
X-Gm-Message-State: AOJu0Yw1c95ckb+oPUhSSEPL/DVmFc2zBfqPr1NOP758ySNUqJEm0t8n
	YBDSk+O09yzsY+37VXN3v9/XRA3H88LW32QQ
X-Google-Smtp-Source: AGHT+IFElW4lPUvQcPMZfcX3xMBJFF7/gM9Mla6OBx6TmTb1yBsLmotdPXWGWGBojizUoYyCl3wXPw==
X-Received: by 2002:a05:620a:894:b0:76c:e9e1:2b2 with SMTP id b20-20020a05620a089400b0076ce9e102b2mr3099189qka.13.1700680013616;
        Wed, 22 Nov 2023 11:06:53 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b0076d25b11b62sm97885qkp.38.2023.11.22.11.06.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:06:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] monitor/att: Add GMAS attribute decoders
Date: Wed, 22 Nov 2023 14:06:46 -0500
Message-ID: <20231122190649.879386-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122190649.879386-1-luiz.dentz@gmail.com>
References: <20231122190649.879386-1-luiz.dentz@gmail.com>
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

