Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A201317163
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317766; cv=none; b=PVuyDr09QsFxohIFtot7nlMf6zXX6SsVoeZjUmul+Bi3fLhZvTxItmU2/CgDJNcmtTIT+2RLkMIiwwJ9tzr5vWu9+Q5orhUuzDA9fzVbiOCR2/TKync972sJAXV5gDbRWan8aEI0bsI2r4I6KaJNfkcpPluvkf8muaLUwoScGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317766; c=relaxed/simple;
	bh=mP41cputbgdleNzbrW1jo/9EhPTIveY/Oiqw2HcoJAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CipGg6UCTgjpq6KERSwpGhJnXHYZZbNj2NAIyKohFh+XMCAkoL4nHpwPdDWWOqr0yLaqPY9AhW5EWL4wcOC9qCTYTDuKFP6TSUIakKZX+weRGGfzXeG09FWvp/bdkylNwP2Mw8yWk2241wYDf2bDSc4r2NpFjIYJCpKdu8FsGPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ylkzwdpn; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylkzwdpn"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-610aadb2d9fso3454779137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777317753; x=1777922553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r0sG+vei2+rpRRVJd/XdB5jvzRiZaI5qHao/HX3zuC8=;
        b=Ylkzwdpn0qYSwJ1l+gzXAxqdXANcUKUB8WB3N+ju8pBwM/Fk/VENLOC+Uj31hC5toQ
         oA4QvReLoNJKHR4eczGtyYzvADGQkIU6w4dkWrDmw5PJb42EoYLR7CTM0O83xFg38HeA
         4xwp1H2WETgAjIApLVRrzjYbmkWiGHrgs24grza4S31jE4kvPdQVDtKmE+er4KOqnpor
         EaF/3m3sCDvJoWZ6Kmddj0+RS9qIcARja1KpuqwLpKJT+dzhQ8pgoP2JFPuMfPEjEW6i
         +tFyqLwOjajxkHUIwStyhYfqBQGS+FTzf8T4tlRfz64x6RRy7BepAGbGPTUMVLTmq9e+
         8VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777317753; x=1777922553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0sG+vei2+rpRRVJd/XdB5jvzRiZaI5qHao/HX3zuC8=;
        b=hvGyhKzSMZFx7olq1XkaByhR7w+EUghO/uQmauf5rpTkn0RQ4szPSvxS8zbYIUzw6b
         TNJO37NXdUdourQiOuA954PFA5iIHEtG+vEbUpXVRti4PSAPYT7LuFh9z9OrIwRs6wid
         zg48gJuYdtwsFdvokGFtDXLjMmYlJQG07G5f7zoNLWIg8r9452evfvZLe1F1U4PLJ94G
         Kmdn8wbC42IJvxjo5PPC37iyQeLnBLC7y4SC37sMhYyr8j7IONZZSSlewCWu/Zjsl36a
         PYaTAHH91hH/VGy/FLh9XyUcAswIIyWiIvNMIaz9mwzPFuNTmEvetg/3R8aHEZ/gzcDx
         ysrQ==
X-Gm-Message-State: AOJu0YyvkmY3ROSkre8XDkaj2dcQb1fFI5FpCCTyGcbpWcrt0I7fl7Bx
	va4djTX3SV6OyFy3cmNuehilLx2/w0sM6qFRNlB6qvn/d1GPQWTIf03T
