Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3C191F91;
	Wed, 16 Jul 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626807; cv=none; b=ZjviBqSvs9QI6Lc2+RDC7SvbtT9nRPFlSS4fHjIkjRuOriLL1xi8z3UvTkXsrdL06ebgtI/Cuej09zvlFIk8lYlibZBjKxbiN7L8a6ovNdziT196CCvuqccgwbKZsXGfc/WKDbSuIon7izH7tZQsPRXePdDYSr1o2Ex+UUSrm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626807; c=relaxed/simple;
	bh=woAgzFOPYnjFecFnNTShmZq0j+l1H6Ja/Vv6z99qT90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFUMk0gs5Gws+9PYRLCcx9zRaPzSrLiV84zOUij95BjL6ZjETJZxJjj1IDG34g8nj57EQiz/JepUNA8zyFg2zc5Wfwon9OAms/pyDNxhsVtucldpCVFh1NWKYDUQ5WrfBmG/axE6qtPD4wtiBmtXbxlpdM7QI0TDtDyw8DBLCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMK0/BJG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMK0/BJG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so54384245ad.1;
        Tue, 15 Jul 2025 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752626804; x=1753231604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRTEJWMwRNmGn9tXl/iEoGQRPnhU0bu+ekhvd2LYaEQ=;
        b=VMK0/BJG3MIQul8SlHWnHdKOWNNg7XlhlJpyeJgQNmLoosUXujzE7041cBVxBRGZJG
         vlV1RkNC2W/QsOlwcqiT6xfNdYlcJOpjsQmLWw8AyCAiPPzTmWVTStUTNan+jZrpb+sO
         DYPoxXHPUp2ZOddOb9g53BqYrAoLOXDN2bqbvV2rjoM5opmvEmYVpF1Y5qeIAQIFWELD
         mQ7Etbcc3lBbsdomXYr4VNZHU6azbi9mq/QpdqUNbrRZ5wHCHrL6R3QnkJtraC5Es0/w
         80XuO7mNgg6Ra1pbgv5yQGxMUiuIwhF01iqWXJJ+0sHi/vmpyCH/qmtPTXQ8g1Wj9JsS
         JGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752626804; x=1753231604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRTEJWMwRNmGn9tXl/iEoGQRPnhU0bu+ekhvd2LYaEQ=;
        b=HEunR3HCNFQSFjRXjk83JG/7XtpQwL3rI9CePFSlHt0qHi6+farm7sDThfbcGFxCNJ
         CnTjuV5DKYdqB24L+QIvnAONIaB4zgxsM2S57R/GsV89v63izBL4MJp/3hcyKuFgtPgo
         iuVb7x6g5sxZ4Kci687n7IVlM3I9D7tJtEOv61AV7ga2d+dHdF2xHaaELjukaJ9jnE2o
         mVzuo8fH5Cdao2rLlosdgONuRmIlnfl1NAmRTw/5cg50gD10z7TV+p0J3wA1OfOCajXH
         nU1INq1akWD7bCpIbRfi1/X0kVkkAOGnlYvsEguoOAEDolvljyuZvQPOctxB0gOMItDf
         7amg==
X-Forwarded-Encrypted: i=1; AJvYcCU5nWAw/g2bDP37ArttsgIULHbpdogrRlWFzjimZftZd1ZHZUTGbPQd219NSy0G+r98PWFIGlGexGPmKpyvygQ=@vger.kernel.org, AJvYcCVXTPaVMlq0+v/qgnieMUlsh8LNnqT7TBWjqPRAlKQKbbr87JZXddO10eGR/QO6TDwmufLm+MSxER7BihIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3J+g4BPeI5putv59oX7OHQPPUgrmGYO4Ev6Gck5SvcgvxbGmq
	7YTep3t5OmPKhkuz5hIq0lCLATomliw/HQxp1BbKILgwbM5Tc+EtZKHf
