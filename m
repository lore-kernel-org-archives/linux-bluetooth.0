Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098593E024D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958916; cv=none; b=N8Pz1H6EtWRjMmUwMSqdPqi2XBSBqLQTz+Qsdvd9NM3dCYACMDxS2t7PAKN883HV6V58GqAXFqVLV9b+Up6A2nXy6uir41WButz0Q61HQAjeELRbx08aeXEnX+/sSeOq3H+HWU4LKKRnhljC5OT74u7FqEtRf9otv/Z4hDYHqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958916; c=relaxed/simple;
	bh=+hKTcHJO8h0GJOEsKFRIEShCOx1nBC6fJhhgDCRO06U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMD8dl03QlBSXX7zrqLYJoQKFyZ86T2ZMoV7Q7Ql/RI+4upqGDVm7EwiKNpsf1VsWjWR8EZp7FF1fu6j3Y32PtMSf02e0c6oPkmEnyp/pt7trAtRgpnjhCRT7bZ6TPqI10mF0aohj4em7+nk6qOv8mBxoYbREkvlK2gSTRhKxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=YKEc4fVi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="YKEc4fVi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so53414685ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1786958888; x=1787563688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYDirArVvvPv7iCfsyMq1tp5gLaO6hvVOSoX8HafwJQ=;
        b=YKEc4fViz8MaT3f5dunvGLD0E/2lN7FGSxNFQncRWdjM+HfYbi80c+LlPeWVt9prab
         7R26cgy/OFdyYyeGfeozzIkJjSS6lV2m4VYcOnSil4d1WxB8ApHTy0UM7muep6K05RSO
         lTKp+AQ/iGT/awycavwZC6HIXytsscQZ6I6Z/TCPISgwokhOfSnRmsY3exb4H79e3IqI
         Lmd96MZBPFW76ynjRbWuGjWhM+t/B0oYzTMTEAW7z4UcVsMxZ7JICotKJI86Ah5wYJkE
         Ji0B+KK9kBdCptU7tybPyhwDoX4i4wnxbs7ox8K0mUoFuVMvsN17q1nuGlFNnOzs8jTC
         luAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958888; x=1787563688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uYDirArVvvPv7iCfsyMq1tp5gLaO6hvVOSoX8HafwJQ=;
        b=srik1ueDu4knx4rz48XOuYUqPJkEXMNSHjL1MiZvL4yAOs3wHZDBVowTY0VWNzHo3x
         7EcX2o/TY275DYu3MM/4Y7lF72HBZf7dodilLB1XjG7TNiHwZJl1TElXZR5bARSZ32GO
         2QXFOocY6kN+kF9D3JOTnxFHneN71IiGauyThFPX2mjMuu9G9KV3FzTqUZuNzI+NjhY1
         v1sw/Laz4qDLCF9/Fl7UvEd+S5lsR5DTTdNkEBNBAxlshlbRRQvvdA4+FsqN2NMSmnYQ
         CAf9bb3SPHby348TrWVsF0vEnobxTUfddiK8EaAjQ5imHuKSBgd0g32dQQ+dUWFUUiwB
         UsMQ==
X-Gm-Message-State: AOJu0Ywrt6hed16lZTvDeS3hL0KIEb6tIhFfQTFsfYO+vN3hb0PBs1tL
	oreYcpXtQrdz/DESQDeQnNzZFHkLaqsP8TxBjxrxCRtttHP/zXY+TPBh5Qm8Rlhn+w0cvFXeuu2
	ZSxE=
X-Gm-Gg: AR+sD13B+sKYKhwqmkvEzFVsWBQr04VDr0LuEoDzCEtarwqTgwGUk0eQv5fP8e3awG4
	un+080mC6ydo8tWSVTuzKmofY98IdbwO0W+QxVRFNcO1b2YdeHS0sM7RFbD4rJ8/d6l43y8pH77
	VTNYftSPhnX/khjKRKu/lZjZtHbqqr7xAiMET4Ni4xOBAYymgDHdFj8JyHsAQ+0G6Ah4h1gR+aH
	BolQVAgeL37oH8kF670D4eAB8GYPIATqYeR3ciG/qApvJ54+FxDijCnnmxRka4Zx2HyknO0rARo
	O+TqXQQti9dQjp9FL1sCuVeQMymRdMDMaIsn44IUiir5hybiBBf0+zVEcw8hbL/72L+MYtekpqg
	kKpk8AfdfgYZp5v40GQrXJCLmjDxhljEgxdA5t+1wVdhIF4M0bhWFofi473heLLlP1b9YtAsHGu
	afz2pEirYeD4+KcgWhzxc74ySvXjH2JCOHOIR7wvtKqPJ8u9KTAUZWvsUsJ6GR6yt87MSLD8+7S
	HewtVyTF7RJNYAgfN61hYVten0/c8y5+ZZ7Q99rCts6CPKfOD9ZOot59rIWIbcCRg==
X-Received: by 2002:a17:902:ffd0:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2d3b0c9fa6dmr255601095ad.18.1786958888404;
        Mon, 17 Aug 2026 02:28:08 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e12sm2962455ad.8.2026.08.17.02.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:28:07 -0700 (PDT)
From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaihsin <kaihsin.chung@synaptics.com>
Subject: [PATCH 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the Synaptics 4384 Bluetooth controller by adding the corresponding chip IDs.
Date: Mon, 17 Aug 2026 17:27:23 +0800
Message-ID: <20260817092723.637956-3-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify the change on the VIM3 platform

Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
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
2.43.0

