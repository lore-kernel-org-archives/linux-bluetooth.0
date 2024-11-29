Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186918A6AC;
	Fri, 29 Nov 2024 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876055; cv=none; b=WYfP4+NApasF4qPAECOJC7s5h0Cj93vimjyXiKAAOdqkD7Crmhqi9gEwJPDTTMxUdxQ+D3m8gjzODug1a2VePo6alHLtXm9dBTry6amxad6AQzfIkenxhRrlOTGjWnC3J7kyUqD03jodkUSThTxFGVgGKpBJRggJhLkG52C1rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876055; c=relaxed/simple;
	bh=9AauVqi3pNsIbEb+9JtIdeS1sshApVXNvulC6fEMuMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/O/YYX3GDUwzunC9UkQfMie0llsKcSrlI8CWuCT5ckqQ13ZaKoMnG+k8tWtByef20PzIgoHNFvKBftLhpiPM9TDGSw/jRGR0sUdbbweLdwFFOyrz+VC5pk69Cct7CLm0IjqfAs9kJESOE1WOSmGzyfYsOHQHN9BRVwuPfhePpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82b14a5aae3c11efa216b1d71e6e1362-20241129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:66d1a889-1204-4fd9-ab8c-8b4bec61fb46,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:9a5af8ee66d2af270b2ee10a4143a33b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82b14a5aae3c11efa216b1d71e6e1362-20241129
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2070425658; Fri, 29 Nov 2024 18:27:18 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5D456E0080FF;
	Fri, 29 Nov 2024 18:27:18 +0800 (CST)
X-ns-mid: postfix-674996FC-8168322012
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0623BE0080FF;
	Fri, 29 Nov 2024 18:27:07 +0800 (CST)
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
	Heng Zhang <zhangheng@kylinos.cn>
Subject: [PATCH] tty: rfcomm: use sysfs_emit() instead of sprintf()
Date: Fri, 29 Nov 2024 18:26:40 +0800
Message-ID: <20241129102640.499871-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Heng Zhang <zhangheng@kylinos.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Heng Zhang <zhangheng@kylinos.cn>
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

