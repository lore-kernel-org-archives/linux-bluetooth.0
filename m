Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA31DFDA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156737; cv=none; b=pYFWnVkRRuk3ChfhNtXX79UKkqENrxGOapfIce040oG0N3olpFhaC9xFymAf7vJThBsl4T5TT/1kr4r2OT+077XdSe0Zi15sKHsYPX3uwMLU+eriOw20SRQcAYzO3EczPOVoK9MTYJvdJzyc5CgYVuVBwN9T2tqX0FTBrGoljBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156737; c=relaxed/simple;
	bh=HZLFcXlN2SAS+4uemyWiI/hg2+LybM/2EQhllRt9XB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA27HGS0XBVgDaMsHOiCLzC35fAORXUWR614CmaIvwZhpJgmbTka8U8BEVxreNHHzLHSbe7phdRWvIyAcxKG98xLJnuyP76VIwr2zLxHgHaT68jqlkYS8eMyUI0AWmwIfn3dHV4UHpiuPEFnVJ45nMJIiycZ27EhWttRaMLiEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MQ0xMIse; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MQ0xMIse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788156731;
	bh=HZLFcXlN2SAS+4uemyWiI/hg2+LybM/2EQhllRt9XB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQ0xMIsecT63Qv8/9DQRrZaFdW/U1sfxrOZbHp/1zMXxzSQfjbTuiOMX38vIKInSZ
	 c63FeUnw4vxhRfiTKO1D8cS/8uIHG9kgSmSrFyc6aHvSqLfrqCJJiUuhKE2o+R+b7j
	 J/ocPckxlSz0ek6NkvmF1UvJI1zQ4/c+zvm8JtAg/dbdthho+nBaoJnXVpRxiKnOLB
	 xmpbfC2vB8oJJ+8Zudc1lX4zKiTWozkNQ5Ilvjqw8fEwFscM1mP66mr1JxqEujjvnf
	 1iOr+wY4OTy0bEk25j0ojMjLwxDBY4Bl0ZjVnTCWf2SAXudRps5+Z6hja+zp9o7iK9
	 0pVzPxendpbjg==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 67B2117E0180;
	Mon, 31 Aug 2026 08:12:10 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH 3/3] shared/mcp: Notify unsupported RFU opcodes
Date: Mon, 31 Aug 2026 11:41:44 +0530
Message-ID: <20260831061144.7767-4-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831061144.7767-1-raghavendra.rao@collabora.com>
References: <20260831061144.7767-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This is needed to Pass PTS GMCS/SR/SPE/BI-01-C test.
---
 src/shared/mcp.c |  4 +++-
 unit/test-mcp.c  | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index a954869b0..583ae40dc 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -324,6 +324,7 @@ static void write_media_cp(struct gatt_db_attribute *attrib,
 	int ret = 0;
 	int32_t arg = 0;
 	uint8_t op;
+	bool rfu_op = false;
 	bool ok = false;
 
 	if (offset) {
@@ -337,6 +338,7 @@ static void write_media_cp(struct gatt_db_attribute *attrib,
 	}
 
 	rsp.op = op;
+	rfu_op = !op;
 
 	cmd = mcs_get_command(op);
 	if (!cmd || !(cmd->support & mcs_get_supported(mcs))) {
@@ -370,7 +372,7 @@ respond:
 							ret, rsp.result);
 
 	gatt_db_attribute_write_result(attrib, id, ret);
-	if (!rsp.op)
+	if (!rsp.op && !rfu_op)
 		return;
 
 	/* Make state transition immediately if command was successful and has
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 6331c6c99..21997915d 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -2057,6 +2057,19 @@ static void testgroup_sr_mcp(void)
 }
 
 
+#define GMCS_SR_SPE_BI_01_C \
+	WRITE_NORESP_CHRC(CP, 0x00), \
+	NOTIFY_CHRC(CP, 0x00, 0x02 /* not supp */)
+
+static void testgroup_sr_spe(void)
+{
+	define_test("GMCS/SR/SPE/BI-01-C [Media Control Point - Opcode not "
+							"Supported]",
+		test_setup_server, test_server,
+		&cfg_sggit_gmcs, GMCS_SR_SPE_BI_01_C);
+}
+
+
 static void sr_spn_value(struct test_data *data, struct iovec *buf, size_t size,
 								uint16_t uuid)
 {
@@ -2132,6 +2145,7 @@ int main(int argc, char *argv[])
 	testgroup_cl_extra();
 	testgroup_sr_sggit();
 	testgroup_sr_mcp();
+	testgroup_sr_spe();
 	testgroup_sr_spn();
 
 	return tester_run();
