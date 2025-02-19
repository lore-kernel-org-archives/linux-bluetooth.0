Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1F20011A
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973799; cv=none; b=MNeOcSyZKP1T8jz2QIkJBhbo44DhTFVpWguWLsxEq4JeMnIJ/ik9RqH/xGF/tI5BuXepKlaz7iabBbwy+Q3ZDJr4rq31v7xqZmjvhhQKKhrF4Ftzj/MfEwsLPD+YjzwzJdKetEoqnsG1xgztWtwYjCoagOW4xvE/O2HstxzjxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973799; c=relaxed/simple;
	bh=GygF+WVIr59uul343L9tuyWR4MAHL9uIqO6GdsWz4pI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t1MdaIYPCT4RtK0onsMqMZQWZDTGvjtba5B/dSTcV/L1gJjiUM8hte1LSCQUQFGaWx6x6q+kv3SWeD+N+APVoT7hWqWEufGH9vdt2HAFLZHcRal8bP+nSN6/abL6RWV/JVCIBpYnayRFGlnnSsqPHSSwetf8AfKfDEPLWBwVbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJKPR8H7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJKPR8H7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so13651197a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739973793; x=1740578593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Ys/0wpk03bVrAqBvfg9sanxMv5Le9U3+rayIHkkyAE=;
        b=PJKPR8H7AQn4dDIgRyKXkpZiPTM3la8REk6nUG/6DHuMPQ4kPt6DY/2leOJBy/Vues
         hltwfE+D+Cgpxi07mxzUGU1ZZJquuANrkTbkenTH05+fh/IYXLiIrWgj5BGWAOn2IA0Z
         mN/VZQNbOd8Rxhc6F0z5LLih+zZPIcFFXMLdkN+CsL2eNU7TxvKbzSA6L5ySjBDIG5rb
         WGv41+kCGVv/yUaJyn5acYKwlsKr1UDczf7zcxSaAKazsbu/55MdLYe+DTQhaAMc29VS
         kWDep5u3Trktu1SF0N8AVkor5Zd4EsPg/pn/mWdDfIr+5Y7pvuHYSDVX4IUV83/+fW9Q
         SxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739973793; x=1740578593;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ys/0wpk03bVrAqBvfg9sanxMv5Le9U3+rayIHkkyAE=;
        b=WuWIr+59D7dVhi12bHrC1XfeGO/4Vg8lFXKWi3VMKnr23KwAdefYyHgIOZsQ81epDK
         JONDZKJGEupig70vITbUJHF/jRCtM+89yBVSqY62NGvwWQazHoYNYMZ1gMshaVFPEaeI
         JKQUT7hGaj8UjhgIPPMI6HLVgKMvIhPbDB+4EMO13LuW6AYPeUUzxlGVS8YqM0QnP8yX
         6zndqMqscQgminOCONu9jmNMKYt8OctX7J1J5KxTmYDk/12ENQG8YZLB9/NG/If9SsTw
         m+tyMjFkDA4LP2v4IVkXtg4M6lLcAZ7Vl6SgbHC3re0fuGZ8hwFXDMCA9teVJJVHj3XP
         JeNQ==
X-Gm-Message-State: AOJu0YyK9qDW697fbshij5aEsHx8h5ITQWILllgoUj7qMrp0GpT7bZ7K
	YIRmPH65pWvikJ+j46oC4WDrrg5YJuwksD2kNxhisMezYjM/Vo44W2zZVOfa8BcID7PcnUs5Emp
	7/8WQLcd21ZTddQSu2l1z9gmvupPFjogT8XYsbp2aARns2/GVC7lZKmw0gnNqVbPE/ddKwRTyPd
	G2cVg4XxWzM0elDle6zAgUTHsZ3k5Hh6WdUk9VE3s7s+aR/PPMyw==
