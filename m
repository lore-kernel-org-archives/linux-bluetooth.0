Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954843B14D4
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522292; cv=none; b=JE9KKuQumwDgcg8TEEi/DqmtdeirpPGeb5MGzsX42nYHTjvzmPZlRztbe5JCvDyB1jTSx5ssORnFzcEHoHBIvunFrzGQTuTh+UXb4KZ1e7mO9G0kaKzswcOb2xMOhShVhS5dy3yO2Qv87LzVC6mwayctnNhI6+PJv2M0z/iokrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522292; c=relaxed/simple;
	bh=5418uiOZIrLw7XAMLKFEISPaEYLaJyb7AMmk0UyzmFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8LOi5aV/9WISe+4ZcwUrgc/c3tgLh0IciY5+aFN2sGNSVzBhqwgB9RBOh5iioZxzRvjgOA6pcXKVqe//hhcp6KZcPOqeJOW9eYRefkLvJ2c0kHCKrA5lO1W/HW8GGbNPy1WfGFwGURX6k2e6fnyIUuPoifDpPku//0QJ8n3Fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e966lpqa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e966lpqa"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533324e9b13so6954361cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790522288; x=1791127088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YkF56u2AgW7HxdpJaZzO7aMu9gXdkeZxABmnu9ytFjo=;
        b=e966lpqaUYd31BhRPp3LcYymGp2NFIRsuhxZXfBkUMShRGeAv4aXZjjfNZIncK5d5U
         2Aq8xlBYlWqZIgBWhZ1WrWlh4JQT21jH3/dgOAQOqpWPE/I68porNVYTk+ah/kqETioT
         u5KwRCoZialFo4btCBM0EEGZFhITKGKHIIN98YHXMEkqBddFMTdh2V0LDPWcbhLWBcbn
         89EzNY3SIj0Zp6Y0om1aOJc0FVklHWMB4njcuafS4hjw2QBjWfdiwx4kf76cB50UoHy4
         kDR7bgmoD+6NyfZ4Z1QlXhx6mIFLlwCdoXV3W24KjIuYvElXZX2JpjYwxiX9AXKzHxFC
         FCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790522288; x=1791127088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YkF56u2AgW7HxdpJaZzO7aMu9gXdkeZxABmnu9ytFjo=;
        b=tKr5yvMPbne6lmOx1131dXfNRxo6gc6IMPe77UMOusk4JaVhIYsvyF5znT+C2sQKt1
         ZMTe+wqcUGUDu49Iqxuu6ofZB8ijsSYKmtjmB65YhPbeYm0LGzTwpoONKZKZjcj5CXTM
         PsEbf9rYxdiUymX6jPV8/Np++2Y/gAgsxlo+DmtCTHsmbKDA0nuaHn2Hxm4/0YA9D0wm
         fpRBWStWI3fp1hAT8Ypk5PI1JB7Yae7VmIdZEx6I+t+lyrDDQTfcqLBK0vZK2YxkT+mc
         UHmCsXfO/XohVSJ3arXPIuw80ew8yjrVxZrtB2ISFYv1ILMs8QFdufP1iCGlPHcADg3W
         qhZg==
X-Gm-Message-State: AFuF++maUTfCkBFC5U4dSq1t5Du4Z2V7iaAiSAi9fwVuwcG/mxnlPMLz
	19oPDkROPJZOUpc1upy8BgEV8TxeZxUNotWVlmr8pCXd1BppgnLQ2BiO
X-Gm-Gg: AYBFou39dviUCKdmr4i0OPrPU7nujOyDxEdp4hr0NHyuUWn0zz2Duq/qfTcV09Cc5nZ
	c3HywdyM3uN3M4m7BTp6N4BdIQtHkIQaRwRM/bwyzG654yVX+rLM4mdBfpoLnoread4omB5hQBA
	OuGyH/t+acTT1/CpQJHnsGIf1ooaUAAa0IWj/tXEfSQloerCrn6c8xpF5PR5EK2F+RfOOPPU/+3
	jW7UhxbXVUDB29gDxaLLpvOQ5MhDBhWIChQUNcoqQUqj/8hnDnQqwsc0wcwzN3uRW5X+bk6EOEY
	c3jYp3WWQr0oqwlJL7FT7oXiCsn5eU1/Kqpe9RnZgGqRW9+enYpgUlQuTC5+/FBGrzPZeus53ke
	8zZD0xCOU5FUQOq/0FEGUvAPZiMFZ1pGR1k81zY/9+Xwh07teRnF5HgC88CN1Q/vBQX/VaEpAKY
	cw8+4nQFCncyk22jivFtbDPs2gKupdQirdh8r8VyhD5kzk8OyNjyh34nMHBie8aP+wdwogmw==
