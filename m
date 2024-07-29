Received: from mail1.khirnov.net (quelana.khirnov.net [94.230.150.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130278004E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.230.150.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269148; cv=none; b=S41dRn9jB3gi9AyobsBmklbtPxWN43rQ7d/J5qyUaJbCukbyzUGSnTHEcxFggkTZzqbIt5fv34kqCNsu101mZIguUG69mFYrysSdgAuuAXOFUwaSXOP8ISMK0qQoTRPHkeNpDAUCOhUW+rSG/0AFTcMBjQH6DIhCaDpRlN/oW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269148; c=relaxed/simple;
	bh=hoQRoSYKXrXcT0dwcI9MQbSsaXRRq0I4nioosoRjaxA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=IkTDj2SkYVMORUlDarhceTa2jzRkodJ6+9X8ULsiBwSyIAuVHO07GglNxAKvlSF69VUYjQVYk/q6gnSlQj23doL918l4X/P3Z2+5VuDrD6K8EehAUEbVoqA4hxTI5i5rpuRkIAYD949jpTx9WOzhZeAdagCqR7EOZh6wwwfTyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=FvuPCyJZ; arc=none smtp.client-ip=94.230.150.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="FvuPCyJZ"
Authentication-Results: mail1.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=FvuPCyJZ;
	dkim-atps=neutral
Received: from localhost (mail1.khirnov.net [IPv6:::1])
	by mail1.khirnov.net (Postfix) with ESMTP id 052124DE1
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 17:59:22 +0200 (CEST)
Received: from mail1.khirnov.net ([IPv6:::1])
 by localhost (mail1.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id YKt60V4eQT8Q for <linux-bluetooth@vger.kernel.org>;
 Mon, 29 Jul 2024 17:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1722268761; bh=hoQRoSYKXrXcT0dwcI9MQbSsaXRRq0I4nioosoRjaxA=;
	h=From:To:Subject:Date:From;
	b=FvuPCyJZ/2272wYipHPP6+P88KJt18NN3VfQOA9euPBbi+9mOz4m1qQa8N/r0CLLF
	 vfCMQlWscsOVTgQbXqoYUW3ecNo4vgzChvyA7Q+iT2vwVFs9Z7EZ9DumpPtwmf5CKO
	 tr39WzAvgrFcut8hBuF+blQHU3LpT8GmgxQzPn3csFLaxwT9m2HLUc59krRlfbOoOA
	 KBKv/L3eSLPKcxytunQY7/cs4egsh+X+K2inpszmWopZfodzdj+S9Rg6ElnWNLpeij
	 +BJq26YTzGJAsWgab+D+A4CRKYEAW60Iwqr2hAUV6bBoiR2i6XcfNWbqNCYlJiI7yr
	 g7BMeXVgy5QDg==
Received: from dev0.khirnov.net (dev0.khirnov.net [IPv6:2a00:c500:561:201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "dev0.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail1.khirnov.net (Postfix) with ESMTPS id E7082EFE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 17:59:20 +0200 (CEST)
Received: by dev0.khirnov.net (Postfix, from userid 1000)
	id BD8FC40341E; Mon, 29 Jul 2024 17:59:14 +0200 (CEST)
From: Anton Khirnov <anton@khirnov.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor
Date: Mon, 29 Jul 2024 17:55:46 +0200
Message-Id: <20240729155546.20932-1-anton@khirnov.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This restores behaviour (including the comment) from now-removed
hci_request.c, and also matches existing code for active scanning.

Without this, the duplicates filter is always active when passive
scanning, which makes it impossible to work with devices that send
nontrivial dynamic data in their advertisement reports.

Signed-off-by: Anton Khirnov <anton@khirnov.net>
---
 net/bluetooth/hci_sync.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a31d39a821f4..e79cd40bd079 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3019,6 +3019,20 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	} else if (hci_is_adv_monitoring(hdev)) {
 		window = hdev->le_scan_window_adv_monitor;
 		interval = hdev->le_scan_int_adv_monitor;
+
+		/* Disable duplicates filter when scanning for advertisement
+		 * monitor for the following reasons.
+		 *
+		 * For HW pattern filtering (ex. MSFT), Realtek and Qualcomm
+		 * controllers ignore RSSI_Sampling_Period when the duplicates
+		 * filter is enabled.
+		 *
+		 * For SW pattern filtering, when we're not doing interleaved
+		 * scanning, it is necessary to disable duplicates filter,
+		 * otherwise hosts can only receive one advertisement and it's
+		 * impossible to know if a peer is still in range.
+		 */
+		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.39.2

