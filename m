Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB63143879;
	Wed,  3 Jul 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006820; cv=none; b=F/0AbeYT7/XdgNSq7mmpzoU199Jeuul/2G7HeKVb09c+mWrZaOyg59Rtcpt4Fny+SHrnv/XgazJmilhTbXSq+M6/pL/UsJQ2Q7dPLrlmH29j9je0sR4D5immTaA7U/0EfUCNf/gdjR81V+sPbAlkaqWwR4FaciuPrU4AkHOL9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006820; c=relaxed/simple;
	bh=cf5FUF1pxBoZp2lEvP3kxfAmlx2YPkL72Aajcv3udiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owPP5VZ9Tof/yjzzPTFEEWwKNGCuFciePctg6nxeLa4rA73ISLtn6QcdLgl+O5TWPpUbhHI3Dpe2HfLsqXCh1muE+Egw0NysMMr8hndvWPZ5oNX26jwBRBZSqCO3U/tczBLL+XDB68t/zcXX6ZK0onVH6w3NIjBwIEhYVlhXDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5db7936b3so7228726d6.1;
        Wed, 03 Jul 2024 04:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006817; x=1720611617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93e6dTwFtrGIp7dWWNReuZoDgeAQuDgZQ4EBP6wdeKg=;
        b=tmRUFiDwhcggVGvJGUV3fU9FvDB+3DKToLh4o2gJWz/qGu+WUncAme/00CGBZv9M/e
         Kq6Uj/ZYaYru8HU2C4JwMMBUS4iKkWUCET2GkOlwEKsJAvpdjtX4g+p+IcQrjBFfFMM5
         cn24uiHudzKf/Vy3d6Cm7P6b3MNK5eJMFt0Wb5gB8IdTb1r6sOcnobtxCSMSB2giZeP+
         BaD5qKSDRc2ZXZu8JrslRbKRPN20IdGrNXHZM8hU+e4N2t2ninRPHJVodcZaXZxcCf52
         16NhGd7dc3k0VbpqA4SpE1gdgDZlDkOjxEphdDKRpp2exrACl6143iwiMp1rTsQC0hcN
         1hZg==
X-Forwarded-Encrypted: i=1; AJvYcCXKafpnrKgXJcJmn+U+3Y2t6+3UW/KmKwo+OVBBwKQoCv2jvvcR7zgSCfWgS8ByqeDKYucMcAPR+zffY3G/yvHGiSSVxmASmWnE1EnQqSbhmbScZPgD6eblvZBBm2pa2y6Ujt6EVwedvIv9Ycii
X-Gm-Message-State: AOJu0YyS8ueJKIRuZDv12jYxyAZYNrmHIcz7MCByP0V6Sw5/2PH+YfkJ
	eQK1y+jZYXB79GInXKdA6cMTrmpan2w4Loa4oZZeaABXxD4O0Z+f
X-Google-Smtp-Source: AGHT+IGXf6u2pEOGNTaTkt5wzo4SMKQq3gEuUu4qmCFjToxzeAw5evOv3eE+jO3ZFKELvMcgWIDXeg==
X-Received: by 2002:a05:6214:226b:b0:6b5:e1fb:68ee with SMTP id 6a1803df08f44-6b5e1fb6b8bmr16735356d6.25.1720006817646;
        Wed, 03 Jul 2024 04:40:17 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f2b77sm52921566d6.92.2024.07.03.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:40:17 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: 
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
Date: Wed,  3 Jul 2024 07:39:37 -0400
Message-Id: <20240703113936.228226-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dirty #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: hci7 hci_power_on
RIP: 0010:hci_read_supported_codecs+0xb9/0x870 net/bluetooth/hci_codec.c:138
Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78
RSP: 0018:ffff888120bafac8 EFLAGS: 00010212
RAX: 0000000000000000 RBX: 000000000000000e RCX: ffff8881173f0040
RDX: dffffc0000000000 RSI: ffffffffa58496c0 RDI: ffff88810b9ad1e4
RBP: ffff88810b9ac000 R08: ffffffffa77882a7 R09: 1ffffffff4ef1054
R10: dffffc0000000000 R11: fffffbfff4ef1055 R12: 0000000000000070
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810b9ac000
FS:  0000000000000000(0000) GS:ffff8881f6c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ddaa3439e CR3: 0000000139764003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 hci_read_local_codecs_sync net/bluetooth/hci_sync.c:4546 [inline]
 hci_init_stage_sync net/bluetooth/hci_sync.c:3441 [inline]
 hci_init4_sync net/bluetooth/hci_sync.c:4706 [inline]
 hci_init_sync net/bluetooth/hci_sync.c:4742 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:4912 [inline]
 hci_dev_open_sync+0x19a9/0x2d30 net/bluetooth/hci_sync.c:4994
 hci_dev_do_open net/bluetooth/hci_core.c:483 [inline]
 hci_power_on+0x11e/0x560 net/bluetooth/hci_core.c:1015
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0x8ef/0x14f0 kernel/workqueue.c:3348
 worker_thread+0x91f/0xe50 kernel/workqueue.c:3429
 kthread+0x2cb/0x360 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Fixes: 9ae664028a9e ("Bluetooth: Add support for Read Local Supported Codecs V2")

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/hci_codec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 3cc135bb1..5c98eec2c 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -74,6 +74,9 @@ static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 transport,
 
 			skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
 						sizeof(*cmd), cmd, 0, HCI_CMD_TIMEOUT, NULL);
+
+			if (!skb)
+				skb = ERR_PTR(-EINVAL);
 			if (IS_ERR(skb)) {
 				bt_dev_err(hdev, "Failed to read codec capabilities (%ld)",
 					   PTR_ERR(skb));
@@ -129,6 +132,8 @@ void hci_read_supported_codecs(struct hci_dev *hdev)
 	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
 				0, HCI_CMD_TIMEOUT, NULL);
 
+	if (!skb)
+		skb = ERR_PTR(-EINVAL);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
 			   PTR_ERR(skb));
@@ -198,6 +203,8 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 	skb = __hci_cmd_sync_sk(hdev, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL,
 				0, HCI_CMD_TIMEOUT, NULL);
 
+	if (!skb)
+		skb = ERR_PTR(-EINVAL);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
 			   PTR_ERR(skb));
-- 
2.34.1

