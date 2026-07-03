Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E407346AFD
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058441; cv=none; b=orZ7kqZuW36Ia6qKNRwT2mFSxz2KB08y6icl73oOxznlIAlTBnadIBT5uaIe1uZD3/e5fKMBBZF4e0Jet6910bSTx3+A7JNnHb6Z/rfBKCEG/0+LGMvhtPXidudphCaZqdYraaBx5tDH2KgwGu/nSUpyxdPLvYt7LGcWHCVlEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058441; c=relaxed/simple;
	bh=01ctfTpR3Oc5ejLd+QOo/enswnmwvzz7Ey4v7LhW41I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crqb8kRH7cdAIYkjvmBjMlHROUJAjoyI84zpB1UdoTisX9oypA3iKa+XBQfgbb3oh8UNJPJumtMmdqg/htDNOAAxEojm/PfxVUM0P3n0bmp9oPFoQgDQtrWMigyalxZOVT1Ky8esG522ahAis+kZXnu48SBiYnxiKjptTp0Spwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJRHdUcp; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJRHdUcp"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37ffdc718f8so246288a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783058439; x=1783663239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEe9tK0pdPJ/vh4fadxqcTP4nEzSKtWpGeT5rRxX6RY=;
        b=hJRHdUcpYlSnjc3U+3iioLh97NzBkX6FFlsQMU7GMGuwVjhbFG6Lq2UGrHEiyJ2CFU
         nPDg3UA4b6OWxcGN8Suv8Z5FS2BwkaDHJlW0sfK4wxJQdtUMBkYI5KRhv06E31qHIVQG
         YrlLv4YyyMm7NERnzXRkI+z6kT0L71q3pt80EGXVt8RNBlMNPQsUMLHml9/3g6fpTMQP
         yqQn8+atUK3MqdMGkrqaGaPchpYWS72szwDb25BlCRm4d0R4zPDURwFik0dokxsfoTCt
         dkqEfumX+Bu0kJzQt3G/kmvP19JmL/uMND/0VNvXVU+9KXU4DRVtdbNDx7ccspuOa6AE
         DKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783058439; x=1783663239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEe9tK0pdPJ/vh4fadxqcTP4nEzSKtWpGeT5rRxX6RY=;
        b=LkCV8j9vNqF/8NzssvV43rt97EW6gECdJPNHH47ha4z70JDpxSqSBLYm/8jtZEA2w7
         xW81Anw+59TyhQVMIzsafSmrQDSA1smkYHSj9PztJbiTugDDyb9+Fe9tKMGkLjXH8rH1
         DHJzilZ9man2zVvhVQjsxEkpt3e7mI8A2TcA3mzAXfS6W/cbnoud04J194YhROTvl34i
         mpYSV4OGjbY6Z3Aeq33EEMmujHlS6RFn/DX17NxkNh3EWj1EP2lfdeCl+cMmzdVkRvdS
         kHsRujmHNIb0AMGIQdGuNmWRu/WK41c1zV9NcQltS3tC7VsclQWt9mA/ur25kTFMO5MD
         vJtg==
X-Gm-Message-State: AOJu0Yw7KejGHqu7vuo7TML6UIUOlas/4HV59nbTk1rn0+/RkGykbTyb
	Uj7+lmlDwRukJYkI7HY6Xm05LOZwbsurghSJ+yIBOQA4ApY901WTKXuo
X-Gm-Gg: AfdE7cmuO32mVAA/c1DAe8MByp1BmDl+ElAs+X5McoNo9YsWm5RglZLM2w1P47tvw7t
	E9FhfaXBOZoAAcmZjtydnb6ZZg0Fz1eBNzV6tt0JBxQj3Sie+v8VWieRJgwSl9i6T20jhEmxWcx
	XEoo00jcvSZ7HwxugGOZAV0S29dCKG0N04xoGvKeaOa6hQ7JxnQfY7mlDK0QGJPIUTkQObUWAUX
	7Z57cfNbtpvI0Uo46pOb3UdDct2TiDlenAOCMHI35EKn2iTR9u4fmZv6TVPDyRbTsSG1gajfryu
	svjfHMus+eWfPUoNCKDA48MVzxcz6FRr/sRbPxaZ4fsw/kdDiI2Za3KKlVpzXldy/H/a+4FeIiY
	9/V1nP2NNhtJRmUC876m7z+nF+IHpn2X0Rpza8rMmHN2ouq3Dc4hbKhvOy2tkt/cdRJK2/FxdxN
	Frrp0ph2s=
X-Received: by 2002:a05:6a21:4516:b0:3bb:106d:77be with SMTP id adf61e73a8af0-3bfed560398mr10645154637.44.1783058439156;
        Thu, 02 Jul 2026 23:00:39 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e92b81be9sm2159628a12.30.2026.07.02.23.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:00:38 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: Fix ADD_EXT_ADV_DATA rollback of committed instances
Date: Fri,  3 Jul 2026 14:00:33 +0800
Message-Id: <20260703060033.570932-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_ext_adv_data() uses clear_new_instance to roll back failures after
preparing advertising data. That path is valid for a newly created pending
instance, but a malformed ADD_EXT_ADV_DATA request can also reach it for
an already committed advertising instance. In that case clear_new_instance
frees the live adv_info while hci_cmd_sync_work() may still be using it.

The buggy scenario involves two paths, with each column showing the order
within that path:

  advertising enable path:           ADD_EXT_ADV_DATA error path:
  1. look up the committed adv_info  1. accept an update for that instance
  2. wait for the controller         2. hit clear_new_instance on failure
     response                        3. remove and free the live adv_info
  3. resume and access adv_info

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
Read of size 1 at addr ffff888104e3f010 by task kworker/u17:1/2502
Workqueue: hci0 hci_cmd_sync_work [bluetooth]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
 ? __virt_addr_valid+0x19f/0x330
 ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
 kasan_report+0xe0/0x110
 ? hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
 ? __pfx_add_ext_adv_data_sync+0x10/0x10 [bluetooth]
 hci_enable_ext_advertising_sync+0x99/0x190 [bluetooth]
 ? __pfx_hci_enable_ext_advertising_sync+0x10/0x10 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Allocated by task 2515:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 hci_add_adv_instance+0x35d/0x440 [bluetooth]
 add_ext_adv_params+0x291/0x510 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 __sys_sendto+0x2bc/0x2d0
 __x64_sys_sendto+0x76/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 2515:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x313/0x590
 hci_remove_adv_instance+0x130/0x1b0 [bluetooth]
 add_ext_adv_data+0x263/0x640 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 __sys_sendto+0x2bc/0x2d0
 __x64_sys_sendto+0x76/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Only pending instances should be rolled back from ADD_EXT_ADV_DATA
failures. Leave committed instances in place so queued controller work
cannot retain a freed adv_info pointer.

Fixes: 12410572833a2 ("Bluetooth: Break add adv into two mgmt commands")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..a4126d616efa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9220,7 +9220,8 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	goto unlock;
 
 clear_new_instance:
-	hci_remove_adv_instance(hdev, cp->instance);
+	if (adv_instance->pending)
+		hci_remove_adv_instance(hdev, cp->instance);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.43.0

