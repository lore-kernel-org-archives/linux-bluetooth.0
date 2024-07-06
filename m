Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CF1CD1F;
	Sat,  6 Jul 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720306415; cv=none; b=noJf+7dBNkpFgtxEX1F5kT3h0zvdVGcea+dQLE66utfdMgcJY2gXWusepWh3A8hVQr8PQylrgolOmvI3c6S43TzQ8xh9yzXOyL4MpNm7j0LrUMxoYraGMbxQZ5TPp5DOGAsW6NyTL5g0CYk4Fnp99k2O5G92/WTiIAzBS2MyBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720306415; c=relaxed/simple;
	bh=sTCz5uirL7eXcM8cyHm5sXS+VKwhP9ggmH4ENpftN3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXFc1S45W2URGqOuhwRXDMeyxJj1SSQQZaqEH797Pza+o5OPi4/M2hGOiqi4D8d+k7QpHFlVQGgpVKOHgzJg3mQdwUzP2sAa7MvJgkUi3nEdysLvuC2PtB3TBeC06UhC7tDf9jXNQ2bSpstTyNa8QcqkjnlwfrHuES1AO4NJT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447e02f3ac9so4921971cf.0;
        Sat, 06 Jul 2024 15:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720306412; x=1720911212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+5jRIYyiJr8mt/C1ZnzBA+FQ+W5BHlmJZfCDgBLnqI=;
        b=T3yFCtYGhSY8uv/V8ogRicP7PwdvPaRXYLT4xEarEPtrEf8JBU0G8D2SLvrw6iJfGD
         DvEh5qWvTRQ3hOIwNSr/+2lCPGn46kSQovsp7+g2eTBYDR1bNj12JdcXGMwYot+mGV+E
         I7qxOvoRDlsOZIb6t13hf1EtcsPSKsZQmicW40UBd9IDBQaqZ8xEYaOqjEEf8IAJ4Wq3
         Lg3Vb6oMlYdH0YaoSb2Oy9VaxdqLqIbw4G00cginSpE1wy0/EQAZSrAbaTwSd3PafFrT
         zPhpWN1t/zGMmdtrjCluiiKkguYdStZVPoiXa18orUO4RJIH1jYJ775nZD8F9Ngalx+0
         ZxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2OEHG8BFPz+JaeiYFgloAtaOMJxnYTNX0D5ePfIADSjbJt+vEw4riflXOINMfO21mZDSWObIE0yvZ3nlU7fUfGtmh3SlS/IQVJjduWpmCv9bErb27NXVaoNBv+cFafQxQKbOz6LbEF7S+tiJR
X-Gm-Message-State: AOJu0YzfRlTbLyiLhZpxQjww9f3COjLMabmt4HeYa+hH0GXBrEPRS2dI
	lvtiMsC7hqRztGmfGondCSmZ2y3VUkekxqULbvGnMrrYGIeWbTz8
X-Google-Smtp-Source: AGHT+IFEFwacMfBjL9nzRaaQiZqpGm7zhBIOnm2VQaaU/YYan0fRhhbOpZA2i9ajf7rg4Y1Y3qwCeQ==
X-Received: by 2002:a05:622a:1212:b0:446:6005:b824 with SMTP id d75a77b69052e-447cbefa746mr99364291cf.29.1720306412431;
        Sat, 06 Jul 2024 15:53:32 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447e04c49e3sm11106041cf.96.2024.07.06.15.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 15:53:32 -0700 (PDT)
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
Subject: [PATCH v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
Date: Sat,  6 Jul 2024 18:51:24 -0400
Message-Id: <20240706225124.1247944-1-iam@sung-woo.kim>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__hci_cmd_sync_sk() returns NULL if a command returns a status event
as there are no parameters.
Fix __hci_cmd_sync_sk() to not return NULL.

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

 net/bluetooth/hci_sync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76b283b8e..c4e4abc6e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -201,6 +201,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
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
@@ -250,6 +256,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
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
@@ -257,13 +268,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
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
2.34.1