X-Received: by 2002:a05:622a:134a:b0:530:fbd3:2038 with SMTP id d75a77b69052e-5330b6b0db8mr162099471cf.26.1790522288303;
        Sun, 27 Sep 2026 08:18:08 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7ae0:50::3d0:69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322132ef3sm42669271cf.10.2026.09.27.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:18:07 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister
Date: Sun, 27 Sep 2026 22:18:02 +0700
Message-ID: <20260927151802.13619-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_unregister_dev() disables cmd_work and cmd_timer, then calls
hci_cmd_sync_clear(), whose cancel_work_sync() waits for
hci_cmd_sync_work() to return. That worker dequeues and runs every
entry on cmd_sync_work_list. With cmd_work disabled nothing reaches
the controller, so each queued HCI command waits the full
HCI_CMD_TIMEOUT (2s).

The backlog has no bound. Userspace can keep queuing MGMT commands
such as MGMT_OP_GET_CLOCK_INFO against a controller that doesn't
answer. Closing /dev/vhci then blocks in vhci_release() for
backlog * 2s:

  INFO: task syz-executor:5749 blocked for more than 143 seconds.
   cancel_work_sync
   hci_cmd_sync_clear
   hci_unregister_dev
   vhci_release

In a local reproduction the backlog held more than 5000 entries,
which comes to hours of hang.

Stop the worker from taking new entries once HCI_UNREGISTER is set,
and wake any request still waiting with -ENODEV before cancelling
the work. The entries left over are destroyed with -ECANCELED by the
existing sweep in hci_cmd_sync_clear(). They stay on the list until
the work has stopped, so hci_cmd_sync_dequeue() and friends still see
them. A callback already running may still issue another command,
which delays unregister by at most one timeout per remaining command,
not by the whole backlog.

Fixes: 008ee9eb8a11 ("Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work")
Reported-by: syzbot+217e3f1283cafe80586e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217e3f1283cafe80586e
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Notes (not for the changelog):

Two reproducers were tested on QEMU x86_64 with KASAN and PROVE_LOCKING,
on master @28c5139761e5 (v7.3-rc2-1134). The patch also applies cleanly
to bluetooth-next/master.

 - syzbot C repro (converted from the syz program): it loops on
   MGMT_OP_GET_CLOCK_INFO, which queues HCI_OP_READ_CLOCK.
 - The repro from the cause bisection: it emits LE Create BIG Complete
   events for an unknown BIG, and each event queues HCI_OP_LE_TERM_BIG.
   That queueing path is why the bisection landed on the ISO BIS commit.

Each run lets the repro go for N seconds, then SIGKILLs it and times
how long it takes to be reaped, i.e. how long vhci_release() takes.

  unpatched, both repros:  still blocked after more than 10 minutes,
                           hung-task reports every 20s, same lock
                           state as the syzbot report
  patched, both repros, N=8/30/60s:  reaped in 0-1s
  patched + debug print:   backlog of 2641 entries (N=30s) and 5260
                           entries (N=60s); hci_cmd_sync_clear() took
                           1-2ms

No KASAN, lockdep or hung-task reports on the patched kernel.

 net/bluetooth/hci_sync.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 74e2b04c84b2..e41fc1427d34 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -312,6 +312,10 @@ static void hci_cmd_sync_work(struct work_struct *work)
 	while (1) {
 		struct hci_cmd_sync_work_entry *entry;
 
+		/* Leave the backlog to hci_cmd_sync_clear() */
+		if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+			break;
+
 		mutex_lock(&hdev->cmd_sync_work_lock);
 		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
 						 struct hci_cmd_sync_work_entry,
@@ -658,6 +662,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 {
 	struct hci_cmd_sync_work_entry *entry, *tmp;
 
+	/* cmd_work is disabled, the pending request can only time out */
+	hci_cmd_sync_cancel_sync(hdev, ENODEV);
 	cancel_work_sync(&hdev->cmd_sync_work);
 	cancel_work_sync(&hdev->reenable_adv_work);
 
-- 
2.43.0

