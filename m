Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 00:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiFQAuE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFQAuC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 20:50:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755EA62215
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2855352pjh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=quKHrfAloY3WsrO87VOSJq46tjw5gmCo6dq5cjf6nDg=;
        b=QDMv41xbXX/1q9DMnknODD8mDoTTdppB8/ixPgsQ2sQXVoSbsxv4TBuWTQa3NUryp3
         9I6LlCP5CQP6D7Q1IK40XtYE8uOpqeU2OJ6RrWUyxxuxxtePWNpMDNDkrioTqXEjbbj7
         NLN6lkZr6jrjggMRhl71gQUy4yl29jdEybEPLfZjqu9vw+hAF7ltQ4mEEisYt8PGA0uY
         +u9iYD9KDPCLDBMCnZFhFzlk0il3BRuMW6Zq8pk+KgmsfgQPSAxeqy4EVciqrpNpKwYq
         tW1BRRm8Vtn0gtS97dNwe0f7aaa7XblzohNWJzqevkQyxjQlqwRmUQvA2HCN672mlygn
         indQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quKHrfAloY3WsrO87VOSJq46tjw5gmCo6dq5cjf6nDg=;
        b=t5QO+7LGg0HH06r73EB6vPgcSyEmtCEKSkBsiehiQPHuksZJi38FlOS3YpQDT1HjeQ
         i/c13KtP4lEQTWQpUALKBHNdNqiRxoXvH6Dmgdc6SFrWJkFlerCKfL1ZLGL3ZGvj+nNY
         X7sEFn0wKG416vSzvqpRyiTPBS9evGqT7fYOG5bb3BV0SSOSeZpfppk1CTk91N+QWZRc
         rc8UsaCUq65vtxjftR42pEdOFEXKWjcYcmdyvT4vyZ3H+e1WsP7S/778onMknvwKpveP
         MK9/+N0l4mS9N0lYXUAA9PQypSqFXRk2QshReaJrxSZWG/jo+asWvUIv7gVzDvN42Ewh
         /3Uw==
X-Gm-Message-State: AJIora90chdfzgC5w58Mnfb8yGi/nqk450wcWVvHYduhn2LuAR8+04dQ
        UQEG8CtqhUtHXHgA4nBZ3AkjI5fVe60=
X-Google-Smtp-Source: AGRyM1vgd7anUgQRcZDJ62THgYGJivBuBB0gPSiVeCafTCtNowaiGAquIRkSv/Yvhj9ngi7YwVUeVg==
X-Received: by 2002:a17:902:7102:b0:168:dcbe:7c50 with SMTP id a2-20020a170902710200b00168dcbe7c50mr7263151pll.116.1655427000402;
        Thu, 16 Jun 2022 17:50:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b0015e8d4eb25asm338996plq.164.2022.06.16.17.49.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:49:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] monitor/att: Add decoding support for PAC Sink/Source Location
Date:   Thu, 16 Jun 2022 17:49:55 -0700
Message-Id: <20220617004957.1148939-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617004957.1148939-1-luiz.dentz@gmail.com>
References: <20220617004957.1148939-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for PAC Sink/Source Location attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Request (0x0a) len 2
        Handle: 0x001a Type: Sink Audio Locations (0x2bca)
< ACL Data TX: Handle 42 flags 0x00 dlen 11
      Channel: 64 len 7 sdu 5 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 4
        Value: 03000000
        Handle: 0x001a Type: Sink Audio Locations (0x2bca)
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)
---
 monitor/att.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 34babac6b..8b47cbd9f 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1050,6 +1050,74 @@ static void ase_cp_notify(const struct l2cap_frame *frame)
 	print_ase_cp_rsp(frame);
 }
 
+static const struct bitfield_data pac_loc_table[] = {
+	{  0, "Front Left (0x00000001)"			},
+	{  1, "Front Right (0x00000002)"		},
+	{  2, "Front Center (0x00000004)"		},
+	{  3, "Low Frequency Effects 1 (0x00000008)"	},
+	{  4, "Back Left (0x00000010)"			},
+	{  5, "Back Right (0x00000020)"			},
+	{  6, "Front Left of Center (0x00000040)"	},
+	{  7, "Front Right of Center (0x00000080)"	},
+	{  8, "Back Center (0x00000100)"		},
+	{  9, "Low Frequency Effects 2 (0x00000200)"	},
+	{  10, "Side Left (0x00000400)"			},
+	{  11, "Side Right (0x00000800)"		},
+	{  12, "Top Front Left (0x00001000)"		},
+	{  13, "Top Front Right (0x00002000)"		},
+	{  14, "Top Front Center (0x00004000)"		},
+	{  15, "Top Center (0x00008000)"		},
+	{  16, "Top Back Left (0x00010000)"		},
+	{  17, "Top Back Right (0x00020000)"		},
+	{  18, "Top Side Left (0x00040000)"		},
+	{  19, "Top Side Right (0x00080000)"		},
+	{  20, "Top Back Center (0x00100000)"		},
+	{  21, "Bottom Front Center (0x00200000)"	},
+	{  22, "Bottom Front Left (0x00400000)"		},
+	{  23, "Bottom Front Right (0x00800000)"	},
+	{  24, "Front Left Wide (0x01000000)"		},
+	{  25, "Front Right Wide (0x02000000)"		},
+	{  26, "Left Surround (0x04000000)"		},
+	{  27, "Right Surround (0x08000000)"		},
+	{  28, "RFU (0x10000000)"			},
+	{  29, "RFU (0x20000000)"			},
+	{  30, "RFU (0x40000000)"			},
+	{  31, "RFU (0x80000000)"			},
+	{ }
+};
+
+static void print_loc_pac(const struct l2cap_frame *frame)
+{
+	uint32_t value;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_le32((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "    value: invalid size");
+		goto done;
+	}
+
+	print_field("  Location: 0x%8.8x", value);
+
+	mask = print_bitfield(4, value, pac_loc_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void pac_loc_read(const struct l2cap_frame *frame)
+{
+	print_loc_pac(frame);
+}
+
+static void pac_loc_notify(const struct l2cap_frame *frame)
+{
+	print_loc_pac(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -1072,7 +1140,9 @@ struct gatt_handler {
 	GATT_HANDLER(0x2bc5, ase_read, NULL, ase_notify),
 	GATT_HANDLER(0x2bc6, NULL, ase_cp_write, ase_cp_notify),
 	GATT_HANDLER(0x2bc9, pac_read, NULL, pac_notify),
+	GATT_HANDLER(0x2bca, pac_loc_read, NULL, pac_loc_notify),
 	GATT_HANDLER(0x2bcb, pac_read, NULL, pac_notify),
+	GATT_HANDLER(0x2bcc, pac_loc_read, NULL, pac_loc_notify),
 };
 
 static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
-- 
2.35.3

