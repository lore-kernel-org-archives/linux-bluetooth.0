Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC953B0588
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165847; cv=none; b=Nsk7pvACsRY2K85Jzys21PkZ0/5nMSilhmltAp1vpb+ReDDNMa+RZqd4LVb0j5R8e3RVr9qcsaJo/8byV77/RdL1/ww+kiNam9Y5kErhklb/87SqJPoqo8y8+eYM210IDcO2zO7XUoigRIV/RXDFtAVnl8QgcAEbdaw2O816DyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165847; c=relaxed/simple;
	bh=Bp30F1/SB6kVARtPOg2I7rVp9M/mkWlYhMd8lCNJpOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7cBIV7Xke0H1FN9vGQi0UpuiclnWYq4TT0kivtlBtBD8kJ4pL59mceflbcAAoDcDRdc+4aV32iccJmid8mitWSUvKQ4CVydEUNkj/BCbhB7kgPz8yRibyEdwq7xYMMFwAnWkCjt0DLhOHYvFh252RP9hdoPHich45kaKZC9B+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cueYahl2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cueYahl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GE
	ujmdh/oRxptyyTqSYMqeer8UL5Fo7k6zOTuxsKygk=; b=cueYahl2F4wKf3oQR6
	Yq8w+3AKceZF0yCLjwl1SoZScGgzVJty1AMmanPQ3gy1AYSo8OawuPQO7FL2FlsM
	CpCVvhA4ZJVYa7UASgSAZEjAI/FoRl3kuURp3s+gKeuCVwMzQdn7p54IOMal7FQ0
	aiWEJVNtfxQCiu1q4NhRf4GPc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHHCGzPpVqlPitPA--.24552S2;
	Mon, 31 Aug 2026 16:43:33 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	pav@iki.fi
Cc: linux-bluetooth@vger.kernel.org,
	Chen Zhang <zhangchen01@kylinos.cn>
Subject: [PATCH] Bluetooth: Reject controller operations while powering down
Date: Mon, 31 Aug 2026 16:43:29 +0800
Message-Id: <20260831084329.3141802-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHHCGzPpVqlPitPA--.24552S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1fKrWUWF17ZrW8Kw1fXrb_yoWrXrWfpF
	Z5AF1YyrWkJF13XF1ftayxAFWYyFn2v3yjkF12q345Aws0q3yUtw10yFyUK3y5CrZ5tr1r
	ZFyq9rn3ur47GrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbCztUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbCvxW8WWqVPrXd3wAA35

From: Chen Zhang <zhangchen01@kylinos.cn>

When an adapter is powered off with devices still connected (e.g. a
Bluetooth keyboard or mouse), the shutdown sequence issues an HCI reset
which returns Command Complete while the controller firmware is still
rebooting. A concurrent command sent through a raw socket during this
window (e.g. periodic hciconfig queries triggered by the Bluetooth
status change) can leave the firmware in a stuck state where it stops
answering any HCI command. The subsequent power on then fails with
'Bluetooth: hci0: Opcode 0x0c03 failed: -110' and the adapter is lost
until reboot or re-enumeration.

Reject controller operations while HCI_POWERING_DOWN is set at the
public entry points in hci_core.c, which covers the ioctl (HCIDEVUP,
HCIDEVDOWN, HCIDEVRESET) and raw socket bind paths:
- hci_dev_open(): return -EBUSY
- hci_dev_close(): return -EBUSY
- hci_dev_reset(): return -EBUSY

In addition reject raw command transmission from an already bound
socket during the power down sequence in hci_sock_sendmsg()
(-ENETDOWN), and fail early in hci_sock_bind() (-EBUSY) to avoid
toggling HCI_USER_CHANNEL while powering down.

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 net/bluetooth/hci_core.c | 28 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c |  4 +++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d1e78ae7728e..a0533f260471 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -445,6 +445,16 @@ int hci_dev_open(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	/* Reject opening the controller while it is being powered down:
+	 * the firmware is rebooting after the shutdown reset and any
+	 * concurrent command sent during this window can leave it in a
+	 * stuck state where it stops answering HCI commands.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	/* Devices that are marked as unconfigured can only be powered
 	 * up as user channel. Trying to bring them up as normal devices
 	 * will result into a failure. Only user channel operation is
@@ -515,6 +525,14 @@ int hci_dev_close(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	/* Reject closing the controller while the power off sequence
+	 * is already in progress (see hci_dev_open for details).
+	 */
+	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		err = -EBUSY;
 		goto done;
@@ -556,6 +574,16 @@ int hci_dev_reset(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
+	/* Reject resetting the controller while the power off sequence
+	 * is in progress: the shutdown routine already issues its own
+	 * HCI reset and a concurrent one would hit the firmware while
+	 * it is rebooting (see hci_dev_open for details).
+	 */
+	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN)) {
+		err = -EBUSY;
+		goto done;
+	}
+
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = -ENETDOWN;
 		goto done;
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

