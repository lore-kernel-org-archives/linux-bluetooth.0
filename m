Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B43AA4F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700938; cv=none; b=fI5flEX5QFODokw0AV0sAC5/WQeWsffFVj40Gudsgynz1bp1gs+JPvq6ep5HtrjMFoVrrcoXW9BTZLsvfeBVaLIzI1HQnwwIgg0nO366tLq+Wx6dCRGwxm3bjewp7NwLCruHKaxKCmi+qt6bgMeR/y4tDBo4KgO7YPZ4+Ycfwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700938; c=relaxed/simple;
	bh=vA6RpUdKopEs6oycVJjkV0lI8fBKY0jLi9rmCr31vFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsoR3yofWnSY7rPojA9Iw0MekXzhPAwgJaSEognawJVfiX+FRwKYFxOEJxTyMGFmUg1rDj6IXMLYFygUt8Nw+oun18sxvY1RelFa6doPyq7DKmem/qWyx26nVwL9wYY2Kzv10Gar3DkTOVnLOlPBPS7D8grkuhoysOs5tZY/VUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=h5Ik+tNl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="h5Ik+tNl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so80260245e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1778700934; x=1779305734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvAe1DPpB6I0psi9WiBtsI+tM6xWmLP/jLbbUynVL7k=;
        b=h5Ik+tNlvjBHehG+DQNYaBnvU3vpqXhBjC4Wpw9MRbGtDoTnVgJEl4E9uKLpRyW2Q+
         8mVbsUUcNgfb55jY6/T+ph8rPr8FjkHk1Gm+gc4khJf+IBn76EkrgNnP7DjkbiURdmca
         xRugY7raiGBij9wljMPocW9kshmGjpV29JXa1d9LJvhslrZ3zVIdS1AI73q4Kkm6NcW+
         +tx9T4+CaJRg/B6bYVz9NJSWVGi0Gx38+CFyJVhDj3VPxmAPsygUmF095jQaH3OENPdQ
         oI0zsWvH+utiSqwOkUGjLXtdokBub2QodrZv1k2MvZN7hadl0Ehc1Cp0ZgiEQ4OHWT07
         LoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700934; x=1779305734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvAe1DPpB6I0psi9WiBtsI+tM6xWmLP/jLbbUynVL7k=;
        b=Qy2moOJsHVmoQZScQasBSDjSmNITjYKj5vuQtr5u5FQ4oQFBFbKtZxmcJ+WOaKN4ZT
         0L60/NZDh0HTfHOlYPbjFnJCL+jc/3GHQ/8zfwcogj2qynx0o3FjcsrHS/vWib5kZk08
         w2iuvh7gCQIkdzsl3zyb+159zd5z4IFbMRJYrcLLzJkwcuNYnjl1tVa+CJAnFbzbD0YZ
         W72rSM6OO+wT5dl6YGNCtvZ7gw19Vdr8WU+Xab1wnAoMgWEy911U99zaodFeYzBLxJti
         H4ib03HK3kLSYV+wQ4/wvnWM78sXUg2y2u+sXyMGPPHs9ZohEzNj5m3MhWZB/yY8KQ77
         7LzA==
X-Forwarded-Encrypted: i=1; AFNElJ/SyXhNUPNsqWYoSWpNtfQghuBvkn2+otVRrmGIk9u1mCjxvF6k1gNOhNrZK3Ojln0Atx5SWKvR4uc+/WaeasE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlCjt4wb8XVYsog6P+zFe+6gwWxKWYGFr4xI0bQso9+l2r34k
	KOWaPFChLOYcc26TubpFfG6VuNBMiXczSa7/Xj/hdi2h32CFCjOqKsA8tPFX8EZ+rQ==
X-Gm-Gg: Acq92OGkymPKxIiLmFEH+OiegrZ+REdz7+Ks3Y383KX8z8T/7NOOnrU4wADERGTna5d
	O5hMvUOZ+kDqyJvG1LuRv2xSlnUlAG6V4ctwVWus1bnG8lLb1q0cCboApKcI9I+wYms29jWoYkw
	YAv/XXnBOq4gMaLYSx4mDFRD/ri/usFBW/TAgFMpPrqOI+LKiFP5iV8DVc36hDYtwMC3dPbBfNE
	q1d1xVDG1FNtEz357bIsCsQGENRGKfTmFcKdR9IxmlnscvK4lSb0V7Axx9WXFJJu7vPmCDTSqy8
	aAHJKuZefPltdaXH1IS98VhNnsGnY7yOLHVJnuPjOto1Tw8/386HOEfUsTaUReG2sXs5FqNAYRd
	jkWLdB0AX2v5bF4MBako0nI/ntPIzN/KWZrpHQINWYMZJ4SkprSFRX31PYIOyRc7fls8GITW+En
	L0wVbFfPyCymDMdqDYYCq6IKg356sAxjVdgmTfwN7/H1oBTbXtzg==
