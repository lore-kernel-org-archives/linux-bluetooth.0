Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86135201E
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892916; cv=none; b=UeSSMs6dcjPNtSk9x9cSEDOMr5aAjaz+POcMG2T6rfm+YV2guGJtksFVdAPSSxG6heOZVXnai+4r+2GDpz+jBuIJ8ACuR9ML1FuNcvU+hUFV6sqeLeFraYUFj6D59OEVKa/+Qe6gEM/ytKneDkhJaxhiNOXuTBkrxIm74yaBnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892916; c=relaxed/simple;
	bh=5UINrUjPw3FHTW8fYqPryZzAMwU/0otpBIraJwzBYPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQlzLHaspAzd4IHD/48ct8Jk5PPw1UnUdmsjEe/v8Ne4+9evhUPYlkHU7h2mZz7Wjs0L8MBRy5FfuVjWoRpkxX975+DbPzaeALqKKwVANxc4lGd3oCLV+5whinuV9XoO76uvLxxtDBga6BmhfFJzNpzCLG8o6QcKnuZGWn5mN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=GJ++DKPW; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="GJ++DKPW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso290019b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1782892914; x=1783497714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTScvm1zZd+3nA0fjlNA6rYKU/4RkmjhTIYqRiuAIAY=;
        b=GJ++DKPWhN3HW4gy3yKri+2RVgJ9ZGM/qgUPgHlCLS/hP73ZLMWDsWVyKPXrMUPNzl
         bhSxOYXQZ0Wnmi1vGfAQqzG3Gg3rwaZxHSQuWYTGBuuj8jO0c3B+c0v6zdDl8TNBXSBm
         SbT6kE6Q1Xh8r3kb61foLzAo2vc4cju4WHGC5D+IBxRhLTsD4nC1qsm71L1myUrNbepk
         4SDqrH3NwO8yr/EhBHedlzSTAK9VRmidMVKayhqsd0lfnUxR2cb3ebNO5VSSldcRWuaU
         BhpDwQPznXPdOEaABLlDREu4N5gnI0gyMhR59JQ3sZiiC7pSLBp3ojPVxTcVkL+FrofZ
         Vg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892914; x=1783497714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTScvm1zZd+3nA0fjlNA6rYKU/4RkmjhTIYqRiuAIAY=;
        b=qvR+zs60hFlxa5zrWOaFYG7XOE6q/RZTFwq/scpJRIf0d+IkW0FYz2sC+oSBWqpRfR
         I7CEeJheoJHuhDxSB9ZG81li/U0sYMeeHz5Nct0X+W3rn1a4A087EIK8OkRK9Bl4/FU1
         iXvH5ROLe6Bx6YLlIjtuKNS5LGfyzPIpDMU/iLWbiMxUHgRnJopsQS5jWdbk+WUcoxMD
         c27TMyxms6SnEvDYRbwNOu98HSnMEWD3vY1A3cPL3EXSIQqI7KFRTPJrmuEO6iFtyWyG
         URQB6dLMTdAU6Bo1V6POwo9x2IP6eAL3qpiePvvdUkK+O1dyH/Iz5b+lW541n8Iqgi75
         kmBw==
X-Gm-Message-State: AOJu0YzM9YVMt+yeVPMWR8x5M2xBDAIFgeSYeuDozZjjMdRP7+UGgtAz
	3CACgc9W0vJ01aSwdmqLh0Wqqc2Ty2AZCAm0OFfVJqGgxZG8g1YKgt/y08864mNHcW8cs7pML9D
	IV18=
X-Gm-Gg: AfdE7clEJEqGcPrJQjjLSf57wK1wznGHj6VgUAgAeA9dLU/chPsOEd7Hjzpd/ONY91w
	IYEh7YRGhg6/iyGgtBvfBB5KCEQBW3w1tFNfsi+VcMOPgG+qdOsIdE6Sk1/u89AModXo718Jo5J
	u9NPSQAWn6ezT1HakfOVx93LVqe8zHhfMdxUUPdkOzDAcgkXGEKvb9qKGtJLDJ6T1GfgTUVIEfR
	K5PypOa21jGq0riiTSLYHn51ZEHUfVgCJFf1c32m8H2SyassP0yfSEuQ8UMoEYQeSwN6Tw3J8yA
	uB33l59UqgY2B/n94ck8co4COzsjPQZay6Klvesof0HHw8f/k+hFnx1rxP8EOmJ6MebRs9aLp7j
	eL1LyazUc6O0UwDhPJfjFt3fhL3QhuMPcRkSkX6rmJkuW6I+fCBnJWEheXL4KskmzyCaOReOuOf
	XlcletpYShOCuFkG1Clyv9Pah7rS536Gac54MhIGpjFawjcVUvZEazxPEX+IoVxY03oMV18ucZI
	RXShOBr7FWWArJSAg==
X-Received: by 2002:a05:6a00:21d4:b0:847:84b9:f3e2 with SMTP id d2e1a72fcca58-847c0a3c9a4mr427407b3a.50.1782892914279;
        Wed, 01 Jul 2026 01:01:54 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c584sm3504322b3a.2.2026.07.01.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:01:53 -0700 (PDT)
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: Kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v9] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Wed,  1 Jul 2026 16:01:38 +0800
Message-ID: <20260701080138.3786003-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
References: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.

Verify the change on the VIM3 platform

Changes in v9:
- Align bcm_uart_subver_table formatting.
- Group the Broadcom DT compatible entries together.
- Capitalize the author's given name.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
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
index 1a4fc3882fd2..6773079d4af4 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1592,6 +1592,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
-- 
2.43.0

