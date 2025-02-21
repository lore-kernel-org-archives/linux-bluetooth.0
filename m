Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D033EA;
	Fri, 21 Feb 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128300; cv=none; b=o+Yoriq/2arEOsaeOgjE1MwJQeV+qDZPmdT/+Su9GVZTlFsb9KV0getxvJ7pRL+B8X5/ACuqp+yLcdhbqISALvP2Z83WjOrocwZhiENGmxxBHQVgSI9LIqwAPjxfVKovkrXtRKeoZSsm/zS9DjeyMFQB23jrcE2z5YqhnCv7pRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128300; c=relaxed/simple;
	bh=UyexAoCF90msn3EpRu+01QsmJ98TJOg4xx80bhAjidw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJPPmC9GBG7Cx1Im8m5o7psyB5pNIgPEhGYNENT8XwHi3OjVfAcQ21dfszI9vwr+Ix1D0M5B8omwf+xzn4vljQlbbP7mhaKKT2JHVBTtWS7i15kDjp/u7GXElDXYTlofMZKPFeQO/3uNcxyHexOgL/jUHp4Tjz8Kcy149tSk6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OG22an2v; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OG22an2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cLdYr
	DKnT+YqC55FWMJBE8T5WHN7xWlY7jZoam5g8go=; b=OG22an2vFmq2J1aOQDTfU
	QHDLzuvqtNf/kTZGxHanO+kUluLpUlaWxyq1g7sULnJwXgsM4gwtyH8KYKuQvFjO
	z0cjBySXnLgwPyqNklaQ+EBJvcqTBrqXu9fMlZkkzQfRW6fzxkh6byFR0DdlWhPu
	MPhPdZZRWUwpdB/XvHBEDo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD312YbQLhng8gYNw--.55440S4;
	Fri, 21 Feb 2025 16:58:04 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
Date: Fri, 21 Feb 2025 16:58:01 +0800
Message-Id: <20250221085801.2760571-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD312YbQLhng8gYNw--.55440S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18JFy7tw48Jw18ZFW3trb_yoWDtrcEgr
	1vv3s3uFyUJas7XF1vkw43urnIyw1rAr97WrW3t3s7A3y5Gr1Uur1DXrnxJ39rua17Cr4x
	Aws8GFWDZw40gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0h-6bme4OkyLEgAAsp

Add check for the return value of mgmt_alloc_skb() in
mgmt_device_connected() to prevent null pointer dereference.

Fixes: e96741437ef0 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_CONNECTED")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- modify the title description.
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f53304cb09db..f1a9f58d1c7e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9659,7 +9659,8 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
 				     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0) +
 				     eir_precalc_len(sizeof(conn->dev_class)));
-
+	if (!skb)
+		return;
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
-- 
2.25.1

