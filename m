Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FB222D67
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024961; cv=none; b=EW+zzReDWZDujzvCbSWe2P7b/RRezqQLCm/NSCrM2EH25Qk8csFfXz6spbdNw38Zdmk7fiZNtjtbpacHgApvwMEtahsFc1TPZ3D1X1EeBDzbZ5VNTD+SQ9IThghfQ0FOeepctaxvH+m2igLf1MkZ22/Rro4zgsbxzEcDw2mzRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024961; c=relaxed/simple;
	bh=unHPHEf1EAAvyGEKP6w87OZccJqMDZhryTo+qSpX5ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LG0PnTr+24yqA55zQMitOpL9TyfKgSHHEGPyYuzUTR7PdE80X/wMcsRzQFB3EGgjcu5T4u8yMWvfWJTaFsEkTugbNgvX1HMMSG3UeDMIuH3rFqbSrRlPdiOndjIOjoxSavn/zoZnBEXiUABmDgScnR5Jq6dHSkyZ8kyo4qYN7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=beyJgUWf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="beyJgUWf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efa806acfdso687183a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734024958; x=1734629758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdytzyuSMv8Cb7sCazvlhn0z0OC1z8gCNLSykLKXbN8=;
        b=beyJgUWfBmmF/SA6rR5tVRX+yj/g6q+OkbkmfGHiRMM8o8IGk1tlCK+aajecwaN1dq
         A1QIXHAT+b9lsjd6DWVC5mm1Yr4lBlxyFYOzo364Ry9Sh+IRAr7bTi6VMVmVgljzFlgi
         SzFyZuEwJ5LiAPCTDdKYUgfgvyYCULmpJ/Lvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024958; x=1734629758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdytzyuSMv8Cb7sCazvlhn0z0OC1z8gCNLSykLKXbN8=;
        b=vVTfPesUL9HLH29fuuB2z88we06AfdhjKtCOeQ4utujq38bnTWjhJqgxWi8vu3SLeh
         DaeoeLikxocQfs8tfBinNAtOHzm+eNSxpAfV702G0QKaxrTAclUnhAFIVuWGu62cqbC9
         LGCFL+SavpcDxRp/6wXvWOYU4Ru1nslBBjwDRrdNXvoL3Auyq8dK0p/j77I5wG61LGVT
         WWTWN4ujdP0QlmWSKfOMCGv1OrsJo5I4pcgD2cgsgJslviOYTxwTj4XxBqaQsKXIs4bi
         TgLDhmNcpjXGXVIeNvLbiXyhGsLBOSQoQHuWxHnJHIxl5/oS+fB85R9CRUjvd8gs6gQ1
         mtYA==
X-Gm-Message-State: AOJu0YxRKO9lGHo+FvB564RFvViUM+vFkDIqx1ksH17arzigTm3PdCds
	SB+o5BXrsNqqJgInx0t1LXxbZFBtms/j7rDuV1cmr1F7cOt6mYeXP8nI04Oo58Q3RA17ELdgYhg
	=
X-Gm-Gg: ASbGncteSzmIvw/Rz73MPTIjlhwzrExSWMcQd8Vj+RMYsRN4ipaE02xBoLvu0k6LYi0
	dtmX8vLR3uqV8SPWno7FdnycEEUkSGLldFu9cLr6ApulbDEOPPdiq8PN2n+esg4JyVEEI5sqK2r
	nTgr8vfDN7vDobBxwKJtMglcIlsL3Wmb+AONBMPGUnSBtrhhjPRhBaQkJIcso2ExJ9VpkXo8L3A
	L9QNW/gGNg48TupZnPMeVAog3gAmaPgMc50ljLJo+nqALIp76tIQ0bwvkr+cw+WPdRW3CWB03Ky
	qB7MRbF7
X-Google-Smtp-Source: AGHT+IFgE5LN8snCnmFL+VXsBBoz1dVwQGLUBcwmNo4e91lh2BOf6JJ9b23cP2pLu6zhjZ3byDX9gw==
X-Received: by 2002:a17:90a:ec83:b0:2ee:4b8f:a59c with SMTP id 98e67ed59e1d1-2f127fdbe3dmr10607801a91.22.1734024958406;
        Thu, 12 Dec 2024 09:35:58 -0800 (PST)
Received: from superwings-p920.tpe.corp.google.com ([2401:fa00:1:17:42e:7922:6366:9f29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e40b3fsm1542714a91.49.2024.12.12.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:35:58 -0800 (PST)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>
Subject: [PATCH] Bluetooth: btusb: add sysfs attribute to control USB alt setting
Date: Fri, 13 Dec 2024 01:35:51 +0800
Message-ID: <20241212173551.192925-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
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

BUG=b:382526205
TEST=read and write /sys/class/bluetooth/hci0/isoc_alt

Series-to: linux-bluetooth@vger.kernel.org
Series-to: luiz.dentz@gmail.com
Series-cc: chromeos-bluetooth-upstreaming@chromium.org

Commit-notes:
This commit has been tested on a chromebook with AX211.
END

Change-Id: Ifc708cc471a8834b344c26fce1ce2fe3e5992cad
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
 drivers/bluetooth/btusb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..e8446f3e026e 100644
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
@@ -4032,6 +4058,10 @@ static int btusb_probe(struct usb_interface *intf,
 	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
 			    &force_poll_sync_fops);
 
+	err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
+	if (err)
+		goto out_free_dev;
+
 	return 0;
 
 out_free_dev:
@@ -4052,6 +4082,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 		return;
 
 	hdev = data->hdev;
+	device_remove_file(&intf->dev, &dev_attr_isoc_alt);
+
 	usb_set_intfdata(data->intf, NULL);
 
 	if (data->isoc)
-- 
2.47.0.338.g60cca15819-goog

