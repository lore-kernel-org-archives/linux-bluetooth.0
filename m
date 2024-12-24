Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3CA149E00;
	Tue, 24 Dec 2024 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735020516; cv=none; b=LYYOW9l4qSEatGSWg+b+LL4bWnh7J9NaBljDmLcosUXnPaOt2bYYAR0KoHO0euQIrESkMYBtf5hEAchbVTJWK/x+XqgcKG+ESe2hwQAbNZlX5tSVK1wbUfa1CsvEBwP9prMXw81Lr3RmSxw9dCKa2hVP2UDbtFIVI6q88vukYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735020516; c=relaxed/simple;
	bh=smYDExwdQAOY971UHKtzhETSX83RonO1nFIb24hSPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZ5jzP5leIdmt8LKaAV31+cWBRfoZnwxc76E+zu3QnTv3g5cbkiEGUWC7MdRP7AgX9qXG3JiOs/T8YMJoQc+dUk3dQhnc85TXLBnPSi6NgVH3M7+E2ea5zBNWLT+wPmzFrfKg6vD7bkAqEyYL/q6i8ak+dgXmciNWjmT4C0oz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 79bc5734c1bd11efa216b1d71e6e1362-20241224
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:fb6e49c0-fa1e-4844-8257-f9610abe5682,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6dc6a47,CLOUDID:91b3402cf925d85c275a046530ba3339,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 79bc5734c1bd11efa216b1d71e6e1362-20241224
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1673258560; Tue, 24 Dec 2024 14:08:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 83F0AE0080FF;
	Tue, 24 Dec 2024 14:08:20 +0800 (CST)
X-ns-mid: postfix-676A4FD4-285627137
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7C7DDE0080FF;
	Tue, 24 Dec 2024 14:08:18 +0800 (CST)
From: Zhang Heng <zhangheng@kylinos.cn>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	kees@kernel.org,
	erick.archer@outlook.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Heng <zhangheng@kylinos.cn>
Subject: [PATCH v2] tty: rfcomm: use sysfs_emit() instead of sprintf()
Date: Tue, 24 Dec 2024 14:07:30 +0800
Message-ID: <20241224060730.3231502-1-zhangheng@kylinos.cn>
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

Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
---

Changes in v2:
- update author name spelling

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

