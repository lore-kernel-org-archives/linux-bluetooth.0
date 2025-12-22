Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7130E0E9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432118; cv=none; b=usvsh97i98GRpgLh+rn0865aYO/m1EtgENJNmK5Inspqn7hIyLvaR7vlQ7p+yXy6iNt34kK8neHK9LpTqv0TrIDt7Zl3eFRQwXP5VZlpbiU160wHENi4f/KRJxpi19EmYTH7xNcv2efxzd+TC6Lk/DFUjes76QtRAGj9SrPZXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432118; c=relaxed/simple;
	bh=7PXR5hF8UuKyznnqSy+znAPfdcsv7WxPN6Anbcuc63I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uHu0ietYRqo+r2+WTOlOrpy4OCRbxNDjZAPoaR6IRqnmhjm7XokFp3pSWVm1cEZSuQxqKH3sGwIRtbB+jNuUEdh9UH8oyLQWsBU5hrBkVnCbkqKx3/BBiy+0cw8HzTsEZtF4KWPE+oXQXTrfy53owLyDtMAnkhGcLTUPzZGS0Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx5vJby9; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx5vJby9"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55b26332196so1130225e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 11:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766432114; x=1767036914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPTE7zWfe/DvMcP+3FPRDgGYyeZMwXCmfauxdr9uYVs=;
        b=jx5vJby9eybVPEfdSxSW053PSmrPIAjrDtLhNNbexZoc+o7W1ryBEwfQVzqFsCFS1W
         rJJ4wi3qxjtK4KRPyEhBSulp9LTuS1J4b95vWnuXwWV9k8V+04bD+N67l2ebuYnFthvc
         RfIHlXyWoo+NAGF6Mex+oDgSTKU+jQX1POOObYfpH50JVhTLtHeF2A1NC8Gn7tlF+w0d
         WToBNKgpBT0xM5EdIEaaftvKcrGJsRIlLMBA7EM8wmPp9z/BXgxZe+/gEBAJGINSurUJ
         JxyrHA/zuIjQmuhcU2PkiWVDw/C5P07fJ5W6eXmaanisnnKUbXcnXc16Y56kMtT/kXbA
         kn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766432114; x=1767036914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPTE7zWfe/DvMcP+3FPRDgGYyeZMwXCmfauxdr9uYVs=;
        b=xTtn4u6frz4GEVn2BqO0nX3rBuWu8W7Px21fZR1t2aooCoc1EWWj+2n0Ik9FjYF40N
         IQp81FEWSErKMIY3PnXTFQaoQCj8hWCJyP54EZY+W1vQTXDDRG3EhdXvTTpC4VbQcEim
         Mxbmf10aCg104aFkELDPzIZYxyurTbXhknsBVCqVZygksik2FXRFRGEpw5DkvkjfQ2Px
         dEA+t5fjDazKKbEjpkmYBu/7mmjryKoOuwVv5Z/bU572sOJS1puvVJTCgJ9z4SZhwDQe
         IHvYQvLaeAYUEhKsR0t91SgnFQNcJ5DkMQsN1VHFRdOkZh2cmgbX2WIrURHk71AFyz7D
         Bw7Q==
X-Gm-Message-State: AOJu0YwOZvubOFSJ7Ufu9IXiZfbovlNXmr91Lg4D/rKNb2YZttvv6mxw
	n5TTUiW8sYYf4EOSa7hTwTxv7IOkct2Hk+hT+diooFftQZpj8QvY/+Fc7iSKbxKoFtE=
X-Gm-Gg: AY/fxX4sr0x4KwhLGrabt9DelPLi9AZ9iRGgg7AObvjz1umXrRsoW/y+71EA7iXvIKy
	bg3MJbxdQned+uCS7hrTluDY5BQxDws28fgYAbxsl9yQa5IXJzxd3wjZM50JSJRrHf+lX6FlENc
	xHDW3HIkoGtweT/VCzTr/S25xPJjzp3Zd24FEs9KNqdL0NNO1er+BUFOOkJov1eUmFNsPvHQ2uf
	w1+urVE9P6a7m/iNDo02yusNAy9CAC9lghy3WXbznGuRHKYdg05xqB4YPkXmY9REwIcDlMT2P7J
	FD+yQb/hXJ+wjddDkWhzsduOxviXwbU8YbUeOrQ9AVe1UheJCFi1R9TCHJ06DNLpEWe0eNj9ZAE
	iNCfe48jOiLMMWyYyR72tDKCD8pG9i6rJ2fwfD9GHumGhYEv2fpArQvvfx7P16Xm8M+4CU/pYQE
	qW2DL4FCnS4JOzDA==
