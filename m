Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD212C3242;
	Thu,  5 Jun 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117223; cv=none; b=Rnzgbm6vgF9rymoJNW2Sj7KHV09i0O7w+8GqWaIl55FtUwydxAZpqFPuji4PfV3gRk+HOcmi71rz7+LDKVBysgNGygJ7HUfyE39VVth3+OjREUkvcqngZyJDnS6ViochcxzB+XVZmZfCY9R/9ztejIytBaStIo/sGtd5BEd4HTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117223; c=relaxed/simple;
	bh=4Xp2uVImHgR94rRAsBJOPKG/r6QAhYfKsVK0CfdOKzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jolzm3Rq1J69VOziTI+YSYr252bFeERYIG67tYQ1jGtNurgUn6QxFqpmGVZ1MmTbNmgXAqGcxeHh+zSO5yIzA2s5u1miX5MF/GQ4Da9k5pY12gdvYt7DA9e1w9O1exSP4/6tG5ksoVHCLqRsoMVXo3YqzuELtdLy9lipYgTkPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G889bN4J; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G889bN4J"
X-UUID: eefddcd841f211f0b33aeb1e7f16c2b6-20250605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZBJILawDWuUuG50M2YAXIGCFh6D28w6LmUWA6KnjpUU=;
	b=G889bN4JfWkcq7bi+1Zk6VGRoblojdDc9EaZi3r/LxzyaNtK78R9SpoEceRad5HjK9O6IfggVg1fXU5rLxzCLu+0lo1hw9wDbXqVUxVLYUzfbTya+mOMVd7/fwweznGL1Fz56MmsW6+oY9BjWbLcp4oKYgSEhw7pVxSw0NLTmNQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a9663365-446f-4425-8e83-743a4b075a4c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f49c7e59-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eefddcd841f211f0b33aeb1e7f16c2b6-20250605
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 376434943; Thu, 05 Jun 2025 17:53:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 5 Jun 2025 17:53:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 5 Jun 2025 17:53:26 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v2] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
Date: Thu, 5 Jun 2025 17:53:00 +0800
Message-ID: <20250605095300.22989-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch provides two methods btmtk_reset_by_gpio,
btmtk_reset_by_gpio_work for mediatek controller,
it has been tested locally many times and can reset normally.

The pin is configured in dts files, bluetooth is reset by pulling
the pin, when exception or coredump occurs, the above methods will
be used to reset the bluetooth, if the pin is not found, it also can
reset bluetooth successfully by software reset.

Co-develop-by Hao Qin <hao.qin@mediatek.com>
Co-develop-by Chris LU <chris.lu@mediatek.com>
Co-develop-by Jiande Lu <jiande.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  5 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..88e588f1b95b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -6,6 +6,8 @@
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -109,6 +111,60 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 	}
 }
 
+static void btmtk_reset_by_gpio_work(struct work_struct *work)
+{
+	struct btmtk_reset_gpio *reset_gpio_data =
+			container_of(work, struct btmtk_reset_gpio, reset_work.work);
+
+	gpio_direction_output(reset_gpio_data->gpio_number, 1);
+	kfree(reset_gpio_data);
+}
+
+static int btmtk_reset_by_gpio(struct hci_dev *hdev)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	struct btmtk_reset_gpio *reset_gpio_data;
+	struct device_node *node;
+	int reset_gpio_number;
+
+	node = of_find_compatible_node(NULL, NULL, "mediatek,usb-bluetooth");
+	if (node) {
+		reset_gpio_number = of_get_named_gpio(node, "reset-gpios", 0);
+		if (!gpio_is_valid(reset_gpio_number)) {
+			bt_dev_warn(hdev, "invalid reset GPIO, use software reset");
+			return -EINVAL;
+		}
+	} else {
+		bt_dev_warn(hdev, "no reset GPIO, use software reset");
+		return -ENODEV;
+	}
+
+	/* Toggle the hard reset line. The Mediatek device is going to
+	 * yank itself off the USB and then replug. The cleanup is handled
+	 * correctly on the way out (standard USB disconnect), and the new
+	 * device is detected cleanly and bound to the driver again like
+	 * it should be.
+	 */
+
+	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return 0;
+	}
+
+	reset_gpio_data = kzalloc(sizeof(*reset_gpio_data), GFP_KERNEL);
+	if (!reset_gpio_data)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&reset_gpio_data->reset_work, btmtk_reset_by_gpio_work);
+	reset_gpio_data->gpio_number = reset_gpio_number;
+
+	gpio_direction_output(reset_gpio_number, 0);
+
+	/* it requires 200ms for mtk bt chip to do reset */
+	schedule_delayed_work(&reset_gpio_data->reset_work, msecs_to_jiffies(200));
+	return 0;
+}
+
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor)
 {
@@ -364,6 +420,10 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
 
+	/*Toggle reset gpio if the platform provieds one*/
+	err = btmtk_reset_by_gpio(hdev);
+	if (!err)
+		return;
 	hci_dev_lock(hdev);
 
 	err = hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NULL);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 5df7c3296624..8a265ce367d1 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -179,6 +179,11 @@ struct btmtk_data {
 	spinlock_t isorxlock;
 };
 
+struct btmtk_reset_gpio {
+	struct delayed_work reset_work;
+	int gpio_number;
+};
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
-- 
2.46.0

