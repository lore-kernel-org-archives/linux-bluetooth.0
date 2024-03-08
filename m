Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FD2E3F2
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914041; cv=none; b=CEFl99AWpnhO2NfKMsodm5V7z7Q6o2z/3KmIIZQvI5gdxeaER6DcfigLbF1ZDqX6HcT5CgFwbqbyrw515YDoWRdkR9uetVERB7RFAabXjwpf5FPvpdQPKFmMMSpnAncrMqKvC3RnZ98aPouTLkNIcQy9/0eUHxIGOaVKhmenEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914041; c=relaxed/simple;
	bh=K1R/q/N/kaI19m81pJG0nPwp0L+SeYWs3lWlthlj0Dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kJLHpFqtexadqkkVcN5DvGKLxxmnKhkN+Ps2CO9wzUW6zYqWgIZIongRr53aTjt26rP2vC/ew2VkLY66EzYMjCWE+Ewla5uOw6r7SiYluEIDmjK3v/+u1vILgo0MoJ1UbXITsxSNzbOnfrrJ18xsEEHSV6BBMjwEW1Q+ItILSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBQ+Mf3R; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBQ+Mf3R"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7dba7098dd8so669163241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 08:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709914038; x=1710518838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ExXaF/MToz4KdRSrAZxQmHnGbA7c6seQEWIwrQs7DE=;
        b=dBQ+Mf3Rb7cdN9EVlvirF+fAxXem5ST2JYtSmKpt4ToCaqR+lnEX16tb0nSi3EZ5sb
         rbPye3/11vNHmWOEgFG6Vosx4U2GTcx5JsCKNvqu5wPvRlKM5+gHVEr0bK4WDdhHL+8o
         KAlaT/eO43FCEZ879Tdk/VNWeST2WcDXUvjpbYNT4CTGrmbMNqChm+uchArzsAbFCCv+
         pmB2ka6D6yVF1V6/5C8vqoqYeKQLam3NIN8ivCsU8FDOXEJixIye8K1kYEERO9ZHlVla
         LUvRlrlJZtiPOWM4QXY/Pd97cyFT7yyMlQwxBDSTpgI4lq/sTA5XuExLs8vqZqDHBN9Z
         k+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709914038; x=1710518838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ExXaF/MToz4KdRSrAZxQmHnGbA7c6seQEWIwrQs7DE=;
        b=H0T7BdrglSvAkjhLsWLOXP4ot2UaU3KYUa2DkBu0Lc6X5yaARb6yPDmJQ6I0YKDgga
         rCR6GgmvcQT0gGQLdg1MuuZdm9Z1y8i5uhctK8WXPZsoJa5GPQSAJfT3LpuwvrwbFitR
         l7lUR2RVSyr4pvH3pVEhgRBFG8wxZKdZsbiQuKO5LVZgfbqEzRS23O+NYvmODjs759yd
         uUpM8HXpIDzd1mSDeida5XZkYwxzqdnoploIg/WQsvu4JsPwyIXYTaVUGGB/DfOPW8W1
         0hcVqLF9AKoFBy+XZyrSDvHfYwkQuZTwjeb0AEw0Iq/HFvHx0Rx8lTRCULNt7jjAvTdI
         uidw==
X-Gm-Message-State: AOJu0YxJUQLfx7WuCGYE5E4gTEJm+4uz28kX/nepJ7zHgm207jRanZgT
	01QzIETtkpZaMvNoQDzsmAlnqrnDYq2XdELM2Z2At9ySWd3je5XJC4/u3Iei
X-Google-Smtp-Source: AGHT+IHe3ZzMfH7VqI4AIeeFa6tVYYa5uhN9jEEmhL261RYdfmQiHrxwEFQqi1muPT0NEh7McOUdgQ==
X-Received: by 2002:a05:6122:319f:b0:4d3:3236:e91 with SMTP id ch31-20020a056122319f00b004d332360e91mr11456566vkb.11.1709914037465;
        Fri, 08 Mar 2024 08:07:17 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id n21-20020ac5cd55000000b004c0460eeea3sm2079505vkm.43.2024.03.08.08.07.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:07:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
Date: Fri,  8 Mar 2024 11:07:15 -0500
Message-ID: <20240308160715.88478-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following error caused by hci_conn being freed while
hcy_acl_create_conn_sync is pending:

==================================================================
BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0xa7/0x2e0
Write of size 2 at addr ffff888002ae0036 by task kworker/u3:0/848

CPU: 0 PID: 848 Comm: kworker/u3:0 Not tainted 6.8.0-rc6-g2ab3e8d67fc1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38
04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x21/0x70
 print_report+0xce/0x620
 ? preempt_count_sub+0x13/0xc0
 ? __virt_addr_valid+0x15f/0x310
 ? hci_acl_create_conn_sync+0xa7/0x2e0
 kasan_report+0xdf/0x110
 ? hci_acl_create_conn_sync+0xa7/0x2e0
 hci_acl_create_conn_sync+0xa7/0x2e0
 ? __pfx_hci_acl_create_conn_sync+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_hci_acl_create_conn_sync+0x10/0x10
 hci_cmd_sync_work+0x138/0x1c0
 process_one_work+0x405/0x800
 ? __pfx_lock_acquire+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 worker_thread+0x37b/0x670
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x19b/0x1e0
 ? kthread+0xfe/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 847:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 hci_conn_add+0xc6/0x970
 hci_connect_acl+0x309/0x410
 pair_device+0x4fb/0x710
 hci_sock_sendmsg+0x933/0xef0
 sock_write_iter+0x2c3/0x2d0
 do_iter_readv_writev+0x21a/0x2e0
 vfs_writev+0x21c/0x7b0
 do_writev+0x14a/0x180
 do_syscall_64+0x77/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74

Freed by task 847:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0xfa/0x150
 kfree+0xcb/0x250
 device_release+0x58/0xf0
 kobject_put+0xbb/0x160
 hci_conn_del+0x281/0x570
 hci_conn_hash_flush+0xfc/0x130
 hci_dev_close_sync+0x336/0x960
 hci_dev_close+0x10e/0x140
 hci_sock_ioctl+0x14a/0x5c0
 sock_ioctl+0x58a/0x5d0
 __x64_sys_ioctl+0x480/0xf60
 do_syscall_64+0x77/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8a3d0d1f7871..f6b662369322 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6709,6 +6709,9 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_create_conn cp;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
 	 * Connection. This may cause the MGMT discovering state to become false
-- 
2.43.0