X-Google-Smtp-Source: AGHT+IEnOsd/ghTfTvgXorTISrxKHqFEdd8SKGeOprm4JeAN2qCCuhwXUISTkiD+EdcI/4FYzUQ16w==
X-Received: by 2002:a05:6122:7c6:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-5615beb3bd3mr3431750e0c.17.1766432114080;
        Mon, 22 Dec 2025 11:35:14 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d132efesm3764301e0c.11.2025.12.22.11.35.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 11:35:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] monitor: Fix parsing of BT_HCI_CMD_LE_SET_CIG_PARAMS
Date: Mon, 22 Dec 2025 14:35:02 -0500
Message-ID: <20251222193504.650019-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The fields of BT_HCI_CMD_LE_SET_CIG_PARAMS are bitfields rather than
values, so this changes the fields to phy's' and fixes the parsing to
print it as bitfield rather than value.
---
 emulator/btdev.c  |  4 ++--
 emulator/bthost.c |  4 ++--
 monitor/bt.h      | 12 ++++++------
 monitor/ll.c      |  8 ++++----
 monitor/packet.c  | 18 +++++++++---------
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index be43623e8bfb..f66fe4c78d03 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6977,8 +6977,8 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 		memset(evt.cig_sync_delay, 0, sizeof(evt.cig_sync_delay));
 		memset(evt.cis_sync_delay, 0, sizeof(evt.cis_sync_delay));
 
-		evt.c_phy = le_cig->cis[cis_idx].c_phy;
-		evt.p_phy = le_cig->cis[cis_idx].p_phy;
+		evt.c_phy = le_cig->cis[cis_idx].c_phys;
+		evt.p_phy = le_cig->cis[cis_idx].p_phys;
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 935b4ba60fb2..c9eba77cff7b 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3886,9 +3886,9 @@ void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
 	cp->cis[0].cis_id = cis_id;
 	cp->cis[0].c_sdu = qos->ucast.in.sdu;
 	cp->cis[0].p_sdu = qos->ucast.out.sdu;
-	cp->cis[0].c_phy = qos->ucast.in.phy ? qos->ucast.in.phy :
+	cp->cis[0].c_phys = qos->ucast.in.phy ? qos->ucast.in.phy :
 							qos->ucast.out.phy;
-	cp->cis[0].p_phy = qos->ucast.out.phy ? qos->ucast.out.phy :
+	cp->cis[0].p_phys = qos->ucast.out.phy ? qos->ucast.out.phy :
 							qos->ucast.in.phy;
 	cp->cis[0].c_rtn = qos->ucast.in.rtn;
 	cp->cis[0].p_rtn = qos->ucast.out.rtn;
