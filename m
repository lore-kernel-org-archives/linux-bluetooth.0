Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BE1B218B
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443842; cv=none; b=dQNWMrFUCJIVik/ynweR5Y/E28bTdltBnj7etH9jRwPkTtn+vn1O83MQA8IGbs+WuvOHeH0W6vJN0lURCBfA/+5jdClrC0vc4U8VnBk5lzyuPzEH5VMfk5wtzApEgByvdNvja5rl8j8ifvVNRwhLYqn5EPS+3UIOVJf2mZukgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443842; c=relaxed/simple;
	bh=Dwx4RRUwHaqDwEUOrrQiQe9EvqOqneBkX4MudSge/o0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uuPFWyU3sYsDzdY73Vp4a9sQw43BNm3ZFjvur0tNdsiecRIrWK349Pf02SmLSKSgpOv6vvpu9cGWQ+RTxeV+Xk9tVQVEF2kbbtIjzOnBRLcckfuJHUt+pedPkwl0AiNSRjNHt/9VL7FeZe63weSVUE4FMdNZqgcTCSQqCoQs3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZIuqSaka; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIuqSaka"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29fd1868bc4so5905607fac.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 23:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737443840; x=1738048640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6POgZu70+PjVYcuU/158CQRyYRKdbK+Oy5JVkfz8x2Q=;
        b=ZIuqSakawIDhYUeC6qAIrofqPqduVd6B3i4auzPah10+Bfc66JMGtjR9HoDxHaN6aV
         xK8rpVAUjCG+dBO8EtYdaSqHd3dOZOIuBci8pvlDMxQ/xKgzybkvDErXyUAcwlHXTryg
         +JRfshzImht+jKbdu9MyLlR5V/27C3b87IQTPjFRP/8tQo1hMU7cFNj/zg+5snWbdsKA
         lF1nExi1pX/ti/r3jKu3xR8hHXhBu+XBDuPrThSzj7EREQZxJJJ3I9MjFqqOeTXS6D3S
         30R46O53NbWmC2xmPl8x1zd8XtNO5o5yofBy8cmWNBKzlmIY5QibdOeWNu6huB86MdM8
         N0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737443840; x=1738048640;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6POgZu70+PjVYcuU/158CQRyYRKdbK+Oy5JVkfz8x2Q=;
        b=WNze2VnJS8CHzUQqmwRaNw9mBLktZ68pSH51qk3FkPwnsuGhPdjiEi2MCHN3BUH6Ce
         XFEHXdNzXRfcOb+ar37ncLqydGeEczeXeO9RSJwQaZUYvbtiG5dOVN8icYsaDcXmDmTe
         GWa25itTJ0q1GzxwRQNYIsyb7QhOw/Vay3lVZz8a6oFqmVLv8oIJ81nalAVMUo6OH3CU
         8KX/LMH4eWVyDthp6x2Me7D9JjBVe5UwINDK8yuHVWjAOPL4Tsn3398GyrE8s139/fpo
         V+zAWlN+P7x1uSCctCmDdrkpoa0c4nCkh66USoL2yE/walwpL+kMjc0/0pBU4mmphXrw
         PeCQ==
X-Gm-Message-State: AOJu0YykSVSQyEsJA3yyND1HUVw2NYa4QneMnRYrFoIobluDWaEDwh4K
	VKrmnCQN7F+6pIQHM64BUaYUYq7WJO7qXJccH73q+NTqdO/+fAolN14rk1lrJtbJF3xSBpx1JwR
	Rv7ndImSoDxRGIGyH67ZlvZsnHkVPihvW5iknkV+NktV+Hn9k0ES5juqQOrgsf+ILdkYbJeBs3m
	Mm3TkUwaOeYR9jNTafj0ptDKGNNUcMLUk//ugir0pQ0rWYqDkIpA==
X-Google-Smtp-Source: AGHT+IFM5tQbg1m5rXt6opXiz/QXmmzdu7N9SXAzDLFxdpUEPI/hJNCN2+XN/hDQZTjODt53IgRP6SkBcDmJ
X-Received: from oacpv10.prod.google.com ([2002:a05:6871:3a8a:b0:29d:cb27:3f14])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:ff84:b0:29f:b1d4:7710
 with SMTP id 586e51a60fabf-2b1c0c52266mr8855302fac.24.1737443840160; Mon, 20
 Jan 2025 23:17:20 -0800 (PST)
Date: Tue, 21 Jan 2025 15:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121151532.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Subject: [PATCH 1/2] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
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

 drivers/bluetooth/btusb.c        | 42 ++++++++------------------------
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_sysfs.c        | 33 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9aa018d4f6f5..f419d0827ee4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2224,6 +2224,13 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -3646,32 +3653,6 @@ static const struct file_operations force_poll_sync_fops = {
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
@@ -4036,9 +4017,8 @@ static int btusb_probe(struct usb_interface *intf,
 		if (err < 0)
 			goto out_free_dev;
 
-		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
-		if (err)
-			goto out_free_dev;
+		hdev->switch_usb_alt_setting = btusb_switch_alt_setting;
+		hdev->read_usb_alt_setting = btusb_read_alt_setting;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4085,10 +4065,8 @@ static void btusb_disconnect(struct usb_interface *intf)
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
2.48.0.rc2.279.g1de40edade-goog

