Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189B16D4E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062683; cv=none; b=gvnrTH3sPAsIa7yZYCXaexqTKUD8u2flIilR6ykJU5r9B3X8VDgW26oN3lomIJk39yksd0G2CvKWCGt+kgQM8KLCXG77o82gBv7QbkBr7Xl2bfTPPiwgZBXiuMpK3YuouH43PhRSfbeNzBrFJWWH3sR+74XdaAzemLVPNGEN5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062683; c=relaxed/simple;
	bh=9uKPv+nA0DYYhWDNhWFHUgyJuC9n4Q/+gOe7CZ3OOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbjE34xZNoGusoeMsvqsfYvwh9UwbJNaA4pldFozewvyjlBJll6UMX5O5gMrED8euOBchEtsABF6hbGKbhNa3YgJoIu8Gq3djSIJmgcZ5JOPfa0FoEenOKgota97liYB3ot3Ovi4UuKX0O5sRPpudmYBqA6Zia4lmGT3xsqmebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cWANRpDu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWANRpDu"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1147271b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734062680; x=1734667480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xC1PWxsz+fLoRoV12VLNzfDC1+hiBiUnmX6sO7UCuXk=;
        b=cWANRpDuL+TBDcqE0Cv4f1lqUAnP91E17DsQAiGDS4Gq2xzf8GJQ8gMie1misMhYGR
         D3bl1pV7eqGbH2Fj18iUk8WSsKqjTYCDXxh5Wb7JOIlFQHm1XoC2KVPEnyvpKPiM5yCR
         0Lzy37K5WwRPEvPn6PJR4libntD7BowBX2sXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062680; x=1734667480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC1PWxsz+fLoRoV12VLNzfDC1+hiBiUnmX6sO7UCuXk=;
        b=oBklbor3lRqXR87N7mBLLORlqKXS9hQuOdCPP2AyDqvYgR1/vvBwkbWhoJmHaGJXYE
         hMlg4Va3C7RBzyakvfaVlmBEceffJY/uOuY8KoPsHhPuFKCQKiQ2rzWOjlZoJFfaZDT0
         hLRWikc2pYU0uFqgIEplcsrki6LJl7p9mINIysXUh9tvLdGmPmtpq2hfXOph0cLh6tKH
         fz6kr/+q345LzhyStxmKoxi4KdPSDec+mWrnBvrs0HDOYY1oS0+P1hqazM6wfQCYOBXI
         QVL3mAN0CrPCdzQf9FOzhkENVqKZNBV/V5XYGJyHz78ORslEGE5W6+HeSnEAENhdwYHM
         guvQ==
X-Gm-Message-State: AOJu0YzCWaOiGnyk4sfOegtVO8NXjGlOCJn60W5BOrHyYHxUnXzkCHiZ
	EDhWnNtoMDaTdecAX+SSP2XqdEKC3guYBmoMkEGy5XnPy6bGv+9l7PozEkJdotRSRXx7Cx6vyi7
	eJA==
X-Gm-Gg: ASbGncvRHwBtqF0zHBggHJ10t7eCs+p0bUAacFKRQ32adrWQ2jqk7w2kQ8pD+bnZoMd
	1zG2eRfajq02TykchaLw4KL9EN1NZwidIUHBRP+PjK1NV8ZVMiCzQpGeYjSQ3rxpZey3ZpfcTGm
	DKF3/uHhKQyLkEgib1SLhghD97qi0JRJXpEwnStNyo9PWT8eSN9/o/Db4txvfjgTqzNoU+j46AE
	4K3rED3spys4MqCAQtByJgF+lCREZ2sLwxX1y3CUU4oNtrXKNvSwrFmiOnBKqtLv1tAHBADSi6f
	awRkchoM
X-Google-Smtp-Source: AGHT+IGVI281zdlVYTcdVEiL/CpBhWJseYXPG1mM20XQL8Q0gyt/Hy4yCMb7tVAtIZJ/+QY3fDJRrQ==
X-Received: by 2002:a17:90b:28c5:b0:2ee:44ec:e524 with SMTP id 98e67ed59e1d1-2f2901b1131mr2019572a91.35.1734062680598;
        Thu, 12 Dec 2024 20:04:40 -0800 (PST)
Received: from superwings-p920.tpe.corp.google.com ([2401:fa00:1:17:5fde:7175:a92c:73e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d979b7sm2179398a91.11.2024.12.12.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:04:40 -0800 (PST)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
Date: Fri, 13 Dec 2024 12:04:22 +0800
Message-ID: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Bluetooth raw socket is open, the HCI event related to SCO
connection changes are not dispatched to the hci_event module, and
the underlying Bluetooth controller's USB Interface 1 will not be
updated accordingly.

This patch adds `isoc_alt` sysfs attribute, allowing user space
to update the alternate setting of the USB interface alternate
setting as needed.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a chromebook with AX211.

Changes in v2:
- Add check for the existence of a valid USB interface 1.

 drivers/bluetooth/btusb.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..7d7cfcd07aef 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3645,6 +3645,32 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t isoc_alt_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
+}
+
+static ssize_t isoc_alt_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	int alt;
+	int ret;
+
+	if (kstrtoint(buf, 10, &alt))
+		return -EINVAL;
+
+	ret = btusb_switch_alt_setting(data->hdev, alt);
+	return ret < 0 ? ret : count;
+}
+
+static DEVICE_ATTR_RW(isoc_alt);
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4008,6 +4034,10 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
+
+		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
+		if (err)
+			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4054,8 +4084,10 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc)
+	if (data->isoc) {
+		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
 		usb_set_intfdata(data->isoc, NULL);
+	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog

