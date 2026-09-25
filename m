Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529750EBF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379660; cv=none; b=b6E5Tcoc6LE9V1JwCO11nDF0xWP7jRGh4OjKRWrrHYLGMxs54DXLcKBp9wDv/jZdpQ9sIOaW7g759UfIwl14XMZnxswjy+FiSCnUh0rWVC04iM3hFSn64SaFfDBv3HdiEjApKfE/bOQWThUGS10EmLtrOUtTpcIJN1N19SV72hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379660; c=relaxed/simple;
	bh=EQOqmbHbh5fQ0X2C6iqhCwP3KdZoMmE0a0ZhPxKdfPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBBCy12xLjbljHgznw4VVkZ8Y/fZ4b9sm0eSJ94OLX0pe5bPhpqjYIQkaZmrp5fL1ZBZgWBRIxsHmvZ6Bpl+fZ6UIgTR0kqfpan5MKq7+6zTSPbt3az/IAmY+HfUQ4JK9L61JIuWqCfpBFkw9ZWRR6AKgE1gRkFXNZ0joOq3UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fknSZK2u; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fknSZK2u"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3a0aa5e2b20so427453a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790379653; x=1790984453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKYZ7QmEMKBKN0PWq40K1NCVT7LCh/HrFy5AX5GhHjI=;
        b=fknSZK2ufmc206TLS4/XCq4h7SkOBGp9U7h4HR/r5tWmayOgXuUTSi7R7L12hP62+Q
         L+ce5jkI+3qQkGj3mFXvitKiqB1lk8SdXYQdGYOdwHbfBL27XYJd5xe2NCKHHws0LhRm
         uPTuYvU6zk33tZ/YvFoKFHXajXrB25gKjNRW1PIT0h5apoRtYpkwEYlkN2SXGyIropE2
         e0S1drQLD1WBMzgghRjtzNMMj3fouv0nDYQLa4oxLco7QAJztNGdL3Yg+oxR+FmpYg0U
         fbDXPGvCN/CJ6K4mY59DpbMK3svWnrh8Jb1rHGU/FjGczZfU6ClzgxNMkf9OyGqpRTgC
         4Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379653; x=1790984453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKYZ7QmEMKBKN0PWq40K1NCVT7LCh/HrFy5AX5GhHjI=;
        b=swZCjxDQXlaPxCKmWOtuFlwfeExPYtn1AGJZj2GzaxP+fESwoxeMpWGqCjyHsDsx6h
         JDogNJymdjcFurhPhkYR+kcSqHTFfKDPl/CCounyceRVhWv6jdhwQ8YVicF9jej4dLRb
         xexrwb7poLf3308jSlWkAn6Tb1rF1XFQ6X1Akp1Y+DoyXf9YwPzd4SWs9qSY6R8Q9OaU
         Of3Xgd6SjAVXCpX52iRl5ETkKY+FoaJuwvJaXYZITNulnO4RmIamZe3Dy8AYg+9PRNNq
         LHuFle7qcIOEOyrjjwzJ4wqGLcNeHDTanF5+yHp1wvPWFy3QTN6Mo7eH/2bQuj3fLuBz
         6KgA==
X-Gm-Message-State: AFuF++l9k7iRsHDO8rjEPiTRsAYdIe/WIFcnUXJPdkDqzQGMuOE9DBMj
	HCEdAeuEv+8cuzDD+ixsi6aOyv6kMKOls+lW82lQdgrAMjP13G+Sc1xVHBAW+fUpHRA=
X-Gm-Gg: AYBFou0FI6tCEtP4tUpr3dMy6BVXHR9upJddrqosja8Np8xTG57Otd3oREL4gnf0k3F
	2Jvv+qDf7aGABYiTJ8Lf7BXw0NmSJe7Z0Hi9Negv6V0WHyDKnem1Xe8+H+ejq8V+3MM+X9y8TpB
	+lrkDUUAS37cSLcl/e5bOsorUsvgZPVLBFH60ZKASLcYYxheNBm3Sy91bA/uNuCnTDMy6sLkcvr
	kJ9gH51G03HpDMqmSL8v61pL8dZGXQE28G0Uneh0VqXPYNaTGUl8qAN9hVbrQO/kjHdjRuo/w6O
	Gaz/oROb/wzCV+UPJ81wSB5BxuX6beWmnxsuUmlPRDfmoR4tDDw2mIqQ9CwB8/e2nFMVAGRMRdl
	oNSWcWxJHVtCv0XL0XkmY86h/giyS1NCQjfm3XMB7us228YLn0nqqYKBQF3g9xG2GyR9nzlsubB
	70QDu+G9e6umsMYRhoMn3ZXH4+cSUsOPmTGIIgH2kl+getezu2owZzf+0v9j+KC7CvIlxUJEnv0
	DnSFuw84x0=
