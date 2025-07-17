Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60218FC86;
	Thu, 17 Jul 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765110; cv=none; b=rWIEEobnwhahV1OyUsfJqQhoqAGlQtitWr0TT49wE3N1+YgYKuBWOHxyYiY9BOnh6BASskEsWoHGz/B3ygr3hxVKsAmdsu9xgKZOqTbgkLMyxhKYOPuK9p2fu8QfK9fHVbZLZWeVNSZFUyzP4DbwoCdeEWz+RwQvLdz4sccU6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765110; c=relaxed/simple;
	bh=RfvJAbGcoePDrvUo8SG41VwGoiTa7Wy/weJXB8JvzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qb1iFuo0a4FV78GX056jP0WpkksmxvaaSv9KmiZ/OZajRekUBgKZJrIOcTY4I4R/qSRJ1kWJktfN9zLszjdQ69JdFAKHh1CeNdZbbMEIlxc2LxOQGi6tlyUWY8uXgMXtLtwF9J+wO0+9xdDjfjLlSw2bPEKE4cDQjXWl3BT5LMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sco8B/X0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sco8B/X0"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so919573a91.2;
        Thu, 17 Jul 2025 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765109; x=1753369909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mhv/Dq8Lxx9kqyTK+rpaOCeKirx9sGRLXSClbZRCh0=;
        b=Sco8B/X0BeXiojSGlo69ASwf+4dk971X9YT9Ue3F+u7M3D9KAh7+qkG2h+8B0ZxNZO
         CUs6eKM0hwuYGexasuPtrMQA+l2BR49iNPO+gXbTXiZFjywsKILOYRC9LctROSwMMANC
         yf1LvxQ3rK/2pYdYRhDy87T7jSZhSxTD2qA9KNUBALVBsWc8/vWWKoE56B4ucLvSHrhY
         0F1evgErrLIOvn74UrJlL6JsuRAb834VMXqZUYk0rriTcsw/V2QgBcOBwokpgn8ghOsY
         rFZGPthR0eNTrKV7ZUGNMuz9/xuFqdXvG8rS8NQdr/GGOdfr8CGCDiLLKopq07LZHoyd
         5wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765109; x=1753369909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mhv/Dq8Lxx9kqyTK+rpaOCeKirx9sGRLXSClbZRCh0=;
        b=K+6IpQyTotF++KTLzS4ARxlqnml4PIDkWSAFeD+wcOFvdIKgYkOfzxiZgBaxzn0fMQ
         9Z9IqMITvJy7/oJPSi1S0hpvey6Api+UITuv7T57IplgM+IaFY+yvtyD9b6RDyKdYRQs
         IgrFvEQQ9uIIc5FnW/uuG/2AmXFAsmfQXNZpLqna2bKFC+VxMZOMo44/LU34b4ThlajX
         3EVt7MCZ+zPtif2q/o1JhHc5ZO22hJmzds3/xRYDcMykVxJb0cucoSPYbyztszhsVsWF
         xK8paE8qg5QmujQtwXNGGL5VFx/2Pn/vKqyDhMfT+UaEJ3KQb76HWuBeU1wS6/P0vPpD
         vpxw==
X-Forwarded-Encrypted: i=1; AJvYcCUA0gmS5joInRYEHBZaBdD6R1Q5R7UBZd74AAbbt3F2yvyOmVgjUB63PC995OmpVIN2lY5gacZwez6ttjSZ@vger.kernel.org, AJvYcCXSU69UjIKeQoSaizpXj3KOppNu2w4UWBbQsGSRQ7l9G90lmjABRuHI9i8uauBXjA51skah5uR/GET+Um6TKng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBz991fsdsv8C5+aY+dikPjtaHH8Y94X9pytnAABmMuoli3l1
	0xXPTrnkSPTabaa7TZTHSEsTWIb/UeFirvCgdAHwYoXFd0/EuH4bH4Qz52mpLCXh
