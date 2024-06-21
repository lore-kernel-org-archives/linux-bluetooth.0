Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592A15218A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975430; cv=none; b=FdmVAhWtmNs+jIklZciiabvx9rNQ/IXIj0CzXab8ZkfIA7fdMb6hYddgUsY/MOhPOi7W/dGIScddix5zxssD+SQRJZUOv88OT5foNXyPtQ1+Qcl4SxChrpX3UKv8VffdnDlbN+iYw7yUimwFZC8u7LKKUwq3y/16KEhxYlAR7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975430; c=relaxed/simple;
	bh=ZpGG66K0AB4VmcER42/eoNA87wRpoe+V7RsDzZN0nIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMohWBzBmL3DBrPD0czr2m3ypTPOKSUkyQNYIjXoAf/q2cRr/zrK5W/pCGuJMC5FVh3vuIjVDMF9mp/HrpvnhK1TpbAf4IZ3zGKF6cImzvMRUdpZrMICKhlUMxS4If+l6m5Yj6O6K0NOdWHmi//q1E0NJrW0UC7OJ31Ta4nXS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=f3dNkydi; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="f3dNkydi"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 0833B665C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 16:03:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:38a3:0:640:a710:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 7CB9F60B37;
	Fri, 21 Jun 2024 16:03:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id V3LjCtoOgOs0-F5mqmXzt;
	Fri, 21 Jun 2024 16:03:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1718975013; bh=EUvY+b+VFa9Rhy7rOctxHbz7ZEIvhb8WKVL0LHg+VJs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=f3dNkydiJNPOlU/rMUPaI3Dtg6ma/NOpQCl0ZEOLSnjHCypf5mU9QXOn15OH7loZM
	 HmfTltBOG8T4T7bDdqA/6BXuybEI7ddgkcoAZmvKtYJ96So44TO+uP7OT5uCcbfwuy
	 Bfi15hcnZ3ri6YrJej7utb5jWPHwCmYi9EqfPgGQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] Bluetooth: hci_core: cleanup struct hci_dev
Date: Fri, 21 Jun 2024 16:01:55 +0300
Message-ID: <20240621130155.314280-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused and set but otherwise unused 'discovery_old_state'
and 'sco_last_tx' members of 'struct hci_dev'. The first one is
a leftover after commit 182ee45da083 ("Bluetooth: hci_sync: Rework
hci_suspend_notifier"); the second one is originated from ancient
2.4.19 and I was unable to find any actual use since that.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/bluetooth/hci_core.h | 2 --
 net/bluetooth/hci_sync.c         | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eaeaf3dc07aa..31020891fc68 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -476,7 +476,6 @@ struct hci_dev {
 	unsigned int	iso_pkts;
 
 	unsigned long	acl_last_tx;
-	unsigned long	sco_last_tx;
 	unsigned long	le_last_tx;
 
 	__u8		le_tx_def_phys;
@@ -528,7 +527,6 @@ struct hci_dev {
 
 	struct discovery_state	discovery;
 
-	int			discovery_old_state;
 	bool			discovery_paused;
 	int			advertising_old_state;
 	bool			advertising_paused;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index eff648853ae1..511e995f17e0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5840,7 +5840,6 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 		return err;
 
 	hdev->discovery_paused = true;
-	hdev->discovery_old_state = old_state;
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
 	return 0;
-- 
2.45.2

