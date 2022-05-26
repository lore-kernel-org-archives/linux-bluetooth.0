Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBA5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 00:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiEZAjg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 20:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiEZAje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 20:39:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D5AE264
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 17:39:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so391641pjt.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 17:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BslgsBKGZNxVg2pXEhy2GHC93u0ntQzBrl2q1A/4j4=;
        b=adr5q/VunQHolufh0Y5INdqvnhKu1e28sl/NLEuQLHy1Qpy83k3mG+UHYhc2mtHgP9
         aVRPy2mkyEq6xPLR/42oYK5M6fECFInH3UmxH0zBZC6BpCsBMfZYcZTFy/9HMOpmd4PL
         a0pKmAC0aLGEtz26Xublza0vrO4/QsYZP9LwEUAiH6rzNPiJkGYpQvGLMeCmXjEzpt73
         RuSogBblNyZlLPsrqIxkweYjT9Gg5O4vbq+UlIqAgNp4t+jD8Yvd2DH1dTivaqOyjrWJ
         NAGs9jY2t8zVNtPNXQcUvEC15iA3zQhIbp2ant4S6rfWvPmXuyOIzadGMbcGLJJBbgpZ
         l3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BslgsBKGZNxVg2pXEhy2GHC93u0ntQzBrl2q1A/4j4=;
        b=makFVIPOMfnVLSX2pbwmWjRSL0n2j2Wd/d/GvT60YiTHOcTpKjAQ9gDNlZmBm4yMXP
         L65CHzjxL0zZFjZxV2yArvbUhCGsQUVNu9s4deIBayohdss7rGOqX/lGn2L+Q61xbbXQ
         YKT76b7znXaKdUaByjtGkk9hc2mfGtRXoLowipwjzHQ8jNkWRPx8v5CDAtAPyLLoFQV9
         Q3xH4nbdsESwSmbYcyEK6B6e9mMb+omt7utQDoY1DFuY/RI0EeJeL7wQXO3dmBnVDj6P
         ByhAW4i06/vaCw7ZpTIhFytDC0UxMZYWRYbsFHarJulr0cS+YPTAk9gHEEZ5KzKKO1nI
         tmOQ==
X-Gm-Message-State: AOAM531eAO7KTGqPzKgge3pV15tRlJamLmYF5AKA8cXz+3HT30KbKt2e
        480BvIFqzJut3B0/mNPgYTYmrYY8tAY=
X-Google-Smtp-Source: ABdhPJzElrUBDD2fTw/KyynTfb/i1zndJpZxYiLQ/Sr/H0xrS3167znkmezX+lY8/eBI6WB7ksGobg==
X-Received: by 2002:a17:90b:1c92:b0:1dd:10ff:8f13 with SMTP id oo18-20020a17090b1c9200b001dd10ff8f13mr13224206pjb.54.1653525570382;
        Wed, 25 May 2022 17:39:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b00162529828aesm13339plo.109.2022.05.25.17.39.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:39:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] monitor/att: Add decoding support for PAC Sink/Source
Date:   Wed, 25 May 2022 17:39:25 -0700
Message-Id: <20220526003927.3972965-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for PAC Sink/Source attributes:

 < ACL Data TX: Handle 42 flags 0x00 dlen 9
      Channel: 64 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)]
      {chan 0}
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017 Type: Sink PAC (0x2bc9)
> ACL Data RX: Handle 42 flags 0x02 dlen 31
      Channel: 65 len 27 sdu 25 [PSM 39 mode Enhanced Credit (0x81)]
      {chan 0}
        Value: 010600000000100301ff0002020302030305041e00f00000
          Number of PAC(s): 1
          PAC #0:
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x03 type 0x01
            Codec Specific Configuration: ff00
            Codec Specific Configuration #1: len 0x02 type 0x02
            Codec Specific Configuration: 03
            Codec Specific Configuration #2: len 0x02 type 0x03
            Codec Specific Configuration: 03
            Codec Specific Configuration #3: len 0x05 type 0x04
            Codec Specific Configuration: 1e00f000
---
 monitor/att.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++-
 monitor/l2cap.h  | 10 +++++-
 monitor/packet.c | 10 ++++++
 monitor/packet.h |  2 ++
 4 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index df3e65057..2b1e21d05 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -255,6 +255,96 @@ static void gatt_ccc_write(const struct l2cap_frame *frame)
 	print_ccc_value(value);
 }
 
