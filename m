Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77696086B
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528959; cv=none; b=mQzQUAH/6KU/sqj+ZFDGm7P1LE9PKDcJna+WXBQk0ZC9pWRbY789+xchcrabbQTsYlMYrg2TH5I9LN2sOQLa2SE339yqJy04JyjoP9cmkI9cBQBog/MwZNzPB9FH0NCZA94/b92k9FWe/zD6tINNLyBNqt+sOKVpwrtAP11+MPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528959; c=relaxed/simple;
	bh=JrdX4gG/uCk0OZpF5qXRdtzFqv9g7kPjMhpd30rLtjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCnFkO1g4UaWeZmdDYZ1aK2zwKhRs96Dqq2AiqQTKITO4hxE3akmLgBeTX6ngpm30WYwkl5l99/QZ0cy4IBOACqhrhJD9sNcMp0oL0rNU6ntueiUan4UhhpnfUBSD5f8BXWURn1Nps4YtxLLxeVk3HrKjfdTvKFI9ui0ukLW9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TNmmN2S8bz9sZv;
	Mon, 29 Jan 2024 12:49:08 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 2/4] mgmt-tester: Adjust a test for recent kernel changes
Date: Mon, 29 Jan 2024 12:48:58 +0100
Message-ID: <20240129114900.92919-3-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-1-verdre@v0yd.nl>
References: <20240129114900.92919-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TNmmN2S8bz9sZv

With the changes in the kernel to move to hci_sync for connecting ACL
devices (see kernel commit "Bluetooth: hci_conn: Only do ACL connections
sequentially", https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/),
the "ETIMEDOUT" error path for the "HCI Create Connection" command was
changed, sending a "HCI Create Connection Cancel" after the timeout.

This leads to the returned error in the "Pair Device - Power off 1"
test to change from NOT_POWERED to DISCONNECTED, so adjust for that.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ee12ed7d5..7c9e63cbb 100644
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

