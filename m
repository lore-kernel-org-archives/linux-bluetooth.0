Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613781D9A5F;
	Wed, 27 Aug 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306442; cv=none; b=clnSNcfETX6QmIPLzxei+v/yhsCKn67+lP5ExQ7y46y5/iw2Q+vbsNHuZqS5+x5CcSL8fwWz8PF1nFjwntniNVo8/xCF16VjB6WT5BwNVSDS+2O4mXAX7YzdtfW+NtxZE3fr3ASqOaAfjlt+OcUpV52Gd7A/1L569H0c9MTj3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306442; c=relaxed/simple;
	bh=LTVYaPQmpbESbLa29AHfdA6gksQ96bqgTEIsxw27+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+alKej7cjzI/jivwec/dQd4eJUOEQnSnH20aB1vva/ctHL9Bbbe4pPtvAcRurhiwK9DmfVEf81H/lc4XbeES2Bt6d1suZmGAeduJvHEXVRuvdEtm21Hx10cS3UhGkx5rkgoCPERDI/8drIQitYedQrB0TSvlZz0VLaEu9Bpens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBAAmdrS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBAAmdrS"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70d9a65c353so67649676d6.2;
        Wed, 27 Aug 2025 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306439; x=1756911239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsW01q9TUkJKPs+74mdvZj7XDe/KxO6JgJKENh+3OII=;
        b=aBAAmdrS7Di3eLMGKaRQvsPjt/ZYpHwd1wuH1PGovijPx6NvO7uUqFy9/Vwy3eJzXO
         tKRpN6V4S9bkw0MSwUMZhwEqmhoB9b028//v8jCvtr5ZRXuQli66MvNnbTEREdE6DmMx
         Dl0BKUQie55MBJq+23N/MVZa0wuRVzzNLZhpakJ7G1vK/0HWAkb7xC/SgJoa+GoDRZiO
         +IMc/TRhxzVlntElPvphNwIlxVxkOhcp96GbaxVBooqafy0BREy+BK7ruqTM2LKxUGGe
         QEQWs1CheiFV25Hg8PKT4KMhRbafzqhetqKGdJ96W5dNY25K2D3bo8brJ3z/8UToz5y1
         jksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306439; x=1756911239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsW01q9TUkJKPs+74mdvZj7XDe/KxO6JgJKENh+3OII=;
        b=njuwSio+la5hU457fNdSD37hytvyDbn0rgtdDw7ZrbYBHDamEN1vh4I/W0HM+TTicU
         gK27tPoY2lfuaS1CU4ZVq/gEmyyDYpr1SEtfTwrhj++OkFbSnu4CIRMc/ZfjucPoMdXc
         A0uC+n9WNIPH4xTzskSKO/Wdcog+u3NjguDmTj59i8E9sLjVVM2eKal4ofA6o07XBt7r
         fTaT/Yi6Pa6LLaN07YYUbOPl63IX2oS6NaDDMxw6ndtzbyQmG+NLXsHC8isdygRP6UFk
         JIZZyMu3XtvPh9hsuKWvzWMrxrfDeizEEpBDlPVgpY0V1wGin0vBuArrzQR9QhFQOz0n
         ahBg==
X-Forwarded-Encrypted: i=1; AJvYcCVwGXV6hMlEuYfyiznC8cbq7liJBTPSeQ31nrinIC8fGTLLIn/nJp4QS++RUlAp2HoP/WCAYmaDW8YGbIsj@vger.kernel.org, AJvYcCWcQfpAsgRtlR80E2FmhjCl5St4Wlk4NCrkVxe3mm1+xilf1zIVlczTDmz32G4m7YAKXRiCT9Af0cd6dXrtRsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sP8euIj1xvPhqRI6Zq7Zv3CEVgE82a2qkChQ3VDUItSy45yt
	tEZFIlVJpbJmwR0IbZTcBLjVNlJirCI4LzCo5iFwlMj6qslOBGoI77gRJOgdVrLQ
X-Gm-Gg: ASbGncu9+uEdPYvHnOPYwyXivSG+C0SO8eW3xy6v+l29yXHgnykcKvQtCbDuHpEuFeZ
	7gRec7otjvG/pB/jWf3cP6HLhBlnjIPu5o/LkVL2e4FL8lVzX2nUqJS2MAaS70W23uU6f95EsOA
	/gc29NHedOnpGOCBFJk9vOoF9neqk7/juE0AtQzi96YYy57rhYkBt7ur26r7wuipzAfO+ARgcdX
	7tivxIADzOULDBO4HiMVZcYcKtzcgRrFK40qbfrO55lOEVbVIEyH3UB5nSKpr+k3jaDNRwpoY/T
	3hSxXX5Cv1mlBkWraEbfIQ9DO3KmCCfKhvtGzwR8gdJ0f8DzZLlVpvPSZ90GoW7QrWaepJxXhOm
	huR7FjjDBWwwPtD0GG+eLTlA0JS4n0g1Epf9F6T2MScJ/mVveKF5jHcCBlzrQLzFPsXqDkhZYCS
	TSsp2X
X-Google-Smtp-Source: AGHT+IE4qwObq+xLWcPwZ30NFJ8El+ZMvdyIuGZ1DkE/Mg97NF+IUUe/yQYU3AzIl+rnEAr7uCy9mQ==
X-Received: by 2002:a05:6214:2527:b0:707:1322:6ae1 with SMTP id 6a1803df08f44-70d9709296emr195810776d6.0.1756306439189;
        Wed, 27 Aug 2025 07:53:59 -0700 (PDT)
Received: from ideapad.mynetworksettings.com ([2600:4040:5301:100:5bcd:b7f0:d625:7033])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714cb55sm84777446d6.16.2025.08.27.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:53:58 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mmandlik@google.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 bluetooth-next] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
Date: Wed, 27 Aug 2025 10:53:25 -0400
Message-ID: <20250827145324.27180-2-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
changes v1 -> v2:
    - Fixed tag order

v1: https://lore.kernel.org/all/20250716004252.125466-2-ipravdin.official@gmail.com/

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
2.48.1