diff --git a/monitor/bt.h b/monitor/bt.h
index 1c753b694883..0a1508ea28a9 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -197,8 +197,8 @@ struct bt_ll_clock_acc {
 struct bt_ll_cis_req {
 	uint8_t  cig;
 	uint8_t  cis;
-	uint8_t  c_phy;
-	uint8_t  p_phy;
+	uint8_t  c_phys;
+	uint8_t  p_phys;
 	uint16_t c_sdu;
 	uint16_t p_sdu;
 	uint8_t  c_interval[3];
@@ -2720,8 +2720,8 @@ struct bt_hci_cis_params {
 	uint8_t  cis_id;
 	uint16_t c_sdu;
 	uint16_t p_sdu;
-	uint8_t  c_phy;
-	uint8_t  p_phy;
+	uint8_t  c_phys;
+	uint8_t  p_phys;
 	uint8_t  c_rtn;
 	uint8_t  p_rtn;
 } __attribute__ ((packed));
@@ -2755,8 +2755,8 @@ struct bt_hci_cis_params_test {
 	uint16_t p_sdu;
 	uint16_t c_pdu;
 	uint16_t p_pdu;
-	uint8_t  c_phy;
-	uint8_t  p_phy;
+	uint8_t  c_phys;
+	uint8_t  p_phys;
 	uint8_t  c_bn;
 	uint8_t  p_bn;
 } __attribute__ ((packed));
diff --git a/monitor/ll.c b/monitor/ll.c
index 4d65d183f958..6c0f67b5dcae 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -656,16 +656,16 @@ static void cis_req(const void *data, uint8_t size)
 
 	print_field("CIG ID: 0x%2.2x", cmd->cig);
 	print_field("CIS ID: 0x%2.2x", cmd->cis);
-	print_field("Central to Peripheral PHY: 0x%2.2x", cmd->c_phy);
+	print_field("Central to Peripheral PHYs: 0x%2.2x", cmd->c_phys);
 
-	mask = print_bitfield(2, cmd->c_phy, le_phys);
+	mask = print_bitfield(2, cmd->c_phys, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_field("Peripheral To Central PHY: 0x%2.2x", cmd->p_phy);
+	print_field("Peripheral To Central PHYs: 0x%2.2x", cmd->p_phys);
 
-	mask = print_bitfield(2, cmd->p_phy, le_phys);
+	mask = print_bitfield(2, cmd->p_phys, le_phys);
 	if (mask)
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
diff --git a/monitor/packet.c b/monitor/packet.c
index 8ac2d52243cb..4544c90c2d81 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -7768,7 +7768,7 @@ static const struct bitfield_data le_phys[] = {
 	{ }
 };
 
-static void print_le_phy_bitfield(const char *label, uint8_t phys)
+static void print_le_phys(const char *label, uint8_t phys)
 {
 	uint8_t mask;
 
@@ -7798,8 +7798,8 @@ static void print_le_phys_preference(uint8_t all_phys, uint8_t tx_phys,
 		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
 							" (0x%2.2x)", mask);
 
-	print_le_phy_bitfield("TX PHYs preference", tx_phys);
-	print_le_phy_bitfield("RX PHYs preference", rx_phys);
+	print_le_phys("TX PHYs preference", tx_phys);
+	print_le_phys("RX PHYs preference", rx_phys);
 }
 
 static void le_set_default_phy_cmd(uint16_t index, const void *data,
@@ -8853,8 +8853,8 @@ static void print_cis_params(const void *data, int i)
 						le16_to_cpu(cis->c_sdu));
 	print_field("Peripheral to Central Maximum SDU Size: %u",
 						le16_to_cpu(cis->p_sdu));
-	print_le_phy("Central to Peripheral PHY", cis->c_phy);
-	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_le_phys("Central to Peripheral PHYs", cis->c_phys);
+	print_le_phys("Peripheral to Central PHYs", cis->p_phys);
 	print_field("Central to Peripheral Retransmission attempts: 0x%2.2x",
 							cis->c_rtn);
 	print_field("Peripheral to Central Retransmission attempts: 0x%2.2x",
@@ -8900,8 +8900,8 @@ static void print_cis_params_test(const void *data, int i)
 						le16_to_cpu(cis->c_pdu));
 	print_field("Peripheral to Central Maximum PDU: 0x%4.4x",
 						le16_to_cpu(cis->p_pdu));
-	print_le_phy("Central to Peripheral PHY", cis->c_phy);
-	print_le_phy("Peripheral to Central PHY", cis->p_phy);
+	print_le_phys("Central to Peripheral PHYs", cis->c_phys);
+	print_le_phys("Peripheral to Central PHYs", cis->p_phys);
 	print_field("Central to Peripheral Burst Number: 0x%2.2x", cis->c_bn);
 	print_field("Peripheral to Central Burst Number: 0x%2.2x", cis->p_bn);
 }
@@ -9764,7 +9764,7 @@ static void le_fsu_cmd(uint16_t index, const void *data, uint8_t size)
 	print_field("Frame Space max: %d us (0x%4.4x)",
 				le16_to_cpu(cmd->frame_space_max),
 				le16_to_cpu(cmd->frame_space_max));
-	print_le_phy_bitfield("PHYs", cmd->phys);
+	print_le_phys("PHYs", cmd->phys);
 	print_fsu_types(cmd->types);
 }
 
@@ -13325,7 +13325,7 @@ static void le_fsu_evt(struct timeval *tv, uint16_t index,
 	print_field("Frame Space: %u us (0x%4.4x)",
 				le16_to_cpu(evt->frame_space),
 				le16_to_cpu(evt->frame_space));
-	print_le_phy_bitfield("PHYs", evt->phys);
+	print_le_phys("PHYs", evt->phys);
 	print_fsu_types(evt->types);
 }
 
-- 
2.52.0

