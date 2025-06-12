Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A51EB1BF;
	Thu, 12 Jun 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712983; cv=none; b=GGlgSV66sx5dDQiqjcGWzhOSJAgVaIj+ebRI/B8n1Zhkuqq1OvvOsKw09CfhGD7iaO5AycO4YTEanRZrZ/igCP1xsw2TReG7IZ3rbqv/Sas6H7c1ZKtzDxYh8ASPF2tIXVfugra8hAMm41+HpJg6DMeaz1/cGAsKHlUN1XehpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712983; c=relaxed/simple;
	bh=d9XvE049Rw+K2GkAseDoYL+XkVMvP/QBaHC6XkeU5YI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPOoI1jaD0wv72I4ESqK73xdzdHkUBW3MDu2Rdj2tIpdr0G0pWRrnXWuPWqLZiUq2dto9O0YqW9XY0I/nk0qU2q7OpNiMVQ5orPDxslvdeV+IY4QuII2qcVoH9clwKFXN5OFLaaaxWTaJAPGhRZnCkTd3Hab6VPAVc5a6/bMa9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BsABS+42; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BsABS+42"
X-UUID: 0fc0431e475e11f0b910cdf5d4d8066a-20250612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nsUuIaqnM98AXc3sk5GAF68VDIKR4aTmuSKr+dEPhZ8=;
	b=BsABS+42ewliRqlZjkm0YslDK6H59m1Fb2NFb+63lreKfH0qTYCMsxyTX1o6ymI7Qn8L6jWLkmOJw3VbilQRddFZUFxet+LBvDZKOrEug2o4Zb/Rpz+G8A4fE0Yh0pLlPjVGm5GLZzldLms0e0sBi7M8Pv5r9z4hqQrGShS1+qs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:19ad8a15-cff1-424c-91a1-9cd7cf4a052a,IP:0,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-META: VersionHash:09905cf,CLOUDID:07b46028-fdd2-4021-9c0c-83548fdcf243,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:11|97|99|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0fc0431e475e11f0b910cdf5d4d8066a-20250612
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1127273499; Thu, 12 Jun 2025 15:22:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 12 Jun 2025 15:22:54 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 12 Jun 2025 15:22:54 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v2] Bluetooth: mediatek: add gpio pin to reset bt
Date: Thu, 12 Jun 2025 15:22:30 +0800
Message-ID: <20250612072230.12537-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This V2 patch provides two methods btmtk_reset_by_gpio,
btmtk_reset_by_gpio_work for mediatek controller,
it has been tested locally many times and can reset normally.

The pin is configured in dts files, bluetooth is reset by pulling
the pin, when exception or coredump occurs, the above methods will
be used to reset the bluetooth, if the pin is not found, it also can
reset bluetooth successfully by software reset.

Compared with the previously submitted version, the following
information has been revised in version V2
1)-Changed the capitalization of co-developer names,
   using the correct capitalization of abbreviations and full
   name, and corrected obvious spelling errors.
2)-Add a revision history.
3)-Remove the "BT Driver" in the prefix.
4)-Add the bt-binding document, include inforamtion related to reset
   pin and compatibility matching.
5)-Add a comment before the schedule_delayed_work function call,
   although schedule_delayed_work is asynchronous, there is no risk.
   Even if it is not completed within 200ms, it will only postpone
   the subsequent probe and will not have any impact.
6-)Add a comment before the btmtk_reset_by_gpio function call,
   if the compatibility filed or pin cannot be found in the dts
   files, it can still reset bluetooth using software reset.

Co-developed-by Hao Qin <hao.qin@mediatek.com>
Co-developed-Chris Lu <chris.lu@mediatek.com>
Co-developed-Jiande Lu <jiande.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 54 +++++++++++++++
 drivers/bluetooth/btmtk.c                     | 69 +++++++++++++++++++
 drivers/bluetooth/btmtk.h                     |  5 ++
 3 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
new file mode 100644
index 000000000000..bcdb46effdba
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7925 Bluetooth
+
+maintainers:
+  - Zhangchao Zhang <zhangchao.zhang@mediatek.com>
+
+description:
+  7925 uses the USB bus to communicate with the host.
+  Two methods are used to reset Bluetooth.
+  When Bluetooth crashes or core dumps,
+  the pin will be pulled low, then held for 200ms,
+  and then pulled high again before next probe.
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7925-bluetooth
+
+  reg:
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      An active-high reset pin for the Bluetooth core;
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    &xhci0 {
+      vbus-supply = <&pp5000_usb>;
+      usb2-lpm-disable;
+
+      status = "okay";
+
+      bt_reset: bt-reset{
+        compatible = "mediatek,usb-bluetooth";
+        reset-gpios = <&pio 248 GPIO_ACTIVE_HIGH>;
+      };
+    };
\ No newline at end of file
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..3e5f3ca6f0d5 100644
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
@@ -109,6 +111,65 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
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
+	/* It requires 200ms for mtk bt chip to do reset,
+	 * although Schedule_delayed_work is asynchronous,
+	 * it is risk-free. If it is not completed in 200ms,
+	 * it will only postpone the next probe, which will
+	 * only make the probe run later. There is no other risk.
+	 */
+	schedule_delayed_work(&reset_gpio_data->reset_work, msecs_to_jiffies(200));
+	return 0;
+}
+
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor)
 {
@@ -364,6 +425,14 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
 
+	/* Toggle reset gpio if the platform provieds one,
+	 * if the compatibility field or pin cannot be found
+	 * in the dts files, it can still reset bluetooth using
+	 * software reset.
+	 */
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

