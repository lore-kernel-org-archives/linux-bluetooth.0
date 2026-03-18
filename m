Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50936A038
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863513; cv=none; b=EfcElcbM9WQ81P/COjzO7LplnbsWz2nyYoN6MJsq6+ytyqdZZNNQY7m0sGMQEPyFeY4YpFBZU2ekWSsv9FcB/teEvwkFJXgVZknZTDE9mGb+uFx2g+O4Os0qUfMDBTO70YRcFPULoHQ+Y+OYHdXe1xdCuM1amTcdwUJXa2OuP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863513; c=relaxed/simple;
	bh=tqPRzMtHOIZLjWEVwhds2hAjNGs4sUGuk1r2OLRtmBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1qdULrqCmD1MrD+sfyBDidqHSoPfmqz7+iKJfQYZq2KqnXZH1zTy+NQu4AWRTnUFhq6+3k9DAU7Ff5cQiN79h8+8T0iAVjuZz5RFG7bKPrmF3wMIhRKzGuk+Fjf0vTjP0Dc8A4fCbW9Lg26k82AuMDDJq3o74gM8NLOPCqjuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=gP+aopfS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="gP+aopfS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so2750595e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773863508; x=1774468308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9diUOv++hsh458hLzcUOWkiK9bUzXbhl4P/hLWU7Ycs=;
        b=gP+aopfSXKRgqHiewyipTkAY++67j2AbebWUQz+WNkR0EWQoylFASJBwiEyaIJWpJ1
         GQ8+Ad8wQD2qPOc8S1d6Qi91V2AGFH+MfY63Z7e62mnVuX03m5Q/JZnd0yTTpePIxJsq
         UxpSO/tje30H9qFPEDqf2hbHYJ5AmtueoYi3xasH6AgNbhtI01i+mfUW22yezsOoRVXs
         lrrWhosPSgi4vC5vHe+tErVRrdHCAUj7h3e6cFfBbUmYymwRnYcWAndXdK+DAoaZjEhE
         lfSxJSnD9+zz/Oe/zDM8r5ejmgRd0x9nOcGPHeyKUHJyQYt3mRF6whd/20qEPHgZEBxT
         TlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863508; x=1774468308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9diUOv++hsh458hLzcUOWkiK9bUzXbhl4P/hLWU7Ycs=;
        b=Pa5nOIyzaWt4Znmoz5f9DOEv0XFsEEYeF+vMHT01IKAbygFt+Pw1pPRt6IpROhKCYG
         8LZFNO8Rsmc9Y9XPKbc0SLMLMI0a55DNiw3ExIL5yeR8o5m1ee3jfKGO2U4rl8YG2wno
         jp7pjtvN1GBDyQ+kcwv+Hv74dQrb1Bp7KH1pwRh+U8n0+/K1ApNEjoANeA5GAXLMf2ru
         ribDQLXZcgYTRB9Ua4UOLrhnlJQbG+5C0MO3M5mY0SZAGqT1hhmDcqvn5BXI0jowQQYb
         xmXDDHAbYSWz5q9l3+OEkA4wQacTk1Pse9z8lyVgcHg3nTgTuNpOP8f7abw4xHn9zL/2
         O5iA==
X-Forwarded-Encrypted: i=1; AJvYcCWz/CJoe3Be1pfLVLub7qHsYmsmkn2vWARA5yRt4npoh0N+OYX7Kmujq4Xa80qJ62EoT38H6N4fG2FrZjtVjCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6ZxB33f8ttKJ+664ApesqM9RoX293cFyA2mpR8ixKyr5r1Vb
	pHC6miHhA3DPLTUhGDJqpIqMGp0CjQUPnIP9CGPc7OxkKn0pJ3mmSwqszrJCOfGquhdNzPRcE2F
	zYNp/2g==
X-Gm-Gg: ATEYQzwIYwEVcC0zLx94zXlMCTb01/sadO25Uill4PkadIDap9+lCQmy0m8WHJ5y4ua
	cnXVHx1xZTAExjDBKiFVhMxSQTq6l/8xZSvAeCyJmg8olkgfXyakU/0L5QXr1Ix2SL4O9I8Z8kl
	lza++w9z5x/ozXQyxl4rGtWfOsfdf+p5mDjHRDTzxKJrk4jzoSBe95VYQYz6RgjyCXUd0oQROzq
	JPghTovnAOcReU3hCKNwZTVPBVLdRWTZ+D4bBoxIcbDviNGnfCwTNyN5aWybkrO6zHiaJ4dHCvt
	TwRm66d5uN4iWWBhmr6VM/ZxdjSKaS1aRbUw5R41T9UoPhxXfVNev88yAwL4mq9zr1EPzGB1Rh8
	f4rcMUZRvq6iLaeFdgXueKz56KYUDBkhWlQgqhEMzfoCTviRZpy0XT86nBouv5bR6gWmfFwmD3X
	0seSjJ+Z8xyNBlroLR1pQjrHBL0aWSGAnwP8BfOIRWSuTQpDQBU9U=
X-Received: by 2002:a05:600c:4710:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-486f44375aemr74930775e9.11.1773863507756;
        Wed, 18 Mar 2026 12:51:47 -0700 (PDT)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f45d8e3dsm27252465e9.0.2026.03.18.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:51:47 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
Date: Wed, 18 Mar 2026 19:51:45 +0000
Message-ID: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6953217d9f44 ("usb: core: allow ACPI-managed hard-wired ports
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

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/bluetooth/btusb.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..9df8a7c3254b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -901,6 +901,7 @@ struct btusb_data {
 	unsigned long flags;
 
 	bool poll_sync;
+	bool intel_combined;
 	int intr_interval;
 	struct work_struct  work;
 	struct work_struct  waker;
@@ -958,6 +959,9 @@ struct btusb_data {
 	struct qca_dump_info qca_dump;
 };
 
+static bool btusb_intel_idle_power_manageable(struct btusb_data *data);
+static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data);
+
 static void btusb_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data;
@@ -1151,12 +1155,19 @@ static inline void btusb_free_frags(struct btusb_data *data)
 
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
@@ -1924,7 +1935,8 @@ static int btusb_open(struct hci_dev *hdev)
 			goto setup_fail;
 	}
 
-	data->intf->needs_remote_wakeup = 1;
+	data->intf->needs_remote_wakeup =
+		btusb_needs_runtime_remote_wakeup(data);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -1967,6 +1979,38 @@ static void btusb_stop_traffic(struct btusb_data *data)
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
@@ -4041,6 +4085,8 @@ static int btusb_probe(struct usb_interface *intf,
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		data->intel_combined = true;
+
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
