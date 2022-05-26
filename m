Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiEZU7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 16:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiEZU7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 16:59:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67BE7328
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a17so2448688plb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X65r6hR3vAP/IZaizNOL3lQnjdFm2a7gMNwJvuzqbK0=;
        b=XP0JC8x/88oMicKngrikucMjUQuYD5DrlViLJVuvJq9dLdb6K9k27UFwQ1vMqD65k5
         op+7FZq+OtGtQad30P/r4mHeyMk6s9/tCwzZ0Q+R3iXHOIcfeZ55X17BVMRxgtAqlXeV
         nQa8VIOls2gom6+pi55ZGBFHJuDUPbjNnRpubzCb3m49uug2f3JH3EgBwCk4A4qNOXXQ
         rkzwc4GK4WuC/gLh7wvM+GyUBOMPjCxzpW/c+UkhU3uSGAAIy5gLlsnyQvEkX8+fCCT0
         +5oRbPPRZrV+yKAp3+4vyHg27o/b33XoWn5Wp7sVgQcDD3LM1jj8G+AxC08ukYY+xxmj
         nHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X65r6hR3vAP/IZaizNOL3lQnjdFm2a7gMNwJvuzqbK0=;
        b=Ia5D5FpNvJI1ML3W4v7BGrsG32oTmhekd85fJk6+h7mV4iSQ8LZZmuBW/ob0zWuLea
         eoS8eXKpVHCZ4XDa2JoBArWQIaJqDWufavkAyW1MhNCn6kmKvZ4h0zp5csAtI/7j82ZS
         0iwtOv811kbVYR21/KAHP18wzguTXjRNCjCOA5wMaGmuSHd6CImxUQmzwfHo21sSb+y3
         qKawpYAqmgC4jgF/IhRO68XobFo1KlOqYAAgbtM6QaFfDSVrhPXvUWauVf8awfTxSWaO
         mZoG/HjQudmUGfuKtSGi+jB0Z852lq9kV3XutSLRau7JMjAcefqZIvtD9R/Rar4sBmPi
         1kqg==
X-Gm-Message-State: AOAM531vBdZvOHLPLNwEZoFWIW+dSeEyW655i469OGnrVb/LIS5EA7FE
        rW41pyaw3CzEGoa4Uux8vB5fRsc9ZJg=
X-Google-Smtp-Source: ABdhPJxbtM19/r3+1DQfgOh4iymTNalkSdX13dBAg2qeSgUuYhw0sw7tnEI1lmeKw0FTaIWbtsdRiw==
X-Received: by 2002:a17:902:e741:b0:163:62e2:6f04 with SMTP id p1-20020a170902e74100b0016362e26f04mr8532919plf.0.1653598781336;
        Thu, 26 May 2022 13:59:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015e8d4eb25bsm2080064plg.165.2022.05.26.13.59.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:59:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] monitor/att: Add decoding support for ASE Control Point
Date:   Thu, 26 May 2022 13:59:37 -0700
Message-Id: <20220526205937.4159665-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220526205937.4159665-1-luiz.dentz@gmail.com>
References: <20220526205937.4159665-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for ASE Control Point attribute:

> ACL Data RX: Handle 42 flags 0x02 dlen 30
      Channel: 64 len 26 sdu 24 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Write Command (0x52) len 23
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 010103020206000000000a02010302020103042800
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x02 type 0x01
            Codec Specific Configuration: 03
            Codec Specific Configuration #1: len 0x02 type 0x02
            Codec Specific Configuration: 01
            Codec Specific Configuration #2: len 0x03 type 0x04
            Codec Specific Configuration: 2800
< ACL Data TX: Handle 42 flags 0x00 dlen 55
      Channel: 64 len 51 sdu 49 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Handle Multiple Value Notification (0x23) len 48
        Length: 0x0005
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 0101030000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
> ACL Data RX: Handle 42 flags 0x02 dlen 27
      Channel: 64 len 23 sdu 21 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Write Command (0x52) len 20
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 020103000010270000022800020a00409c00
            Opcode: QoS Configuration (0x02)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            CIG ID: 0x00
            CIS ID: 0x00
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 40
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us
< ACL Data TX: Handle 42 flags 0x00 dlen 37
      Channel: 64 len 33 sdu 31 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Handle Multiple Value Notification (0x23) len 30
        Length: 0x0005
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 0201030000
            Opcode: QoS Configuration (0x02)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
