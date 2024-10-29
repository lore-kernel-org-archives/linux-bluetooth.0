Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE720606D;
	Tue, 29 Oct 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231256; cv=none; b=YSck0yQqd5SyiV6sPz3Vu+sooonsbh//qcjVIPtcVT908BUfIzycMJ4uoCo3c36jBibNS94G0n2V2Kn0gLPUDnXnu+AYIV4E0S6o5JoZzxc4+ELdzHx2h5d5XPUYig0QNDu8Zvo9/kN5YncpMLhqDZq+7ozoikdc0Rwo+9zIf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231256; c=relaxed/simple;
	bh=3cZeqCLHBMhECRg9kEM70AUFfXRiDjWGNpFY4l/a1gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckUM3R9uPd+AyiyVFLv6jA+1tjd7RlSE/xVMOR658lzQcUDrK90yczzoq0e827LGhG4lq5tgNNXeZtcnUffC5KPjA1mfE7PpVrS4MLssNIoFwXYC7I7S6vOR+cSlQC7uXYUhkAtzj4hvqlIUXsI1IjFSOPxPkQOIu/5V0a6F/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea11b32ab4so1981477b3.0;
        Tue, 29 Oct 2024 12:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730231253; x=1730836053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSXt0bPWptzeFjc/V3fxmhGgzYcRQVIhaPLOnFaRxT0=;
        b=po9qOh0WdZmJvgXinsAxtdaJ+yhUQip8pZnxtAj7NojpC3TIgN6emBacyuM424GZi6
         AN1aSmN4QnvznS0cmr9/xhdHhadUmv8+RBLEtGj3hTR5i4Qd1t/6HESWa7pBzL7DvBP/
         vtrlEguMLTfdHflfFWWrn7PQT3pORPXGo71m1bl6iEqs36VbEbKMuMd42m19iMwraEY+
         pGLMTbKdZpC5on/7oxBmdsVD/223lT0w0EN/Y1whfTwIEoQapv5Lt2kYvLgsD8vjk9Wv
         I3GhNzz9zGkxbdFlYhvW3O/sXqLYJF6GgIwVKesg6UuFmw8Yw3HQclzZDVLUb5fEgnTI
         yELg==
X-Forwarded-Encrypted: i=1; AJvYcCUSR7oTVVUiegvhXYy4Kfabtfz9Gf8koBXShVotwJFcCL3+Ogeuoh08c/l6u5eIuOS42Tuz6JJYnvURMMFu7CI=@vger.kernel.org, AJvYcCXe4k96/7pAMOzAJF4yuTwHIFjct8lip/dBCbaBA0TltE1WcFoNtZ3/5u5x7/218uOVgmxCuxqP1cga43qt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Y1sfZMAfqLUJAZI1WGsscaFb3yLH7IWaMvJAIrdnZLGFqaI3
	v1Y0bR/FN9EXAs9C4M9sutjaVJ+BvCOgtxVpkG2Z5m0ouKO/VPp5
X-Google-Smtp-Source: AGHT+IGESn08yCct6swgl0EFfH1Gdg2/NCOl3miUz3hNf2Zg1dK7HiEgZOHy2IiC60OrHIASBCfgnA==
X-Received: by 2002:a05:690c:f93:b0:6ea:1230:2467 with SMTP id 00721157ae682-6ea2bf552f8mr28322007b3.2.1730231252732;
        Tue, 29 Oct 2024 12:47:32 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6ea1229a15dsm9425967b3.136.2024.10.29.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:47:31 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: daveti@purdue.edu,
	benquike@gmail.com,
	Sungwoo Kim <iam@sung-woo.kim>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
Date: Tue, 29 Oct 2024 19:44:41 +0000
Message-ID: <20241029194505.2094645-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix __hci_cmd_sync_sk() to return not NULL for unknown opcodes.

__hci_cmd_sync_sk() returns NULL if a command returns a status event.
However, it also returns NULL where an opcode doesn't exist in the
hci_cc table because hci_cmd_complete_evt() assumes status = skb->data[0]
for unknown opcodes.
This leads to null-ptr-deref in cmd_sync for HCI_OP_READ_LOCAL_CODECS as
there is no hci_cc for HCI_OP_READ_LOCAL_CODECS, which always assumes
status = skb->data[0].

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

Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVERY")

Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
v1 -> v2: make __hci_cmd_sync_sk() not return NULL
v2 -> v3: elaborate reasoning

 net/bluetooth/hci_sync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9482bd562..c86f4e42e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -206,6 +206,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
+	/* If command return a status event skb will be set to NULL as there are
+	 * no parameters.
+	 */
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
 	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
@@ -255,6 +261,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	u8 status;
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
 	if (IS_ERR(skb)) {
 		if (!event)
 			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
@@ -262,13 +273,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return PTR_ERR(skb);
 	}
 
-	/* If command return a status event skb will be set to NULL as there are
-	 * no parameters, in case of failure IS_ERR(skb) would have be set to
-	 * the actual error would be found with PTR_ERR(skb).
-	 */
-	if (!skb)
-		return 0;
-
 	status = skb->data[0];
 
 	kfree_skb(skb);
-- 
2.43.0