X-Google-Smtp-Source: AGHT+IE8tbpPScniAMA+GJrwlRP+pa1BWvl+HGIGTPTx+8j17BC69rfZSBG+osCwkkwzt6dEQ9VkKZOZd7Ds
X-Received: from pfve14.prod.google.com ([2002:a05:6a00:1a8e:b0:730:7a4d:b849])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:995:b0:730:949d:2d3f
 with SMTP id d2e1a72fcca58-732617a0c39mr29654813b3a.7.1739973793375; Wed, 19
 Feb 2025 06:03:13 -0800 (PST)
Date: Wed, 19 Feb 2025 22:02:56 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Expose the isoc_alt attr with device group to avoid the racing.

Now we create a dev node for btusb. The isoc_alt attr belongs to it and
it also becomes the parent device of hci dev.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v7:
- Use container_of() rather than dev_set_drvdata() + dev_get_drvdata()

Changes in v6:
- Fix EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
- Use container_of() rather than dev_set_drvdata() + dev_get_drvdata()

Changes in v5:
- Merge the ABI doc into this patch
- Manage the driver data with device

Changes in v4:
- Create a dev node for btusb. It's now hci dev's parent and the
  isoc_alt now belongs to it.
- Since the changes is almost limitted in btusb, no need to add the
  callbacks in hdev anymore.

Changes in v3:
- Make the attribute exported only when the isoc_alt is available.
- In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
  (which calls hci_init_sysfs).
- Since hci_init_sysfs is called before btusb could modify the hdev,
  add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.

Changes in v2:
- The patch has been removed from series

 .../ABI/stable/sysfs-class-bluetooth          |  13 ++
 drivers/bluetooth/btusb.c                     | 114 +++++++++++++-----
 include/net/bluetooth/hci_core.h              |   1 +
 net/bluetooth/hci_sysfs.c                     |   3 +-
 4 files changed, 103 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
index 36be02471174..c1024c7c4634 100644
--- a/Documentation/ABI/stable/sysfs-class-bluetooth
+++ b/Documentation/ABI/stable/sysfs-class-bluetooth
@@ -7,3 +7,16 @@ Description: 	This write-only attribute allows users to trigger the vendor reset
 		The reset may or may not be done through the device transport
 		(e.g., UART/USB), and can also be done through an out-of-band
 		approach such as GPIO.
+
+What:		/sys/class/bluetooth/btusb<usb-intf>/isoc_alt
+Date:		13-Feb-2025
+KernelVersion:	6.13
+Contact:	linux-bluetooth@vger.kernel.org
+Description:	This attribute allows users to configure the USB Alternate setting
+		for the specific HCI device. Reading this attribute returns the
+		current setting, and writing any supported numbers would change
+		the setting. See the USB Alternate setting definition in Bluetooth
+		core spec 5, vol 4, part B, table 2.1.
+		If the HCI device is not yet init-ed, the write fails with -ENODEV.
+		If the data is not a valid number, the write fails with -EINVAL.
+		The other failures are vendor specific.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..495f0ceba95d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -920,6 +920,8 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct qca_dump_info qca_dump;
+
+	struct device dev;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -3682,7 +3684,7 @@ static ssize_t isoc_alt_show(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	struct btusb_data *data = dev_get_drvdata(dev);
+	struct btusb_data *data = container_of(dev, struct btusb_data, dev);
 
 	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
 }
@@ -3691,10 +3693,13 @@ static ssize_t isoc_alt_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct btusb_data *data = dev_get_drvdata(dev);
+	struct btusb_data *data = container_of(dev, struct btusb_data, dev);
 	int alt;
 	int ret;
 
+	if (!data->hdev)
+		return -ENODEV;
+
 	if (kstrtoint(buf, 10, &alt))
 		return -EINVAL;
 
