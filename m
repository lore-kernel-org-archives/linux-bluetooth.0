Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC044403;
	Fri,  5 Jan 2024 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RzaE6CDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W/BE1
	H26lT73ypRwxj9iex/0IgYxdoHST44/6jTUsyU=; b=RzaE6CDW9Gn9k+nvv/r6A
	c/34bfCYK1aTD5m/HSQwDYHvs2PRTmjJRwcf87VFM/KZ5cFRSVOug/tDdxskuhr7
	jhMOtjdGd7wfKsw2w/1DmaUGi7r55EmnTExb8cHFDNwenzfODcQ4oiIa6+145f4D
	zYioW657/hMxkLHXwAMD9I=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3n0hQc5dlHOY8AQ--.11850S2;
	Fri, 05 Jan 2024 11:11:14 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Date: Fri,  5 Jan 2024 11:11:11 +0800
Message-Id: <20240105031111.132851-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n0hQc5dlHOY8AQ--.11850S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1rZryrXFyUGFWfKw4kWFg_yoWfCrXEga
	10vFW7uF48JrykAF45uayrWr1ayrySgan7Xr9IgrWxAFZ8Gr1UGFn7AasxJFn3uanrur1x
	Zr4DJFWF9r409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeiXo3UUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisB1cuGV4HNfAnwABsB

From: Clancy Shang <clancy.shang@quectel.com>

bluez lib could not receive MGMT_EV_DEVICE_FLAGS_CHANGED notifications
after sending MGMT_OP_SET_DEVICE_FLAGS

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9dd815b6603f..c74abdf3618f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5177,7 +5177,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 done:
 	if (status == MGMT_STATUS_SUCCESS)
-		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+		device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
 				     supported_flags, current_flags);
 
 	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,
-- 
2.25.1

