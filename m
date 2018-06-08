Return-Path: <attitokes@gmail.com>
From: attitokes@gmail.com
To: 
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Artiom Vaskov <velemas@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
Date: Fri,  8 Jun 2018 19:20:09 +0300
Message-Id: <20180608162009.22762-1-attitokes@gmail.com>
In-Reply-To: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Attila Tőkés <attitokes@gmail.com>

Added support to automatically configure the SCO packet routing at the device setup. The SCO packets are used with the HSP / HFP profiles, but in some devices (ex. CYW43438) they are routed to a PCM output by default. This change allows sending the vendor specific HCI command to configure the SCO routing. The parameters of the command are loaded from the device tree.

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
---
 .../bindings/net/broadcom-bluetooth.txt       |  7 ++
 drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4194ff7e..aea3a094 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -21,6 +21,12 @@ Optional properties:
  - clocks: clock specifier if external clock provided to the controller
  - clock-names: should be "extclk"
 
+ SCO routing parameters:
+ - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
+ - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
+ - pcm-frame-type: 0 (short), 1 (long)
+ - pcm-sync-mode: 0 (slave), 1 (master)
+ - pcm-clock-mode: 0 (slave), 1 (master)
 
 Example:
 
@@ -31,5 +37,6 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
+               sco-routing = <1>; /* 1 = transport (UART) */
        };
 };
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a..0e729534 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -83,6 +83,16 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ *
+ *  SCO routing parameters:
+ *   used as the parameters for the bcm_set_pcm_int_params command
+ *	@sco_routing:
+ *	 >= 255 (skip SCO routing configuration)
+ *	 0-3 (PCM, Transport, Codec, I2S)
+ *	@pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
+ *	@pcm_frame_type: 0 (short), 1 (long)
+ *	@pcm_sync_mode: 0 (slave), 1 (master)
+ *	@pcm_clock_mode: 0 (slave), 1 (master)
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -114,6 +124,13 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	/* SCO routing parameters */
+	u8			sco_routing;
+	u8			pcm_interface_rate;
+	u8			pcm_frame_type;
+	u8			pcm_sync_mode;
+	u8			pcm_clock_mode;
 };
 
 /* generic bcm uart resources */
@@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
+static int bcm_configure_sco_routing(struct hci_uart *hu, struct bcm_device *bcm_dev)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct bcm_set_pcm_int_params params;
+
+	if (bcm_dev->sco_routing >= 0xff) {
+		/* SCO routing configuration should be skipped */
+		return 0;
+	}
+
+	bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d %d)",
+			bcm_dev->sco_routing, bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
+			bcm_dev->pcm_sync_mode,	bcm_dev->pcm_clock_mode);
+
+	params.routing = bcm_dev->sco_routing;
+	params.rate = bcm_dev->pcm_interface_rate;
+	params.frame_sync = bcm_dev->pcm_frame_type;
+	params.sync_mode = bcm_dev->pcm_sync_mode;
+	params.clock_mode = bcm_dev->pcm_clock_mode;
+
+	/* Send the SCO routing configuration command */
+	skb = __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: failed to configure SCO routing (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* bcm_device_exists should be protected by bcm_device_lock */
 static bool bcm_device_exists(struct bcm_device *device)
 {
@@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	/* Configure SCO routing if needed */
+	bcm_configure_sco_routing(hu, bcm->dev);
+
 finalize:
 	release_firmware(fw);
 
@@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 }
 #endif /* CONFIG_ACPI */
 
+static void read_u8_device_property(struct device *device, const char *property, u8 *destination) {
+	u32 temp;
+	if (device_property_read_u32(device, property, &temp) == 0) {
+		*destination = temp & 0xff;
+	}
+}
+
 static int bcm_of_probe(struct bcm_device *bdev)
 {
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	read_u8_device_property(bdev->dev, "sco-routing", &bdev->sco_routing);
+	read_u8_device_property(bdev->dev, "pcm-interface-rate", &bdev->pcm_interface_rate);
+	read_u8_device_property(bdev->dev, "pcm-frame-type", &bdev->pcm_frame_type);
+	read_u8_device_property(bdev->dev, "pcm-sync-mode", &bdev->pcm_sync_mode);
+	read_u8_device_property(bdev->dev, "pcm-clock-mode", &bdev->pcm_clock_mode);
 	return 0;
 }
 
@@ -1022,6 +1088,9 @@ static int bcm_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = platform_get_irq(pdev, 0);
 
+	/* SCO routing configuration is disabled by default */
+	dev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&pdev->dev)) {
 		ret = bcm_acpi_probe(dev);
 		if (ret)
@@ -1281,6 +1350,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
+	/* SCO routing configuration is disabled by default */
+	bcmdev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&serdev->dev))
 		err = bcm_acpi_probe(bcmdev);
 	else
-- 
2.17.0
