Return-Path: <SRS0=uVZl=3N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF76C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47B2075D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABAj8SwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgAXRPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:15:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33274 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgAXRPs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jan 2020 12:15:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so1618737lfl.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2020 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QM61o1gs/0bd/WDHBdVHAo1RK3V3y0ZD0814081OSGo=;
        b=ABAj8SwRRPiIPl/fqXcYbgdCHEUVBPd9Zgw11KE2Y/v1LFKap1T6ZtqTLCZroMbjsX
         Ie3eBn4JH5HigxDicXtcoESGItIa+XLZoUI9r++NJWy5wJKmSXXUVxYs+EQNWaawKSYO
         zaEJGdVNnX1yrFxAKKfxnnKJ61cvJnUxOEDaqI1M8+1WvNyEL6R9bOu4k+svl8iJbnyX
         ZshPFNwGBqlWxs6aIcDG9/1cKISP8EreCYg0pt4IdWM2fIAc2zeLmLypJlyNhluZr8cH
         Bz69g40S7igGv78tk5x/VDJ3xicKIyU7nESC1SwHVeYN4xCzKUAeEdoVZf73QD6Y0vk3
         R5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QM61o1gs/0bd/WDHBdVHAo1RK3V3y0ZD0814081OSGo=;
        b=Qx4920lKbpmW21cczDBcPURC+Cqca/R7xLPacICH0Mgh6rSDpfhGEtQoovgg+7jaaz
         zCNTnqlVdg2L0prqJJ9NABO9KTq/YL0ncK6kYAhwP+5aU+RyJeMTffxOVpkxPVTz2NUh
         7dmRNpo53fMT+oRoQYFChRAobrJEK2MDciXHOEjp9twsTTDKFa1hneNMIwq2moRAp1/I
         CFoqsqTZinoFxqwPsZU+xS2pt87tfCFkcokbyV4fTIFzJBoeEZ+9QA5A6fvfetqPM5bC
         ntGX7PQE9cicJjS/r3R6QZk070W8KpbXj7b91akb6dgV5o1QxSunl7p1Gr7v+9nQqvVp
         HwdA==
X-Gm-Message-State: APjAAAVTda9eEgp3z31JrI4T3CG0U11zOUiYs/HEmPB3hILx66DVRknW
        6mX3h7C0cpcqfU82knlkiVU=
X-Google-Smtp-Source: APXvYqxBHh365O1GgWY2jfrez58cd6G0ocGZy4uhVlgY6tafaw3ixhi5F1VmmquwsyGDOD8ivSugUA==
X-Received: by 2002:ac2:428a:: with SMTP id m10mr1830095lfh.158.1579886146509;
        Fri, 24 Jan 2020 09:15:46 -0800 (PST)
Received: from satellite.lan ([2001:470:b62f:eee0:3001:7c88:84ef:9c69])
        by smtp.gmail.com with ESMTPSA id c15sm3417718ljd.58.2020.01.24.09.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:15:44 -0800 (PST)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@endlessm.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] Bluetooth: btrtl: Use kvmalloc for FW allocations
Date:   Fri, 24 Jan 2020 19:15:35 +0200
Message-Id: <20200124171535.32919-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, kmemdup is applied to the firmware data, and it invokes
kmalloc under the hood. The firmware size and patch_length are big (more
than PAGE_SIZE), and on some low-end systems (like ASUS E202SA) kmalloc
may fail to allocate a contiguous chunk under high memory usage and
fragmentation:

Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821
Bluetooth: hci0: RTL: rom_version status=0 version=1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8821a_fw.bin
kworker/u9:2: page allocation failure: order:4, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
<stack trace follows>

As firmware load happens on each resume, Bluetooth will stop working
after several iterations, when the kernel fails to allocate an order-4
page.

This patch replaces kmemdup with kvmalloc+memcpy. It's not required to
have a contiguous chunk here, because it's not mapped to the device
directly.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/bluetooth/btrtl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f838537f9f89..577cfa3329db 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -370,11 +370,11 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	 * the end.
 	 */
 	len = patch_length;
-	buf = kmemdup(btrtl_dev->fw_data + patch_offset, patch_length,
-		      GFP_KERNEL);
+	buf = kvmalloc(patch_length, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
+	memcpy(buf, btrtl_dev->fw_data + patch_offset, patch_length - 4);
 	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
 
 	*_buf = buf;
@@ -460,8 +460,10 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	if (ret < 0)
 		return ret;
 	ret = fw->size;
-	*buff = kmemdup(fw->data, ret, GFP_KERNEL);
-	if (!*buff)
+	*buff = kvmalloc(fw->size, GFP_KERNEL);
+	if (*buff)
+		memcpy(*buff, fw->data, ret);
+	else
 		ret = -ENOMEM;
 
 	release_firmware(fw);
@@ -499,14 +501,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 		goto out;
 
 	if (btrtl_dev->cfg_len > 0) {
-		tbuff = kzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
+		tbuff = kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
 		if (!tbuff) {
 			ret = -ENOMEM;
 			goto out;
 		}
 
 		memcpy(tbuff, fw_data, ret);
-		kfree(fw_data);
+		kvfree(fw_data);
 
 		memcpy(tbuff + ret, btrtl_dev->cfg_data, btrtl_dev->cfg_len);
 		ret += btrtl_dev->cfg_len;
@@ -519,14 +521,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	ret = rtl_download_firmware(hdev, fw_data, ret);
 
 out:
-	kfree(fw_data);
+	kvfree(fw_data);
 	return ret;
 }
 
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
-	kfree(btrtl_dev->fw_data);
-	kfree(btrtl_dev->cfg_data);
+	kvfree(btrtl_dev->fw_data);
+	kvfree(btrtl_dev->cfg_data);
 	kfree(btrtl_dev);
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
-- 
2.25.0

