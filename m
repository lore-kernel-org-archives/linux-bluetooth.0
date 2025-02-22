Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150A18C0C
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740200854; cv=none; b=GVtU7o631KRIYGcFjeHngFf4wxj8UzMxb8EFEClP/Cq/WpnEq6Gsw7t3z/z6HNn7VBp1Sx7c5J/ahnTu7wK2xxo7UHsVzoK8731XlHSLVkThEem5oy2vPEcZBJ15iQOfAyWCX+DYJSe4YPVVcZrgL++dh4CTokvV9pLrENJqByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740200854; c=relaxed/simple;
	bh=WdjpbkHsenDZpPkT3LQXsBJoK4pVrXZAaYoQKLjLfcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twr/au0HRc7NVh116GDtqntRW+g4wMRppSupc0VMAtyF3RdkPFTcgh7nodZI8yW9dKsW3e2P9dqXJNEQoYp6Jr5vJ4qLCuAFc/o6jrtDQxveDL2AbmJLHFkImBbWIAuCzCdJcmhvxGrFs6Y+BxYhdstzu7E/bnEvq9Yzh+pANrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwE7IJkT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwE7IJkT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so4603281a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 21:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740200851; x=1740805651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skAepCMpS5A+SARkM0JSy/NjPFnXGTxwrYBtrHVQjm0=;
        b=CwE7IJkTl3bHlQLiid+qugxik0oD+dSmuTAdKsK1i2Ziq8g1e/lBxlxj/US4WqFm0F
         ljFxkqrLkPGyyAI1wkSUFb0QmfH66JlDMhSWrzoaEhAjFs6Ouy/XAxmelvFUvM1QnJW7
         LO21xCp6bGqPFynTCW7OYpdDd7Puquv1Npb2in50Q60mC/VqCL6C7gbQEKc7p5TGzsE7
         4nJqeboPLwRGVrVyGZB2GQgk2zuJb/Q4w9UwHB5za7/Ux4rZztBVdJ6OHnAgh3kwxCN7
         si7GvhDc3e55XeCtBModsPad4tFGrsN5WTrI8Qu96RH7NEB1q/v5QHk24XlZZ6Oc+fgE
         4Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740200851; x=1740805651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skAepCMpS5A+SARkM0JSy/NjPFnXGTxwrYBtrHVQjm0=;
        b=NiClSdyfeaqMuPOHtb2fcheyY1CYvpo+DVsmma5CMjbVuU0a3Gi/NbjkvV/gZVJu5t
         sJcpu8HELGNUyJZRx/o9rJvFUYVBIweH1n+1MWHV6awxitqG5o681WT8Xym2J7idcz6C
         JinmteaqFFsuViPJ7uHVttfYpnCKOk/eFK2QKNh8aMlXIgs6GhyIDCF51aTIrbDgAqce
         w5w1PxENScZ78ZbaL7PrwGsXf+zCnxFx+vgvh3VtF9eG2EhtQ5qqH/pNhwOWMbgOpwyD
         h3uG1uMePF2gRmvA9+7M/KDAy1icKha9jRNmfvji5QWnS42mvJ1ccYwaZ+KWRcCPbob8
         GxtA==
X-Gm-Message-State: AOJu0Yxl4gFjdO/FQQelq/QgR2pDvu0D0xiTj0Vdmzshif989NeFJFiB
	hg9T4TsSHADa7iVdOofHJP9IaPQ4R5p5mCtmmjs96KDqNfHe51N3k6U7mHXr
X-Gm-Gg: ASbGncv80ifp1smyB4dzF8Q6KuTCA8YyBEqKVz+cD7S7v3rZoUI6+9ZLRwD7xCnxfdE
	y0kpgrBaWLzyXLVAF1+wq072hP9VkX3kjUAyfrcF7CiQol4aOnf4ydHEnTce39KD7WxmoMJ/+lo
	TRdEcjxCaGF6uim5pZIsYzizKVAHR9rzFIaaDAn2g3FrbN/guOJocNznY9pzAo+Ngv3mLwI9nD7
	NXPGvALihOTJjmkssfLkjyxv/x02eLd4aMBkr+Yf2Jfw6FWKbu9t5ZJQeiLs2fmdImyEypvSboy
	pRyH5BR7w0ZIAtpmPrdU83l9erfLl8P4GtOoMmWzYBdoC7dqqu+W8jf7z4tLRIaFdoYsA+/xQDW
	5uBiegyuigLk=
X-Google-Smtp-Source: AGHT+IF54F2qdxtWgjpyd8Q7c8tYVhDVcNaCXj9aa8PVDv+F/nsUR4VnhM9f8ZFMRWW1Loa4uQxSVA==
X-Received: by 2002:a17:90b:2b8f:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2fce78aab09mr10185072a91.10.1740200851493;
        Fri, 21 Feb 2025 21:07:31 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb06539csm2265849a91.28.2025.02.21.21.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:07:31 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH v2 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
Date: Sat, 22 Feb 2025 02:04:38 -0300
Message-ID: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 include/net/bluetooth/hci.h | 16 ++++++++++++++++
 net/bluetooth/hci_sync.c    |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d809f..b99818df8ee7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -354,6 +354,22 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY,
+
+	/* When this quirk is set, the HCI_OP_READ_VOICE_SETTING command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
+
+	/* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec36..e76012956020 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3696,6 +3696,9 @@ static int hci_read_local_name_sync(struct hci_dev *hdev)
 /* Read Voice Setting */
 static int hci_read_voice_setting_sync(struct hci_dev *hdev)
 {
+	if (test_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_VOICE_SETTING,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
@@ -4132,6 +4135,9 @@ static int hci_read_page_scan_type_sync(struct hci_dev *hdev)
 	if (!(hdev->commands[13] & 0x01))
 		return 0;
 
+	if (test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
-- 
2.48.1