X-Gm-Gg: ASbGncs4xPhmeEb9B9HK4cQmDOQb9mXE6IqD47IO7c+hS6SIqk3xnJzqbpfIl0QjkcQ
	G3+2ztlPEkZeStdXe6zVDRU1q0Mv4DsArsDMKkpOfiYy7UDi+Wpy90B4xeyRgVsL5QopwrcDIeS
	eeugA9pfwqlKc8TjIvzYs/t/vuWeG8O348a1ZaaU4+fnZdqUTxWYcpGPmVWnSOFQbH/RNIKgM2K
	GA6thI1t1eT8qCg/OAerRfjxFg4fBGPKpYGbYNmbtrCvdtaVIHYdDchQFaRg9fTz5xbSRfC5TuP
	l5jqIIqGPIoNu4/AdcczB7bglVGZE/2MBHx9nZKugtvPnzsSKfW3papkWdakye4McaQpTiS1aX9
	hLbpp3j7AjvFmEOtWhN4iclScIbFMWoNVcdPJmYy2pnsx3IicYl9iigwv/Qgv+N1GZuixRiSzPg
	==
X-Google-Smtp-Source: AGHT+IG6rCKsKtVMjbxz0oZEbHmPuLfjFMKAZoeQQA0RwebSQXkifPxBSoNLvFq1rG3NqpwRhNqq3A==
X-Received: by 2002:a17:902:e751:b0:235:225d:3098 with SMTP id d9443c01a7336-23e257706f7mr12490345ad.46.1752626804267;
        Tue, 15 Jul 2025 17:46:44 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:cbd:b87b:a7dd:f79d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42849d7sm115995915ad.21.2025.07.15.17.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:46:43 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH RESEND] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
Date: Tue, 15 Jul 2025 20:42:53 -0400
Message-ID: <20250716004252.125466-2-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the creation of debugfs files into a dedicated function, and ensure
they are explicitly removed during vhci_release(), before associated
data structures are freed.

Previously, debugfs files such as "force_suspend", "force_wakeup", and
others were created under hdev->debugfs but not removed in
vhci_release(). Since vhci_release() frees the backing vhci_data
structure, any access to these files after release would result in
use-after-free errors.

Although hdev->debugfs is later freed in hci_release_dev(), user can
access files after vhci_data is freed but before hdev->debugfs is
released.

Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
---
Resending because previous patch got archived [1].

[1] https://patchwork.kernel.org/project/bluetooth/patch/20250614235317.304705-1-ipravdin.official@gmail.com/

 drivers/bluetooth/hci_vhci.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index f7d8c3c00655..2fef08254d78 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -380,6 +380,28 @@ static const struct file_operations force_devcoredump_fops = {
 	.write		= force_devcd_write,
 };
 
+static void vhci_debugfs_init(struct vhci_data *data)
+{
+	struct hci_dev *hdev = data->hdev;
+
+	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
+			    &force_suspend_fops);
+
+	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
+			    &force_wakeup_fops);
+
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
+				    &msft_opcode_fops);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
+				    &aosp_capable_fops);
+
+	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
+			    &force_devcoredump_fops);
+}
+
 static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 {
 	struct hci_dev *hdev;
@@ -434,22 +456,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
-	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
-			    &force_suspend_fops);
-
-	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
-			    &force_wakeup_fops);
-
-	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
-		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
-				    &msft_opcode_fops);
-
-	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
-		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
-				    &aosp_capable_fops);
-
-	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
-			    &force_devcoredump_fops);
+	if (!IS_ERR_OR_NULL(hdev->debugfs))
+		vhci_debugfs_init(data);
 
 	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
@@ -651,6 +659,21 @@ static int vhci_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static void vhci_debugfs_remove(struct hci_dev *hdev)
+{
+	debugfs_lookup_and_remove("force_suspend", hdev->debugfs);
+
+	debugfs_lookup_and_remove("force_wakeup", hdev->debugfs);
+
+	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
+		debugfs_lookup_and_remove("msft_opcode", hdev->debugfs);
+
+	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
+		debugfs_lookup_and_remove("aosp_capable", hdev->debugfs);
+
+	debugfs_lookup_and_remove("force_devcoredump", hdev->debugfs);
+}
+
 static int vhci_release(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data = file->private_data;
@@ -662,6 +685,8 @@ static int vhci_release(struct inode *inode, struct file *file)
 	hdev = data->hdev;
 
 	if (hdev) {
+		if (!IS_ERR_OR_NULL(hdev->debugfs))
+			vhci_debugfs_remove(hdev);
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
 	}
-- 
2.45.2