@@ -3704,6 +3709,36 @@ static ssize_t isoc_alt_store(struct device *dev,
 
 static DEVICE_ATTR_RW(isoc_alt);
 
+static struct attribute *btusb_sysfs_attrs[] = {
+	NULL,
+};
+ATTRIBUTE_GROUPS(btusb_sysfs);
+
+static void btusb_sysfs_release(struct device *dev)
+{
+	struct btusb_data *data = container_of(dev, struct btusb_data, dev);
+
+	kfree(data);
+}
+
+static const struct device_type btusb_sysfs = {
+	.name    = "btusb",
+	.release = btusb_sysfs_release,
+	.groups  = btusb_sysfs_groups,
+};
+
+static struct attribute *btusb_sysfs_isoc_alt_attrs[] = {
+	&dev_attr_isoc_alt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
+
+static const struct device_type btusb_sysfs_isoc_alt = {
+	.name    = "btusb",
+	.release = btusb_sysfs_release,
+	.groups  = btusb_sysfs_isoc_alt_groups,
+};
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3745,7 +3780,7 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
-	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -3768,8 +3803,10 @@ static int btusb_probe(struct usb_interface *intf,
 		}
 	}
 
-	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
-		return -ENODEV;
+	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
+		err = -ENODEV;
+		goto out_free_data;
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
@@ -3823,16 +3860,46 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_acl = hci_recv_frame;
 
+	if (id->driver_info & BTUSB_AMP) {
+		/* AMP controllers do not support SCO packets */
+		data->isoc = NULL;
+	} else {
+		/* Interface orders are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
+		data->isoc_ifnum = ifnum_base + 1;
+	}
+
+	if (id->driver_info & BTUSB_BROKEN_ISOC)
+		data->isoc = NULL;
+
+	/* Init a dev for btusb. The attr depends on the support of isoc. */
+	if (data->isoc)
+		data->dev.type = &btusb_sysfs_isoc_alt;
+	else
+		data->dev.type = &btusb_sysfs;
+	data->dev.class = &bt_class;
+	data->dev.parent = &intf->dev;
+
+	err = dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev));
+	if (err)
+		goto out_free_data;
+
+	err = device_register(&data->dev);
+	if (err < 0)
+		goto out_put_sysfs;
+
 	hdev = hci_alloc_dev_priv(priv_size);
-	if (!hdev)
-		return -ENOMEM;
+	if (!hdev) {
+		err = -ENOMEM;
+		goto out_free_sysfs;
+	}
 
 	hdev->bus = HCI_USB;
 	hci_set_drvdata(hdev, data);
 
 	data->hdev = hdev;
 
-	SET_HCIDEV_DEV(hdev, &intf->dev);
+	SET_HCIDEV_DEV(hdev, &data->dev);
 
 	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
 					GPIOD_OUT_LOW);
@@ -3971,15 +4038,6 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
-	if (id->driver_info & BTUSB_AMP) {
-		/* AMP controllers do not support SCO packets */
-		data->isoc = NULL;
-	} else {
-		/* Interface orders are hardcoded in the specification */
-		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
-		data->isoc_ifnum = ifnum_base + 1;
-	}
-
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
 		btrtl_set_driver_name(hdev, btusb_driver.name);
@@ -4012,9 +4070,6 @@ static int btusb_probe(struct usb_interface *intf,
 			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_BROKEN_ISOC)
-		data->isoc = NULL;
-
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -4067,10 +4122,6 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
-
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4101,6 +4152,16 @@ static int btusb_probe(struct usb_interface *intf,
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 	hci_free_dev(hdev);
+
+out_free_sysfs:
+	device_del(&data->dev);
+
+out_put_sysfs:
+	put_device(&data->dev);
+	return err;
+
+out_free_data:
+	kfree(data);
 	return err;
 }
 
@@ -4117,10 +4178,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
@@ -4152,6 +4211,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 		gpiod_put(data->reset_gpio);
 
 	hci_free_dev(hdev);
+	device_unregister(&data->dev);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05919848ea95..776dd6183509 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
+extern const struct class bt_class;
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
 void hci_conn_add_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..f8c2c1c3e887 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,9 +6,10 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static const struct class bt_class = {
+const struct class bt_class = {
 	.name = "bluetooth",
 };
+EXPORT_SYMBOL_GPL(bt_class);
 
 static void bt_link_release(struct device *dev)
 {
-- 
2.48.1.601.g30ceb7b040-goog

