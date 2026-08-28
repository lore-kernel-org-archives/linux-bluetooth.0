Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B853E0B
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901853; cv=none; b=OLqlfr6XYrifL6YHNn2hMSRYkFny6T5M76B6grQ2EMDfFTXSFH2GzdOkPj2RAkH0O5nGQz0csfgDF2m+rdWwnL9gyh+ejkjVuL74nj6Ydwnj5lb7UIC1ZUKAR6qJRSLfvgGiNTQbAl8+4VKhs8EnxwhH40dLW2eZ4rKzI5Fd1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901853; c=relaxed/simple;
	bh=1Ltwl02VndSixQBVG+vMYGj9WjPb38ytzNwfgb0y7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l38Xh30l+ffzwRZEViCFwgvRNU/EeTz+InGLyCYgKKdPfmJoqc4ou5dc+4277XJABuKGP3sKc9sT0IXOiM34QUrkLEMLbMPAcf8esMJ/j/57B8PX3asYsMtR6yewOW78xynlQvD7zq9nYKavvS7LM8P3D7GnKlAq9MkqsjsHFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KqYwAaLl; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KqYwAaLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=U7
	+pcyh1+gF7odWEAef8efXZz+KitJm/JdeQ93w6RPk=; b=KqYwAaLleMH5vZlVON
	lHcEQvNkV9Xswj4mie1a2lT24oW68K0caUE4BQJ0y/A3UC4kt7YGS5bqSmOg/Bk7
	29B6CpLj/ZKOXmX9dXB0hl5eGfzXNzr7TN9P8u49YoPwNTP/0v82E7w3t45MvHEX
	p69s7R9gbIiExZhMTTlm5K/d8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3n3yGN5Fqfl8oQg--.56272S2;
	Fri, 28 Aug 2026 15:23:51 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] Bluetooth: hci_ll: check clk_prepare_enable() return value
Date: Fri, 28 Aug 2026 15:23:49 +0800
Message-Id: <20260828072349.217999-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3n3yGN5Fqfl8oQg--.56272S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1UZrW5Jr45Ar1kXFW7twb_yoWkZFb_Cr
	Z5Cr9rWrWUJF4rAa42krWUZ34Dta95WrWxX3Z0v343tF9rWrnFyr4jqFnFkFn3urZ2kFy5
	Aw4DAF1xJr45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjg18JUUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gftnGqRN4d+BgAA3-

From: Li Youhong <liyouhong@kylinos.cn>

ll_open() ignored clk_prepare_enable() failures for the optional
external clock and still reported success.  Propagate the error and
free the privately allocated protocol state on failure.

Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/bluetooth/hci_ll.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index ab744001dafc..c2dca22d1eee 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -112,6 +112,7 @@ static int send_hcill_cmd(u8 cmd, struct hci_uart *hu)
 static int ll_open(struct hci_uart *hu)
 {
 	struct ll_struct *ll;
+	int err;
 
 	BT_DBG("hu %p", hu);
 
@@ -130,8 +131,14 @@ static int ll_open(struct hci_uart *hu)
 	if (hu->serdev) {
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
 
-		if (!IS_ERR(lldev->ext_clk))
-			clk_prepare_enable(lldev->ext_clk);
+		if (!IS_ERR(lldev->ext_clk)) {
+			err = clk_prepare_enable(lldev->ext_clk);
+			if (err) {
+				hu->priv = NULL;
+				kfree(ll);
+				return err;
+			}
+		}
 	}
 
 	return 0;
-- 
2.25.1

