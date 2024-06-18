Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004BB1BF50
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737621; cv=none; b=ZFKT1N9yK1d1MeG3YWC6oSdERlfhOos0pg3Ofib+I2sQeKntMJrgAkcMTjpZHwP2NOBPb2U/r330PdVOTrj10Exb1eDtOgvVCjVBFZL33xoSjTNiI31b2pBM8gzfA2JUL3qKTu4fYNsktrUPw/GK6UfDk1aHPkPl63mse5EPl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737621; c=relaxed/simple;
	bh=aUeh61bxbfIK/Jv5b+Bk7RfUTa3kqTcqNBi9cAKmhn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MS/yGf1rtJEcKj7TaZuxWRn++IdGkoX1hIQ+sU9sGk+dwAF2kjDjRtKCtCybDSvg/CCynV0J/4q8fe3zjimywdhROmU9x+zVEtwRiIP7tuc5uEbga5YUwPBzHrJJHk9eSE1UGfP9n22VFuwy6xMc77P9eEo4zs3uZ6Yotc7FOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=w3MaYI4Q; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w3MaYI4Q"
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id 08A0965D66
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 21:59:44 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:489e:0:640:3c5c:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id BC07960916;
	Tue, 18 Jun 2024 21:59:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZxNGPCMd8mI0-64uTbmc8;
	Tue, 18 Jun 2024 21:59:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1718737175; bh=3hAiIMW9n9ySVBijyfm4E4eXKV6/XaGObAAFvtGxPaE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=w3MaYI4Q3pnfvp0cgsb3jrl3UN9LddnzqvwdO/vJUeXg8qZPqB9Q0qPduIcl4MAMh
	 buiZP8yeoNiL5/rx5/EixDiszW2m9tdoNd1VL6YRivw9muYeYzZgNSplrDGCrMWzw2
	 xsesyu5BFvKorCpvW1Jnkf2C5Hr6Sh80I1lA4Il4=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] Bluetooth: hci_core, hci_sync: cleanup struct discovery_state
Date: Tue, 18 Jun 2024 21:59:32 +0300
Message-ID: <20240618185932.49963-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 78db544b5d27 ("Bluetooth: hci_core: Remove le_restart_scan
work"), 'scan_start' and 'scan_duration' of 'struct discovery_state'
are still initialized but actually unused. So remove the aforementioned
fields and adjust 'hci_discovery_filter_clear()' and 'le_scan_disable()'
accordingly. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/bluetooth/hci_core.h | 4 ----
 net/bluetooth/hci_sync.c         | 2 --
 2 files changed, 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c43716edf205..b15f51ae3bfd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -91,8 +91,6 @@ struct discovery_state {
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
-	unsigned long		scan_start;
-	unsigned long		scan_duration;
 	unsigned long		name_resolve_timeout;
 };
 
@@ -890,8 +888,6 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.uuid_count = 0;
 	kfree(hdev->discovery.uuids);
 	hdev->discovery.uuids = NULL;
-	hdev->discovery.scan_start = 0;
-	hdev->discovery.scan_duration = 0;
 }
 
 bool hci_discovery_active(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a8a7d2b36870..d126b4ef4e0b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -358,8 +358,6 @@ static void le_scan_disable(struct work_struct *work)
 		goto _return;
 	}
 
-	hdev->discovery.scan_start = 0;
-
 	/* If we were running LE only scan, change discovery state. If
 	 * we were running both LE and BR/EDR inquiry simultaneously,
 	 * and BR/EDR inquiry is already finished, stop discovery,
-- 
2.45.2

