Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469D12E1FC
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218594; cv=none; b=uRf5QZHhcg4Obv6h0CoxFejIxFI0FDPpffIV6orzIdDBpAi0FUdHvSHdFcUZtcStQ205Zl/tS8K9NCQDIbYkSENN+F9Ikvemp8C3Fq1aW+uqjDSF2+8niPD+34DRLeIn6ljYT28AyZzm2e+LzpwiaOZU4OXhHczdi9L+6Db5awE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218594; c=relaxed/simple;
	bh=wyBQMtAQ77Mo9NLIgT8063PW5DnJNq5je6ORcAdKM0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbnfrLU82qUGc8vyeYZJqinYktm64RGNLjS2geRAq2Vk2qrNk82UQ3wujkijniNRLPspmG/coxGbp6FfBeawvCyGDVDrtm6k8Jvok28g911yrNllMzd7tuViFiVtAR4XSVtJki7ZodUF7wuy1YwDi5rYyE3no5GjFRZjsgP0RqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TTgph5kHbz9stk;
	Tue,  6 Feb 2024 12:23:08 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ v2 2/4] mgmt-tester: Adjust a test for recent kernel changes
Date: Tue,  6 Feb 2024 12:22:51 +0100
Message-ID: <20240206112253.76446-3-verdre@v0yd.nl>
In-Reply-To: <20240206112253.76446-1-verdre@v0yd.nl>
References: <20240206112253.76446-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the changes in the kernel to move to hci_sync for connecting ACL
devices (see kernel commit "Bluetooth: hci_conn: Only do ACL connections
sequentially"), the "ETIMEDOUT" error path for the "HCI Create
Connection" command was changed, sending a "HCI Create Connection
Cancel" command after the timeout.

This leads to the returned error in the "Pair Device - Power off 1"
test to change from NOT_POWERED to DISCONNECTED, so adjust for that.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7d884bbf6..767cd5cda 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3216,7 +3216,7 @@ static const struct generic_data pair_device_power_off_test_1 = {
 	.send_opcode = MGMT_OP_PAIR_DEVICE,
 	.send_func = pair_device_send_param_func,
 	.force_power_off = true,
-	.expect_status = MGMT_STATUS_NOT_POWERED,
+	.expect_status = MGMT_STATUS_DISCONNECTED,
 	.expect_func = pair_device_expect_param_func,
 };
 
-- 
2.43.0

