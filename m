Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CB383320
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998610; cv=none; b=HY7zTkYgCCpjkwT4rThK8CPVLaRKwy4GifdcmwbNwhVf8VR8L7sMI0utdNrxnFGlf247zqmobKlMoXf9nOan64elDJcjCJH7jWsZtVDJVTSntASYYuCHUYyh+1645Q6QrHePLltRqKSNOVo0D777OdmY3uqaau5OEvxHv/wKTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998610; c=relaxed/simple;
	bh=in/zU+bpaBcikYil84rJAmbNYh7oLZ4LgY89LY/JYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjJ3c9d6CHyMU+JNcsuwLb+cCISlt84aXkWCVk2FbaJtox3+enw2pkdNisfP14sjRfaNQwtS78iqJxTykXLRCW1XSxoue3Bzn+Sz1N3CkSewNwZe9eMtcPUtyaggGriOsuC6AYjFRjOgPVUWg/fWV3b/zlLqAx6tmZ+LZKk3vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiFeRCOg; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiFeRCOg"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c16ac21acso3652611cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783998608; x=1784603408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=looH15ecL5VpYfgf8qYiXk8yKrr71rtniUSxLscBZKg=;
        b=OiFeRCOgoVC87Gr8jvCFXthE2ITF7RUWaLXnizM+rlEGmJJ7zvQissGruOWB6D5Vna
         uBsl/qtczQ5rwpMwbfHjTsbEAF93t5pAPACHvhR7LCsSx2OQWXffocEYRrzDQnAA4Urx
         OyoWPcUHtz9GHtSynu47St9Gxgo05Y3g8SDH2mm3pHG1zQskeYW00iwiywD7Uyl+9xjF
         Cc+mARqKz1+zNvHPGqCIjwxk3EvkfvmAIcEGuic0bmyRwVeWPufIVbWkp873GXaXgdUh
         rta9/Wcjd+Q3dmmweuN7dydSA54R2BZioqgRQX+dERsqanPHzGbhxpolTOd9P9A1Mk9f
         izAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783998608; x=1784603408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=looH15ecL5VpYfgf8qYiXk8yKrr71rtniUSxLscBZKg=;
        b=DlI1rxb65EbfViiKYon/DlGNdtFroSPxSBWt6e3PyN9ZcoGoMTrG6y/VV2BvjKjHEl
         CLUEX7WG8jFHkcquk1esTP7HpkbtAAWRwgDamTu/XqllVToAEtZ4OQf9p1sexfheVcSv
         3TsPQrYR5/ddKb9X8JtzwjiBRRbV7HbBgTKWHD2SVFb1ckKRioQII49bntIwIm+KgK2K
         EQSfcl9oVvF+XNy70hCfIohjX7iC+TmsNJIAWZyamjYu3JPAHiLu7KnCNU+bt13U6R02
         +Wnxpa0ylUchg0wtLWt8+MqlIeqc9JmVrayOL5bC8ofavtJDh+6Ui4jxTrfHuULgtq5k
         9J0g==
X-Gm-Message-State: AOJu0YxyoBNK7Dslz1hG+03fkWtIN6Ery1+g7RIj/h39VcMtAYlAIro4
	l0LAMsE9t2bJc7Y0qI5eDp3Ed1t3JSAVxZoEZJG/a/G+DyXCDuWH32/vZuLh9aHm2x4=
X-Gm-Gg: AfdE7cktUmer1I8xy+GzIHc0unEs+pAQb0cxLUC12RexSF1fyAcwGPN/TmYhyOCzL/4
	6yxe+khocYvEF34hE75viGrtyMa/V6p3i7kroct7E+jgHmX3CAhXRhLLimcT7jVXYXTExHP08xm
	UejoOKwOkwe1jQT3j7TLWNuDpxRSl/uSouVweay1egr4Xl/jetFufrQNARFqLAiQxl5AhFizKQ8
	mAtYZwD6SbfMstQZhDDU6499NplVur/2wOc3e3HV9NLB3auko7ol35WXCsXBF6xCy6aiJsI3+QR
	mQcK1ncG/M0no5Bjuddxwb8HzKhJYyiB3Gc3dLvoynla8vZBjqAWjlXru8JZfmKxcShaDpzm/ze
	DpQSkla6B312avtO8H1Q5PZj7ndN42jfq+NlQlsieR8aBrCbaRwoeuz73G8zcpN6OE5FDR4PFi+
	Spg1VVOGq2Zr4kt6BHR56DTvpvyjwB5iZvuoN6
X-Received: by 2002:ac8:5d08:0:b0:51c:217d:d772 with SMTP id d75a77b69052e-51cbf0be5d9mr118903141cf.19.1783998608411;
        Mon, 13 Jul 2026 20:10:08 -0700 (PDT)
Received: from pc ([209.202.207.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm99098461cf.24.2026.07.13.20.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:10:07 -0700 (PDT)
From: Ameen Al-Asady <ameenaladdin@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ameen Al-Asady <ameenaladdin@gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Skip MSFT/AOSP init when controller init failed
Date: Mon, 13 Jul 2026 23:10:05 -0400
Message-ID: <20260714031005.230895-2-ameenaladdin@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714031005.230895-1-ameenaladdin@gmail.com>
References: <20260714031005.230895-1-ameenaladdin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_dev_init_sync() calls msft_do_open() and aosp_do_open()
unconditionally, even when setup or the HCI init sequence has already
failed. Both send vendor commands with __hci_cmd_sync(), so on a dead
or uninitialized controller each of them blocks the power-on sequence
for a full HCI_CMD_TIMEOUT and logs a spurious error.

This is easy to trigger with an Intel USB controller that needs a
firmware upgrade: btintel resets the controller to bootloader mode,
the device drops off the bus and hdev->setup() fails with -EINVAL,
after which msft_do_open() still spends two more seconds waiting for
a response that cannot arrive:

  usb 1-6: USB disconnect, device number 4
  Bluetooth: hci0: FW download error recovery failed (-19)
  Bluetooth: hci0: Failed to read MSFT supported features (-110)
  usb 1-6: new full-speed USB device number 5 using xhci_hcd

Only initialize the MSFT and AOSP extensions when the controller
initialized successfully.

Signed-off-by: Ameen Al-Asady <ameenaladdin@gmail.com>
---
v2: no changes

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b4ca34abe..38158835c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5173,7 +5173,7 @@ static int hci_dev_init_sync(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
 		ret = hdev->set_diag(hdev, true);
 
-	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+	if (!ret && !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		msft_do_open(hdev);
 		aosp_do_open(hdev);
 	}
-- 
2.55.0

