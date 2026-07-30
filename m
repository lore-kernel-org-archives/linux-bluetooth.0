Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7306409E0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414037; cv=none; b=nxoKbdA7BHcjUuctN8VmjAPA4arVPTxsymP9uYWbx4r1ML9sMI+j9p5kIsNHj2CQd7+wDOU5yCbZ2El4EZRbp92CJJaJqm65x8tWO6KxniAC9EXp7EJSGAQjK0O1ckF+M/OlnfkLw7PeFs0IXbsKBNg7QbTvtcNXrHBY6iIVJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414037; c=relaxed/simple;
	bh=gRGySUQgCN6HTBJuP6J5a+XBQJj7MDX6z+ieHVbFzTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmp8DlyR7AiYwLH6YGFaEkwQcc/X82kIXDj5t9/oxfZxPzOTNIwa/OML5Sjod3DsAM4/hcl/uFSdZHFm9qIi8MWr1PlMsBU5u9T5MtRjXnu5+FrTK7PX0YLXnkpmtfeGZhZmP/ZS4J8+4MFoiIJaYewHEJHsDx3Iu76p7MsGX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O11NHvGj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O11NHvGj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so1585258a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785414035; x=1786018835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mFQjefOe6oMqkkHRip9h5eiVqU+Xd9obx5gLjx4osg=;
        b=O11NHvGjs4dKQBx7d2Y/YUHEQqG7mYFTMUPqz5h7HRKhxq61lGmHzzeBqwKipuJi5w
         H52Jxr+EUOflNK4Ek1iUBul6df07ICeffTfYFSjNS/qCOXMkbTYH2rSodTd+jixRQlUU
         iWIyUN3g4+Gsd2yBx0AtXNljga6Hc2jzuGCbdr1wcfI6heHCFqADdaPEUFu90G7jiPXc
         WUcStnnenONCPyybcjen9GJclY/GYw/OSnxN6LuY8MVujWgaIGpZUCiX/6GJHoK1qW/l
         zkI72REDvu7qvkz1ZS3yLP/FhIP+VQ5ZzqB7i+CE6oPE7YGDLajxyr1yNxkCQbm0/54l
         Rsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785414035; x=1786018835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mFQjefOe6oMqkkHRip9h5eiVqU+Xd9obx5gLjx4osg=;
        b=BHfZ6pA86X7NpxW52mb5GXtpoYfmOGPUr7rAbCDWs1N4Xg06SxIqLacHuKbBNU19SO
         6vRjJWdINvyTEYi5hclQ+rBpFuLND4k+yP+eq1IZL1nZG1afTpc4NaW3LO+u9VIPjBI4
         OZIT5Z4K40rjC6NrwyKYKPYkLT6cLVvOCpV6HvAjPlFb/y6c65nBB+wn8PtMKSZfO8sA
         V4EumYjJZS2cLfCCTWOV0QsG3dR1SBeFnOkIvF5sWtr5Bcq9HhkujtuxVo/8H5o2RWOC
         +ZNNa9vHPRpM74RPZsf6J5LdcvUs+1zTHGPWjTsu+Q9y8XevWfYsQyZanSlLQWeO9/Em
         65eA==
X-Gm-Message-State: AOJu0YyFx1JxaRZ7EoXAtnpMzHd/MCJ3SSJLKEZrUGdwElChSBrPRp2r
	4n+bfS08SxJmbrSzAOw0GskV4mQE2dL5LdErHQa7D4Gn12QDfRXD2iG629MffYqseAA=
X-Gm-Gg: AR+sD1326H0ZrCofNZm9EmK+nth4ltVMYJNTCzux958U/5HJJynkhWkwDDcI3ZGFyYm
	NsawutmSlQcF/c4lZCkuR7DbzITZcL4iTyzoOEDsagjMPtRuytPIesukEuwQNTK7jBBwSCPd87W
	lYxOiUzV+Ic0iVwXp1AukAGGLQj/PgFUtgkn4kJiPOTgWk9wqZIPpkAWsiNRGQl/FppA7vJnSm3
	oz3rJKNC2t7Mtej0ZOG5/caiksUoy/qoHHltzAxSB90RCbyyKRq4IgXYd3vjZ5wEbI8tjkZX54q
	fn173bfr8hzSJWhqnsFA3hZHUE6A3A91g0BGE9F2yRCPLHm3dGVito3+go3OTFwfsiSs0IEpOWF
	3OCRWkoj8zvJWRBu59HpGGcqcsSl/bVD8vZYnapLU2Zf6ivq/A2rkufhdg6tkYM0n0w49SpWCeB
	FOMTpBXHS8tCXKOZ+qxVtwuxki7Nvq6KRiGbmb/VNU+IEZGXEUR/awRczWIroy4Yu20U3t6AFEc
	Uut/F/OZYp90dUR5XuhDN+f7+M6HvhCsA6WeqIW+ezIPeTd52t19F0erqD/9j4Rc/Mg+0sEiAwP
	L71U1dw=
X-Received: by 2002:a05:6300:4045:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3c900465733mr2543213637.13.1785414034864;
        Thu, 30 Jul 2026 05:20:34 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dd42a9sm24944127eec.30.2026.07.30.05.20.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 05:20:34 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: yang.li@amlogic.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_aml: validate firmware segment lengths
Date: Thu, 30 Jul 2026 18:05:28 +0545
Message-ID: <20260730122028.98159-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aml_download_firmware() reads two lengths from the firmware header and
uses them to build pointers before checking that the header and segment
data are present. A truncated or inconsistent firmware image can make
the driver read past firmware->data while constructing TCI commands.

Reject images shorter than the header and ensure that the ICCM and DCCM
ranges fit within the loaded firmware before downloading either segment.

Fixes: 37bac77e4649 ("Bluetooth: hci_uart: Add support for Amlogic HCI UART")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/hci_aml.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 959d9e67b..067fbf278 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -247,7 +247,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
 	const struct firmware *firmware = NULL;
-	struct aml_fw_len *fw_len = NULL;
+	const struct aml_fw_len *fw_len = NULL;
 	u8 *iccm_start = NULL, *dccm_start = NULL;
 	u32 iccm_len, dccm_len;
 	u32 value = 0;
@@ -281,7 +281,21 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 		goto exit;
 	}
 
-	fw_len = (struct aml_fw_len *)firmware->data;
+	if (firmware->size < sizeof(*fw_len)) {
+		bt_dev_err(hdev, "Firmware is too small for its header");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	fw_len = (const struct aml_fw_len *)firmware->data;
+	if (fw_len->iccm_len < amldev->aml_dev_data->iccm_offset ||
+	    fw_len->iccm_len > firmware->size - sizeof(*fw_len) ||
+	    fw_len->dccm_len > firmware->size - sizeof(*fw_len) -
+			fw_len->iccm_len) {
+		bt_dev_err(hdev, "Invalid firmware segment lengths");
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	/* Download ICCM */
 	iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
-- 
2.51.2

