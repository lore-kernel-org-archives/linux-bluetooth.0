Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE34420898
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230016; cv=none; b=MXxEsHxRzNwmBMGbuki43twyZ+0Sh6/blChN9prn9E0X6o91EGVId969sDeFEV4fZYKhU+HfhBf+rpMkW1OVxuXK6D00hcfLfXQGIT/gpN6/pJAn+pKNgwZcMMCiNt4hl/mZELyJKtQy5oHDHL7521IeVz3YCHjPMw2+gYQ3Sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230016; c=relaxed/simple;
	bh=8urEIkOEgNg/W0WfryJCD+eWZUJUCTF8wpI/6h2nZwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WplPq3ZJJ506kfoV7mtAZ+jsHIrhxC/Rht3CknfrKA8ONuLYa01vD1aNwjN7M9ouLlskahsNmKQIJypRr2EJ3/dCMsO7XD1Yi2ANIQgA4COcBk1GmVl+EBkdXodxKcsLiBdnP0RgPJVRaC8VC+XsTykAqVeqK1nL3VwVs9IYOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=M5RsaTMq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="M5RsaTMq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8535a9be75eso3205516b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788230014; x=1788834814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fj+fXTtu50ERwc8Uhij96oNyWIgOxu7AHbjsaE81Xyc=;
        b=M5RsaTMqgK9nMKs3Dn9KF5gvzLPK9Jb5Qw/svqH6jK7k178EADKUYb79jYvty32VmY
         UxbyGIZxwGiRzxf+rr94C5+D+MXxsiIlad98TbmSyH6XU4EiNQL7/rzHOVp7gsmNjNh3
         wV8RODOwsHWvv+lTJu5IZJi3VGnoPnop+i58QJeMJffBlK3wjciqHdebbq6smF6IRY/Y
         w9uhf8zRrgWBCbwiVC6/71MYYnD+Zy3t7BcheaWZ/Xe6MjdDWPyMn9npV0SOJV8JHIXz
         LhIfRPdvvH0Cid5LUz9t/43V+2jLUxPxtvZ+UwxbdDOJ9yccdC8rsNSJZeuK6vu7vyVt
         dQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230014; x=1788834814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fj+fXTtu50ERwc8Uhij96oNyWIgOxu7AHbjsaE81Xyc=;
        b=aNwORu/R4ju1AFqsl41kgTgr2+izbDxTHXszU6UC/SrGP/buqrIRKlbctfgakQziIp
         WMXZRaSzbqMLjECTypsIDmPtE38hXWRSGeu/A0Ss0kV6q1LEAfrMQC2n2I5GwprUG6jj
         421Dl++VjA64M+MRSkgZONeh1MlwOZ2qEMxuCYRG8Oo+RlrYnYReSsUFlIZoKpGGYChi
         3qwFb6Ivjcpzk5booSSj2FQ2zOQmatYvnd/zALwoe0RGhKycL0d+xmGsy+3Z5Ps0FWdr
         aYqOHHF8qvI9bu+mojiGgeOBdkkQJYd1KqUotocAtgv0Krj2c98AhkrQq6fIH31W9OdA
         b1hg==
X-Gm-Message-State: AFuF++muRr2SiGvdCqW08ayV6Xtt7G5hY7RzaZl6jh70bRDS/zUz5U+K
	a5dT64wUh4dxRpsy7i7AnMrBEeL4aVHx0UgCnIuqkDRfzlzCM/SVf/nwRZQQgde+49dMh6iaPGb
	pDMXoxsw=
X-Gm-Gg: AR+sD11YV7e/ai3HS0rNqZDT4ch4SICn1Rlh0BzT0NzfEkSlCDzIwhLzNVV+MghlANR
	Qwe5PQ9ipuSAVh95Z9BwS6AVS4QQrs0rDW387GMfz7K+3N4I0qo99XWXVQ3DMzCapeSPFkASL3g
	2kQoFflrDko5FCozzmD9kiqi9K6bRrwsUFy3csdJzvh0MnTzf/0Mw8bChJiyspe6YxxSgjh5NH2
	Lu5YDgz9zs1u3XGgM+kss5spR462Si0j8AeqysicrnZiOPG8la7DM5Bjc9DbhczpulTFoZSycu5
	Gng9sPL+9/zFhJ5jtGV8P9CnlEwFyCmFD80PZ5wBTJZkeV+81Zf/GqUJ3KbzeuDc6PENzn3Q0PJ
	/iYnSujhrkHFWSXsJqFcujab3wWoM43bH9neT+7OthfCjaUCT0vnsYNbwJZFT9Raggjd9VyZPt8
	C1vxVcyATumTEjQqF9S4A4JPggxeVs1GEPacVq6SMUwzAzxtaUKAhNDJp799aJvTdEBF/PJVM2f
	nlLEQgtH0cso808L3hl89oG2BLaWbzAWLb/mpvVoAJ+qL+8RCy/+CfywLNCf0vBmgGJl1bPt0k6
	aK6IlQ==
X-Received: by 2002:a05:6a21:6e88:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3d267b60e7emr52877351637.9.1788230014187;
        Mon, 31 Aug 2026 19:33:34 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f3312270sm5005565a12.11.2026.08.31.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:33:33 -0700 (PDT)
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Subject: [PATCH v2 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Tue,  1 Sep 2026 10:33:00 +0800
Message-Id: <20260901023300.1382808-3-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.

Tested on the VIM3 platform. Verified that the controller initializes
successfully and that firmware loading and basic Bluetooth operation
work as expected.

The VIM3 is a Khadas single-board computer that I used as the host
platform for testing the BCM4384 Bluetooth controller.

Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
---
 drivers/bluetooth/btbcm.c   | 6 +++++-
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..63c4c788d9c4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -31,6 +31,7 @@
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
+#define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
 
 #define BCM_FW_NAME_LEN			64
 #define BCM_FW_NAME_COUNT_MAX		4
@@ -130,7 +131,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4384B0)) {
 		/* Try falling back to BDADDR EFI variable */
 		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
 			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
@@ -514,6 +516,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
+	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9a103db7e355..e70b9f3fd968 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1593,6 +1593,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
-- 
2.25.1

