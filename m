Received: from mail1.khirnov.net (quelana.khirnov.net [94.230.150.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4285628
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.230.150.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283149; cv=none; b=pDTyGUqf7Ppy+KrPaWF1I1JGsZs1ihOQL8zj/+GIkup1dJyDLIRC5YT3vvc87BVE5g9i0wTxfjZRtzIi8N22LAgn4GU/qFOUZmsDo/YgdxGkILhjXk2M1gbsPoH3ozW6zwg6I9ItMx4XMwEWo8p+wwSaCt1ftelD6sRT4CIlV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283149; c=relaxed/simple;
	bh=QunWEtDDK5Q+zBpMcXG9j39lSv4hjQt7iM+24VlTSMo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=B7B/A4K+AE0Yl6lrrzKRs2hQFVfZnRnFqYyuY3c3xB6L3RJbtMxUo5yE9xVUiJHGyry5MRJG2e7qEzXMZXV/HU7VS504W9+lW/wkuorLDicVkZ30lijhRgGO2rYRvbfBZB+7JcD/pxMwxEyTS/6Trc1U2BrcjW8P9FgMtAXXo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=B0+y2ij+; arc=none smtp.client-ip=94.230.150.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="B0+y2ij+"
Authentication-Results: mail1.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=B0+y2ij+;
	dkim-atps=neutral
Received: from localhost (mail1.khirnov.net [IPv6:::1])
	by mail1.khirnov.net (Postfix) with ESMTP id 02F9A4DE1
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 21:59:01 +0200 (CEST)
Received: from mail1.khirnov.net ([IPv6:::1])
 by localhost (mail1.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id kTqtQGjdsOCS for <linux-bluetooth@vger.kernel.org>;
 Mon, 29 Jul 2024 21:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1722283140; bh=QunWEtDDK5Q+zBpMcXG9j39lSv4hjQt7iM+24VlTSMo=;
	h=From:To:Subject:Date:From;
	b=B0+y2ij+YJM0e7SNT32DRipan5bZstInASUfhbrvU4dXMprX0rKGZTsyQ/aiFA63g
	 /jiMTt8Mp5UtbjhUONwixecHVZxbh8VvkcdKOxUngvrcT14WsgrU+i03+Vli+nNCsK
	 UsfJYunh7VzvUiJXQY1Kk219cIecLrGvXCc1lZAB/K+239xhni1Y9+v/Wq24mXYatS
	 3tPVtD+apTqnIkxei/atMhVZvjVhnComxlHKdiTuyZAw8qyqBqpJ9NvA9C1Q69EgTU
	 sXOXgDUddnBJtgug+M5oTqJUjVatDFtzqNnK+w192oM2/HceZsJVXwxWpR2BAUPLAt
	 C9IesUWJXbxrA==
Received: from dev0.khirnov.net (dev0.khirnov.net [IPv6:2a00:c500:561:201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "dev0.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail1.khirnov.net (Postfix) with ESMTPS id 0DDD2EFE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 21:59:00 +0200 (CEST)
Received: by dev0.khirnov.net (Postfix, from userid 1000)
	id E8E3340341E; Mon, 29 Jul 2024 21:58:59 +0200 (CEST)
From: Anton Khirnov <anton@khirnov.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor
Date: Mon, 29 Jul 2024 21:58:10 +0200
Message-Id: <20240729195810.25040-1-anton@khirnov.net>
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

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")
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

