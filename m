Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DC47A76
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000120; cv=none; b=pajH6k4cPFI68ZTi2i74dsZZPcm4L+z7XE1tsO35/EaTpYYNzDZZSjnZJj1DFbQWeLA65KLj+q3r2ARQZ4a7rD9Ob5WT+GcBSbnNZ9MbpeHtTIyAgDxmwMcN72TfMJq5Ooj+nRKIVkGvyeIxbejGh15AzIEuWkJ4MoIT5BNprao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000120; c=relaxed/simple;
	bh=eiBRusosevAwe+E0Yr7yTwyGtEcxbx/vqCn+8L6f5KE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VDANdcBw9YO6zMzSkzh6+mh9lSI3vXj/l8aEQ4Zshi24GdIF3w5pQdg79GLTdmvbsCTwCPpGgsHaPUSoZLONlsYqq/kdgJ88xjPljeIt3NyEvN1hldXVPrUiN9QE/4DTYeayw0VZZfup1tPmMUAa4IEQZqbYIdHWuuPHmXqWG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4JUWjxy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4JUWjxy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-615053a5252so5224107b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000117; x=1712604917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0peppwjL7k4Qpkty4rXP6TvmRptTKks/OtLL9q22XQ=;
        b=T4JUWjxyYzfAlX9+22aHSRIqmceLtNXJX3C145IjMchSQL4Z+pkNrG4KH84IFWSSi0
         c0NfVC7xxkmlRJ8FRyPClpeZ25oQOdsEe67RxcqG91wBDCKlGdhlb8yVzvNWIikfjWMg
         +aJIGLdkleicIRKpsKW82EIkQ1gZI7JAGv/mN5+/G7YhWuj2zSKTxkbE5WTRgP1LcUze
         1/lT6lNt9+kCFGL/BZgUoymS6NmfU13ogTA/hhmSEelJUeQ5JhC8kmOj5l7L+TWsoAxj
         yDena9NjSKkbGjZGJ23cu9VptojrAXnrSVTGHAghh+X3mhYfgS8/5uhVoaob5PjPCXML
         dkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000117; x=1712604917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0peppwjL7k4Qpkty4rXP6TvmRptTKks/OtLL9q22XQ=;
        b=VVKioUVddOedpruPvUrZk/vOA11HRmBnoFHim2fVcewNEtNux2/UJ1+z0GTg9TXod8
         Px6dH2Nhr3ztSlTHD0qRqqoTsBbiLLyOTf3wuSAOidoMAfwRSOmlGQQMg2K3iMwLslDh
         FKKd9GS4fuhgZJQsbtOwyEe0sSV3IKCY/CrCWYMV0VqUdUbVT6bTvflGXvK98yhik4/A
         caIMRke99M6TGh7urvr7HhgsjuqYrW3oh9vV6Au1Jt7LEbaVJyLJ3aFtnQbMen8a5NiS
         L+/MNVmZPyO7YS4jPoov3w51VhNknulBDSHL4dcoOB04NwdOkA6aS9QuX8GHEMxHz1bM
         ailg==
X-Gm-Message-State: AOJu0YwF5GmjnDaQNj3W5MczcaSOmGwCCvstyG4syHO/OyyEgEmBPCK5
	Fz+mUekRw+WoSLMA88HiM4s95nmgtuB+xcWT6uZXcaMiA3WEj0wqNHkWjdG+
X-Google-Smtp-Source: AGHT+IG4n1f5oV0rENpu9O1o4i+D30nD3p6XHaQYElHkre5raRl9+ZaA9zgrfPyQVZNItiMObBjtFg==
X-Received: by 2002:a81:6543:0:b0:614:e0ac:b7bd with SMTP id z64-20020a816543000000b00614e0acb7bdmr1841911ywb.7.1712000117002;
        Mon, 01 Apr 2024 12:35:17 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id s123-20020a25c281000000b00dc6e1cc7f9bsm2166706ybf.53.2024.04.01.12.35.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:35:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel: Attempt to reset if Read Version fail during setup
Date: Mon,  1 Apr 2024 15:35:15 -0400
Message-ID: <20240401193515.2525201-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

During setup callback the code would attempt to send Read Version which
sometimes can fail due to ncmd being set to 0 which would block any
command from being send which is why INTEL_BROKEN_INITIAL_NCMD was
introduced.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 47 +++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..c2ebdd2b2462 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -655,9 +655,6 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
 
-	if (!version)
-		return -EINVAL;
-
 	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
@@ -672,12 +669,38 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
-	btintel_parse_version_tlv(hdev, version, skb);
+	if (version)
+		btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
 	return 0;
 }
 
+static int btintel_read_version_setup(struct hci_dev *hdev)
+{
+	int err;
+	struct sk_buff *skb;
+
+	err = btintel_read_version_tlv(hdev, NULL);
+	if (!err)
+		return 0;
+
+	/* Attempt to reset if the command times out since this could be
+	 * because the ncmd is set to 0 therefore no command will be able to be
+	 * sent.
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "sending initial HCI reset failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+
+	return btintel_read_version_tlv(hdev, NULL);
+}
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
@@ -2821,7 +2844,6 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
 
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
-	const u8 param[1] = { 0xFF };
 	struct intel_version ver;
 	struct intel_version_tlv ver_tlv;
 	struct sk_buff *skb;
@@ -2862,18 +2884,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * command has a parameter and returns a correct version information.
 	 * So, it uses new format to support both legacy and new format.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	/* Check the status */
-	if (skb->data[0]) {
-		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
-			   skb->data[0]);
-		err = -EIO;
+	err = btintel_read_version_setup(hdev);
+	if (err) {
+		bt_dev_err(hdev, "Intel Read Version command failed (%d)", err);
 		goto exit_error;
 	}
 
-- 
2.44.0

