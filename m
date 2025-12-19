Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD983559D1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161711; cv=none; b=M6LC1OBhfhFbTK7nV4E2yFzpTOk8nk7na+uWRgmhANoTwu8U9UWI2P9DGA6nTGV4nDudxl/hK5UlSMc5ccxVWM5n2zaBmBfotwQK4r8wlaYLFtnRDxtWNZsyPWQlJhXlHkxmgrgB21AWgx3Dqnj5HYn+/zhvzK+12CiKf91qHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161711; c=relaxed/simple;
	bh=FLE3EOKEhibNiRLlcF8s3ipZLVl/xC/i0JF8pM0L2pw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LNlYwhIJcjUAABvCagLqwqWGzDFUDyLjPDObqMgewrOjwgIEubppk8hZR3PJkxz7hcsLvq3VYCMv+5t3VoFdaCGkzd2Sf6zz1CDubuC+OAdAFMTbPtQIsv3dsL5a43x0JfTQ3TVi7sC2HnYTQTJtBzvpSHzcj5EXRv7MId1hA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYU7gu9+; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYU7gu9+"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-559748bcf99so1646483e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766161708; x=1766766508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=50gPXMBeYWG2dcC6MkLX4C6cQGAEZREz1tJqzbGhCJE=;
        b=MYU7gu9+cCed3oY5kF6ajmyH+bIoWKNC1MPrU4wPk86S6QVRJpyEy2IkdSKf7eQTe0
         AThaVhR+tGPfYjhWnDri5ZjVfTfVFwf/DkjToZqEI34NPldpbYVNby2og54WP/2IK1ud
         Ijb5zn7ZaAfl+pe00zTtYgoK7XNzpannJGB7oCVMSIc9/GJKqgP40y1sMEX925TCiN+T
         e7En9MfVWl/MQv+E+hx7z/YF5tPFR0dhdN208FlmQlun4psX8iSbvQWgkCcsw8tUX3zx
         jJs0u72XddrV80UE7Za44oVGyyGvWVNrTtNKVIo48Kqr5xAYPXTUTit8kAZ1MvEh+d2E
         l7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766161708; x=1766766508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50gPXMBeYWG2dcC6MkLX4C6cQGAEZREz1tJqzbGhCJE=;
        b=jNiqYjHFTf+3AGndG5o0L3huFDucwHwLjRgG+Zec60R/Vzc9I2qhEZO53Sk/hmmvS8
         PPSabiU9SUOgTeBbVL4PO+vIRiAslM2wwUPo29sTxrUO4yohiciwTxq7zWPP4ftnKnAM
         DktcADIe6h9CgptpsdKmyXhZzTq2i6Mxgj3UEla1Fp5iL2t306aQASOi49T6twg+QHop
         w7ck3d3BNPHUSZ1xe4nRussOWaXALFGj2dr/QaNYcbLW1riE5/bXDzFGPM8pjkmmQclb
         JGM43K0SHf+K9kMD9ILW+EiZMuYvQfF19BnlCLE0fdjGiLLlNYPFsh8Wmr00MwP3utfp
         8vkA==
X-Gm-Message-State: AOJu0YxoWV0HkJNBhg2MSj3hrXrNdoYxf83sEwPhGdY+TVWM8padDsHY
	BwWU3eYldgY15yiI4Qep1msAbIQvv6JsanhIQ1g/NbYWWNMYnWkE8rfVUtzFkgo9aeI=
X-Gm-Gg: AY/fxX6nba/nILA9VA4O+TIM7+14ZmBSk++CsFemqijGxL4uB5/Uvo5/IXMCzcr5Ohm
	HA/ECjxVOhQida4eLB7kY6Io5WsvBgradAptVc3IEYXtn1AvLXJ+1dXgLsxh4BcK7MTFUz5O7xs
	aaFBiAPwf0Fh+Xngj6WP3b8fDCkEkrtv8431t9U4lok/PxXIS3K1NmEbTq3HxU8sIIKJvp6XQXf
	/2d3DWlSj1iEEaRPgqurR2813rBfbJ4+XO2n02i0CP0WvvL9VFKewyUsvGqUHiaAJv0JxhUCnJs
	+cCFLQol8rv+bIhPrXju3b8acnt+2V8Z/9DuuTF2x2rW9hOUKhjWfY4PUNcVtH9HOqdDMbk37oW
	0GWCjWIyjDk8luLe3x5/NWEAEHJpMwC2NlPFUtE3vrEbmAr/EhpMbAmEcHwQWRo/cVYzaxCGj5E
	B/NOyWLYuxZYcH7A==
X-Google-Smtp-Source: AGHT+IE8km0v8Y+Ss5kXk4tCXLKgwWrIHbPZYZgV5Pizg3aLj+GG0XrpdvTvJt3OYj+DQbJBvPTDMA==
X-Received: by 2002:a05:6122:9005:b0:55b:305b:4e43 with SMTP id 71dfb90a1353d-5615bf272b3mr1295437e0c.20.1766161708187;
        Fri, 19 Dec 2025 08:28:28 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d1329ffsm956176e0c.13.2025.12.19.08.28.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:28:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] fixup! Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures
Date: Fri, 19 Dec 2025 11:28:20 -0500
Message-ID: <20251219162820.320823-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5de98be752bc..ab0b68faa61c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4570,27 +4570,43 @@ static int hci_set_le_support_sync(struct hci_dev *hdev)
 }
 
 /* LE Set Host Feature */
-static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
+static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u8 bit, u8 value)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
-		return 0;
-
 	memset(&cp, 0, sizeof(cp));
 
 	/* Connected Isochronous Channels (Host Support) */
-	cp.bit_number = 32;
-	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
-
-	/* Channel Sounding (Host Support) */
-	cp.bit_number = 47;
-	cp.bit_value = le_cs_capable(hdev) ? 0x01 : 0x00;
+	cp.bit_number = bit;
+	cp.bit_value = value;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+/* Set Host Features, each feature needs to be sent separately since
+ * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at once.
+ */
+static int hci_le_set_host_features_sync(struct hci_dev *hdev)
+{
+	int err;
+
+	if (iso_capable(hdev)) {
+		/* Connected Isochronous Channels (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 32,
+						   (iso_enabled(hdev) ? 0x01 :
+						    0x00));
+		if (err)
+			return err;
+	}
+
+	if (le_cs_capable(hdev))
+		/* Channel Sounding (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 47, 0x01);
+
+	return err;
+}
+
 /* LE Controller init stage 3 command sequence */
 static const struct hci_init_stage le_init3[] = {
 	/* HCI_OP_LE_SET_EVENT_MASK */
@@ -4618,7 +4634,7 @@ static const struct hci_init_stage le_init3[] = {
 	/* HCI_OP_WRITE_LE_HOST_SUPPORTED */
 	HCI_INIT(hci_set_le_support_sync),
 	/* HCI_OP_LE_SET_HOST_FEATURE */
-	HCI_INIT(hci_le_set_host_feature_sync),
+	HCI_INIT(hci_le_set_host_features_sync),
 	{}
 };
 
-- 
2.52.0

