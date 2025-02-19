Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67D2586C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002049; cv=none; b=kz3Ovcl+y78TIlshAbzmJ/nbKLHZyASx+mx8OlmIh1ouMy6ySkjT5VF1AX89+N+Mq9WKhGJ1sW4rJo6Pgzdk+YvU3g17g7iA3RbsLq1/adOtx+ty+Y+K+qJcPoXiF7wMb7cTRtBbys4JgZGMIaI2PBVE7Vqpph4gOW9/dB1nTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002049; c=relaxed/simple;
	bh=cq3HwJSh79T0oG4jrILIHlbKt08amBT95DaWH8MgaCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqY9EBIzueSF5VG8W/W97M+57lHsEU7y1TBZh6bB7NJjNaib4yJmCxF3PbwMgfeI7thIS25nFXmc+uY/Nf1oDe7uv78NHmVnMVCtiMoJax6C5NKUgHJks0VW7tCHXbEzq0bfvl2eIOEFAca9z5OLLirPE1MNhMVYVT2MG/QESBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha7N5voK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha7N5voK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so6147215ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740002046; x=1740606846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ABhxJqnGQAAf9BMYNBxx+SGk/KS5ofgIXX/lyuiQF4=;
        b=ha7N5voKQw9ZogZWj4Gjfjbb6v1Tt4xb8Gy5GLm/cL7k4ut/fJzqWe3smfktXJL82p
         /rYAJNslHxu9Li/ur8cUk7yGRIKSK835CM/MqLGsm9j85+ldY2v+12mDlPwwh84R0dEX
         HTfPhmmh9KWXgNydbXZVAEwE2Fok5MJgR88Z+JeTEMqn+X7ejFPFocTyZPStiZqTQeTR
         TwgAAZMdPegrLG+HDliJekOwq+W47yN1m6x8sRC9JX3mux9ig2mRcze6EgCUhoo0mV8K
         M/CYIW6RCTEiHpGneyP3/r4ZHc+2yY+z+Zicr58sqj1GXgXiYRHwNU0lqyhrINMhEFD8
         pVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740002046; x=1740606846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ABhxJqnGQAAf9BMYNBxx+SGk/KS5ofgIXX/lyuiQF4=;
        b=TJY8cMBqA8jKjoNbgu7cvWPM6zQMC/ezRRMRRlpwLdwsw4HE19iMbUBJkeAOS3rMkZ
         QvICQeOotx8D85sokBRAQw6IaQCChln7CiZ0WYc6y0dPi+LhtVifqNjjqou1eml2STfq
         EG6d7WJf5pS3zX2JVr2SMsP+wMWFexiH7psJasY44xrHbkAFJmvBlQhf+AZ1AoYMO1pC
         xAuwiE3icz6kfN547KpdM/wxLv9mntPNOrb4CKadwOYBb66+/JvRTCxagEZsJTlpnh4x
         XGE0nTGs8+efrhy4tD8BI988wdEOQOpC+KlZXnKyA3YXOuHGbMjVM5CZgh5DBWOScQ+x
         tdFw==
X-Gm-Message-State: AOJu0YznWJSAg5YaI1I9EvpTGiWQxSKL+tXi1QKRDq9wa1HiKItdEofQ
	DMsGoxrqJ7GI7bcOfmHT+MSRHTft4/79YBXJ/+iGc1r/Si54GZdmriKNmFln
X-Gm-Gg: ASbGncsyy4m8XoV6beB53lTQTeZ0r6EHhepfEjSETygz6OfSHbDKQWkgJXPGi+lnCvT
	Mq9b9O3Hg7g1nDAfazu3247J5hJH/g7i25pmK9XE9Na6Pb8/mdx6XKF4llf65T939N4aQ0NSFTi
	1uNZ7nImp09b3tmI2O3WKJbpTuatmpyRAyM3WYR9TkRhr9YRTMKecDt4SfiAYWrRY+CO2X9S0PV
	BPTZYsp4Lme5OmE5/fjZS7Qc4uVbHc2peC8xtl8BBpQ9By8uawbgPv5542QmVc58jn8VGawc309
	Ea6oahlVVBYc02YpsRy4yxrabWwO8Yt3E5Y+b4szPSAcuxC+/GqZ++geIfaiz5tw4hR6RBufqLE
	+
X-Google-Smtp-Source: AGHT+IGzhngNXnvxEAqDrrH+AKB7qAnlU1K2gbqffXCAiTrJvqGIDjEI4S7pelwfd485lajpvgQVNQ==
X-Received: by 2002:a05:6a00:124f:b0:730:8a5b:6e61 with SMTP id d2e1a72fcca58-7326177d0ecmr31130375b3a.2.1740002046389;
        Wed, 19 Feb 2025 13:54:06 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5870cba6sm11610138a12.42.2025.02.19.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 13:54:05 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH] bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Wed, 19 Feb 2025 18:53:52 -0300
Message-ID: <20250219215352.15605-1-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set HCI_OP_READ_VOICE_SETTING and HCI_OP_READ_PAGE_SCAN_TYPE as broken.
These features are falsely reported as supported.

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 drivers/bluetooth/btusb.c   |  2 ++
 include/net/bluetooth/hci.h | 16 ++++++++++++++++
 net/bluetooth/hci_sync.c    |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90966dfbd278..43403b0cb5cc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2435,6 +2435,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
 		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks);
 
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
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

