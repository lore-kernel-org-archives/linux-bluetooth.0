Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDD12F5A3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671785; cv=none; b=ihK4a6MCcqyYq7325MagwE7WHgOSvoW7ceJgP//38GrJSWd3lR+L05qkvIbZkDplbDstVF8nhhyT5aMDgYRprVJUZEJCYvyuUki9AbFEeBp4HWWQQdWHCk26IYrxy8OJmC/c1AqPnFIVnKsGciTzk6MKzvNrNYh0mG9BD3E2NE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671785; c=relaxed/simple;
	bh=7cruCXvQ0TEEm2Cfb65ldopgK5E7Wk8dd8UvBChZaAs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DB7eBGl4FNQnrw7NrpsHy3hgUtZYbb8gukyTFgrtVBvFTeBy1GqLlShHhdEyPdKxGNE2da3cNeWnddxT3LLIJPAGP3o2YDcLsXTpunLGnmIwpGIDLCkVIkmbFhAtyG0Muc5wJFVM9w/cJDS4n7lHJTT8/89/9l7G75fG/PVe1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctD4sAbt; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctD4sAbt"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22a96054726so4945605fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 07:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712671782; x=1713276582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDibxSAWWAP7CiizZ+VQ6iWwap8kl7b405UZALQbb70=;
        b=ctD4sAbt3aJyT5RipuqCy84X2+UBsSgnovH/vKWKAIPQbrYKw1kt2ItvOQERJeFg/P
         mme5LJXoqkLDMZt7QoGVr3QD/qVinAv7DDa22DSI5diciK76YX0eMRvQ++ZiGtrt8FIQ
         Zz8ejcFNYFAasbt1BaJe+Ify6DTRSZ0t6KWm3Z4wE8YZKOEeFUoCHL5mbE+9189NWTAo
         ItQ9WzKCz6LLsXKZcFYO8aYohG94Rw31BiNmCyLr4bZEUFiY0q0Q2dxQDaoWtI9Hyi7z
         I+6aRLxI4JtVDbtVBv86EMCnKcWCj3XVhXZOSqldJ/Yd2Vuzmk5cTrP7RtWiHaQ5vaRM
         a/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671782; x=1713276582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDibxSAWWAP7CiizZ+VQ6iWwap8kl7b405UZALQbb70=;
        b=D9Wfs9wqgu3ou8AXK3uaOtxDWnLOVt9Kgl8NtQA8wDoney5PSKY28vPYo0bjSRT2+X
         rIjO4cDmQvv8BHO6ZUyIEJLxHo2L2yOU2Olbw4LSwtzS/rmx7bvYJjdO5N5YFljnGjGk
         5w4XzdEqjV3kcX9PERShCgHEnxljoCGS1zOJvjauCwXO5xcvXHLjuHe1mW9QysR15mR5
         um5ysuBqu/n9LSj0lg4vxk4nEfKDUa01f4TFYJ75YKWD8tD54+XENGboglHFnrLVNDWb
         C+wTJB1SbB+7/LtymC1iFloK8bUxFN4Ug9CruJo050hpRnYbGgVuoGIkT3lxd4P6RFY8
         EqUg==
X-Gm-Message-State: AOJu0YwgBt3CFsGtF+sEPbmQHrS/YWLqytlY3AclPrpumGjNHQ3uaem0
	8TUCZVDzocej7tbKGHz3qNSKelG8zJoAQfJflN/GZX9zrDZUB/8MkqF5H17+
X-Google-Smtp-Source: AGHT+IFiVE58DPdvnxwHUcadLQ8ZSFRjGctUHz8PPSlyQlsMcTCH3xpXHGiWlj4rnK6az1a+YmTEng==
X-Received: by 2002:a05:6871:5b1c:b0:22e:c1ff:303c with SMTP id op28-20020a0568715b1c00b0022ec1ff303cmr12930011oac.37.1712671782127;
        Tue, 09 Apr 2024 07:09:42 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id v13-20020a056102330d00b004784cc400f4sm1704270vsc.3.2024.04.09.07.09.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:09:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel: Attempt to reset if Read Version fail during setup
Date: Tue,  9 Apr 2024 10:09:39 -0400
Message-ID: <20240409140939.3855573-1-luiz.dentz@gmail.com>
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