> ACL Data RX: Handle 42 flags 0x02 dlen 17
      Channel: 64 len 13 sdu 11 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Write Command (0x52) len 10
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 0301030403020200
            Opcode: Enable (0x03)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            Metadata #0: len 0x03 type 0x02
            Metadata: 0200
< ACL Data TX: Handle 42 flags 0x00 dlen 33
      Channel: 64 len 29 sdu 27 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Handle Multiple Value Notification (0x23) len 26
        Length: 0x0005
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 0301030000
            Opcode: Enable (0x03)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
> ACL Data RX: Handle 42 flags 0x02 dlen 12
      Channel: 64 len 8 sdu 6 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Write Command (0x52) len 5
        Handle: 0x0030 Type: ASE Control Point (0x2bc6)
          Data: 050101
            Opcode: Disable (0x05)
            Number of ASE(s): 1
---
 monitor/att.c | 773 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 588 insertions(+), 185 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index b39ac5a49..152a5f320 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -247,7 +247,7 @@ static void ccc_write(const struct l2cap_frame *frame)
 	print_ccc_value(frame);
 }
 
-static bool print_codec(const struct l2cap_frame *frame)
+static bool print_ase_codec(const struct l2cap_frame *frame)
 {
 	uint8_t codec_id;
 	uint16_t codec_cid, codec_vid;
@@ -279,6 +279,36 @@ static bool print_codec(const struct l2cap_frame *frame)
 	return true;
 }
 
