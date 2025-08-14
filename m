Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5282F659F;
	Thu, 14 Aug 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165496; cv=none; b=E7rnA3wqrykPf7wekQubmNj/WCLiUSPL+V52qqQYTpl2bWMpevt5MvRHJD7NLzaAYUex/ktIjCd+g4rzfoP3QtHmzuMRa082ncsfgCcVXx3QpQ33aT/LWkHNBeEpqnzMlfQyH8TQRDzDaP+kJuPDDlXdIrk1zLuqjMpZXqP0Igo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165496; c=relaxed/simple;
	bh=c6hg11JChL/Z5ebyc3d8W/NuDFKnfQBBgcLkpkhNtLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrWvpj9M02MHLsCqk5knqW7rYwqGIAqwmCoAmWqhtlFD0LyNk8W6sbT4vt9vwk2JGVa2YiS2iC/Os10kg/UGXvJiwMki5kmTN9Z4DhtFDG6t35e2e65Vmr8kyhj90kdaGB8+oA1Wf6b2qK10O1IYYshhwMmZz9AX9rgdku6RBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d02eb0c78f511f0b29709d653e92f7d-20250814
X-CID-CACHE: Type:Local,Time:202508141735+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:596a5f94-f76f-4f1a-aba3-d028fdec78b9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:6493067,CLOUDID:285143e7b64956b5ff9f7cd813fc6bb9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d02eb0c78f511f0b29709d653e92f7d-20250814
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 301693908; Thu, 14 Aug 2025 17:58:06 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 649ABE008FA5;
	Thu, 14 Aug 2025 17:58:06 +0800 (CST)
X-ns-mid: postfix-689DB32E-258094814
Received: from nature.lan (unknown [172.25.120.81])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1F2AFE008FA3;
	Thu, 14 Aug 2025 17:58:04 +0800 (CST)
From: Jiajia Liu <liujiajia@kylinos.cn>
To: pmenzel@molgen.mpg.de,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: alex_lu@realsil.com.cn,
	hildawu@realtek.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH v2] Bluetooth: btrtl: fix rtl_dump.fw_version for firmware v2
Date: Thu, 14 Aug 2025 17:57:39 +0800
Message-ID: <20250814095739.38343-1-liujiajia@kylinos.cn>
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

For latest RTL8852B FW from commit c1a6a1a2 ("rtl_bt: Update RTL8852B
BT USB FW to 0x098B_154B") in linux-firmware, the release version
is 0x098B_154B corresponding to $(hci_rev)_$(lmp_subver) and at
file offset 0x16aee.

 $ hexdump -C rtl_bt/rtl8852bu_fw.bin | grep '4b 15'
 00016ae0  99 66 4e d2 bc 93 07 07  2d b1 bf 4b 15 8b 4b 15
 $ hexdump -C rtl_bt/rtl8852bu_fw.bin | grep '8b 09'
 00016af0  8b 09 08 00 00 00 00 00  00 00 ff 02 01 01 14 01

rtl_epatch_header_v2.fw_version is 0134ff2b-00019cfe at file offset 8.

 $ hexdump -n 16 -C rtl_bt/rtl8852bu_fw.bin
 00000000  52 54 42 54 43 6f 72 65  2b ff 34 01 fe 9c 01 00  |RTBTCore+.4=
.....|

Tested with RTL8852BE BT (0bda:b85c) and the following script.

  #!/bin/bash

  set -ex

  echo 1 | tee /sys/class/bluetooth/hci*/device/coredump > /dev/null

  sleep 1
  cat /sys/class/devcoredump/devcd*/data | grep --binary-file=3Dtext 'Fir=
mware Version: 0x98B154B'

  echo 0 | tee /sys/class/devcoredump/devcd*/data > /dev/null

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
Changes in v2:
 - Commit message
   - More about FW release version
   - Add test script

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

