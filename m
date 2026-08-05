Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FC3ED5A6;
	Wed,  5 Aug 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926217; cv=none; b=ZapAcZTy88wj0M7pIE340ajWAq/qOy+bNj3uK5Rf5g6XYty1q5J88zK2pGwqtTRdygx7sKegRbWCphyglrQiyZrKK3W7Ra2d/j+tthF3sRcDqM++5GPJLex0d6vH3u8xQycr6SDQ7GjWT1Pi72atzxDtIffWv33AhCC6lXb/uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926217; c=relaxed/simple;
	bh=wweRSA3jZ3JksQoGA6B2PixqNeG8hu3QgEAPHfsdFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0pjpHdNVlq0gs/w+3YyWRv017C+kO/6q9xmvyFh45ewjanB51hDkITqF0ABV/U89KSTCjV7iUCVt7WTM6X+NWVnc7EcYCtqqqpRcPowkAZkVOV3wkEbrdYmgbVoRpWAnEGZqBOroNbP5REN78o5Xf/N9ekdj3pSCKktbOgjbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Tof/fQnG; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Tof/fQnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785926191;
	bh=1cSBFG13E11AsLThh/tacwvn7sqfCKvF2OEgcJZy1gY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Tof/fQnGtdTeIJu4ZQcikxq0owMjX5M/xwZYBdwI0r6GSBbMgW4hVvfFymOhBdqTq
	 eBcmnsmJKawlHcbbbodtapz6wnKX7FGIOVK7tjbdmX57/Jnt/wITMdBESTYvgOr4Hs
	 37RA5eIMPwk32CYcJsHJV4Tp6GI/5VVqbAnEe/8Y=
X-QQ-mid: zesmtpgz6t1785926185t0c81c0f3
X-QQ-Originating-IP: /CnueA4ypeRJgnbz1VrRsGBrk6FsYmdfwWthFyjdBts=
Received: from PEN002676 ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 18:36:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9662022247066101482
EX-QQ-RecipientCnt: 5
From: ZhaoJinming <zhaojinming@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
Date: Wed,  5 Aug 2026 18:36:12 +0800
Message-ID: <0BDE51B0554940FB+20260805103612.916678-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MyhNtuNETree+iwqgL3l6cnLmc68yTGsl2OctM44KBGxQAYsi7UVd7Wm
	vGCyuY4ztNn/1pcO6i9UPe2FD+yuV2FXs93enXRAjCSu0i3qcQ99nYdSFo7SXMb2vjcbqNw
	gTFl5kLZ50qUMon6w7VsHRX7J7fCh0Y5COKKx5u0lpMlKKqw1DfgQ/zoPehO+2qWevwweuy
	HTYdhIXA+Y3BNuLzptffSxg/Zk8QHsjjxZQ+Qah+CP0aHPvbD9Nc3OTE6YK9gysFn5LHDAZ
	FktVMVK9stE3hkeOB2SCsdE0wobOdAaLZc4mjd8Hf00GWAg1U9itimWD70eXAdHMkGQ2P2U
	pH1XVaEfvcihiNNcV4bbmIdX3yQS5v+1k6AISKOP/IxS8GLLBjdnfJjaUHAa9cwT/179pkz
	vh99kPlTV6gbuAbxInyQ26RFh5kfgTMpDe54HfAVHwVbMEU4rWG4ytB9qXsHivMd7QIxZkz
	AZut84OSBuLkEul7o+78dnsqRzapXS6RGM2cmmKnDaaS8mJEzFugCPAux9xszJBgoueKtez
	cDp/kE5A0TWK/y8+JrkSBYCivl5UdpiPs8fQCokK9BJKyA2PxmxI1NgFww6kxfWDTMZEQHJ
	qBqnSYNDFCT3/NDQKc6ntAuKVDJ8tYRCUAGf6kJ1GsdSKRCmtnuvfGlP3pRWjC1MgNsZNO1
	xngSJXnEyXVMwcb/xEZjh3BmsKNfM4t/tgEka52McE2w5+PAjws5JRecdr8ap9guyUJVRPf
	iCvEeMJWERQuUGFSeCbNdlwChwTSIGSnLR/QSRBaZUDYd7fCj7blwNUePGevpWy8Wjumy+K
	6jEJ7LWAdwRp/A1ixvm7qfghCXXoshVsDlf0bNFmg0AlSsVtlA89WaLdbLaIzGKwZERCNBd
	s3wGxxSIwg+0VS9XQDfoUze+UE+uifZnraCjEJR8+JUBG2o33CkRnZa5hfNgB+6ouGts3Rp
	SX+UVb+gSNv2obWboHRV7HDnRtX7/s0Cd3UvMcc5z5RmtTgAt8PUKnfkXyoMBnZ0BOta6vX
	fyQBTNOm3wqLlL6yc7woU2HviZ1mE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

hci_uart_unregister_device() frees the HCI device (hci_free_dev)
before cancelling write_work via cancel_work_sync(). If write_work
is executing concurrently on another CPU, it can access hu->hdev
(serdev.c:61) and write to hdev->stat (serdev.c:75, 83) after the
memory has been freed.

Additionally, HCI_UART_PROTO_READY is not cleared until after
cancel_work_sync, so the write_wakeup serdev callback can still
schedule write_work via hci_uart_tx_wakeup() even after
hci_free_dev has freed the device.

Fix this by mirroring the same ordering used in the tty/ldisc path
(hci_uart_tty_close, hci_ldisc.c:565-593):
1. Clear HCI_UART_PROTO_READY and close the serdev port
2. Cancel write_work (no new work can be scheduled)
3. Unregister the HCI device
4. Close the protocol (may access hu->hdev, e.g. bcm_close)
5. Free the HCI device

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/bluetooth/hci_serdev.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 593d9cefbbf9..e06b9d5b3846 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -397,18 +397,22 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 
 	cancel_work_sync(&hu->init_ready);
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_unregister_dev(hdev);
-	hci_free_dev(hdev);
-
-	cancel_work_sync(&hu->write_work);
-
-	hu->proto->close(hu);
 
+	/* Clear HCI_UART_PROTO_READY first to prevent the write_wakeup
+	 * callback from re-scheduling write_work via hci_uart_tx_wakeup().
+	 */
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		serdev_device_close(hu->serdev);
 	}
+
+	cancel_work_sync(&hu->write_work);
+
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
+
+	hu->proto->close(hu);
+	hci_free_dev(hdev);
 	percpu_free_rwsem(&hu->proto_lock);
 }
 EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
-- 
2.51.0

