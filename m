Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785919;
	b=WlVsfO1rYO/AkaUI2X3LFsdv1nk06KMhyee+0o8wN7XcdL/7eWogZgoeIhv+Y8M+8dg6
	 E1dBCC9XvnAQOLNQdGg75Q1LqWNwHDzNh6fDCIoB6eHA4y9qbAsXj+NQq9bbSksIBOEXv
	 NdnlZlRlFoEvXXXraSmL+ycIubXJKt+arpPO27QcWCkCx4j89h7j7DE9YICOLLv7mgGyu
	 xuxJuUhywaAIX0sxx1wwpEb3lMZO4Q0auvSLtjpxIZS8j9bLBxPDI9pRIuRDype/4MN09
	 oRVT/kYTRn08fBQCjFbTZylxIBHnWstvLF6zLl4Z0/Ge2sGSR9/vp545MsWNxvhUpug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785919;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bq2bT06VdOokWroCEDAW2WkYAtYpKDoLg0HVCeahJd0=;
	b=QecXKrbk9GCN5ZyNiT2Zo43OO4rOlDeBECFsTyHCFM0L21EsPYJVg7taM9IO6FEHb4Jx
	 Wy/6ChrZWfsEO809RN6rXaHDZiSqeR9Wc3znn5ZUdBJHVPx5ZnwJ1jOZfbjrgpnZ79yzb
	 i8Dp/VvKGUKfBJETR5SgYRC7LTeoYKyhW79cDB5SODR4vBAbN5ON6e2grmWsxWzewTJ7G
	 ESYeqavYa8u3/b3a5BTLJByRBqfzk1oaujmsQCHxjluO4rl344BvEp6oa8dP6/cYfu9GN
	 K00dkyg9rGG1aE6/JcH9rnL0EQY4SzmKpgDPrGSaun2L/vqtLaZX4Y2N/FNLyqEaGRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=EaNRqZ3e;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4D606A329;
	Fri, 27 Nov 2026 13:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EB4D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=EaNRqZ3e
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785910;
	bh=V1C5VH1z8t54cs61S8a6VCL8sJ+HDsoL+WFd+UAABD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaNRqZ3e/i9cSqt8uBPInfodrpMp/xvZpWlz6cfzyTu4ejfmEoVlqFiejUuIi5WWD
	 60rONptrm6DNg9GubVH8/kHcqtUq3npeFNpbdAdm9ILtndYVI9CU6+lsZhaJwL5+op
	 qdyanTBi89+lo+5aNq3Oir+GWCJjYmnbwW+7OlxXlBsIM4iDrcoOqOEXZeFVADLkby
	 1T0rcnagfmU8fn/+48AVJEuMIU/j1sArP311NIchvN3DKetHWuBxorBcbJGPJGN14s
	 GNLEl84zr7pimR5g6lPeeXSXCzymoeqIZabYd1Vq09AKn34K5SM+9uMc/BPjupyx2i
	 PeAZwxGkWGyIQ==
To: sven@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v3 2/3] Bluetooth: hci_bcm4377: probe again after a resume through firmware
Date: Fri, 27 Nov 2026 14:25:00 +0100
Message-ID: <20261127132501.262651-3-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127132501.262651-1-dev@deq.rocks>
References: <20261127132501.262651-1-dev@deq.rocks>
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

The BCM4377 is powered off during ACPI S3 and loses its firmware. On
resume the driver only unquiesces it, so every command times out.

When the platform firmware handled the resume, probe the controller
again from a work item and skip the ring teardown messages to the lost
firmware. Suspend to idle keeps the quiesce path.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm4377.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 8c9833d625e..f1beb09c9f5 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -16,6 +16,9 @@
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/workqueue.h>
 
 #include <linux/unaligned.h>
 
@@ -566,6 +569,9 @@ struct bcm4377_data {
 	struct pci_dev *pdev;
 	struct hci_dev *hdev;
 
+	/* set when the controller lost its firmware during system sleep */
+	bool fw_lost;
+
 	void __iomem *bar0;
 	void __iomem *bar2;
 
@@ -1017,6 +1023,11 @@ static int bcm4377_destroy_completion_ring(struct bcm4377_data *bcm4377,
 	struct bcm4377_destroy_completion_ring_msg msg;
 	int ret;
 
+	if (bcm4377->fw_lost) {
+		ring->enabled = false;
+		return 0;
+	}
+
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_type = BCM4377_CONTROL_MSG_DESTROY_COMPLETION_RING;
 	msg.ring_id = cpu_to_le16(ring->ring_id);
@@ -1107,6 +1118,11 @@ static int bcm4377_destroy_transfer_ring(struct bcm4377_data *bcm4377,
 	struct bcm4377_destroy_transfer_ring_msg msg;
 	int ret;
 
+	if (bcm4377->fw_lost) {
+		ring->enabled = false;
+		return 0;
+	}
+
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_type = BCM4377_CONTROL_MSG_DESTROY_XFER_RING;
 	msg.ring_id = cpu_to_le16(ring->ring_id);
@@ -2432,11 +2448,54 @@ static int bcm4377_suspend(struct device *dev)
 	return 0;
 }
 
+struct bcm4377_reprobe {
+	struct work_struct work;
+	struct pci_dev *pdev;
+};
+
+static void bcm4377_reprobe_work(struct work_struct *work)
+{
+	struct bcm4377_reprobe *reprobe =
+		container_of(work, struct bcm4377_reprobe, work);
+	int ret;
+
+	/*
+	 * Probing stays blocked until the system resume completes, the driver
+	 * core then retries the deferred probe.
+	 */
+	ret = device_reprobe(&reprobe->pdev->dev);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(&reprobe->pdev->dev, "re-probe after resume failed (%d)\n",
+			ret);
+
+	pci_dev_put(reprobe->pdev);
+	kfree(reprobe);
+}
+
 static int bcm4377_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bcm4377_data *bcm4377 = pci_get_drvdata(pdev);
 
+	/*
+	 * The controller is powered off when the platform firmware handles
+	 * the system sleep, as with ACPI S3 on x86 Macs, and comes back
+	 * without its firmware. Probe it again.
+	 */
+	if (pm_resume_via_firmware()) {
+		struct bcm4377_reprobe *reprobe;
+
+		reprobe = kzalloc_obj(*reprobe);
+		if (!reprobe)
+			return -ENOMEM;
+
+		bcm4377->fw_lost = true;
+		reprobe->pdev = pci_dev_get(pdev);
+		INIT_WORK(&reprobe->work, bcm4377_reprobe_work);
+		schedule_work(&reprobe->work);
+		return 0;
+	}
+
 	iowrite32(BCM4377_BAR0_SLEEP_CONTROL_UNQUIESCE,
 		  bcm4377->bar0 + BCM4377_BAR0_SLEEP_CONTROL);
 
