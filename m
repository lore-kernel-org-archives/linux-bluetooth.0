Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB545970
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="fAPS6Zmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/+aCD
	SDvCkWff7kQfh+ZT1atrjsQegON3DWG1uWF/Gw=; b=fAPS6Zmhe4hXyvq7BCIGA
	kcN1FtTlcP9Kugj1fIbYHpa4JaQbYD5dVLgYOZoSjX6KdG2M/uQvrpb9MBvQ/gih
	ebLnr4miOKaBUjxBUhyWb0hOkCuASYBSKKVy0TsKDSoc22HBy2EN9gZPWqd/ctHl
	xO1DWCJVRupwMneqipW9ck=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wDHDjic_H5ldFh4EA--.9809S2;
	Sun, 17 Dec 2023 21:50:22 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: antiz@archlinux.org,
	Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ] adapter: Fix link key address type for old kernels
Date: Sun, 17 Dec 2023 21:50:12 +0800
Message-Id: <20231217135012.1476534-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHDjic_H5ldFh4EA--.9809S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4DJry3uryrJF13GFWktFb_yoWkWrXE9a
	1UWryxGrW5AFsxGa95X3Z7uryxKw4furykZ3Wftas3Ar15Xa13XFnrXFs3ArnxJa15ta9r
	JFs8Wr98tF1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjAhL5UUUUU==
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEANJ1WVLY6CMOgAAsU

From: Xiao Yao <xiaoyao@rock-chips.com>

Fixes: https://github.com/bluez/bluez/issues/686

Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
---
 src/adapter.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index ee70b00d2..b4628a411 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4347,7 +4347,17 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 		struct link_key_info *info = l->data;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
-		key->addr.type = info->bdaddr_type;
+
+		/*
+		 * According to the Bluetooth specification, the address
+		 * type of the link key is not fixed. However, the
+		 * load_link_keys function in the old kernel code requires
+		 * that the address type must be BREDR. Since the address
+		 * type is not actually used by the link key, to maintain
+		 * compatibility with older kernel versions, the addr.type
+		 * of the link key is set to BDADDR_BREDR.
+		 */
+		key->addr.type = BDADDR_BREDR;
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
-- 
2.34.1

