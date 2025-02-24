Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368A24EF63
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430498; cv=none; b=Rb0jRUaq/8ue9M4UOXNn+NdZ277ycqxlXnDA/0MhUqoLFKS2SyIqsh8BmHlazTz3zqnDEOGv1iScdViKBEvgVdMt7p7ha4kmczteFO8XKf7i2lw5w532jCLyXoQZCYbJ76QLOBaYSHFu0rxji4xrkQBqCuV9XFAB7H6FoVSAjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430498; c=relaxed/simple;
	bh=WdjpbkHsenDZpPkT3LQXsBJoK4pVrXZAaYoQKLjLfcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EibUeWZr2sWfh+qBJmRxN23S30Zrb9PNQX5W3UOlk9zxdeGfVVOcuKReb5yTtecagVPXptAplQeKVNxGxqc0wk6LDbfq0eV/+e/AoWDy4CZJF+jS68J6f6uL4lhnuGFMTvkp9d3/a8LbMKGUgUKEqM6sKtUp18aLwMR1NsZCENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/hhjYHm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/hhjYHm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso85012725ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740430495; x=1741035295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skAepCMpS5A+SARkM0JSy/NjPFnXGTxwrYBtrHVQjm0=;
        b=K/hhjYHmRYqRBrF9pD7z4Yslu5ksUD4CTwxy8Hebi0AzeHDjj/47WCQyN0ar34mBc/
         /3LCPz1GiI3u3EZ6M/3cTH+QWSUXlKKXtzHD7Efiy7XxciGcHPmqaDpudzDDV3EdaQ2n
         HMqoQMAGazfhrVGqyxFXKXG8iufNWUFacFgK5i0kOW9i+9hHpmsQLtQ77gbKdrWnKw3U
         YoRIsuCtI6o/xcAC6zeQ6SwzPAbRQ91UZQvWskJd7jpNEHvKBi6/mUKywJAVIxtGxyal
         eediLACqlElHiPOlEqyS0jyuVmh3cEJQ6cpgw3Mpqa5IDoEERpOadYy9DE27854o/cnu
         5sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430495; x=1741035295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skAepCMpS5A+SARkM0JSy/NjPFnXGTxwrYBtrHVQjm0=;
        b=QD4rvoWYnrdZtjCv9xzR6ICdOavvNkPSqKNnzx0twLyiZASzoEBI+z8NC7XfmkVdNQ
         5OStEReUSY6bzaUk6ui0YpzLY+kCLOHilk43WPwOKbg7KIg/K/5QW6NEpIhu2i64hRCB
         z9xVmBqJBoabPcbljV1ozfy0cN1ubiK3wgK9X0gDoXW+NysJya2OT32erSPEb47veocB
         kIMC80bXX9xedenJvsb5neV/v1UqbnDIkictnJa+KWcup5NCbaPiETkmpjX2UlBkcBB8
         JywuEgnx/AzIoF9kHaOk1dQRipO2WHTml/jOrxTFpCKjjT0aiOpwaugPN9xjlZVB/yIL
         YcvQ==
X-Gm-Message-State: AOJu0YyfWT02g9X2Wts7iXld3kuFnVNwNBy+si2UBfzGJNiv0V4+nbve
	Obm9yYlPIG5qdA4nO0ZJB04UXePBHqDAmVrlr2aJtcMguIG7JiDHblFnioh0
X-Gm-Gg: ASbGncs8sqaZxV8OGsxUR9298FQ1LApuR/BH19gdVysz5w7yVZL14Rd4cns0cLbWMh4
	pvjdYBTJVk/Entnbyrs6mwwnNp01GSFKiekyk+37yBIejr7ZX7QMTJ6/3EtgMh4NJEQ9NWCpzcZ
	IDniMsvvW7LQnG2jH0vzfetIvKWOp9z2IlTfsR8MWjlMqH6Jzwa2f/oHO1dBIfpTrNnm1DIwf/e
	nuvLwdVxl3LktmhVFBLST0E4GMFHpOcxVTUjimvn5oOdUCDc/22CVQ2WQo4Qv9YLqB0hAxDViau
	2/xsuILwEsDf7ecjSTos5q8e+s8yOBDyM34VEQ6Tp9cdKeNuUwer3hTMS0fHHuwY+Xbd8AYETp1
	V4UGh72FVfuw=
X-Google-Smtp-Source: AGHT+IG4VZc/NaeKyhX9aR1tsFwHhXNWj1TejhT3SH3opPQH4u3vvOD8Mw04jEhHj3D1VT6Bmp3fNw==
X-Received: by 2002:a17:902:e783:b0:219:e4b0:4286 with SMTP id d9443c01a7336-2219ffc00d7mr241471355ad.29.1740430494655;
        Mon, 24 Feb 2025 12:54:54 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fdeasm471715ad.87.2025.02.24.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:54:54 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [V3 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
Date: Mon, 24 Feb 2025 17:54:38 -0300
Message-ID: <20250224205439.18672-2-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
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

