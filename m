Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AE19442;
	Wed,  3 Jan 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UkbQnUrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=chNQa
	qyjmqQSTbtOWxsw9RHKFvBwS7P46pvgdz+FY1w=; b=UkbQnUrmk4B1bUUWoQHSk
	4vFpgPyfBnMSpsTiX7PNJHc+PT4Ow4ZEvxHbiVDbxlYN5baFyYl4yBI4342Pa/j+
	0pDUw81DO/ckZ8z6MaqEX3kYFAdKq4e8CbHxFRnZcqZX5NEeyqaNZxha2hfi9F0I
	0oSLpx7RrxTMjR/eCkc+UU=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wDXP4r7MpVlGNmfAA--.162S2;
	Wed, 03 Jan 2024 18:12:12 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
Date: Wed,  3 Jan 2024 18:12:01 +0800
Message-Id: <20240103101201.1812679-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP4r7MpVlGNmfAA--.162S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw13CF1rKFWfCr45uF4UJwb_yoWDZwbE93
	ZFyay29w1UGrWxZw4qyr4kCr4xZw4rWF4kur93Z34jgF98Wr18GryDXF90kr1xWa95Arsx
	Ar15WFWSqrW8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeiNVPUUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/xtbBzQBauGVOBNCX7gAAsp

From: Clancy Shang <clancy.shang@quectel.com>

when Bluetooth enters suspend, and disconnects everything with the
disconnect reason code of 0x15, the hogp device could not into sleep
and continued advertising. when use the disconnect reason code of 0x13,
the hogp device going into sleep succeeded.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
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

