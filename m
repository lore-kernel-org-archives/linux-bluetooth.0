Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724883D4112
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228066; cv=none; b=GfnzKFDr7kfDpCc4Mrppze44psof8qzHPmUgsVwibZF4A5QK/edMj3FcKgSvniPEw0ZM3vtLUDtylqmmz1djdCLbyxjAKnqzx3XvVM9nTglvDlU/vbC842pghKjXf0s57JtTNWFftgejFeLdCWeSzHFTY99AjDN5wxec3jtvXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228066; c=relaxed/simple;
	bh=3TF1sHdsYHd/WBoG5BMjlNSxtCKxldERbBipiULC6Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Igxk/qTAvkBlvZSrAnyKDx6FKaXaF51eHTHLaBadVwHiKJFe42qXqlYpIdxW3J1mbu5zbhJgCp0kjjbojcF3xPJk91/rvecbNgZ91KraYO9LMMqi563tfWZukMD8d2cChpdyTXZM0ZkWPpAGKSRgdnsMncI8j1DLOPng9sdCKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pVvlGVyW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pVvlGVyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4/
	/KsotP+nJXl2MKR2d7sYSxlrv0R0q9Koe601k28oY=; b=pVvlGVyW1YnOouExAa
	e46TlQmjWOs5YwfDEWvpTvod7bZVJhD9z9qPGuRghBe01Ugtj9c4kCWJ/3F8Dh5q
	p8nvstUaeXTFdZbkYWw+LyfdPQnoCQoX9jbaYjWcPQDs/Wd/o4RMjHyEIWTvP795
	Gjos3SZzco1Fd0XYkaS3BAILI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnNVurMZZq0uB6TQ--.42773S2;
	Tue, 01 Sep 2026 10:00:13 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	luiz.von.dentz@intel.com,
	pav@iki.fi,
	zhangchen01@kylinos.cn,
	zhangchen200426@163.com
Subject: [PATCH v2] Bluetooth: hci_sock: Reject raw operations while powering down
Date: Tue,  1 Sep 2026 10:00:08 +0800
Message-Id: <20260901020008.3846265-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZKH6c7oxcvrTomzL84dy6sMXXNRb6MoHPZr_oKG-bO_5Q@mail.gmail.com>
References: <CABBYNZKH6c7oxcvrTomzL84dy6sMXXNRb6MoHPZr_oKG-bO_5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNVurMZZq0uB6TQ--.42773S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWkAw43GFy3GF4fCrW5GFg_yoW5JFyUpr
	ZYkFn0yrWxXr1rW3W8tayxCF48A3Wvv3yDGr4Ut345JanIgrWFq34IyrWjg3y5JrZYyF1r
	ZF9F9r4fZ3ZrGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEbAwnUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC5w23VGqWMa3ruQAA37

From: Chen Zhang <zhangchen01@kylinos.cn>

When an adapter is powered off with devices still connected, the
shutdown sequence issues an HCI reset which returns Command Complete
while the controller firmware is still rebooting. A command sent
concurrently through a raw socket during this window (e.g. hciconfig
queries triggered by the Bluetooth status change) can leave the
firmware in a stuck state where it stops answering any HCI command.
The subsequent power on then fails with 'Opcode 0x0c03 failed: -110'
and the adapter is lost until reboot or re-enumeration.

Unlike the ioctl paths (HCIDEVUP/HCIDEVDOWN/HCIDEVRESET) which are
already serialized by hci_req_sync_lock against the power off
sequence, raw socket command transmission goes directly to the
transport through hdev->send() without taking the lock, so it has to
be rejected explicitly:

- hci_sock_sendmsg(): reject with -ENETDOWN while HCI_POWERING_DOWN
  is set, extending the existing HCI_UP check
- hci_sock_bind(): fail early with -EBUSY while HCI_POWERING_DOWN is
  set, avoiding HCI_USER_CHANNEL to be toggled (and the controller
  to be opened as user channel) right after power off

Changes in v2:
- Drop the HCI_POWERING_DOWN checks in hci_dev_open()/hci_dev_close()/
  hci_dev_reset() (hci_core.c): those paths are already serialized by
  hci_req_sync_lock against the power off sequence, checking the flag
  outside the lock is redundant (as pointed out in review).

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 net/bluetooth/hci_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..897596614939 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1296,6 +1296,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 		if (test_bit(HCI_INIT, &hdev->flags) ||
 		    hci_dev_test_flag(hdev, HCI_SETUP) ||
 		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
+		    hci_dev_test_flag(hdev, HCI_POWERING_DOWN) ||
 		    (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
 		     test_bit(HCI_UP, &hdev->flags))) {
 			err = -EBUSY;
@@ -1850,7 +1851,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto drop;
 	}
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
+	if (!test_bit(HCI_UP, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
 		err = -ENETDOWN;
 		goto drop;
 	}
-- 
2.25.1

