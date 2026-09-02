Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97F35C1B1
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361804; cv=none; b=Z/lt8z511m5GVLtsPmq4QDEAAQHb4POfJr0sZoxpyI6DYOn85ix6J0CTP7M09TY3IB8MApT3DCZlxgHFlGYvjrEVS0CwyQETa5Y+zkhFewTUZen4mgNTsaNVr2ePCHgOT+pUGF0Y4PoSMK4fw0FPnW4NNVi15wxwuljTsOfX4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361804; c=relaxed/simple;
	bh=b0g6tmpmNcPVvWbA+uEksJMSXfcuoJyS7k/ji0bUYBo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QPI09mBNhWqOB9/cy2+I5VfJhgKSsjK2360+gYQOrcWq27DECS5YfudK2+5QHQGAa617Lt0E67wp5WzkwUsW1OadO3Y+/7dM+PmjiEmcKxe1Hk0FBRwnpMhCzRBH5dwNuDus+KaRMqXtiKTFDpAn+0Awva9b/q4frKZOarlYhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPUK6PHa; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPUK6PHa"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-783d429d0cfso947289137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361801; x=1788966601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ivyngYLVARJNpogPNGXh5yDKvFgKw60rDmwQRdxWwvk=;
        b=kPUK6PHaYrG/Qf7+i/PznC8/QYs5WZsSchB3lcTn2MM971K7lHPsYiHBh/8RyvCk9t
         xjnT8zahxi39wdpRZ9m7KZCVFRsjGR+a8TpvLKynZxiUw0doR2OQ7h9kT4eJvruoIj91
         GnEjOF34muHWh1uJAjZL74eqe5lIp151DzESbvrdlWZYcd2WxGoYj++2jdh0/scI7ceh
         klgluJcK+OdU42txB6ICoPDLwupLnocJFzZ578VyTswB9EjjeSjaX++pVHD05+ZSyrxS
         qZQkE7ktoYl1XwNrDHJMUeT3HHRzM6Y98LCQ5/8vzVb1lfP+7tiQTpoVvWIDvzg4pLpG
         oydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361801; x=1788966601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ivyngYLVARJNpogPNGXh5yDKvFgKw60rDmwQRdxWwvk=;
        b=AefHweVmSAlJh6eplPTXPAveE0Jspdom6njqxPdECYyeYXcpz/2FXl75IkcRNIJS+C
         4UxdB1rnu/qnOw4q3nUl83Cwyb6uSM/WT3Cs1vzBGXYT0zLwi6ngJh3YKSOe710I5SxM
         XoisBezcAIhJ7w3bfZrUwapbUYE9+K2x2Vs2QmYYPHbKwU25F9NdGZCdcc+c9OEcjaYf
         8HAvxyPJRj8fjcjtLRROtasHkgYmMiN6e3Niu1sQAyO3fY8YsPhW3vnW1gI/ik7fMPop
         EiELBJdkOvFwITl7+iD2kS+aGEl6Eo+2mgkFPzJrVs0h1kvRO5TtLLGCKgHDGtGxOG1t
         zVew==
X-Gm-Message-State: AFuF++mERAncSojkkUhxr4nOZOGzaWEwz/+RcXBzb3SYmGc8+hj4kAhp
	4ajappoT8tCt/Q+wWSvLR2X/v2UNESh7AhObL9w40RBmT8BqT7njP5qwGMGGybLm3+lo3A==
