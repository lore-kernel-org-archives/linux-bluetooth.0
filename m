Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBB50EBED
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540842; cv=none; b=rttoeRx/bT2jZtbc8x7UDqIHbQUGvsPSltMELsGPkjoScIJxCZ5V6sgNO23K4BDqnoQR69viAkjU2qXSzegNueWN2z3aHoq8M8LD1wRzJtq9VGT8BaK1HvmJBiuIvbq0cJA8kD7degHvPGbyfWm78XHJBSoA47qQuPrjFWlT9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540842; c=relaxed/simple;
	bh=W+rNoaYzssrQZOEw9qVUnJWErByLuHW1tO6rbCtD26Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Slc4WJwQlLqZq1G5+d245EnQ9KczJkl8r9Pi01tJXgWZnQSUmAhble4QjHlqQSl3twB66l7pTdCPCXhX0nFinhP/FItRIfUFolfTQumVw6Y2tH5XU/gZzwyRSNIOxs52hSXwbY80m+qX0ziL561jHFEHWeL7xpCGUHcfA2SUWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V1gDmwXJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V1gDmwXJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788540839;
	bh=W+rNoaYzssrQZOEw9qVUnJWErByLuHW1tO6rbCtD26Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1gDmwXJIl9PnSUo9aYxBT4ihvC75r9cHwEoiSzhmAzH3Q/jaSfxY/cPDCGRluSpw
	 zyOzIvJSpZsyOSUI+4sjhkZkJqr0FImC9XP90l9ZZEhXFxfbMFrJ+tm2CWl84CqZ20
	 oIzKFS3LZaRZ5JUn+px+jyKWlpEnTurKBS9IHoAHm7Y5ypEfO0r6RvbjDgysHJMPG/
	 MwltGd45dB5iqCd7uXUxpNQFZraE4MEDkPLYkd9+yCYP9Y4GxVqpY49B7qjSiWCXeL
	 M3Va/xj29K22PSsYUv/JH9ENhn/6xFomkV73uMh5c7z891o9S+ZBQd9j3V1k/RGI1I
	 addMS07Nqg2EQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E1D417E092E;
	Fri, 04 Sep 2026 18:53:58 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH 4/4] unit/test-mcp: Test unsupported RFU opcode
Date: Fri,  4 Sep 2026 22:23:32 +0530
Message-ID: <20260904165332.42046-5-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904165332.42046-1-raghavendra.rao@collabora.com>
References: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
 <20260904165332.42046-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

Verify that GMCS/SR/SPE/BI-01-C opcode 0x00 produces an Operation Not
Supported notification.
---
 unit/test-mcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

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
-- 
2.43.0