+static void print_pac(const struct l2cap_frame *frame)
+{
+	uint8_t num = 0, i;
+
+	if (!l2cap_frame_get_u8((void *)frame, &num)) {
+		print_text(COLOR_ERROR, "Number of PAC(s): invalid size");
+		goto done;
+	}
+
+	print_field("  Number of PAC(s): %u", num);
+
+	for (i = 0; i < num; i++) {
+		uint8_t codec_id;
+		uint16_t codec_cid, codec_vid;
+		struct bt_hci_lv_data *cc;
+		struct bt_hci_lv_data *meta;
+
+		print_field("  PAC #%u:", i);
+
+		if (!l2cap_frame_get_u8((void *)frame, &codec_id)) {
+			print_text(COLOR_ERROR, "Codec: invalid size");
+			goto done;
+		}
+
+		packet_print_codec_id("    Codec", codec_id);
+
+		if (!l2cap_frame_get_le16((void *)frame, &codec_cid)) {
+			print_text(COLOR_ERROR,
+					"Codec Company ID: invalid size");
+			goto done;
+		}
+
+		if (!l2cap_frame_get_le16((void *)frame, &codec_vid)) {
+			print_text(COLOR_ERROR,
+					"Codec Vendor ID: invalid size");
+			goto done;
+		}
+
+		if (codec_id == 0xff) {
+			print_field("    Codec Company ID: %s (0x%04x)",
+						bt_compidtostr(codec_cid),
+						codec_cid);
+			print_field("    Codec Vendor ID: 0x%04x", codec_vid);
+		}
+
+		cc = l2cap_frame_pull((void *)frame, frame, sizeof(*cc));
+		if (!cc) {
+			print_text(COLOR_ERROR,
+				"Codec Specific Configuration: invalid size");
+			goto done;
+		}
+
+		if (!l2cap_frame_pull((void *)frame, frame, cc->len)) {
+			print_text(COLOR_ERROR,
+				"Codec Specific Configuration: invalid size");
+			goto done;
+		}
+
+		packet_print_ltv("    Codec Specific Configuration", cc->data,
+								cc->len);
+
+		meta = l2cap_frame_pull((void *)frame, frame, sizeof(*meta));
+		if (!meta) {
+			print_text(COLOR_ERROR, "Metadata: invalid size");
+			goto done;
+		}
+
+		if (!l2cap_frame_pull((void *)frame, frame, meta->len)) {
+			print_text(COLOR_ERROR, "Metadata: invalid size");
+			goto done;
+		}
+
+		packet_print_ltv("    Metadata", meta->data, meta->len);
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void pac_read(const struct l2cap_frame *frame)
+{
+	print_pac(frame);
+}
+
+static void pac_notify(const struct l2cap_frame *frame)
+{
+	print_pac(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -273,7 +363,9 @@ struct gatt_handler {
 	void (*notify)(const struct l2cap_frame *frame);
 } gatt_handlers[] = {
 	GATT_HANDLER(GATT_CLIENT_CHARAC_CFG_UUID, gatt_ccc_read,
-					gatt_ccc_write, NULL)
+					gatt_ccc_write, NULL),
+	GATT_HANDLER(PAC_SINK_CHRC_UUID, pac_read, NULL, pac_notify),
+	GATT_HANDLER(PAC_SOURCE_CHRC_UUID, pac_read, NULL, pac_notify),
 };
 
 static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 1daeb69be..c33d4c57f 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -48,13 +48,21 @@ static inline void l2cap_frame_clone(struct l2cap_frame *frame,
 	}
 }
 
-static inline void l2cap_frame_pull(struct l2cap_frame *frame,
+static inline void *l2cap_frame_pull(struct l2cap_frame *frame,
 				const struct l2cap_frame *source, uint16_t len)
 {
+	void *data;
+
 	l2cap_frame_clone(frame, source);
 
+	if (source->size < len)
+		return NULL;
+
+	data = (void *)frame->data;
 	frame->data = source->data + len;
 	frame->size = source->size - len;
+
+	return data;
 }
 
 static inline bool l2cap_frame_get_u8(struct l2cap_frame *frame, uint8_t *value)
diff --git a/monitor/packet.c b/monitor/packet.c
index e854c1a8e..c7739fba5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1377,6 +1377,11 @@ static void print_codec_id(const char *label, uint8_t codec)
 	print_field("%s: %s (0x%2.2x)", label, str, codec);
 }
 
+void packet_print_codec_id(const char *label, uint8_t codec)
+{
+	print_codec_id(label, codec);
+}
+
 static const struct bitfield_data codec_transport_table[] = {
 	{  0, "Codec supported over BR/EDR ACL"		},
 	{  1, "Codec supported over BR/EDR SCO and eSCO"},
@@ -3368,6 +3373,11 @@ static void print_ltv(const char *label, const uint8_t *data, uint8_t len)
 		print_hex_field(label, iov.iov_base, iov.iov_len);
 }
 
+void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len)
+{
+	print_ltv(label, data, len);
+}
+
 static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 {
 	struct iovec iov;
diff --git a/monitor/packet.h b/monitor/packet.h
index a00975eb3..97d683e3a 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -61,6 +61,8 @@ void packet_print_channel_map_lmp(const uint8_t *map);
 void packet_print_channel_map_ll(const uint8_t *map);
 void packet_print_io_capability(uint8_t capability);
 void packet_print_io_authentication(uint8_t authentication);
+void packet_print_codec_id(const char *label, uint8_t codec);
+void packet_print_ltv(const char *label, const uint8_t *data, uint8_t len);
 
 void packet_control(struct timeval *tv, struct ucred *cred,
 					uint16_t index, uint16_t opcode,
-- 
2.35.1