+static bool print_ase_lv(const struct l2cap_frame *frame, const char *label)
+{
+	struct bt_hci_lv_data *lv;
+
+	lv = l2cap_frame_pull((void *)frame, frame, sizeof(*lv));
+	if (!lv) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	if (!l2cap_frame_pull((void *)frame, frame, lv->len)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	packet_print_ltv(label, lv->data, lv->len);
+
+	return true;
+}
+
+static bool print_ase_cc(const struct l2cap_frame *frame)
+{
+	return print_ase_lv(frame, "    Codec Specific Configuration");
+}
+
+static bool print_ase_metadata(const struct l2cap_frame *frame)
+{
+	return print_ase_lv(frame, "    Metadata");
+}
+
 static void print_pac(const struct l2cap_frame *frame)
 {
 	uint8_t num = 0, i;
@@ -291,42 +321,16 @@ static void print_pac(const struct l2cap_frame *frame)
 	print_field("  Number of PAC(s): %u", num);
 
 	for (i = 0; i < num; i++) {
-		struct bt_hci_lv_data *cc;
-		struct bt_hci_lv_data *meta;
-
 		print_field("  PAC #%u:", i);
 
-		if (!print_codec(frame))
+		if (!print_ase_codec(frame))
 			goto done;
 
-		cc = l2cap_frame_pull((void *)frame, frame, sizeof(*cc));
-		if (!cc) {
-			print_text(COLOR_ERROR,
-				"Codec Specific Configuration: invalid size");
-			goto done;
-		}
+		if (!print_ase_cc(frame))
+			break;
 
-		if (!l2cap_frame_pull((void *)frame, frame, cc->len)) {
-			print_text(COLOR_ERROR,
-				"Codec Specific Configuration: invalid size");
-			goto done;
-		}
-
-		packet_print_ltv("    Codec Specific Configuration", cc->data,
-								cc->len);
-
-		meta = l2cap_frame_pull((void *)frame, frame, sizeof(*meta));
-		if (!meta) {
-			print_text(COLOR_ERROR, "Metadata: invalid size");
-			goto done;
-		}
-
-		if (!l2cap_frame_pull((void *)frame, frame, meta->len)) {
-			print_text(COLOR_ERROR, "Metadata: invalid size");
-			goto done;
-		}
-
-		packet_print_ltv("    Metadata", meta->data, meta->len);
+		if (!print_ase_metadata(frame))
+			break;
 	}
 
 done:
@@ -344,20 +348,28 @@ static void pac_notify(const struct l2cap_frame *frame)
 	print_pac(frame);
 }
 
-static void print_prefer_framing(uint8_t value)
+static bool print_prefer_framing(const struct l2cap_frame *frame)
 {
-	switch (value) {
-	case 0x00:
-		print_field("    Framing: Unframed ISOAL PDUs supported "
-							"(0x%2.2x)", value);
-		return;
-	case 0x01:
-		print_field("    Framing: Unframed ISOAL PDUs not supported "
-							"(0x%2.2x)", value);
-		return;
-	default:
-		print_field("    Framing: Reserved (0x%2.2x)", value);
+	uint8_t framing;
+
+	if (!l2cap_frame_get_u8((void *)frame, &framing)) {
+		print_text(COLOR_ERROR, "    Framing: invalid size");
+		return false;
 	}
+
+	switch (framing) {
+	case 0x00:
+		print_field("    Framing: Unframed PDUs supported (0x00)");
+		break;
+	case 0x01:
+		print_field("    Framing: Unframed PDUs not supported (0x01)");
+		break;
+	default:
+		print_field("    Framing: Reserved (0x%2.2x)", framing);
+		break;
+	}
+
+	return true;
 }
 
 static const struct bitfield_data prefer_phy_table[] = {
@@ -367,112 +379,122 @@ static const struct bitfield_data prefer_phy_table[] = {
 	{ }
 };
 
-static void print_prefer_phy(uint8_t phy)
+static bool print_prefer_phy(const struct l2cap_frame *frame)
 {
-	uint8_t mask;
+	uint8_t phy, mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &phy)) {
+		print_text(COLOR_ERROR, "PHY: invalid size");
+		return false;
+	}
+
+	print_field("    PHY: 0x%2.2x", phy);
 
 	mask = print_bitfield(4, phy, prefer_phy_table);
 	if (mask)
 		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
 								mask);
+
+	return true;
+}
+
+static bool print_ase_rtn(const struct l2cap_frame *frame, const char *label)
+{
+	uint8_t rtn;
+
+	if (!l2cap_frame_get_u8((void *)frame, &rtn)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: %u", label, rtn);
+
+	return true;
+}
+
+static bool print_ase_latency(const struct l2cap_frame *frame,
+						const char *label)
+{
+	uint16_t latency;
+
+	if (!l2cap_frame_get_le16((void *)frame, &latency)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: %u", label, latency);
+
+	return true;
+}
+
+static bool print_ase_pd(const struct l2cap_frame *frame, const char *label)
+{
+	uint32_t pd;
+
+	if (!l2cap_frame_get_le24((void *)frame, &pd)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: %u us", label, pd);
+
+	return true;
 }
 
 static void print_ase_config(const struct l2cap_frame *frame)
 {
-	uint8_t framing, phy, rtn;
-	uint16_t latency;
-	uint32_t pd_min, pd_max, ppd_min, ppd_max;
-	struct bt_hci_lv_data *cc;
-
-	if (!l2cap_frame_get_u8((void *)frame, &framing)) {
-		print_text(COLOR_ERROR, "Framing: invalid size");
-		return;
-	}
-
-	print_prefer_framing(framing);
-
-	if (!l2cap_frame_get_u8((void *)frame, &phy)) {
-		print_text(COLOR_ERROR, "PHY: invalid size");
-		return;
-	}
-
-	print_prefer_phy(phy);
-
-	if (!l2cap_frame_get_u8((void *)frame, &rtn)) {
-		print_text(COLOR_ERROR, "RTN: invalid size");
-		return;
-	}
-
-	print_field("    RTN: %u", rtn);
-
-	if (!l2cap_frame_get_le16((void *)frame, &latency)) {
-		print_text(COLOR_ERROR, "RTN: invalid size");
-		return;
-	}
-
-	print_field("    Max Transport Latency: %u ms", latency);
-
-	if (!l2cap_frame_get_le24((void *)frame, &pd_min)) {
-		print_text(COLOR_ERROR, "Presentation Delay Min: invalid size");
-		return;
-	}
-
-	print_field("    Presentation Delay Min: %u us", pd_min);
-
-	if (!l2cap_frame_get_le24((void *)frame, &pd_max)) {
-		print_text(COLOR_ERROR, "Presentation Delay Max: invalid size");
-		return;
-	}
-
-	print_field("    Presentation Delay Max: %u us", pd_max);
-
-	if (!l2cap_frame_get_le24((void *)frame, &ppd_min)) {
-		print_text(COLOR_ERROR,
-			"Preferred Presentation Delay Min: invalid size");
-		return;
-	}
-
-	print_field("    Preferred Presentation Delay Min: %u us", ppd_min);
-
-	if (!l2cap_frame_get_le24((void *)frame, &ppd_max)) {
-		print_text(COLOR_ERROR,
-			"Preferred Presentation Delay Max: invalid size");
-		return;
-	}
-
-	print_field("    Preferred Presentation Delay Max: %u us", ppd_max);
-
-	if (!print_codec(frame))
+	if (!print_prefer_framing(frame))
 		return;
 
-	cc = l2cap_frame_pull((void *)frame, frame, sizeof(*cc));
-	if (!cc) {
-		print_text(COLOR_ERROR,
-				"Codec Specific Configuration: invalid size");
+	if (!print_prefer_phy(frame))
 		return;
-	}
 
-	if (!l2cap_frame_pull((void *)frame, frame, cc->len)) {
-		print_text(COLOR_ERROR,
-				"Codec Specific Configuration: invalid size");
+	if (!print_ase_rtn(frame, "    RTN"))
 		return;
-	}
 
-	packet_print_ltv("    Codec Specific Configuration", cc->data, cc->len);
+	if (!print_ase_latency(frame, "    Max Transport Latency"))
+		return;
+
+	if (!print_ase_pd(frame, "    Presentation Delay Min"))
+		return;
+
+	if (!print_ase_pd(frame, "    Presentation Delay Max"))
+		return;
+
+	if (!print_ase_pd(frame, "    Preferred Presentation Delay Min"))
+		return;
+
+	if (!print_ase_pd(frame, "    Preferred Presentation Delay Max"))
+		return;
+
+	if (!print_ase_codec(frame))
+		return;
+
+	print_ase_cc(frame);
 }
 
-static void print_framing(uint8_t value)
+static bool print_ase_framing(const struct l2cap_frame *frame,
+						const char *label)
 {
-	switch (value) {
+	uint8_t framing;
+
+	if (!l2cap_frame_get_u8((void *)frame, &framing)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	switch (framing) {
 	case 0x00:
-		print_field("    Framing: Unframed (0x%2.2x)", value);
+		print_field("%s: Unframed (0x00)", label);
 		break;
 	case 0x01:
-		print_field("    Framing: Framed (0x%2.2x)", value);
+		print_field("%s: Framed (0x01)", label);
 		break;
 	default:
-		print_field("    Framing: Reserved (0x%2.2x)", value);
+		print_field("%s: Reserved (0x%2.2x)", label, framing);
 	}
+
+	return true;
 }
 
 static const struct bitfield_data phy_table[] = {
@@ -482,100 +504,92 @@ static const struct bitfield_data phy_table[] = {
 	{ }
 };
 
-static void print_phy(uint8_t phy)
+static bool print_ase_phy(const struct l2cap_frame *frame, const char *label)
 {
-	uint8_t mask;
+	uint8_t phy, mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &phy)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: 0x%2.2x", label, phy);
 
 	mask = print_bitfield(4, phy, phy_table);
 	if (mask)
 		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
 								mask);
+
+	return true;
+}
+
+static bool print_ase_interval(const struct l2cap_frame *frame,
+						const char *label)
+{
+	uint32_t interval;
+
+	if (!l2cap_frame_get_le24((void *)frame, &interval)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: %u usec", label, interval);
+
+	return true;
+}
+
+static bool print_ase_sdu(const struct l2cap_frame *frame, const char *label)
+{
+	uint16_t sdu;
+
+	if (!l2cap_frame_get_le16((void *)frame, &sdu)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	print_field("%s: %u", label, sdu);
+
+	return true;
 }
 
 static void print_ase_qos(const struct l2cap_frame *frame)
 {
-	uint8_t framing, phy, rtn;
-	uint16_t sdu, latency;
-	uint32_t interval, pd;
-
 	if (!l2cap_frame_print_u8((void *)frame, "    CIG ID"))
 		return;
 
 	if (!l2cap_frame_print_u8((void *)frame, "    CIS ID"))
 		return;
 
-	if (!l2cap_frame_get_le24((void *)frame, &interval)) {
-		print_text(COLOR_ERROR, "SDU Interval: invalid size");
+	if (!print_ase_interval(frame, "    SDU Interval"))
 		return;
-	}
 
-	print_field("    SDU Interval: %u us", interval);
-
-	if (!l2cap_frame_get_u8((void *)frame, &framing)) {
-		print_text(COLOR_ERROR, "Framing: invalid size");
+	if (!print_ase_framing(frame, "    Framing"))
 		return;
-	}
 
-	print_framing(framing);
-
-	if (!l2cap_frame_get_u8((void *)frame, &phy)) {
-		print_text(COLOR_ERROR, "PHY: invalid size");
+	if (!print_ase_phy(frame, "    PHY"))
 		return;
-	}
 
-	print_phy(phy);
-
-	if (!l2cap_frame_get_le16((void *)frame, &sdu)) {
-		print_text(COLOR_ERROR, "Max SDU: invalid size");
+	if (!print_ase_sdu(frame, "    Max SDU"))
 		return;
-	}
 
-	print_field("    Max SDU: %u", sdu);
-
-	if (!l2cap_frame_get_u8((void *)frame, &rtn)) {
-		print_text(COLOR_ERROR, "RTN: invalid size");
+	if (!print_ase_rtn(frame, "    RTN"))
 		return;
-	}
 
-	print_field("    RTN: %u", rtn);
-
-	if (!l2cap_frame_get_le16((void *)frame, &latency)) {
-		print_text(COLOR_ERROR, "Max Transport Latency: invalid size");
+	if (!print_ase_latency(frame, "    Max Transport Latency"))
 		return;
-	}
 
-	print_field("    Max Transport Latency: %u", sdu);
-
-	if (!l2cap_frame_get_le24((void *)frame, &pd)) {
-		print_text(COLOR_ERROR, "Presentation Delay: invalid size");
-		return;
-	}
-
-	print_field("    Presentation Delay: %u us", pd);
+	print_ase_pd(frame, "    Presentation Delay");
 }
 
-static void print_ase_metadata(const struct l2cap_frame *frame)
+static void print_ase_metadata_status(const struct l2cap_frame *frame)
 {
-	struct bt_hci_lv_data *meta;
-
 	if (!l2cap_frame_print_u8((void *)frame, "    CIG ID"))
 		return;
 
 	if (!l2cap_frame_print_u8((void *)frame, "    CIS ID"))
 		return;
 
-	meta = l2cap_frame_pull((void *)frame, frame, sizeof(*meta));
-	if (!meta) {
-		print_text(COLOR_ERROR, "Metadata: invalid size");
-		return;
-	}
-
-	if (!l2cap_frame_pull((void *)frame, frame, meta->len)) {
-		print_text(COLOR_ERROR, "Metadata: invalid size");
-		return;
-	}
-
-	packet_print_ltv("    Metadata", meta->data, meta->len);
+	print_ase_metadata(frame);
 }
 
 static void print_ase_status(const struct l2cap_frame *frame)
@@ -612,17 +626,17 @@ static void print_ase_status(const struct l2cap_frame *frame)
 	/* ASE_Status = 0x03 (Enabling) */
 	case 0x03:
 		print_field("    State: Enabling (0x03)");
-		print_ase_metadata(frame);
+		print_ase_metadata_status(frame);
 		break;
 	/* ASE_Status = 0x04 (Streaming) */
 	case 0x04:
 		print_field("    State: Streaming (0x04)");
-		print_ase_metadata(frame);
+		print_ase_metadata_status(frame);
 		break;
 	/* ASE_Status = 0x05 (Disabling) */
 	case 0x05:
 		print_field("    State: Disabling (0x05)");
-		print_ase_metadata(frame);
+		print_ase_metadata_status(frame);
 		break;
 	/* ASE_Status = 0x06 (Releasing) */
 	case 0x06:
@@ -648,6 +662,394 @@ static void ase_notify(const struct l2cap_frame *frame)
 	print_ase_status(frame);
 }
 
+static bool print_ase_target_latency(const struct l2cap_frame *frame)
+{
+	uint8_t latency;
+
+	if (!l2cap_frame_get_u8((void *)frame, &latency)) {
+		print_text(COLOR_ERROR, "    Target Latency: invalid size");
+		return false;
+	}
+
+	switch (latency) {
+	case 0x01:
+		print_field("    Target Latency: Low Latency (0x01)");
+		break;
+	case 0x02:
+		print_field("    Target Latency: Balance Latency/Reliability "
+								"(0x02)");
+		break;
+	case 0x03:
+		print_field("    Target Latency: High Reliability (0x03)");
+		break;
+	default:
+		print_field("    Target Latency: Reserved (0x%2.2x)", latency);
+		break;
+	}
+
+	return true;
+}
+
+static bool ase_config_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	if (!print_ase_target_latency(frame))
+		return false;
+
+	if (!print_ase_phy(frame, "    PHY"))
+		return false;
+
+	if (!print_ase_codec(frame))
+		return false;
+
+	if (!print_ase_cc(frame))
+		return false;
+
+	return true;
+}
+
+static bool ase_qos_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	if (!l2cap_frame_print_u8((void *)frame, "    CIG ID"))
+		return false;
+
+	if (!l2cap_frame_print_u8((void *)frame, "    CIS ID"))
+		return false;
+
+	if (!print_ase_interval(frame, "    SDU Interval"))
+		return false;
+
+	if (!print_ase_framing(frame, "    Framing"))
+		return false;
+
+	if (!print_ase_phy(frame, "    PHY"))
+		return false;
+
+	if (!print_ase_sdu(frame, "    Max SDU"))
+		return false;
+
+	if (!print_ase_rtn(frame, "    RTN"))
+		return false;
+
+	if (!print_ase_latency(frame, "    Max Transport Latency"))
+		return false;
+
+	if (!print_ase_pd(frame, "    Presentation Delay"))
+		return false;
+
+	return true;
+}
+
+static bool ase_enable_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	if (!print_ase_metadata(frame))
+		return false;
+
+	return true;
+}
+
+static bool ase_start_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	return true;
+}
+
+static bool ase_disable_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	return true;
+}
+
+static bool ase_stop_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	return true;
+}
+
+static bool ase_metadata_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	if (!print_ase_metadata(frame))
+		return false;
+
+	return true;
+}
+
+static bool ase_release_cmd(const struct l2cap_frame *frame)
+{
+	if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+		return false;
+
+	return true;
+}
+
+#define ASE_CMD(_op, _desc, _func) \
+[_op] = { \
+	.desc = _desc, \
+	.func = _func, \
+}
+
+struct ase_cmd {
+	const char *desc;
+	bool (*func)(const struct l2cap_frame *frame);
+} ase_cmd_table[] = {
+	/* Opcode = 0x01 (Codec Configuration) */
+	ASE_CMD(0x01, "Codec Configuration", ase_config_cmd),
+	/* Opcode = 0x02 (QoS Configuration) */
+	ASE_CMD(0x02, "QoS Configuration", ase_qos_cmd),
+	/* Opcode = 0x03 (Enable) */
+	ASE_CMD(0x03, "Enable", ase_enable_cmd),
+	/* Opcode = 0x04 (Receiver Start Ready) */
+	ASE_CMD(0x04, "Receiver Start Ready", ase_start_cmd),
+	/* Opcode = 0x05 (Disable) */
+	ASE_CMD(0x05, "Disable", ase_disable_cmd),
+	/* Opcode = 0x06 (Receiver Stop Ready) */
+	ASE_CMD(0x06, "Receiver Stop Ready", ase_stop_cmd),
+	/* Opcode = 0x07 (Update Metadata) */
+	ASE_CMD(0x07, "Update Metadata", ase_metadata_cmd),
+	/* Opcode = 0x08 (Release) */
+	ASE_CMD(0x08, "Release", ase_release_cmd),
+};
+
+static struct ase_cmd *ase_get_cmd(uint8_t op)
+{
+	if (op > ARRAY_SIZE(ase_cmd_table))
+		return NULL;
+
+	return &ase_cmd_table[op];
+}
+
+static void print_ase_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t op, num, i;
+	struct ase_cmd *cmd;
+
+	if (!l2cap_frame_get_u8((void *)frame, &op)) {
+		print_text(COLOR_ERROR, "opcode: invalid size");
+		goto done;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &num)) {
+		print_text(COLOR_ERROR, "num: invalid size");
+		goto done;
+	}
+
+	cmd = ase_get_cmd(op);
+	if (!cmd) {
+		print_field("    Opcode: Reserved (0x%2.2x)", op);
+		goto done;
+	}
+
+	print_field("    Opcode: %s (0x%2.2x)", cmd->desc, op);
+	print_field("    Number of ASE(s): %u", num);
+
+	for (i = 0; i < num && frame->size; i++) {
+		print_field("    ASE: #%u", i);
+
+		if (!cmd->func(frame))
+			break;
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ase_cp_write(const struct l2cap_frame *frame)
+{
+	print_ase_cmd(frame);
+}
+
+static bool print_ase_cp_rsp_code(const struct l2cap_frame *frame)
+{
+	uint8_t code;
+
+	if (!l2cap_frame_get_u8((void *)frame, &code)) {
+		print_text(COLOR_ERROR, "    ASE Response Code: invalid size");
+		return false;
+	}
+
+	switch (code) {
+	case 0x00:
+		print_field("    ASE Response Code: Success (0x00)");
+		break;
+	case 0x01:
+		print_field("    ASE Response Code: Unsupported Opcode (0x01)");
+		break;
+	case 0x02:
+		print_field("    ASE Response Code: Invalid Length (0x02)");
+		break;
+	case 0x03:
+		print_field("    ASE Response Code: Invalid ASE ID (0x03)");
+		break;
+	case 0x04:
+		print_field("    ASE Response Code: Invalid ASE State (0x04)");
+		break;
+	case 0x05:
+		print_field("    ASE Response Code: Invalid ASE Direction "
+								"(0x05)");
+		break;
+	case 0x06:
+		print_field("    ASE Response Code: Unsupported Audio "
+							"Capabilities (0x06)");
+		break;
+	case 0x07:
+		print_field("    ASE Response Code: Unsupported Configuration "
+								"(0x07)");
+		break;
+	case 0x08:
+		print_field("    ASE Response Code: Rejected Configuration "
+								"(0x08)");
+		break;
+	case 0x09:
+		print_field("    ASE Response Code: Invalid Configuration "
+								"(0x09)");
+		break;
+	case 0x0a:
+		print_field("    ASE Response Code: Unsupported Metadata "
+								"(0x0a)");
+		break;
+	case 0x0b:
+		print_field("    ASE Response Code: Rejected Metadata (0x0b)");
+		break;
+	case 0x0c:
+		print_field("    ASE Response Code: Invalid Metadata (0x0c)");
+		break;
+	case 0x0d:
+		print_field("    ASE Response Code: Insufficient Resources "
+								"(0x0d)");
+		break;
+	case 0x0e:
+		print_field("    ASE Response Code: Unspecified Error (0x0e)");
+		break;
+	default:
+		print_field("    ASE Response Code: Reserved (0x%2.2x)", code);
+		break;
+	}
+
+	return true;
+}
+
+static bool print_ase_cp_rsp_reason(const struct l2cap_frame *frame)
+{
+	uint8_t reason;
+
+	if (!l2cap_frame_get_u8((void *)frame, &reason)) {
+		print_text(COLOR_ERROR,
+				"    ASE Response Reason: invalid size");
+		return false;
+	}
+
+	switch (reason) {
+	case 0x00:
+		print_field("    ASE Response Reason: None (0x00)");
+		break;
+	case 0x01:
+		print_field("    ASE Response Reason: ASE ID (0x01)");
+		break;
+	case 0x02:
+		print_field("    ASE Response Reason: Codec Specific "
+						"Configuration (0x02)");
+		break;
+	case 0x03:
+		print_field("    ASE Response Reason: SDU Interval (0x03)");
+		break;
+	case 0x04:
+		print_field("    ASE Response Reason: Framing (0x04)");
+		break;
+	case 0x05:
+		print_field("    ASE Response Reason: PHY (0x05)");
+		break;
+	case 0x06:
+		print_field("    ASE Response Reason: Max SDU (0x06)");
+		break;
+	case 0x07:
+		print_field("    ASE Response Reason: RTN (0x07)");
+		break;
+	case 0x08:
+		print_field("    ASE Response Reason: Max Transport Latency "
+								"(0x08)");
+		break;
+	case 0x09:
+		print_field("    ASE Response Reason: Presentation Delay "
+								"(0x09)");
+		break;
+	case 0x0a:
+		print_field("    ASE Response Reason: Invalid ASE/CIS Mapping "
+								"(0x0a)");
+		break;
+	default:
+		print_field("    ASE Response Reason: Reserved (0x%2.2x)",
+								reason);
+		break;
+	}
+
+	return true;
+}
+
+static void print_ase_cp_rsp(const struct l2cap_frame *frame)
+{
+	uint8_t op, num, i;
+	struct ase_cmd *cmd;
+
+	if (!l2cap_frame_get_u8((void *)frame, &op)) {
+		print_text(COLOR_ERROR, "    opcode: invalid size");
+		goto done;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &num)) {
+		print_text(COLOR_ERROR, "    Number of ASE(s): invalid size");
+		goto done;
+	}
+
+	cmd = ase_get_cmd(op);
+	if (!cmd) {
+		print_field("    Opcode: Reserved (0x%2.2x)", op);
+		goto done;
+	}
+
+	print_field("    Opcode: %s (0x%2.2x)", cmd->desc, op);
+	print_field("    Number of ASE(s): %u", num);
+
+	for (i = 0; i < num && frame->size; i++) {
+		print_field("    ASE: #%u", i);
+
+		if (!l2cap_frame_print_u8((void *)frame, "    ASE ID"))
+			break;
+
+		if (!print_ase_cp_rsp_code(frame))
+			break;
+
+		if (!print_ase_cp_rsp_reason(frame))
+			break;
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ase_cp_notify(const struct l2cap_frame *frame)
+{
+	print_ase_cp_rsp(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -668,6 +1070,7 @@ struct gatt_handler {
 	GATT_HANDLER(0x2902, ccc_read, ccc_write, NULL),
 	GATT_HANDLER(0x2bc4, ase_read, NULL, ase_notify),
 	GATT_HANDLER(0x2bc5, ase_read, NULL, ase_notify),
+	GATT_HANDLER(0x2bc6, NULL, ase_cp_write, ase_cp_notify),
 	GATT_HANDLER(0x2bc9, pac_read, NULL, pac_notify),
 	GATT_HANDLER(0x2bcb, pac_read, NULL, pac_notify),
 };
-- 
2.35.1