X-Gm-Gg: AeBDieuq6pY3jQ26Fni2/Nc8dIqD8njBdwnKlU4we8gNa6ifTvKrwdRNdithazF3+/V
	HpFUQVOqOARbOF/tH94+K5A9lwcv+zHe/0yVp2ZHSjMRcng97hgYPsNA1JR1OGPRkPTy8AvK7OZ
	xNP8HbSRDTcCXrgTuv1FtmVRa65t5n10V4vF9qjmmJmFkQjpW+zHUuXTlGFwCmdO6bvcnDSw3wh
	Q1HPqCvWYRc2uBZDMcADomUlPOvLUz8dWAYrUZPYlbWzv/Uie/a+pk+c6vmMYhjXgrAH7eop5Ro
	yRXHVtbPkYq2YCQZHbVEtajSp10Ed7EePlo3eWKPZu0k7O6CQqNeHIjALzgsJ1gKEheJEgERaO5
	TH+d1Li1mAUFfTgF4A4d3NPSu4jEPO0lpi6MRC2NTgKNSTBgyomldprK054XHB7jIxtpyJbiOwQ
	uE15tkcVqhlC2VuGzmZdKWKyWbpUbFgpThbZwy37DruJKMSjVCCZNfmC2K9A==
X-Received: by 2002:a05:6102:4411:b0:605:4cbd:91ad with SMTP id ada2fe7eead31-627d2a8128fmr479637137.6.1777317752892;
        Mon, 27 Apr 2026 12:22:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-627f507aa75sm90423137.3.2026.04.27.12.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 12:22:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Add decoding support for Public Broadcast Announcements
Date: Mon, 27 Apr 2026 15:22:23 -0400
Message-ID: <20260427192223.2875358-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding Public Broadcast Announcements (PBP).
---
 monitor/packet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ff0b1cac2f5f..820191e0f7f5 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3615,7 +3615,7 @@ static void print_ltv(const char *str, void *user_data)
 	print_field("%s: %s", label, str);
 }
 
-static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
+static void print_base_announcement(const uint8_t *data, uint8_t data_len)
 {
 	struct iovec iov;
 	struct bt_hci_le_pa_base_data *base_data;
@@ -3714,7 +3714,7 @@ done:
 		print_hex_field("  Data", iov.iov_base, iov.iov_len);
 }
 
-static void print_broadcast_annoucement(const uint8_t *data, uint8_t data_len)
+static void print_broadcast_announcement(const uint8_t *data, uint8_t data_len)
 {
 	uint32_t bid;
 
@@ -3727,12 +3727,52 @@ static void print_broadcast_annoucement(const uint8_t *data, uint8_t data_len)
 	print_field("Broadcast ID: %u (0x%06x)", bid, bid);
 }
 
+static const struct bitfield_data pbp_feat_table[] = {
+	{ 0, "Encryption"					},
+	{ 1, "Standard Quality"					},
+	{ 2, "High Quality"					},
+	{}
+};
+
+static void print_pbp_announcement(const uint8_t *data, uint8_t data_len)
+{
+	struct iovec iov, meta;
+	uint8_t feat;
+	uint8_t len;
+
+	iov.iov_base = (void *) data;
+	iov.iov_len = data_len;
+
+	if (util_iov_pull_u8(&iov, &feat)) {
+		print_text(COLOR_ERROR, "  invalid features");
+		return;
+	}
+
+	print_field("Features: 0x%02x", feat);
+	print_bitfield(4, feat, pbp_feat_table);
+
+	if (util_iov_pull_u8(&iov, &len)) {
+		print_text(COLOR_ERROR, "  invalid metadata length");
+		return;
+	}
+
+	if (!len)
+		return;
+
+	meta.iov_base = util_iov_pull_mem(&iov, len);
+	meta.iov_len = len;
+
+	bt_bap_debug_metadata(meta.iov_base, meta.iov_len, print_ltv,
+						"    Metadata");
+}
+
 static const struct service_data_decoder {
 	uint16_t uuid;
 	void (*func)(const uint8_t *data, uint8_t data_len);
 } service_data_decoders[] = {
-	{ 0x1851, print_base_annoucement },
-	{ 0x1852, print_broadcast_annoucement }
+	{ 0x1851, print_base_announcement },
+	{ 0x1852, print_broadcast_announcement },
+	{ 0x1856, print_pbp_announcement }
 };
 
 static void print_service_data(const uint8_t *data, uint8_t data_len)
-- 
2.53.0