X-Received: by 2002:a17:90b:1648:b0:3a0:d651:394e with SMTP id 98e67ed59e1d1-3a0d651474fmr892499a91.16.1790379652628;
        Fri, 25 Sep 2026 16:40:52 -0700 (PDT)
Received: from pandar.dancher.net ([2409:8a28:881:a300:decd:fb28:f50d:71a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm6706966a91.7.2026.09.25.16.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:40:52 -0700 (PDT)
From: Cai Yu <caiyu7372@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] Bluetooth: hci_intel: add serdev support for the CcP controller
Date: Sat, 26 Sep 2026 07:40:42 +0800
Message-ID: <20260925234043.707679-4-caiyu7372@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925234043.707679-1-caiyu7372@gmail.com>
References: <20260925234043.707679-1-caiyu7372@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel Bluetooth controller on the ThinkPad X1 Fold Gen1 (Lakefield,
ACPI INT33E4) is described as a serdev child of its LPSS UART: the port
has no tty device at all, so the line discipline path of this driver can
never be used and nothing binds to the controller today.

Add a serdev driver next to the platform driver, in the same way hci_bcm
supports controllers of both kinds:

 - the ACPI id INT33E4 is matched in a separate table, so the platform
   driver keeps its INT33E1/INT33E3 set;
 - the probe power cycles the controller through the "reset" GPIO (it
   does not keep the firmware across a power cycle, and this also clears
   a controller left in an unknown state) and waits for the bootloader to
   come up before the first command.  On this board 500 ms of reset pulse
   plus 2 s of boot delay are needed, otherwise the first command is lost;
 - this UART is described with FlowControlHardware, so the serial core
   enables CTS/RTS.  The Intel handshake has to transmit freely before
   the controller answers, so flow control is turned off;
 - the serdev path uses a protocol struct with oper_speed = 0.  The
   generic baudrate change in hci_serdev.c runs before intel_setup(), but
   the controller is in bootloader mode at that point: it only answers at
   init_speed until the firmware has been downloaded, and it is not even
   listening yet right after the reset pulse.  Switching the host to
   oper_speed there makes the setup fail with a -110 timeout on the
   version read; intel_setup() changes the baudrate itself.

Tested on a Lenovo ThinkPad X1 Fold Gen1 (20RKA000CD): the controller
comes up as hci0, the Intel firmware is downloaded, the DDC parameters
are applied and the (sole) HOG keyboard connects.

Signed-off-by: Cai Yu <caiyu7372@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 132 +++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index d25d029..5926d1f 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -544,6 +544,14 @@ static int intel_setup(struct hci_uart *hu)
 
 	bt_dev_dbg(hdev, "");
 
+	/* ACPI describes the UART of this controller with FlowControlHardware,
+	 * so the serial core enables CTS/RTS.  The Intel handshake has to
+	 * transmit freely at init_speed before the controller starts answering,
+	 * otherwise the first commands time out; keep flow control off.
+	 */
+	if (hu->serdev)
+		serdev_device_set_flow_control(hu->serdev, false);
+
 	hu->hdev->set_diag = btintel_set_diag;
 	hu->hdev->set_bdaddr = btintel_set_bdaddr;
 
@@ -1067,6 +1075,33 @@ static const struct hci_uart_proto intel_proto = {
 	.dequeue	= intel_dequeue,
 };
 
+/* Do not let the generic baudrate change in hci_serdev.c run for this path.
+ *
+ * It is executed before intel_setup() (and right after the controller has been
+ * power cycled by the probe), but the controller is still in bootloader mode at
+ * that point: it only answers at init_speed until the firmware has been
+ * downloaded, and it needs a few seconds after the reset pulse before it
+ * answers at all.  Switching the host to oper_speed while the controller is
+ * silent leaves the two sides at different baudrates and the setup never
+ * recovers.  intel_setup() changes the baudrate itself, once the bootloader is
+ * talking.
+ */
+static const struct hci_uart_proto intel_serdev_proto = {
+	.id		= HCI_UART_INTEL,
+	.name		= "Intel",
+	.manufacturer	= 2,
+	.init_speed	= 115200,
+	.oper_speed	= 0,
+	.open		= intel_open,
+	.close		= intel_close,
+	.flush		= intel_flush,
+	.setup		= intel_setup,
+	.set_baudrate	= intel_set_baudrate,
+	.recv		= intel_recv,
+	.enqueue	= intel_enqueue,
+	.dequeue	= intel_dequeue,
+};
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id intel_acpi_match[] = {
 	{ .id = "INT33E1" },
@@ -1074,6 +1109,16 @@ static const struct acpi_device_id intel_acpi_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
+
+/* Controllers which the firmware describes as a serdev child of their UART
+ * instead of as an LPSS platform device.  The CcP controller (Lakefield,
+ * Jasper Lake) is one of them.
+ */
+static const struct acpi_device_id intel_serdev_acpi_match[] = {
+	{ .id = "INT33E4" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, intel_serdev_acpi_match);
 #endif
 
 static int intel_suspend_device(struct device *dev)
@@ -1217,6 +1262,67 @@ static struct platform_driver intel_driver = {
 	},
 };
 
+#ifdef CONFIG_ACPI
+/* The controller does not keep the firmware across a power cycle, so it starts
+ * in bootloader mode every time; power cycling it here also makes sure a
+ * controller left in an unknown state by a previous boot cannot break the
+ * setup.  Measured on the ThinkPad X1 Fold Gen1: 500 ms of reset pulse, then
+ * 2 s until the bootloader answers the first command.
+ */
+#define INTEL_RESET_PULSE_MS	500
+#define INTEL_BOOT_DELAY_MS	2000
+
+static int intel_serdev_probe(struct serdev_device *serdev)
+{
+	struct hci_uart *hu;
+	struct gpio_desc *reset;
+
+	hu = devm_kzalloc(&serdev->dev, sizeof(*hu), GFP_KERNEL);
+	if (!hu)
+		return -ENOMEM;
+
+	hu->serdev = serdev;
+
+	/* The port is not open yet (hci_uart_register_device() opens it), so
+	 * only the ACPI properties and the reset GPIO can be used here.
+	 */
+	if (devm_acpi_dev_add_driver_gpios(&serdev->dev, acpi_hci_intel_gpios))
+		dev_dbg(&serdev->dev, "No ACPI GPIO mapping table\n");
+
+	reset = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(&serdev->dev, PTR_ERR(reset),
+				     "Unable to retrieve reset gpio\n");
+
+	if (reset) {
+		gpiod_set_value_cansleep(reset, 0);
+		msleep(INTEL_RESET_PULSE_MS);
+		gpiod_set_value_cansleep(reset, 1);
+		msleep(INTEL_BOOT_DELAY_MS);
+	} else {
+		dev_warn(&serdev->dev, "No reset gpio, relying on the firmware state\n");
+	}
+
+	return hci_uart_register_device(hu, &intel_serdev_proto);
+}
+
+static void intel_serdev_remove(struct serdev_device *serdev)
+{
+	struct hci_uart *hu = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(hu);
+}
+
+static struct serdev_device_driver intel_serdev_driver = {
+	.probe = intel_serdev_probe,
+	.remove = intel_serdev_remove,
+	.driver = {
+		.name = "hci_uart_intel",
+		.acpi_match_table = ACPI_PTR(intel_serdev_acpi_match),
+	},
+};
+#endif
+
 int __init intel_init(void)
 {
 	int err;
@@ -1225,12 +1331,36 @@ int __init intel_init(void)
 	if (err)
 		return err;
 
+#ifdef CONFIG_ACPI
+	err = serdev_device_driver_register(&intel_serdev_driver);
+	if (err)
+		goto err_platform;
+
+	err = hci_uart_register_proto(&intel_proto);
+	if (err)
+		goto err_serdev;
+
+	return 0;
+
+err_serdev:
+	serdev_device_driver_unregister(&intel_serdev_driver);
+err_platform:
+	platform_driver_unregister(&intel_driver);
+	return err;
+#else
 	return hci_uart_register_proto(&intel_proto);
+#endif
 }
 
 int __exit intel_deinit(void)
 {
+	hci_uart_unregister_proto(&intel_proto);
+
+#ifdef CONFIG_ACPI
+	serdev_device_driver_unregister(&intel_serdev_driver);
+#endif
+
 	platform_driver_unregister(&intel_driver);
 
-	return hci_uart_unregister_proto(&intel_proto);
+	return 0;
 }