X-Received: by 2002:a05:600c:8716:b0:48f:d5d7:df63 with SMTP id 5b1f17b1804b1-48fd5d7e0b1mr25261675e9.27.1778700933717;
        Wed, 13 May 2026 12:35:33 -0700 (PDT)
Received: from horizon ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64d9f63sm10160775e9.12.2026.05.13.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:35:33 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
Date: Wed, 13 May 2026 20:35:31 +0100
Message-ID: <19a2b7d308f5cdfa651fee727c1423833380ea1b.1778700929.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8020c41b39f5 ("usb: core: allow ACPI-managed hard-wired ports
to power off") allows internal USB devices on ACPI-managed hard-wired
ports to use the existing runtime power-off path. For Intel combined USB
Bluetooth controllers, btusb still keeps runtime remote wake enabled for
as long as the adapter is open, which prevents the USB PM core from
dropping the last child reference and powering the port off while idle.

Only keep runtime remote wake enabled while the controller is expected
to signal activity on its own: established links, discovery, LE scan,
LE advertising, or BR/EDR page/inquiry scan. When those are idle, clear
needs_remote_wakeup so autosuspend can power-manage the port and a later
host-initiated command can resume the device again.

Cache the BTUSB_INTEL_COMBINED match flag in btusb_data so the runtime
wake decision can be made from the open and receive paths, where the
usb_device_id used during probe is no longer available.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/bluetooth/btusb.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f5fce93d984..8e30c968fd6a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -950,6 +950,7 @@ struct btusb_data {
 	unsigned long flags;
 
 	bool poll_sync;
+	bool intel_combined;
 	int intr_interval;
 	struct work_struct  work;
 	struct work_struct  waker;
@@ -1007,6 +1008,9 @@ struct btusb_data {
 	struct qca_dump_info qca_dump;
 };
 
+static bool btusb_intel_idle_power_manageable(struct btusb_data *data);
+static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data);
+
 static void btusb_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data;
@@ -1218,12 +1222,19 @@ static inline void btusb_free_frags(struct btusb_data *data)
 
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
+	int err;
+
 	if (data->intr_interval) {
 		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	return data->recv_event(data->hdev, skb);
+	err = data->recv_event(data->hdev, skb);
+	if (!err)
+		data->intf->needs_remote_wakeup =
+			btusb_needs_runtime_remote_wakeup(data);
+
+	return err;
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
@@ -1991,7 +2002,8 @@ static int btusb_open(struct hci_dev *hdev)
 			goto setup_fail;
 	}
 
-	data->intf->needs_remote_wakeup = 1;
+	data->intf->needs_remote_wakeup =
+		btusb_needs_runtime_remote_wakeup(data);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -2034,6 +2046,38 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
+static bool btusb_intel_idle_power_manageable(struct btusb_data *data)
+{
+	struct usb_device *udev = data->udev;
+
+	return data->intel_combined && udev->parent &&
+	       usb_acpi_power_manageable(udev->parent, udev->portnum - 1);
+}
+
+static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data)
+{
+	struct hci_dev *hdev = data->hdev;
+
+	if (!btusb_intel_idle_power_manageable(data))
+		return true;
+
+	if (hci_conn_count(hdev))
+		return true;
+
+	if (hdev->discovery.state == DISCOVERY_FINDING ||
+	    hdev->discovery.state == DISCOVERY_RESOLVING)
+		return true;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	    hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    test_bit(HCI_PSCAN, &hdev->flags) ||
+	    test_bit(HCI_ISCAN, &hdev->flags))
+		return true;
+
+	return false;
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -4118,6 +4162,8 @@ static int btusb_probe(struct usb_interface *intf,
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		data->intel_combined = true;
+
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
