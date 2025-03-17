Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D924C9F
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237619; cv=none; b=qO7MFMmpEKmv9+4knM7rAwuocVWE2Yuuj9+7InuTZblpYP3qbwn0p2DMnXrtJ7Uw1T0/EGs+1VeQQEiDi79aUYoKxTwSXU8u6nTxQYEyt1KSITJktJC9/ExDMWyT2Xwd3BQuS11E/LIpcvgcgITXC9dMgUtVIqtc+xQANwuKs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237619; c=relaxed/simple;
	bh=sAJfvlsqgTqAA6hXcOOs+RMObFF8SDbHdyMOYBRBznk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owskRhreer72cMgvPTXb26SPf0FZxH2Nk9yRgXxFg6jtL690s6badQwGo6s8ZdDGj2w5YSYTIFo4qpPW9dPw8BYGZqQ5N819cEtgiZNvKqOOBsoY359egn3stnqHhR3i7kXCs5UXs1h+67JXsIBdEjxl4YU7CjlMR/heV9D3NH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CWvllHTG; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CWvllHTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742237593;
	bh=2SMIGmdU0arUnN+8CnilMKwbqZHhcI7tFniL9Z+diO0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CWvllHTGOc7aA/fLZ1KKMA/u6AtmbxlGcZZob5jBBGLPkh7T2dfzLqJoSxq1JguJK
	 swJkg/5zKNyFLcsds2VJ46grS4sX+VxyeWKyVl5U0ihCj24z2Fnw8Br6Ruk4lYxt6Q
	 PQNWvmJl2pREHFIp6XhsNA5YsuLjzaPxfe9DATYc=
X-QQ-mid: bizesmtp79t1742237578t0r4xyka
X-QQ-Originating-IP: IDmb7yvLRFp+32r4kBCU4WPV0+iSbpOD2ulyFtGC5d8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Mar 2025 02:52:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1448328365827845178
From: Wentao Guan <guanwentao@uniontech.com>
To: luiz.von.dentz@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2] Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel
Date: Tue, 18 Mar 2025 02:50:34 +0800
Message-Id: <20250317185033.11476-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MCqxCcyBE+BGcVW+TJjgLixk8fNZfHMwLO9eAl4ldei6X+p5FgQqGR9E
	q8gsN3GGKFm66s+3xFq7kOxTfFWs5oeLX8owCWXxwAVV3OKWwM0MRNNbd2DpxNoyQspyu1n
	5iX+hxZf1XM/tRMSWwQYIRVV85fgw/TZ9vI+qc36ASPFGU2u2x0cVmJqnL8uBREnelO48+W
	Nv0W+ARugMHRQHrbwQ+zGEO8hrGxM2MxHKXRzP5UIRkrsHzR3lhZX6F3LAaDG4FRTzbepb9
	qEbLoSMPv6WlY5eM8n+4Ke381W4FORGGqqOx9qIXVriiOqZdANejj4LrKzWW6O0wXcZRKXB
	okC2so80Qu8sFplXR9Jhy3q6srxzy1WGLzA7bqDw39ijAYkC21ZqexDjTNngL52vsAEu3wQ
	LLJMHmImkVt871i0FgG7rEYqFK9FPxVlM2fJNslWpWWbpZSXfl68WdwbPU5ZfPgxdKTI3Mm
	PT+RuVi7X3CdR4oMYfJzZhbrzfWZxlhMAQ9Sh3hFuooPSw9GcD9ku/+nEhFasjm9t/wOe2v
	w3n7yY1OifDOacirPFHOpK9j+PXIRqXdPImr68qqb2kAfvrrTnoK134guzK3izYsem/NhTS
	zcj6yTi04BlaFuZP7PcxHQ6fG/16sO8SdhWI8KIFzjNH50SppAmcO/0W6tCEioV/BXyFU6R
	Q95DQbYiBy1fGki+On7jQ9tRezgUwQmlhl4gQR+vEG1njmrqUApMXq3BIAHbM1LCWHw9p3+
	bvgC7T3vuv/MtL1c4MdLIZGpJua8uWzGADpGarnVWh3dgAWpcl8MRqMiIqMXJ28Uv+4Ld3X
	zZaZTs4pTzATPvZ6iu1zEZbkGxNdh49NSSktGmbVX1lfLriRCGC1bogs7moPmxzF4iBLyYx
	dcvmLvkaSBB9SxNy02o/wellFKDzwkbkY0yKej4YctAjlbwh59PiM9aj6ABJQAxbR6sbP86
	GnqEsAnjsx/lrtHPeGj6GdH3G7IaFpnzyc+D2s2GBR6IRmirLICfTcm6DSNeO9oojKWuSUb
	s3I0Mg/p2OFY7lZNP6lr69tWyevPABXRLSsKCQNMGEHmWceIkSdqoSsp7Y1WQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Return Parameters is not only status, also bdaddr:

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E
page 1870:
BLUETOOTH CORE SPECIFICATION Version 5.0 | Vol 2, Part E
page 802:

Return parameters:
  Status:
  Size: 1 octet
  BD_ADDR:
  Size: 6 octets

Note that it also fixes the warning:
"Bluetooth: hci0: unexpected cc 0x041a length: 7 > 1"

Fixes: c8992cffbe741 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
------
v2: add Fixes and change rp type.
------

---
 include/net/bluetooth/hci.h | 5 +++++
 net/bluetooth/hci_event.c   | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6203bd8663b7..ffb6524788f5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -856,6 +856,11 @@ struct hci_cp_remote_name_req_cancel {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct hci_rp_remote_name_req_cancel {
+	__u8     status;
+	bdaddr_t bdaddr;
+} __packed;
+
 #define HCI_OP_READ_REMOTE_FEATURES	0x041b
 struct hci_cp_read_remote_features {
 	__le16   handle;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306350..763a8ad9d2b2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -151,7 +151,7 @@ static u8 hci_cc_exit_periodic_inq(struct hci_dev *hdev, void *data,
 static u8 hci_cc_remote_name_req_cancel(struct hci_dev *hdev, void *data,
 					struct sk_buff *skb)
 {
-	struct hci_ev_status *rp = data;
+	struct hci_rp_remote_name_req_cancel *rp = data;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
@@ -4005,8 +4005,8 @@ static const struct hci_cc {
 	HCI_CC_STATUS(HCI_OP_INQUIRY_CANCEL, hci_cc_inquiry_cancel),
 	HCI_CC_STATUS(HCI_OP_PERIODIC_INQ, hci_cc_periodic_inq),
 	HCI_CC_STATUS(HCI_OP_EXIT_PERIODIC_INQ, hci_cc_exit_periodic_inq),
-	HCI_CC_STATUS(HCI_OP_REMOTE_NAME_REQ_CANCEL,
-		      hci_cc_remote_name_req_cancel),
+	HCI_CC(HCI_OP_REMOTE_NAME_REQ_CANCEL,
+		      hci_cc_remote_name_req_cancel, sizeof(struct hci_rp_remote_name_req_cancel)),
 	HCI_CC(HCI_OP_ROLE_DISCOVERY, hci_cc_role_discovery,
 	       sizeof(struct hci_rp_role_discovery)),
 	HCI_CC(HCI_OP_READ_LINK_POLICY, hci_cc_read_link_policy,
-- 
2.20.1

