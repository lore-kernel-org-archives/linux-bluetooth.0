Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD81DFD1;
	Sat,  9 Nov 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731143893; cv=none; b=Zdx+/rgLYq4dYRd8/rez++aAUGue0WNovphuUtRr9y/y8WGt9ksQeKQ6uxeSN3rwD4R6ac/5De2zS9R/g6HOHmn3TosBR8fqY7wO2eqAhg13b4XGgUoVGnkg64trAwA7SdvDG8trXOU5kbRSykkcpxa68iouNqM5+/vqXsv8hSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731143893; c=relaxed/simple;
	bh=DkTxg95VblgAot6ZNEDGTHGBHGn1h0iJNL0oEfb5Uzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoK/xL4NpX69cXGVhvsqDCjfmaQcMqTw085DkU3eoWFPif5oKUwAfYYB8Jc7hYw7rvbVOxRX0qgs8xZwPynPD/pychpwr82RY9VmsHbT/sR+1p2bMqL4zn+G//VnP93mlXna80R21tS5DIJP7ullgQRrCoVmI+5RoWETiSEwuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 80820cae9e7b11efa216b1d71e6e1362-20241109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e9947f80-5856-42a1-9d43-ae72149dc630,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:1c7aa27cc93c06f80209e2703a124fd8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 80820cae9e7b11efa216b1d71e6e1362-20241109
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1104213476; Sat, 09 Nov 2024 17:17:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 64221E0080FF;
	Sat,  9 Nov 2024 17:17:54 +0800 (CST)
X-ns-mid: postfix-672F28C2-1117023
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 94A14E0080FF;
	Sat,  9 Nov 2024 17:17:52 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	erick.archer@outlook.com,
	kees@kernel.org,
	geert@linux-m68k.org,
	jirislaby@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH 1/4] tty: rfcomm: use sysfs_emit() instead of sprintf()
Date: Sat,  9 Nov 2024 17:17:48 +0800
Message-ID: <20241109091748.4037589-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 net/bluetooth/rfcomm/tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index af80d599c337..21a5b5535ebc 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -201,14 +201,14 @@ static ssize_t address_show(struct device *tty_dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev =3D dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%pMR\n", &dev->dst);
+	return sysfs_emit(buf, "%pMR\n", &dev->dst);
 }
=20
 static ssize_t channel_show(struct device *tty_dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct rfcomm_dev *dev =3D dev_get_drvdata(tty_dev);
-	return sprintf(buf, "%d\n", dev->channel);
+	return sysfs_emit(buf, "%d\n", dev->channel);
 }
=20
 static DEVICE_ATTR_RO(address);
--=20
2.45.2

