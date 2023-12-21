Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB49D2E8;
	Thu, 21 Dec 2023 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GJA0hbno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sCIGd
	908KGaLciTKPmUVUhZRPsc+reQE3D9Ci4aofO0=; b=GJA0hbnoWdi0tsAdVqZbk
	m3Z2aA4wxhRfhrovkvXq3WTEuKF8QonNZv9Nma3Al08/LtSVjAsSsNpSkbkBGoD7
	u9VkQ4DPQJklcU/+DWzmiPU4m66XFRpcSB28WI1+6e03pd597ePyN8GtQZ0HkI0m
	Cj9BBPWJUIRs5KMtlJPpD4=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wD331tG5oNlHQs0GQ--.28665S2;
	Thu, 21 Dec 2023 15:16:24 +0800 (CST)
From: 15013537245@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	clancy shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
Date: Thu, 21 Dec 2023 15:16:21 +0800
Message-Id: <20231221071621.1154462-1-15013537245@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331tG5oNlHQs0GQ--.28665S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw45try3XF1xXr1DtrykAFb_yoWDCwcE93
	Z2yay29w1DGrWxZa1qyF4kCF4xZw4fWF4ku3s3Za4jgr98Wr48KrWDXF9Ykr1fW395Arsx
	Ar15WFWSqrW8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe6Hq3UUUUU==
X-CM-SenderInfo: rprviiitvtljiuv6il2tof0z/xtbBEAxN12VOBFRzTgAAsA

From: clancy shang <clancy.shang@quectel.com>

when Bluetooth enter suspend, and disconnect everything with the diconnect
reason code of 0x15,the hogp device could not into sleep and continued
advertizing. when use the diconnect reason code of 0x13, the hogp device
into sleep succeeded.

Signed-off-by: clancy shang <clancy.shang@quectel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d85a7091a116..16b5420c32d0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5927,7 +5927,7 @@ int hci_suspend_sync(struct hci_dev *hdev)
 
 	if (hci_conn_count(hdev)) {
 		/* Soft disconnect everything (power off) */
-		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
+		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_USER_TERM);
 		if (err) {
 			/* Set state to BT_RUNNING so resume doesn't notify */
 			hdev->suspend_state = BT_RUNNING;
-- 
2.25.1

