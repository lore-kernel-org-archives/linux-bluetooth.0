Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B130DD11
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231217; cv=none; b=gUThsfMhkXpF41AqqF3gSLvuhARP77TwaJsh4YjpBkmMXTMTYv3EAVSE7bpTx8rqkIElODQ3e7BV719m3sDgcumF3u+FH2U2SrakebAgxHp9Uvlt5irFfkaufTOIdorrVeh10u8Q08Kg1iMo+aUWVZYaY1y6gD84QuAYPS2LdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231217; c=relaxed/simple;
	bh=mqKNJRkfAlKUqRVH2cfSksLX/YmAVc8fM8MaLA7N52w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fLEqHvYIJJ1d40chTXgw5dnaJfnNfAeAV9+9mW3jcR4+PlEEWph7kPh7uG7iBws1yqBxPgzmwx5fPdcVTSwwyz3OAfoMydI+D1jzQCA/ErRxthL8iVvQAwZQEqqQxh6zUtgfQNY2t0vwASuQkYxDT4OMOiqgXdtWRC4yeQgYlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXRj7A6r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXRj7A6r"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so113615ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231216; x=1782836016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkVGxnxspHuqAovAYwUnBg1/tuXYyLAM387SHWuJlmQ=;
        b=AXRj7A6ryL5i3qmQohWrj47zShRpb9M+I0Gl1GljFnSvf2rq3cTSchQNzduPjd+Av7
         n4SU5lGs9g6aXLUsapNstjKJenXi+lTGEQ++sAq5XLWDrXALWARix2n7HpL17TfrCybJ
         Gk9iUFLsJIJH2zfHLyzuX6QDuSJkBYtEK/OCYVxwGdj76ZBMQyJYi+y4FtyfP/aswKEy
         hZG1lBVAtzWrqASWyH4h6K19PmvvCBifP3ofX5Yhusxuq8hPjhwcKCAisl+htbQnGV1x
         20qe1zSwQUmTPKJ8Wn045andTvJWmD3GF7bZw48T1b+T7HucEcerKsfd5TKLkuCVNrFU
         20Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231216; x=1782836016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkVGxnxspHuqAovAYwUnBg1/tuXYyLAM387SHWuJlmQ=;
        b=Ir7o0o62RRFbjyQi0ljYM60n+c3Hz+58a4V75PBAiqrgMjIPt/cPDGksmV9j/OWCpq
         YtJjhk+0G/qzmEHckQ+VHR3QmEYHOQmJ8ckJyRj9h1BThoX1JR1miJ7aHbzWnEvaYw5j
         aqHwiBjV89dcONVQHy3eR5HNkkfZHHpb3Sul2ESBRm7a0rpn/eD+DM5GyT9FwCO7fA4u
         R7ifQkHu4PsDV0ZOtKpxGwEvu4OWCwYGeZ247XznleggiJeB6z7q9jYETDBCM5U2uoj7
         qOtJp3JoyQQeVgP7DwY+HTjaZrcsB5xmnfFoyze0hzcs/3pdfpUVG7nCY1N7BEXjtpYG
         I1NA==
X-Gm-Message-State: AOJu0YyJquGuqFDeKn+kf/SkWMZavusEtKucf7NenOueX1UBc4o/3KYH
	FWMTuDwzLJbGzQPy5iLuMxWOoaG6wmZONX1POE+f+l46WRA51vS/okQz
X-Gm-Gg: AfdE7cmSst6MhuytZGR9vOlolFgz/3AqnkJTF2Apf2dgBW2AB8oyzaE+vyCaie+5tNK
	Fz8QYRxW6rbCGEK2HIhnIBfYiBWNYyUfLfQbTztehst3LdPxlcfpBpDd4XA0GlmuYLHtsR6GK9B
	Zm4xd36X3X14+k0R8NNS+MaU3Qp0qQ3kgjoHZqDzs5PxomOZF4YgHO95smY1bUmlJUgoSCKjUuQ
	NIh7SXZIEZDqnUA0kAR9d6owFL3jfUXaCuSXPNu6RFtVyg1H05+oSHqjr73cGrAIizY2UXV2EAG
	flxmzrGUKN+GViqU/dNowkYn/WMw8lYzBM/qw9f8hgrgYJwXwJASEJ6nmG87x8kcw4jFtjGb09E
	3+IaCuOWFaYeS2STFGb8XU0uaptB3O1m7/3RxuqXFW1BVUBr2kjeK1Hg4tHVzIpzEOEcUd32ZgM
	o84WZSo8A=
