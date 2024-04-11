Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF713AE2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846541; cv=none; b=ZPexMoJHgZUvBCfemLRgKPflZtt5BMBt2YOD3XzIqSAjfoM0IRn0W1W7wV74S7cdrLWqgLIxMI5szxBfMPyhrldzzRNrllXtZjnRcK2+KO7KYyL+Ozx096dZInf3lOewd0t2YMBgwaaqRVuet3Es+Xh4/wg/TRd+TI/01+uvzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846541; c=relaxed/simple;
	bh=7cruCXvQ0TEEm2Cfb65ldopgK5E7Wk8dd8UvBChZaAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc7MHOM7Q1lSyuSDL6OiJKX9Lh301wirCK+4KHoOxyCiUFDbQ+D+L/28aEoAo84f3oD9jQowqIXbXFPlnis6rrBaXNhm+dQaPiN+RJDXj+HeKN7c4Nfklx3tIgPZ1X/+IaHPb3WG+ape+bim7c2xXglEWRq046EwxGukeVpFggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlnoUeKx; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlnoUeKx"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-479c8f43ca5so2657783137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712846538; x=1713451338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDibxSAWWAP7CiizZ+VQ6iWwap8kl7b405UZALQbb70=;
        b=TlnoUeKxAxgy/TgBX7CETiyMHC1c5PBLRWVKOi+lNGegtPs8ovAQG94SpucDy2LiRp
         xsOmv3kPiGy+bfVQe6jr8vE4ckQOJzY7MXd144ifmhD/CtJyHmqN2D3k971oZ9ms+tif
         ul9FMuvCfcgUF3TNabwYjfyr/q0jCK0Xh1wx30LykR3Cj/bNdwnvaU79zCfaverQ/Kko
         76LCfrY8wMyaz9ZekI2tnGtEp1MDKcJbo+8UmhYnWu1HdrdsyQ1zX6K208I903PFrSW7
         JigJhInaLJ/2qbGn3LHWtrZ5pzKLOFeplL0rQeylx9D+iFcMcFXnZz6mU3QU9DTZFAK6
         bQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712846538; x=1713451338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDibxSAWWAP7CiizZ+VQ6iWwap8kl7b405UZALQbb70=;
        b=ZRoDcn37ZucZqfTeoaYS9PKY1WdKyVW6ratbQw23ZepfeDIWKjAqSiMlmadQrnRJRr
         v2ipiN62/SWJ2WLKVjG6j+udkQzVXn8jCWK85DcYts3TLhp3KhfdaOY7V/KhijL5TuNs
         LyArKu69qG0GxHtVh7HOmlk2dujwdf/SBWaqp2bVyKfkCeB6+0X9pmE2vHKU9xiR3uWA
         OgmFi/AUzZ1ye7Eak2W9PwWkhEfLW2ZYqfJu68t4s0wgox4TFV5OOWF0zPLtIWGdj326
         eNO1dDLJEyZRGe6WXoqB/enMH1/j75aVzqkiqzksYzyQTsl8hPJMEfHinG6KZ9q4cnf8
         NoaA==
X-Gm-Message-State: AOJu0Yzd2t/sB+BZrbuZKO3ErrfTgb4hMyEfzIrgg7RuZvKVXKEZo0CD
	OG0mcwqtZvAWVA+bW88zk+2dVMHQNAhoyTZfUnNXwYmuVrYViySWDXvtow==
X-Google-Smtp-Source: AGHT+IEoV/KgCPVr0NxoOzwwYkT0H5BQO0honeidUlMimcRkA/iiisynpwLAzTb9d8OfIICsVP8t7A==
X-Received: by 2002:a05:6102:c0a:b0:47a:2a66:e66c with SMTP id x10-20020a0561020c0a00b0047a2a66e66cmr19209vss.4.1712846538245;
        Thu, 11 Apr 2024 07:42:18 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id p2-20020ab05482000000b007e818706332sm93535uaa.30.2024.04.11.07.42.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:42:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: btintel: Attempt to reset if Read Version fail during setup
Date: Thu, 11 Apr 2024 10:42:14 -0400
Message-ID: <20240411144214.109478-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411144214.109478-1-luiz.dentz@gmail.com>
References: <20240411144214.109478-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btintel.c | 70 ++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..b787540a1031 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -430,18 +430,18 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 }
 EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
 
+static struct sk_buff *btintel_read_version_skb(struct hci_dev *hdev,
+						u32 plen, const char *param)
+{
+	return __hci_cmd_sync(hdev, 0xfc05, plen, param, HCI_CMD_TIMEOUT);
+}
+
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 {
 	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
-			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	if (!skb || skb->len != sizeof(*ver)) {
+	skb = btintel_read_version_skb(hdev, 0, NULL);
+	if (IS_ERR(skb) || skb->len != sizeof(*ver)) {
 		bt_dev_err(hdev, "Intel version event size mismatch");
 		kfree_skb(skb);
 		return -EILSEQ;
@@ -655,12 +655,9 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
 
-	if (!version)
-		return -EINVAL;
-
-	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	skb = btintel_read_version_skb(hdev, sizeof(param), param);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
+		bt_dev_err(hdev, "Intel Read Version command failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
@@ -672,12 +669,44 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
-	btintel_parse_version_tlv(hdev, version, skb);
+	if (version)
+		btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
 	return 0;
 }
 
+static struct sk_buff *btintel_read_version_setup(struct hci_dev *hdev)
+{
+	int err;
+	struct sk_buff *skb;
+	const u8 param[1] = { 0xFF };
+
+	skb = btintel_read_version_skb(hdev, sizeof(param), param);
+	if (!IS_ERR(skb))
+		goto done;
+
+	/* Attempt to reset if the command times out since this could be
+	 * because the ncmd is set to 0 therefore no command will be able to be
+	 * sent.
+	 */
+	err = hci_reset_sync(hdev);
+	if (err)
+		return ERR_PTR(err);
+
+	skb = btintel_read_version_skb(hdev, sizeof(param), param);
+	if (IS_ERR(skb))
+		return skb;
+
+done:
+	if (skb->data[0]) {
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
 /* ------- REGMAP IBT SUPPORT ------- */
 
 #define IBT_REG_MODE_8BIT  0x00
@@ -2821,7 +2850,6 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
 
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
-	const u8 param[1] = { 0xFF };
 	struct intel_version ver;
 	struct intel_version_tlv ver_tlv;
 	struct sk_buff *skb;
@@ -2862,18 +2890,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * command has a parameter and returns a correct version information.
 	 * So, it uses new format to support both legacy and new format.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
+	skb = btintel_read_version_setup(hdev);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Reading Intel version command failed (%ld)",
+		bt_dev_err(hdev, "Intel Read Version command failed (%ld)",
 			   PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	/* Check the status */
-	if (skb->data[0]) {
-		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
-			   skb->data[0]);
-		err = -EIO;
 		goto exit_error;
 	}
 
-- 
2.44.0