X-Gm-Gg: AYBFou2/n1yKOmENqj9FtTEPLgKlCdMCe4pnBdSY3NzXTYoPl3wfiiTsXvkqxezhuJE
	iLr54QiCFHTrMS6RIGQpYpGzhfitN1GM0wnmeDdAdFyyf4SG2OONyvZ5Fw7Z1r/zXl5alaYfqoe
	bnF3ZL4KWQoMOAj9Ktn/HpPWJCe/A9Q/OaP+T1CqmGKM4Qgt1tfoupGdFo1I92kfCO4g0/I+hB+
	mkntC1Z3QSky0fGFVBQlLfxrRVPsrFy9r1YQG+ADwkc2l3f7q0pnGcnBijSSiXE8M2RobIxkaE8
	M+/UPs2RfzeXM5JIPOjPI/Xhfl0ywHFg4J21ou4y+UCNxXq7zUxXCtCTzu99WivxZY7Y+tRUVQL
	Bj9YZMGC22UqiBzNtegirREUAYJ+wrQKhRa7axJ5stxN4rSQ+g3kQG8BkSC9JthMrvidx0AE/Na
	/5In8i7yH9oD0JTsQoqvKxtbxmIMF7tuUK32kzkDj20ysgVEeMUme8w3dPVSHCfXTOxC4UDa+MO
	6P9ISmtx5QNkmykvvtHLvcOHbUW1jeB939uB8MHKbxypWC8dKlP3xk=
X-Received: by 2002:a05:6102:f86:b0:786:dfc0:2ece with SMTP id ada2fe7eead31-78a1f3b9b05mr2213295137.11.1788361801325;
        Wed, 02 Sep 2026 08:10:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a510ca3sm2355265137.11.2026.09.02.08.10.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:10:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] monitor: Check valid range of CE Length
Date: Wed,  2 Sep 2026 11:09:50 -0400
Message-ID: <20260902150951.1583184-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time = N * 125 us, Time Range:
0.125 ms to 3.999875 s), so print values outside of it as reserved
instead of decoding them as a time.
---
 monitor/packet.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3fb7..692119ec6425 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2423,6 +2423,24 @@ static void print_slot_125u(const char *label, uint16_t value)
 				le16_to_cpu(value) * 0.125, le16_to_cpu(value));
 }
 
+/* Connection event length recommended in requests by a Peripheral:
+ * Range: 0x0001 to 0x7CFF, Time = N * 125 us
+ */
+#define BT_HCI_CE_LEN_MIN 0x0001
+#define BT_HCI_CE_LEN_MAX 0x7cff
+
+static void print_ce_len(const char *label, uint16_t value)
+{
+	uint16_t val = le16_to_cpu(value);
+
+	if (val < BT_HCI_CE_LEN_MIN || val > BT_HCI_CE_LEN_MAX) {
+		print_field("%s: Reserved (0x%4.4x)", label, val);
+		return;
+	}
+
+	print_field("%s: %.3f msec (0x%4.4x)", label, val * 0.125, val);
+}
+
 static void print_slot_625(const char *label, uint16_t value)
 {
 	 print_field("%s: %.3f msec (0x%4.4x)", label,
@@ -9915,8 +9933,8 @@ static void le_conn_rate_cmd(uint16_t index, const void *data, uint8_t size)
 	print_field("Supervision Timeout: %d ms (0x%4.4x)",
 				le16_to_cpu(cmd->supv_timeout) * 10,
 				le16_to_cpu(cmd->supv_timeout));
-	print_slot_125u("Minimum CE Length", cmd->min_ce_len);
-	print_slot_125u("Maximum CE Length", cmd->max_ce_len);
+	print_ce_len("Minimum CE Length", cmd->min_ce_len);
+	print_ce_len("Maximum CE Length", cmd->max_ce_len);
 }
 
 static void le_set_def_rate_cmd(uint16_t index, const void *data, uint8_t size)
@@ -9940,8 +9958,8 @@ static void le_set_def_rate_cmd(uint16_t index, const void *data, uint8_t size)
 	print_field("Supervision Timeout: %d ms (0x%4.4x)",
 				le16_to_cpu(cmd->supv_timeout) * 10,
 				le16_to_cpu(cmd->supv_timeout));
-	print_slot_125u("Minimum CE Length", cmd->min_ce_len);
-	print_slot_125u("Maximum CE Length", cmd->max_ce_len);
+	print_ce_len("Minimum CE Length", cmd->min_ce_len);
+	print_ce_len("Maximum CE Length", cmd->max_ce_len);
 }
 
 static void le_read_conn_interval_rsp(uint16_t index, const void *data,
-- 
2.54.0