X-Received: by 2002:a17:902:cf08:b0:2c1:ef9:450e with SMTP id d9443c01a7336-2c742b3e132mr156591665ad.27.1782231215325;
        Tue, 23 Jun 2026 09:13:35 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7435bad30sm113237435ad.12.2026.06.23.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:13:34 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: Fix adv monitor add failure cleanup
Date: Wed, 24 Jun 2026 00:13:28 +0800
Message-Id: <20260623161328.2177234-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_add_adv_monitor() publishes a new adv_monitor in
hdev->adv_monitors_idr before the powered MSFT setup step. The MSFT
offload add path can then fail either locally before the controller add
command completes, or in the MSFT add callback. In the current queued
management add flow, hci_cmd_sync_work() still invokes
mgmt_add_adv_patterns_monitor_complete() with the original pending command
after msft_add_monitor_pattern() returns.

The buggy scenario involves two paths, with each column showing the order
within that path:

MSFT add handling                  MGMT completion
1. insert monitor and handle       1. receive sync error
2. send MSFT add command           2. call add-monitor completion
3. callback sees bad response      3. load cmd->user_data
4. callback frees monitor          4. read monitor->handle

Local MSFT setup failures have the other half of the same ownership bug:
they return an error after the IDR insertion, but no later code removes the
failed monitor from the IDR.

Keep ownership with the pending management command until its completion.
For normal management adds, the MSFT add callback now records successful
controller state and returns errors to its caller. The management
completion frees the monitor on non-success after copying the response
handle, while resume/reregister callback-error cleanup remains in the
MSFT callback. The success path keeps the existing bookkeeping.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 ? mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x19f/0x330
 ? mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]
 kasan_report+0xe0/0x110
 ? mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]
 mgmt_add_adv_patterns_monitor_complete+0xfb/0x260 [bluetooth]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? 0xffffffffc00d00da
 ? __pfx_mgmt_add_adv_patterns_monitor_complete+0x10/0x10 [bluetooth]
 ? __pfx_mgmt_add_adv_patterns_monitor_complete+0x10/0x10 [bluetooth]
 ? hci_cmd_sync_work+0x1ab/0x210 [bluetooth]
 hci_cmd_sync_work+0x1c0/0x210 [bluetooth]
 ? __pfx_mgmt_add_adv_patterns_monitor_complete+0x10/0x10 [bluetooth]
 process_one_work+0x4fd/0xbc0
 ? __pfx_process_one_work+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __list_add_valid_or_report+0x37/0xf0
 ? __pfx_hci_cmd_sync_work+0x10/0x10 [bluetooth]
 ? srso_alias_return_thunk+0x5/0xfbef5
 worker_thread+0x2d8/0x570
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x1ad/0x1f0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c9/0x540
 ? __pfx_ret_from_fork+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __switch_to+0x2e9/0x730
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 471 on cpu 3 at 285.205389s:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 add_adv_patterns_monitor_rssi+0xd5/0x230 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 __sys_sendto+0x2bc/0x2d0
 __x64_sys_sendto+0x76/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 454 on cpu 2 at 285.217112s:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x313/0x590
 msft_add_monitor_sync+0x54a/0x570 [bluetooth]
 hci_add_adv_monitor+0x133/0x180 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Fixes: a2a4dedf88ab ("Bluetooth: advmon offload MSFT add monitor")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/mgmt.c | 2 ++
 net/bluetooth/msft.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd0893..e5403c58a957 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5375,6 +5375,8 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 		if (monitor->state == ADV_MONITOR_STATE_NOT_REGISTERED)
 			monitor->state = ADV_MONITOR_STATE_REGISTERED;
 		hci_update_passive_scan(hdev);
+	} else {
+		hci_free_adv_monitor(hdev, monitor);
 	}
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 2f008167cbaa..d7badce8746c 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -291,7 +291,7 @@ static int msft_le_monitor_advertisement_cb(struct hci_dev *hdev, u16 opcode,
 	monitor->state = ADV_MONITOR_STATE_OFFLOADED;
 
 unlock:
-	if (status)
+	if (status && msft->resuming)
 		hci_free_adv_monitor(hdev, monitor);
 
 	hci_dev_unlock(hdev);
-- 
2.43.0
