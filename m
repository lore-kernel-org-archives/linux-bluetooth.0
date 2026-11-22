Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353574;
	b=Bk/N+/O8nXmqcc52iswEogzCM1dBrRtakxFb4hbcBqCjHj5Jg6Brd6/k77SNEhDirNnG
	 FK8yEEO3qLNhJlTnVGG/xkGYQJy+DJOox8IdS4ZkJ2X4/kGKAg1sw+HBcqkCwtDUdl6WW
	 yfVStcTNS1/hdy6BDhvI+iFjXH1QXbV0ZyMCbFSQy44j9LDLP6QDzsO5N8BhOe1lyAc86
	 /6HxD2dRvtR2LpJRSDKuyslFaqgDd9bz3eosR+JwG14AYlPxcbFXxy1H1tgPsl3z1Y8Cq
	 awd7qpJIqrhJWqWNMGE18vuPp7EErKlDcIFg3zNRiga1kTc/jZb+rzwDEkbl/RzPdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353574;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=HDvZmONCug0157g12f+0Zcf9P8MNQUPe122O8kSXMUE=;
	b=oYZTHVQ6I53aax7dj30klDE5PRlJPhsdJNbeuRorcq6son06MMTflmZDk0fwK69fLaBv
	 pPP7yDH9HqLSzZPhy+alegPoAXuSU5EoNuDlz8MZ/TwbsaWpaf+kgZNPCvtDB0lF1ql+j
	 Np//Kk/gbSMuLrN2m4PKfTNQSnchtMuVtT2/uUDuftCCDbePcteTb/NZYZrqUEDmPIg0r
	 x5yfvboJ6H/m2OiQLbu61WcExoi/zv1z/wR5NMAO98sqsGeOlIiGvAOEfGOJFlDnuf7V7
	 PODOrLjwH4T9P+etcFq4Q/KBP1fCxX4fD8nrxjjv11e6h1NSKJB5ymUZDnvnwDovCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41492606A320;
	Sun, 22 Nov 2026 13:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41492606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=HDvZmONCug
	0157g12f+0Zcf9P8MNQUPe122O8kSXMUE=; b=CMA7NDX5vL1p8VBwiOLfX8f/aq
	Z0iHcMbxCi0pPuNgAtmcxTmGCyzgRioijHMhnUHv0pHHVR4b36enegCFbzzARvac
	6dIo85Hd0qDWTTI5SmxzHKTtU50Erd9ah1t/fH6+M83Chx3TorSrau3Zrp7uq6ql
	X8duqYQnk7gvUsrD4=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [240e:454:8311:30f9:88d4:5e3b:b008:f171])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkD2+fzM6wJr+1cQAg--.4331S2;
	Sun, 22 Nov 2026 21:19:09 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicoyip.dev@gmail.com,
	tim.bird@sony.com,
	raghunathpalla.0209@gmail.com,
	peter@hurleysoftware.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: RFCOMM: hold port reference during TTY registration
Date: Sun, 22 Nov 2026 21:18:50 +0800
Message-Id: <20261122131850.44042-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkD2+fzM6wJr+1cQAg--.4331S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWkGFykXFW7trWUuFyUKFg_yoWruF4Upa
	y5XayrKFWqqr17Kr4fAF4DXa4F9rn7u3yxCry8Cw10krn5GrZ2yrWSg34jva1rArW8AFWj
	qF4jvF48Wr9rurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vEI74l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRZNVgDUUU
	U
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAgUDEWr-E0nOXwABsK

rfcomm_dev_add() registers the TTY after __rfcomm_dev_add() has made
the device visible through rfcomm_dev_list. A concurrent TTY open can
acquire a reference to the newly listed device while registration is
still in progress. For RFCOMM_RELEASE_ONHUP devices,
rfcomm_tty_install() can drop the initial tty_port reference. A
subsequent close can then free dev while rfcomm_dev_add() is still
using it.

