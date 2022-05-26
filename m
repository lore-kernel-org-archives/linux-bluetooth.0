Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E6CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiEZU7m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiEZU7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 16:59:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13279E7328
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c65so2099772pfb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rt575DNIJ8qNZ0PTyIh3GV4R6BBDs4YiRzQg+HefwxM=;
        b=Ujxepr8IfTq4CHX1390sYEBxbnKxdhJixw42orkd+QKWJJ5CQ0PiLEaJ+cl6ugJFqa
         4N/Y3MLuFoZ+QWozc0j8VlxXuf6ad8EIXPoquDMxrXfPkxBLOba4myyScsvd2OgnruSE
         ttteZVwl3FYeS8g0qtd/lfJA0mayZE/2AYlIG7Pr9S/Mo/EbyupVaQlZGN3wGgC5BzuA
         I6Nm01eEHGHpxTAdN9N8zVNGJMHNC1HVBa6keHu/SAdgjo2ilw4S4UaRS9nq1pRpQ1iH
         56agk3h2wejG+ZQFkDo/HzqyiKRYCQRKTQArMcNuNXKm39CZLtoFeMZpOBeStUmzlpYo
         sOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rt575DNIJ8qNZ0PTyIh3GV4R6BBDs4YiRzQg+HefwxM=;
        b=d47raXqGdze7DXH4UP8tVneGhab8fymnWXExnVoHeFeqrRtCfSu79enggL9OYt28Nx
         AGgv9ocIiXV7KPuEt8NnSoMGc4wUYnQDKPoxy2aSTat9iFMG8f1SAdb3YegUTEsAiZPa
         jyrd7w8/kR6URrvuOpPlxFcHIigXByfHS+Dx6Co46Y18Gz5oxwRj0bUQZGWCE1tP116b
         BAtL2hJ02//B/nASktC4KTgd2YdEMAb0HIIE6AdMqdC6BZLX729fFY26SJPu6lKDz0OV
         gd11r3fqu3K9li+KGD/bPiTjk9XHwQVvkM7eRKzJTva8TltzaocJAt0Y4ylD0sWvqaMe
         GyPw==
X-Gm-Message-State: AOAM531VpJ68zHj1iPAzs5RKubpGVdiKZoYTSgtwreLc+AQIufX2kfwq
        lDybBjeB3dmSGhZd7VvRPxt5DSjLNpY=
X-Google-Smtp-Source: ABdhPJyWOuF3TbcGXM0HjCfA3f+KmWdWjuqWZaPwbU7nQl3AlY4NAIKJSwJdTuBuj5PdmukBYcJ2KQ==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr34222035pgu.30.1653598779147;
        Thu, 26 May 2022 13:59:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015e8d4eb25bsm2080064plg.165.2022.05.26.13.59.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:59:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] monitor/att: Add decoding support for PAC Sink/Source
Date:   Thu, 26 May 2022 13:59:35 -0700
Message-Id: <20220526205937.4159665-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526205937.4159665-1-luiz.dentz@gmail.com>
References: <20220526205937.4159665-1-luiz.dentz@gmail.com>
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
 monitor/att.c    | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/l2cap.h  | 10 +++++-
 monitor/packet.c | 10 ++++++
 monitor/packet.h |  2 ++
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index 0223af210..de27ee42c 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -247,6 +247,96 @@ static void ccc_write(const struct l2cap_frame *frame)
 	print_ccc_value(frame);
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
@@ -265,6 +355,8 @@ struct gatt_handler {
 	void (*notify)(const struct l2cap_frame *frame);
 } gatt_handlers[] = {
 	GATT_HANDLER(0x2902, ccc_read, ccc_write, NULL),
+	GATT_HANDLER(0x2bc9, pac_read, NULL, pac_notify),
+	GATT_HANDLER(0x2bcb, pac_read, NULL, pac_notify),
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

