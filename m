Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94B476040
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253051; cv=none; b=BaSuvUi7vLGtMc/hUKceQdBqyfTT2nA9xPawzT7Edue6Nn0eAtiMpPrwC8VDLsIrkcnQMNIcqzFt29ovW73kXH2aLtLUVJwGnD+b3wtP9Cl70O9F87OGJhyNPMOmC7vCNonNPMSVVVRgWtBL+mjEHdzpCFhq4eOuJmuYZw59N3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253051; c=relaxed/simple;
	bh=8urEIkOEgNg/W0WfryJCD+eWZUJUCTF8wpI/6h2nZwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d31u4McHz7M99Trr3G+kUz4i2rhhFAStb9dxuRck2vlGzoWJ2qEkB8KRAMfYAdVzkXiAvObNJKvDp0Jl6sNNSxZHKvj9UZzx/MmrgmDFnzk7VPbRV9GGbKWjWxayCwANJJneZE1++CqZ0yWuleqLqziy+FVz3nRKdRImpYxlhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=f4zT8ZWN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="f4zT8ZWN"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so694284a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788253048; x=1788857848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fj+fXTtu50ERwc8Uhij96oNyWIgOxu7AHbjsaE81Xyc=;
        b=f4zT8ZWNXTek/sbE/ZdVrZusr+BjcJ1JTBbqKvqpbvzVkbgFkXh5+X8nYPkIB128vx
         mftJ1+2TEL86o86E6Bn8m6hzTmZoCyN838tmT8aqP+SerkXPw7DerhTRIbl+OqB9ZzbN
         o9azDRFDATbsPwuaBXsooLw6HxNJp2peB1bw0aGOnsxQ6OOCUGuPxaTyk+C4fw9bCGBT
         q+0t/yx3dBzuo/0CvyxnQYmsYhWi1DGJWWuwyE1WqJiwNF2TiUYoXw0Ka7FGNZN4KhjM
         DUByC0i9oYiGuW3rnQq95Kg12AxzDSHyFxG8qhP2SFgm+oF5wQJMLVWAfz3HWdmz6IiH
         qP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253048; x=1788857848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fj+fXTtu50ERwc8Uhij96oNyWIgOxu7AHbjsaE81Xyc=;
        b=cHmC2Sioz3hwJ1kubLxL0XkqqzKk5HQbYwkglbBs0K0K9ZsKg9N3c6E8UpsuCLTd8m
         nl9eWeuCusyfrNFIfYVrpqp3JrW08FyggelFoa4mKtTEeiBwGVForfYRtK47x/FGd/S/
         65kcYB4NZJ626w3zvtvj67ittkboB+gf9IYE6DDX6rwjs3xqLFXFtTzga5ul+m/X0Kym
         4LhB1hpZwAyC530JpQzoB9OxeDzF7KHSisSlFi/oI0xD1tOoviN6r5fzNjiEowPg8Zmy
         Mj55LszKeRKhpDPMLefBuT1gPyXo8dpj+GeoTI15K1Y78QX9HI/1gMKKZ2Ub6+VGodzZ
         pesw==
X-Gm-Message-State: AFuF++mUA/8Ke+B8FiOZP/dv1pvDfjc4F/cI7xIfTDY1E4IGDQcvbCE5
	ulKO94p6fLofjG3x1tZ0gbWPprG+aGfz1VCmrg75Iz1ABIol/1Ikxro+V2eHu/hTgbKM/1H2M2y
	x+igrnwQ=
X-Gm-Gg: AYBFou3oab+YVQtqgBvofC2wPtMrQzHPu+oaZYwdaNpOZue5UlDSFFWCsgX0hQduhux
	f10QdTTYp8E0GqTjq0QCTpfrKlUX6Qrtua6+Dnw1JE0fLNfzk80/C20gtIg4kUBJhu3KGKXTGuA
	zfmTsPUGbhMzniV/RYPBml7ca0BGWKTSUe993EZTEeZRX8nYc6OcE1kRn/S7PjdEOeBQD6vwmRQ
	QUf0nAPhM6RtI5VrFWuPwucjsPoEyYhY//6BQpkqXthJ+otJDqjy41KNNAMbQvPWHW0kr27mbao
	H4rrBXyaTPEuf2iNTXKciSZvvFJf8wA+3adhSiPKXOy10ofu1HkNO5cRJeETFBVVDVMgEh0oGMZ
	pO/o8SZAy97CREBfFT9oZrcTg8L0vvpL9sAG9VSshb37mC6zNVzocr9QPACh9I7YAM7X8w6Dtxs
	bMsFPIhDBhoEZHCQg5xL9tOkOqrPw6jPQ0taX9a+pLs0zkIHqbK02eAcYXQzI5vOVvTr7+He/EL
	HvYQw3K4zK8FkNZPCT6De4n0DsT7xlY9pUNwJ8IgX5KJl3eUrQO54ry4uH6krAYliKAxcRkWUhR
	Iz1T7mE=
X-Received: by 2002:a17:90b:37cc:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-396d0d92d0amr52298580a91.1.1788253047628;
        Tue, 01 Sep 2026 01:57:27 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf6800sm5934432a91.3.2026.09.01.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:57:26 -0700 (PDT)
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
Subject: [PATCH v3 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Tue,  1 Sep 2026 16:57:02 +0800
Message-Id: <20260901085702.1515378-3-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
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