Hold an extra tty_port reference across TTY registration and the
remaining initialization. If registration fails, drop the initial
reference only if the TTY has not already taken it, then drop the
registration reference. Save the device id before dropping the
registration reference so the return path does not access dev after it
may have been freed.

The DLC state callback can run before tty_dev is published. Publish
tty_dev with WRITE_ONCE() and use READ_ONCE() in the shutdown and
reparent paths. Skip reparenting while tty_dev is unavailable;
rfcomm_dev_add() calls the reparent helper again after publishing it.

Fixes: 5b899241874d ("Bluetooth: Release RFCOMM port when the last user closes the TTY")
Reported-by: syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=11542ff1d167fdffa1fc
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>
---
 net/bluetooth/rfcomm/tty.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -127,9 +127,10 @@
 static void rfcomm_dev_shutdown(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
-
-	if (dev->tty_dev && dev->tty_dev->parent)
-		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+	struct device *tty_dev = READ_ONCE(dev->tty_dev);
+
+	if (tty_dev && tty_dev->parent)
+		device_move(tty_dev, NULL, DPM_ORDER_DEV_LAST);
 
 	/* close the dlc */
 	rfcomm_dlc_close(dev->dlc, 0);
@@ -173,6 +174,11 @@
 {
 	struct hci_dev *hdev;
 	struct hci_conn *conn;
+	struct device *tty_dev = READ_ONCE(dev->tty_dev);
+
+	/* The connection can become active before TTY registration completes. */
+	if (!tty_dev)
+		return;
 
 	hdev = hci_get_route(&dev->dst, &dev->src, BDADDR_BREDR);
 	if (!hdev)
@@ -188,7 +194,7 @@
 	 * guarantee the sysfs device has been added ...
 	 */
 	if (conn && device_is_registered(&conn->dev))
-		device_move(dev->tty_dev, &conn->dev, DPM_ORDER_DEV_AFTER_PARENT);
+		device_move(tty_dev, &conn->dev, DPM_ORDER_DEV_AFTER_PARENT);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -267,6 +273,8 @@
 		((1 << RFCOMM_RELEASE_ONHUP) | (1 << RFCOMM_REUSE_DLC));
 
 	tty_port_init(&dev->port);
+	/* Keep a reference until rfcomm_dev_add() completes TTY registration. */
+	tty_port_get(&dev->port);
 	dev->port.ops = &rfcomm_port_ops;
 
 	skb_queue_head_init(&dev->pending);
@@ -316,6 +324,7 @@
 {
 	struct rfcomm_dev *dev;
 	struct device *tty;
+	int err, id;
 
 	BT_DBG("id %d channel %d", req->dev_id, req->channel);
 
@@ -325,24 +334,29 @@
 		return PTR_ERR(dev);
 	}
 
+	id = dev->id;
 	tty = tty_port_register_device(&dev->port, rfcomm_tty_driver,
 			dev->id, NULL);
 	if (IS_ERR(tty)) {
-		tty_port_put(&dev->port);
-		return PTR_ERR(tty);
-	}
-
-	dev->tty_dev = tty;
+		err = PTR_ERR(tty);
+		if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
+			tty_port_put(&dev->port); /* Drop the initial reference. */
+		tty_port_put(&dev->port); /* Drop the registration reference. */
+		return err;
+	}
+
+	WRITE_ONCE(dev->tty_dev, tty);
 	rfcomm_reparent_device(dev);
-	dev_set_drvdata(dev->tty_dev, dev);
-
-	if (device_create_file(dev->tty_dev, &dev_attr_address) < 0)
+	dev_set_drvdata(tty, dev);
+
+	if (device_create_file(tty, &dev_attr_address) < 0)
 		BT_ERR("Failed to create address attribute");
 
-	if (device_create_file(dev->tty_dev, &dev_attr_channel) < 0)
+	if (device_create_file(tty, &dev_attr_channel) < 0)
 		BT_ERR("Failed to create channel attribute");
 
-	return dev->id;
+	tty_port_put(&dev->port); /* Drop the registration reference. */
+	return id;
 }
 
 /* ---- Send buffer ---- */

