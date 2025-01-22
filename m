Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A010E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523257; cv=none; b=WKDOgyR7NFKNAE0nsaupT4kM7jb88Xi5hkensT2fIRPHZFU7FVIMKBHR2NuTuXZcwckv3L0OSzkDW8LywcZ+yE6yDNg32aKVTN+YOsl/4nuD0MPwXiT0xjKp/5l2rFTkXoMwERcC7M4Ama2Ief+ObcXMQCp2OV8lcYR4G1hfWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523257; c=relaxed/simple;
	bh=YhUqF6C+/xOQj2Y/ypEUT9skanylg7/3QRjlJh14Puo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H9LDqERDAnrVC/TV2hPRCVyNrTE1mwgt79N+riaKsu5dEATBljHjQB3cCf5gw2p6kNsRDQaEWCOdAUkMkQ/7NMEnF9hZxBl4eMSYUe4UV84xaCMyPmnkblpiIaZrNED3Dx4/YmEEVsuMmqniwOyss7cPSfz/PYBlrAmSxJvGH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezljAe9Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezljAe9Z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21648ddd461so133589795ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 21:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737523255; x=1738128055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zpKj/vRFh/GcMVyUYHVbJYejAl25i2NKFWrMBBi6KOk=;
        b=ezljAe9ZO/qdVhHyYbkcnOe0I+XVkiReXZYP97+MUZXycrwXooyOGiv27M50zpDmmp
         03pydlyV4ETfuioUeRKuqgjLSfTF1m5cmaIxbaYDEInJ3JrJlC10ZbHn92NUn56+RH+X
         F623HddXBYrKJcKKKMRnhANcljBfbD467VRCH3m8hKzqdMlKl8VN7QC2PbBekS+/Mi7e
         HjTTa0gEwGUzjxPksSwgrbkU2eyv8OH6nOnh+G/PdPICdRVWvfrozHhysBFARaBMniTi
         k1cdmv75wpTWW1OknXyVcFtHnQqyxl/5UsqOmCv70w+iohkGBYZibNrXJWOoTlqiWBpD
         YFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737523255; x=1738128055;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpKj/vRFh/GcMVyUYHVbJYejAl25i2NKFWrMBBi6KOk=;
        b=fx4KOZLpEkzqojxs3KzqH6sTNnzAYQpnQzorKwn1YgcL9AM/cUk2X1/XBBbx4OVnGG
         vh36jjYq3qBg7c2ITsx7jVYAzaYoas8ceimypSPXXStyUHPyxISGdKv4va0k2fZVbaVI
         KrNHcIT56aiOLxWP1ZiXJDC3bqeBn4U1NTzQFVrfmDj9IyPmNXrtjQNLAMXYspMyzn/4
         IuLAvdR3j8HD03ajqooZM6TUAtf4jscm/2qdH+N895VbPgHLBxD3/2M52kfQHV1f/s50
         2eWyIDFCA+JoIiuVr+DV6sSN4+7+gusGwfq58Eg1Haf6vSwJOXZg4qPDiWY9UW1MhkV7
         TgiA==
X-Gm-Message-State: AOJu0YwTA6fZcmcq+3x/2BbXZcfh7fJf49wz21eVfyH+dOAI/5NIf4hW
	xQBHfnBIZkt1tncXP/vo8dscV27z18ZOErzO77y5btMT3/nfm19I5UUcoY6p3rPtaaJIRZiL8zF
	I41oAyWOpiif+8LDIUtMYFqIn1NHbs1A8Ug0Wqeimqz9qOFU1dvwp/XaPzTdaCROtDiWq0WE49R
	ICrMGwBlS8es9PEeyvZ77uIJ6Uag55UJ/0+D27IqNZ0U6iTsPjvA==
X-Google-Smtp-Source: AGHT+IH4xhaj9nNDf+i1lGfmdriydIO8H2hCafDs9TDl1139kXi+me1rarwesfsxsbaZvZMJbhDgOHfzv/FX
X-Received: from pgbbe2.prod.google.com ([2002:a65:6e42:0:b0:9a1:7139:ff84])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e615:b0:1eb:3623:59fd
 with SMTP id adf61e73a8af0-1eb36235ae1mr22932415637.4.1737523255341; Tue, 21
 Jan 2025 21:20:55 -0800 (PST)
Date: Wed, 22 Jan 2025 13:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122131925.v2.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH v2 1/3] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Use device group to avoid the racing. To reuse the group defined in
hci_sysfs.c, defined 2 callbacks switch_usb_alt_setting and
read_usb_alt_setting which are only registered in btusb.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c        | 42 ++++++++------------------------
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 75a0f15819c4..bf210275e5b7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2221,6 +2221,13 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 	return 0;
 }
 
+static int btusb_read_alt_setting(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return data->isoc_altsetting;
+}
+
 static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
 							int alt)
 {
@@ -3650,32 +3657,6 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
-static ssize_t isoc_alt_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
-}
-
-static ssize_t isoc_alt_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct btusb_data *data = dev_get_drvdata(dev);
-	int alt;
-	int ret;
-
-	if (kstrtoint(buf, 10, &alt))
-		return -EINVAL;
-
-	ret = btusb_switch_alt_setting(data->hdev, alt);
-	return ret < 0 ? ret : count;
-}
-
-static DEVICE_ATTR_RW(isoc_alt);
-
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4040,9 +4021,8 @@ static int btusb_probe(struct usb_interface *intf,
 		if (err < 0)
 			goto out_free_dev;
 
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
+		hdev->switch_usb_alt_setting = btusb_switch_alt_setting;
+		hdev->read_usb_alt_setting = btusb_read_alt_setting;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4089,10 +4069,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc) {
-		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+	if (data->isoc)
 		usb_set_intfdata(data->isoc, NULL);
-	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f756fac95488..5d3ec5ff5adb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -641,6 +641,8 @@ struct hci_dev {
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
 	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*switch_usb_alt_setting)(struct hci_dev *hdev, int new_alts);
+	int (*read_usb_alt_setting)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..887aa1935b1e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -102,8 +102,41 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(reset);
 
+static ssize_t isoc_alt_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
+
+	if (hdev->read_usb_alt_setting)
+		return sysfs_emit(buf, "%d\n", hdev->read_usb_alt_setting(hdev));
+
+	return -ENODEV;
+}
+
+static ssize_t isoc_alt_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct hci_dev *hdev = to_hci_dev(dev);
+	int alt;
+	int ret;
+
+	if (kstrtoint(buf, 10, &alt))
+		return -EINVAL;
+
+	if (hdev->switch_usb_alt_setting) {
+		ret = hdev->switch_usb_alt_setting(hdev, alt);
+		return ret < 0 ? ret : count;
+	}
+
+	return -ENODEV;
+}
+static DEVICE_ATTR_RW(isoc_alt);
+
 static struct attribute *bt_host_attrs[] = {
 	&dev_attr_reset.attr,
+	&dev_attr_isoc_alt.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(bt_host);
-- 
2.48.1.262.g85cc9f2d1e-goog

