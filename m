Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D31ADFFB;
	Thu, 17 Jul 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726781; cv=none; b=FHWj+CDCFKxsuXxwILmXYERKHoJrhH9ZmXR/MGbLQK53aQqDPq52oEN6dG/tTWU4EwCTag0zDgKH83UVXsMgQkhm7DE1p1AyhQppQlif1BZjqMFe4rbBj7hD8k1nVMOpl2NSDYp5Gp5LsxCwiJG4YLFLuHI+dUPFJ5tF+GCrudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726781; c=relaxed/simple;
	bh=xIe+GaLbQH9j9IBxovCTUSVk2jO2RsMWCxhDV1lJuC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PQdrnw2Ujl1paIvtQB8J5GOnwU2324nm6wPqkqo9dC+60WpijZIeNwymv4OU6Q69Vm9V6aAGJoSMwAkAr1ApfkdizMT6HR51e4qLSybTTUWQJqf/zbSGq0bOgcWSNsc5f3KqGCcLkt8JGt27sDIY6WwAFpe0Hl2qF6CVh6r/LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD5NY8E7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD5NY8E7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23e210ebd5dso11984195ad.1;
        Wed, 16 Jul 2025 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752726779; x=1753331579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+EaMkLgPPS+jHiBOiWAtmCkdRdrXcYkx+yZAl85pTAo=;
        b=RD5NY8E7wqKqvnpV9WkiBYnkTsALv0jKMKswmtu+fp5HXDTasnFrAgNut8L9t5pCpd
         PvFKeCoVnDSUcd1zPFneFYU5uJiUuV0HbdVrjFLgJJNWWGCiO8biHoQDDKWRLOzFuxz2
         U9PgHZZfYQ68VO4kyp/ECVun8ZzhJV0myQq41C4Ts+JMeG3YgmCS+wdgdKURq3VJPmq6
         6Cl88QMknfPUsaGgU5xaZJuBfM1F/74yrpr564q0K/V/KPMcbn8F0JMXzGIyBz+kvqxd
         SiWzqziu98Q5Ix9H547+DFtcr9r4OIfnu+IqUPazTGsY5ISJJ39rjZEmqQuy9Y4Jc1tG
         S65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752726779; x=1753331579;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EaMkLgPPS+jHiBOiWAtmCkdRdrXcYkx+yZAl85pTAo=;
        b=R3M6LSjzWRyLNWeM6IFUPzqaTlpXtS1A0aTskrs3GuqYu4FBiyT/xqKWwXRheSm36i
         lfazBGV0v/wFpnkzGdLj6zw8CNYllncKzNDy7x8qaN3dPOssYaFbC/C80cHihlaSMI5o
         /cWOooLi9124bQlcQ3d0G/yh2SJ4u5w0i1H4LcYmhUitm7pWKGwkkASViCziAo/MvI7s
         /UqpWL1Jjpom8P2rZGYGqj5Bt5V/lkV8gnVs8gu7Qc+UYM70v4lzuYOQCmFWqBvHMgAq
         pKXsz768e5v9fPODHjbDV/uyrjVO95pEn9+VGVIF4yd61T+FIyuCRD41wiST5j3xEUmi
         vFyw==
X-Forwarded-Encrypted: i=1; AJvYcCUn4sAETXVg4VLhDq7gX5l/5nWfpahTCEaWjGX6efPAlCShcgqiAMqfovoHarmBhCrpAbPz7bn9wQpN3v0pwyc=@vger.kernel.org, AJvYcCXSJEmLXeCWd0GYgOWahYjW67DWZFC7BEKjaAXIGYKEujoZuxjKXZ0Iq79EACaPNpt00VeEVSlkL05elb/X@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWzz0cDhRW720zwZKDXpIbHzwL4I3wrev7YhEEcT3hz4lF3Wq
	u1bZlVTLhY5im8byQBFNUWYEllmeeeJh+V0MDVV1657i2cm7BeHhITtK
X-Gm-Gg: ASbGncvW0tB/XVRQLL1v/WVYLBhab1flRXv1j8jRVW2SmTMpVrRJdGCzDISj72SZl1B
	aC9jA5oyYpMS2Izij/QQPTCNEiNk31+hYsOsRgjT1R2nDXOhOglGYQYeO8YpqZj44PDSMaqsUU9
	3ewVeA7UKjHi1+jYpQfjm0ej0+Rd/KMjSvSwCJApeZLe4fhIS3Y/M7ZsOaKYRMtkLIb0vLfqoq/
	oUoGQuXYy6ylqjcScnKQvfGtGQpXbx2d6K0hAnexgpmhyMnMzUvjmDHsuiaagJJu7Ox5mj3Fp1t
	mYdAUMKso7tThYSJMWqAMqeww09s9hhSEgIOiB6U6F6wQ6dbUIPbn5Eima0JhRP9rxiHRT8fvIu
	aAgPZJ0jlwUiISAZEKsCqTM7QTEoLmEnp20ynOzdbeL3OjshQ
X-Google-Smtp-Source: AGHT+IGc4xAAIxg8OMZwMvBJ6uZwLd5MzTB/bWLEbrJYMwjkm3T0wmOtz4phve5rLtVTGx85h5EmUg==
X-Received: by 2002:a17:903:186:b0:215:6c5f:d142 with SMTP id d9443c01a7336-23e2f744c24mr25770545ad.20.1752726779302;
        Wed, 16 Jul 2025 21:32:59 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:9da2:46a5:b508:3b9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e4acsm134040105ad.183.2025.07.16.21.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:32:58 -0700 (PDT)
Date: Thu, 17 Jul 2025 00:32:56 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in
 hci_devcd_dump
Message-ID: <gkct6i53onzjuzugsor6pnrhjfef7trwhgbjrgfie25xirebhp@dpqxvkguqdnf>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k2yjmnwji4apawbb"
Content-Disposition: inline
In-Reply-To: <67ee633c.050a0220.9040b.0187.GAE@google.com>


--k2yjmnwji4apawbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test

	Ivan Pravdin

--k2yjmnwji4apawbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

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
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..720cb79adf96 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 
 	size = hdev->dump.tail - hdev->dump.head;
 
-	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
-
 	/* Send a copy to monitor as a diagnostic packet */
 	skb = bt_skb_alloc(size, GFP_ATOMIC);
 	if (skb) {
 		skb_put_data(skb, hdev->dump.head, size);
 		hci_recv_diag(hdev, skb);
 	}
+
+	/* Emit a devcoredump with the available data */
+	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
 }
 
 static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,

--k2yjmnwji4apawbb--
