Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066529;
	b=f6CXFee7aT0Mm3YBQkwNk1A0JR3sRC3KfcsJIErAjWLexPA1PpTNb6K+KCIeqvURYesN
	 b7RZTOl3odDv706pYfIhVO/AToUMgGEOA2pD9bxZZF1JfJefk8OpUlBwtQe7Om2mb11mQ
	 enHMZ9qvajL+ASh9dQ4kiYow3fcAKn00BAC6YN4O1giYdAfVXpogSHSKd1OBTdKttiQZg
	 HWv0VavsbWbpRLf7MDN5YTdizLUQk6DgkjOabUm0UW8mB4qSqRyB6/nSwwvhEKEDTe6LD
	 sVCvbmiotE0Dc0Q6toD6U/rnD3pG3WxuBjbJq7EcD2uDT6jMck/O98HDyC3eQMZXBYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066529;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eo/NywlEhroI6mMNdiDhHmXihtMSrWd5iTDNbsGOBzs=;
	b=2iACH33YuZCKqwtEQIuzdrorLBMMfLitSxaIhkDmxUdxQnOoIaQnbwINkD6GyZWJwE2u
	 4TsAubFeJ0WOFn2QD4dfvb6w4wx/Z1+CtyaceKjmk/ljCxcVSRuhqfwO47VGfA4eK8doN
	 MeuCz7yXUDf4g4k2rBaMeKS8B7kkTUPPi7kISaYwq5fty+FRfsYh1y5KGD1T5qQIA6RnI
	 XjZA55eikXkMYgzi8oOMb6SfIBWpqbq4KzEo8cEDI54K97UwBiL4r4OQFZ54ldD+/pwho
	 GlyHuPP1zraP+heFCbC2+QZ4TAvIg2a/qMAbLVnu37sqBN0nY4sFrjbqUPooeC89C3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b="Ezt/vcDR";
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DF608363C;
	Sat,  7 Nov 2026 15:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737DF608363C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=Ezt/vcDR
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: c8b6b05e-e52f-4b47-b25b-9e465b8ba845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794066526;
	bh=1lAmkZ8NRJCX4r08vZCWyv+dbxFv1Yobgq898qKHccM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ezt/vcDR7MwuOzEiwcocCKJgtE3GT0XQ4+Pix9VfTFqdE9XqnNq9mfDPdZMxc+dDG
	 hlFFrvsT7s6WgM5CPDVrsXzV8Np8tdmV1dR650DnDkhoZz6uR8qeVHnO+q2mR4tDtk
	 UMhvtO8hsqcFt8J8h1QrqnmLxv39dMLsfMrye7beoI4wCN8RhQVufU4LgXKGza3crz
	 vAp+ktS1K8LO7+q9ilRSYzN+dN7xlf8soALAajbVNBul7PmHFegdFljEsgXo9YO2s9
	 s5DHAVPC42eTTbAbvXO0GGVkxacPllWPHg1JyiCioI5qf2wWKFGA0hcDk2a0aiH79x
	 9/APIehc3B/Bg==
To: Sven Peter <sven@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_bcm4377: probe again after a resume through firmware
Date: Sat,  7 Nov 2026 16:48:39 +0100
Message-ID: <20261107154839.89941-3-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107154839.89941-1-dev@deq.rocks>
References: <20261107154839.89941-1-dev@deq.rocks>
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
firmware.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm4377.c | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index da0a48c2be3..4e3630774c0 100644
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
 
