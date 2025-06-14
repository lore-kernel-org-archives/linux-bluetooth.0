Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AA1A255C;
	Sat, 14 Jun 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749945222; cv=none; b=kkHtnd9ACjw+pECz2ZhCUCBvip09LugE90pvnv0fEkcWEuB/+4gFb3pgKaPpiaU75Q+9CfLtWu8ZW7ThX+JkJEmog0CoUTfDDwaYABsbqDCwYhCLSC3Y9Fj3oQ6ZvFUOGjTaXZRGI4RBG+glynPJwaikStKAjDMih4bZ4rWRIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749945222; c=relaxed/simple;
	bh=ynaW4cF6HGkZ1zweb4ULPnfsfIUOZqiyFi+NUeuMDpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB4QFAtUEunHnSoNF0HRjX+wwPo7wQ0VdP7kgqTOQQSqWatlfun9UPJTAWeD5qEZh399FEw4wB3JIWwtUgadFn+xXm8soZnVe56Ak6UShGpQUPHO3MsoReq/C5hZgwN6ybqQK+qubJ30ej0bcxwvZgDC19Z/bv14ASfMdcdttkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR/ykiIY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR/ykiIY"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4476d381so2797008a12.0;
        Sat, 14 Jun 2025 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749945221; x=1750550021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAHQAjhuPsz5NdN/q2nz8/6zCOkB72GniBPBSHebAvA=;
        b=WR/ykiIYS2RRh1ic6KEzzJMR58RQl6UbBJoFD4zgfX9HERDXiOd6I3Sw1GA1dqruaX
         WMlflhhgIFL2iNzTjBfrInSfQCWv3dfex8EZlI6eB3YqfuCF9fvEAXVamEVjKj4eScMt
         GZ6kfbqyBv3X5gpj0XFJi6NmGLvRRc9ysYztjag0ci0AER5yweaZGIvnUrtoeQ001Hm4
         ocm09fWsqlLefNB8lEPKlYWSPV62tJoD7gxgDhhG0WC9mwAMlvMx4qw+KHQ4/nCP2+Ac
         gLAoeWgxRTip5WWVsy3LbuwD/+2SkiPqyKNjHgj/bJKoGoAJWlAl6nr3VM+Yg28IOS8K
         rlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749945221; x=1750550021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAHQAjhuPsz5NdN/q2nz8/6zCOkB72GniBPBSHebAvA=;
        b=nvhMF/v6l6YarlN5Iww/cTCwn1zG2kyq+C22XApiXz5wNzXhbKXSAqfew5IOUUSAPH
         6Z7OdkgxcCdLjh5u5TM0GQ6Wn6TpIL0znRVeRo/xODUCRaY/+VpQHdy3agwbXTSXkMQt
         GgXbQOBMw++S1yUEYyDREd7Dfy8UZbxktQhRSzhoPZ0yRMZNAO+Z7x6xybN9ZuJWwRGl
         0u459E5ItCCYmyREoD+uCSxJ4I2Y7p+OdAvIFS7BSV47j8SgIWySNYV8D/kcSSexjGLP
         mNoWXeWg7EWr0OwUhQBZiNAc3UAWAe5aNwZATv7tQ7P3n6lKrhniO/g2WFqcRLSbJkDG
         hLlA==
X-Forwarded-Encrypted: i=1; AJvYcCUhGEvdHej9UOjPYBVXN6fJL+VHK6mZwWH9b5q0EukVVgsuvXZLckUOV4FfFrh3F6bshfq8kJikMD5dQo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYrkTP+eptE/pZGb4sXrvD+Ty1V7uz37EVQyCzS4l2P78lZhy
	2MGtMHEgNaDZSdE4LdV0L8nPvxrnrjoTr/gpf19L0cUHnAOEjDu1T3at
X-Gm-Gg: ASbGncupX3DpRouo0GOQSZB8NgTB2RAPruYv2JD4utHWkLKrm92lDsXcE8WN8wbqqPd
	NnckhAUfdiotd6V36nmBcP1g8+8x5YrYblyxdeZutxUQYRR5zTmpaaI3x9sTTZwXtfaob5D9sH/
	IorQDMPV8B7pVVrjJJS9CbWPUaGjqQq/wjU7a9vm5EUbq37RZh1qc+I8jiZMJkHrrxt25yeXV/c
	EvLJfheLQu+z6Ki2CFL02Ct1t6fIX5hh3v+2I5nlGzJ01YVABAK5oeAiY9gFqdP4C/h7v3b8afy
	BU+ptjcpnFPN70jF0Gigv9oeFkWILp5im3Iu0J/KKSs9tLVVAIT3LTLjEpGWE0zlZzwYNPEDGlu
	cICs5JWPltnqEsjcu0sl52Jk6eRUkiuKpprhsE9Q=
X-Google-Smtp-Source: AGHT+IEGfQrvXOgpSrVFGzBu2GOtCXjhf/xMzYSHB+TO0vt44AVSMTInWOCL/LZX5f4C9s7B98hYwg==
X-Received: by 2002:a05:6a20:1595:b0:21f:56d0:65dc with SMTP id adf61e73a8af0-21fbc778b5bmr6464584637.13.1749945220586;
        Sat, 14 Jun 2025 16:53:40 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:1e02:21f0:5a89:c4f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d257asm3899060b3a.165.2025.06.14.16.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 16:53:40 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mmandlik@google.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
Date: Sat, 14 Jun 2025 19:53:17 -0400
Message-ID: <20250614235317.304705-1-ipravdin.official@gmail.com>
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
 drivers/bluetooth/hci_vhci.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 59f4d7bdffdc..b72f826b2246 100644
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

