Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4092FF64F;
	Thu, 14 Aug 2025 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140165; cv=none; b=RMWzaxeXN2eKcN6EmLQC+D0Ne6aszuqWCxD9cUxi/Rl0Z4PfeGNYgEPhhktzG7/HuxtTlLQnpCuLvpJUI95TMB5eQS4S3Y5rQe9VcDrYD/J5T8JBNB5rKAIXOICAjVy6iTb2KYvXB3V+WJwZ3IwuL1DwKLcUxp/TpiCgJnsgGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140165; c=relaxed/simple;
	bh=g4Mm7DoZYkyRP4ERKJM63h8BAI1UO4oPIAH1Z3P/Brk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfP7qoSz8uChmwkqjd4vawTbWTiej/apjVGL5NLOiVJZvoFD+HQNh2WWCBUSP5mnDCj7oyG1jqX7oJDZUaaxtuTJdHEUnX9GZenAHfVoprA61YUMauSTfp5Y5MMbQYN13gKmy8Dj44Bq5OMSSDf7Jk86TQl1jF/fgFPHycC5+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32ccf1da78ba11f0b29709d653e92f7d-20250814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6ef037fe-ceee-4fa6-9078-e1f19d6aea0d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:ce016305b6a4438f7a8aa3f682c462a4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32ccf1da78ba11f0b29709d653e92f7d-20250814
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 677045440; Thu, 14 Aug 2025 10:55:56 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C5C03E008FA6;
	Thu, 14 Aug 2025 10:55:55 +0800 (CST)
X-ns-mid: postfix-689D503B-679043423
Received: from nature.lan (unknown [172.25.120.81])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2D646E008FA3;
	Thu, 14 Aug 2025 10:55:54 +0800 (CST)
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] Bluetooth: btrtl: fix rtl_dump.fw_version for firmware v2
Date: Thu, 14 Aug 2025 10:55:51 +0800
Message-ID: <20250814025552.10627-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rtl_dump.fw_version is not set for firmware v2. Since
rtl_epatch_header_v2.fw_version seems to be different with the
release version, set it to the fw version read after downloading
firmware.

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/bluetooth/btrtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6abd962502e3..6ad3ba7901e9 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -822,6 +822,7 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
 	int j =3D 0;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *rp;
+	struct btrealtek_data *coredump_info =3D hci_get_priv(hdev);
=20
 	dl_cmd =3D kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
 	if (!dl_cmd)
@@ -873,6 +874,9 @@ static int rtl_download_firmware(struct hci_dev *hdev=
,
 	rp =3D (struct hci_rp_read_local_version *)skb->data;
 	rtl_dev_info(hdev, "fw version 0x%04x%04x",
 		     __le16_to_cpu(rp->hci_rev), __le16_to_cpu(rp->lmp_subver));
+	if (coredump_info->rtl_dump.fw_version =3D=3D 0)
+		coredump_info->rtl_dump.fw_version =3D
+			__le16_to_cpu(rp->hci_rev) << 16 | __le16_to_cpu(rp->lmp_subver);
 	kfree_skb(skb);
=20
 out:
--=20
2.50.1