X-Gm-Gg: ASbGncuhLrDJ+nvKW3Z0MCLq6oJ2lQ3qRFXID86hE1F7K/vjViuriaz00DjI6JqMO3f
	SUX1qLdaJL2A+dTm7+eUzmPcC6wmLnLOV4VrO0nbSLNJ8YlhO4jlU/7bSO2MbPdPIjp/loNFjHR
	6WxSIsKIlImaqh4TO2tUTk8USiuSwocaUSsUamjy1fcHjYrxsGwpFiscTyMxDPsFaN6I9ZoNlwF
	tFfRE0+5MYGVzZ2WUeoze0DKgvQdkCcFamk6Gd0lV6p5Yo6H1sl2od9yuXZvDNrTFDe0MqZHIuC
	oeRuLx95GWPhv/94XAbJNEFUJiE9ba6cJQxR2j3XzhISAUNpyGkA8ZoUxdA5i7vEmI9ux2Cvpk3
	dXJiEbO2AAHL8m/CyqK8zSiuKw0xg229swHqllF4eu3Lpcd/Km+gwaxEf3XZtPRauQwjLyBnX5q
	Q=
X-Google-Smtp-Source: AGHT+IGEtiT/Xk6voUrN+8xLP8T2v3jP5vak5oA9+oMU3uzh4q0axPU3LGQNJYEetePB95PTQpuyMg==
X-Received: by 2002:a17:90b:28c4:b0:311:e8cc:425e with SMTP id 98e67ed59e1d1-31c9e78b707mr9701248a91.31.1752765108294;
        Thu, 17 Jul 2025 08:11:48 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:cedd:b9ca:8b99:e839])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb5cb3f98sm1245049a91.43.2025.07.17.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:11:47 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>,
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv
Date: Thu, 17 Jul 2025 11:10:52 -0400
Message-ID: <20250717151051.195106-2-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently both dev_coredumpv and skb_put_data in hci_devcd_dump use
hdev->dump.head. However, dev_coredumpv can free the buffer. From
dev_coredumpm_timeout documentation, which is used by dev_coredumpv:

    > Creates a new device coredump for the given device. If a previous one hasn't
    > been read yet, the new coredump is discarded. The data lifetime is determined
    > by the device coredump framework and when it is no longer needed the @free
    > function will be called to free the data.

If the data has not been read by the userspace yet, dev_coredumpv will
discard new buffer, freeing hdev->dump.head. This leads to
vmalloc-out-of-bounds error when skb_put_data tries to access
hdev->dump.head.

A crash report from syzbot illustrates this:

    ==================================================================
    BUG: KASAN: vmalloc-out-of-bounds in skb_put_data
    include/linux/skbuff.h:2752 [inline]
    BUG: KASAN: vmalloc-out-of-bounds in hci_devcd_dump+0x142/0x240
    net/bluetooth/coredump.c:258
    Read of size 140 at addr ffffc90004ed5000 by task kworker/u9:2/5844

    CPU: 1 UID: 0 PID: 5844 Comm: kworker/u9:2 Not tainted
    6.14.0-syzkaller-10892-g4e82c87058f4 #0 PREEMPT(full)
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
    Google 02/12/2025
    Workqueue: hci0 hci_devcd_timeout
    Call Trace:
     <TASK>
     __dump_stack lib/dump_stack.c:94 [inline]
     dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
     print_address_description mm/kasan/report.c:408 [inline]
     print_report+0xc3/0x670 mm/kasan/report.c:521
     kasan_report+0xe0/0x110 mm/kasan/report.c:634
     check_region_inline mm/kasan/generic.c:183 [inline]
     kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
     __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
     skb_put_data include/linux/skbuff.h:2752 [inline]
     hci_devcd_dump+0x142/0x240 net/bluetooth/coredump.c:258
     hci_devcd_timeout+0xb5/0x2e0 net/bluetooth/coredump.c:413
     process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
     process_scheduled_works kernel/workqueue.c:3319 [inline]
     worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
     kthread+0x3c2/0x780 kernel/kthread.c:464
     ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     </TASK>

    The buggy address ffffc90004ed5000 belongs to a vmalloc virtual mapping
    Memory state around the buggy address:
     ffffc90004ed4f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90004ed4f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    >ffffc90004ed5000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                       ^
     ffffc90004ed5080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90004ed5100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    ==================================================================

To avoid this issue, reorder dev_coredumpv to be called after
skb_put_data that does not free the data.

Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
Tested-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---

Changes since v2:
 * Updated subject line
 * Updated comment to include more details about the issue
 * Moved dev_coredumpv instead of using temporary buffer

Changes since v1:
 * Changed subject prefix to Bluetooth:

[v2] https://lore.kernel.org/linux-bluetooth/20250716003726.124975-2-ipravdin.official@gmail.com/
[v1] https://lore.kernel.org/linux-bluetooth/20250614041910.219584-1-ipravdin.official@gmail.com/

 net/bluetooth/coredump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.45.2

