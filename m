Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E591D0795
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882729; cv=none; b=IftHCeSXcd1ANCqt99phHMrwkGVz9lwFe+jp+GDgb1D6GiZ4n7lSoJX5srgHo9F5rVkm7y7zOSoimXYh1VqYrPxX30hnez0iKIVFXLOf32mA2fuLHLnEyrJMAvMvwzVE/58j3LcSO2yl8QOxbulOG28sJuy21ySytelULARKSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882729; c=relaxed/simple;
	bh=oWaLdIz7tsjDt5PRegnrwsbapaGClQnZ5TtM+3CiZmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tD4rNNooScwn+GiLlurnCUcYFi58skYR0FvKz+9WoxMU46n9V72hiIFBZkAV71rQyXH09D83oYqalrWyGRfzM5LLgm5EO0jPtjcKnqSGXCFbhN3+NP7A9XdYj+6W+lXnsN+QDW9iGNdi357nS13ZtrH1JifM8x1D7M+UaOuXlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6iENnqC; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6iENnqC"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a3c6bc4cecso1057237137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882726; x=1728487526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yX+1wILB/PTV1HAEf2c9zobiw0BdJzxS9q5NLdsDh4k=;
        b=J6iENnqCZgn/bSliL0aAFu0JD9L3RGaIqCx6SdVfZZ/IbOQ8VbIdyN3C/uOHvgv0ge
         69mhqNcGuuYKboFxeqORRMi6uqD5Y7znrgo3GGHISJjNplfhdKQ+3RRB1DJxW+qTLcvr
         An+Fcy8/CdrUYnR5I97vOXgt+2Veo/SdL831ZmKEdMIvNqGeyQo1s3CeH6YHGaayTb/w
         iWdtPi0hHxgK+8iPIP6g0itSy+4u/CL3gQs9lA2XUQy0k3K3VhyXLWVKNaWHzerreUdg
         0KRPN/cmTkuITSQXk0VQzL1WYn9fXpJO8ZXWbhYp/QWI9P66s+FyyeT43Ac4qwFfhom1
         cLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882726; x=1728487526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yX+1wILB/PTV1HAEf2c9zobiw0BdJzxS9q5NLdsDh4k=;
        b=YTulqNiKjogGdT3nzE4FzKpwHl0vmCwdkdifMBFCQk9EfYhs1V+Zjr/Jlqb8D0DdOF
         qHoo8W+q323/7XcVkdgvtiGhrPLo90Bi21kMdkuoptYT7JuYjuDNFUH5Nz+PnT/uQOTu
         2XDmPzfWR05zWuKFfjUR40uKnGsH68ZIkPxwLHcj9OSEtO140U49tqRcj49uaMeRao8y
         +S1N8nCWTNVxKWk5teD/4IX4lMVvih/qe9kO+xImUQ9Tf7jgYjmga4AHwuchnoDHnQJP
         V5eFAxO9SAde8oBTY4qfHC1pJut9jf4B4+ePF22pc3qrC4IMgS+zc/IbUt3MNyzTY1ij
         2JqQ==
X-Gm-Message-State: AOJu0YwUnX6GzfJ6Y0eO93X5oX4lcHQClxOGAFUFPRmbqnPYOCifqJGv
	+Esd7aEPgQyBo8tbWviL2MifOzWAWl+4naUqtDGduV3iz5rZzXVtnC54uw==
X-Google-Smtp-Source: AGHT+IEJXB8z0u9idxHjzRdHn5Zewrtm39wD7VN2Zbs1iYlJ656YTO7OhMYZu8ryaVPLmNwo7yOaDQ==
X-Received: by 2002:a05:6102:3914:b0:4a3:dd44:822b with SMTP id ada2fe7eead31-4a3e683d3d6mr2962671137.8.1727882726301;
        Wed, 02 Oct 2024 08:25:26 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a2bba39917sm1843618137.26.2024.10.02.08.25.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:25:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
Date: Wed,  2 Oct 2024 11:25:22 -0400
Message-ID: <20241002152522.3328164-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if the ACL connection remains valid as it could be destroyed
while hci_enhanced_setup_sync is pending on cmd_sync leading to the
following trace:

BUG: KASAN: slab-use-after-free in hci_enhanced_setup_sync+0x91b/0xa60
Read of size 1 at addr ffff888002328ffd by task kworker/u5:2/37

CPU: 0 UID: 0 PID: 37 Comm: kworker/u5:2 Not tainted 6.11.0-rc6-01300-g810be445d8d6 #7099
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 ? hci_enhanced_setup_sync+0x91b/0xa60
 print_report+0x152/0x4c0
 ? hci_enhanced_setup_sync+0x91b/0xa60
 ? __virt_addr_valid+0x1fa/0x420
 ? hci_enhanced_setup_sync+0x91b/0xa60
 kasan_report+0xda/0x1b0
 ? hci_enhanced_setup_sync+0x91b/0xa60
 hci_enhanced_setup_sync+0x91b/0xa60
 ? __pfx_hci_enhanced_setup_sync+0x10/0x10
 ? __pfx___mutex_lock+0x10/0x10
 hci_cmd_sync_work+0x1c2/0x330
 process_one_work+0x7d9/0x1360
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x167/0x240
 worker_thread+0x5b7/0xf60
 ? __kthread_parkme+0xac/0x1c0
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x293/0x360
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 34:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __hci_conn_add+0x187/0x17d0
 hci_connect_sco+0x2e1/0xb90
 sco_sock_connect+0x2a2/0xb80
 __sys_connect+0x227/0x2a0
 __x64_sys_connect+0x6d/0xb0
 do_syscall_64+0x71/0x140
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 37:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x101/0x160
 kfree+0xd0/0x250
 device_release+0x9a/0x210
 kobject_put+0x151/0x280
 hci_conn_del+0x448/0xbf0
 hci_abort_conn_sync+0x46f/0x980
 hci_cmd_sync_work+0x1c2/0x330
 process_one_work+0x7d9/0x1360
 worker_thread+0x5b7/0xf60
 kthread+0x293/0x360
 ret_from_fork+0x2f/0x70
 ret_from_fork_asm+0x1a/0x30

Cc: stable@vger.kernel.org
Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fb0946eac8a4..40c4a36d2be3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -289,6 +289,9 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	kfree(conn_handle);
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	configure_datapath_sync(hdev, &conn->codec);
-- 
2.46.1

