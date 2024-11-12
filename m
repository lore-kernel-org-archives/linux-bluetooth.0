Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BA2170DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446737; cv=none; b=JHZoXFBuIYIbUZDBxidpdv65pwpHf9FEf/9Z9U30dZpEw0Klj8ZtteaxEKKKqWzXLm7ncEgo+d8JVh0LvhGjKOc7QJ2tVgJJ2CwX385ryly13VgiztMdHLwH12bKArcSBEXMpcO2hlMCLt6ThPyuHLAyrmEc2e8CJix/viTWsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446737; c=relaxed/simple;
	bh=/BRMOWtySThb9S2gKYqI9iNcLwfGuBwh3bpB+6fQsUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S8ZW4btEeQOyE1v0dZFOvNTBnV6BsznfkarFR6Rh8Ul3a8mSaxQ4MbrEuHxTGYkKuIBQQ8WNdRjj+NzdeKUKKT7EAXHL+hfzogcBcmBcTHZ7zrLsHJqLlpOZLtgN8uneR3mVZ6bCTCZQN2dWCEP7Ry12uxPPJJVEri4zBfjlZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPYJ9iTu; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPYJ9iTu"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fcfe29e09so2314807241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731446734; x=1732051534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYtOxEm8kwJ4OpOPYxp9KKPVIZI2dPUL6Xd273iwU6M=;
        b=BPYJ9iTune7LP5RHwtwploY9R9cOC3x7GQXgl9UTpH4mZhuTFdVJBM40QJQh3gfFGw
         ljXqRFIkfXJfZX2P05bUkn85iR2pGl54cZmXgvcOsrdAv1pjflSwvrcVWnR+5yEj7Efb
         17loWBHrHlXoNFHds00N64PKwQD965PN5a2IrzmIM6/+7fN1RnYF4kKF7C18n1UD8Cx4
         xh6/gkcJiRKShdHBChmwF97DKI7DzXJRcK46Q24niTMLe00OGw7fDciR7wt+64TWlfEt
         Xk1c4FdjcYHXfajbvzjlMeway+jhlGaNoJbtrEfGe6qGrYcZpTJoBou8vT9IGqWPrw7a
         +xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731446734; x=1732051534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYtOxEm8kwJ4OpOPYxp9KKPVIZI2dPUL6Xd273iwU6M=;
        b=F7yHh+/4QMfQVtRzH79L4beFTzFdvpGPQnk4bfMfDJSX8kNH5iKWBelLeh9ui+fvXF
         nzeEX8hUpatyWKKwzVExG3efASZ2OIAzHUyH1ENl++750/Dn7RP3ClHt+XqrYhE0C9Nm
         KcJsZA0KuRq6qvarsvQ+NjNxMHxW+g74bUFwVH//i6+4Req3OvHzpXDGlPijentyn7Lg
         PzwXHGnzVdRnHiiPfguyIqRiO6QQ7lObAkoVY6wvgvQmAN7w2GhmcZPbEby/nYPjCRqr
         TgRb7ch96HQaeSulkfPJ4J9pft4SqVw0YkzGnZL/KugTLfVyYEGSxmFQixZLrDRaOKLh
         hRrA==
X-Gm-Message-State: AOJu0YwfmhmWqhTlkKr05Mg1potKvkTTl0MlyefrRH5qoyjumoHz2StX
	+IhiBVKNG77gcYK48U4Q0nVMMI4wNE2hanm5Awoh8dGFLIcVFCSi4p4xvg==
X-Google-Smtp-Source: AGHT+IFavOtQJk75AFwzp6wg2/ZAL//GAjkCW97WhyzroLb2VWr6h8HQvEnbdhrzaYxIDvWD0r69eA==
X-Received: by 2002:a05:6102:41a6:b0:4a7:4900:4b83 with SMTP id ada2fe7eead31-4ad468e57c6mr949847137.15.1731446733508;
        Tue, 12 Nov 2024 13:25:33 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4aa9f031697sm1924426137.32.2024.11.12.13.25.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:25:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
Date: Tue, 12 Nov 2024 16:25:30 -0500
Message-ID: <20241112212530.1203474-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

Syzbot has reported the following KASAN splat:

BUG: KASAN: slab-use-after-free in device_for_each_child+0x18f/0x1a0
Read of size 8 at addr ffff88801f605308 by task kbnepd bnep0/4980

CPU: 0 UID: 0 PID: 4980 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-00161-gae90f6a6170d #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x100/0x190
 ? device_for_each_child+0x18f/0x1a0
 print_report+0x13a/0x4cb
 ? __virt_addr_valid+0x5e/0x590
 ? __phys_addr+0xc6/0x150
 ? device_for_each_child+0x18f/0x1a0
 kasan_report+0xda/0x110
 ? device_for_each_child+0x18f/0x1a0
 ? __pfx_dev_memalloc_noio+0x10/0x10
 device_for_each_child+0x18f/0x1a0
 ? __pfx_device_for_each_child+0x10/0x10
 pm_runtime_set_memalloc_noio+0xf2/0x180
 netdev_unregister_kobject+0x1ed/0x270
 unregister_netdevice_many_notify+0x123c/0x1d80
 ? __mutex_trylock_common+0xde/0x250
 ? __pfx_unregister_netdevice_many_notify+0x10/0x10
 ? trace_contention_end+0xe6/0x140
 ? __mutex_lock+0x4e7/0x8f0
 ? __pfx_lock_acquire.part.0+0x10/0x10
 ? rcu_is_watching+0x12/0xc0
 ? unregister_netdev+0x12/0x30
 unregister_netdevice_queue+0x30d/0x3f0
 ? __pfx_unregister_netdevice_queue+0x10/0x10
 ? __pfx_down_write+0x10/0x10
 unregister_netdev+0x1c/0x30
 bnep_session+0x1fb3/0x2ab0
 ? __pfx_bnep_session+0x10/0x10
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_woken_wake_function+0x10/0x10
 ? __kthread_parkme+0x132/0x200
 ? __pfx_bnep_session+0x10/0x10
 ? kthread+0x13a/0x370
 ? __pfx_bnep_session+0x10/0x10
 kthread+0x2b7/0x370
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x48/0x80
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 4974:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 __kmalloc_noprof+0x1d1/0x440
 hci_alloc_dev_priv+0x1d/0x2820
 __vhci_create_device+0xef/0x7d0
 vhci_write+0x2c7/0x480
 vfs_write+0x6a0/0xfc0
 ksys_write+0x12f/0x260
 do_syscall_64+0xc7/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 4979:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x4f/0x70
 kfree+0x141/0x490
 hci_release_dev+0x4d9/0x600
 bt_host_release+0x6a/0xb0
 device_release+0xa4/0x240
 kobject_put+0x1ec/0x5a0
 put_device+0x1f/0x30
 vhci_release+0x81/0xf0
 __fput+0x3f6/0xb30
 task_work_run+0x151/0x250
 do_exit+0xa79/0x2c30
 do_group_exit+0xd5/0x2a0
 get_signal+0x1fcd/0x2210
 arch_do_signal_or_restart+0x93/0x780
 syscall_exit_to_user_mode+0x140/0x290
 do_syscall_64+0xd4/0x250
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

In 'hci_conn_del_sysfs()', 'device_unregister()' may be called when
an underlying (kobject) reference counter is greater than 1. This
means that reparenting (happened when the device is actually freed)
is delayed and, during that delay, parent controller device (hciX)
may be deleted. Since the latter may create a dangling pointer to
freed parent, avoid that scenario by reparenting to NULL explicitly.

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
Fixes: a85fb91e3d72 ("Bluetooth: Fix double free in hci_conn_cleanup")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 367e32fe30eb..da74b38637ce 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -73,10 +73,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	/* If there are devices using the connection as parent reset it to NULL
+	 * before unregistering the device.
+	 */
 	while (1) {
 		struct device *dev;
 
-		dev = device_find_child(&conn->dev, NULL, __match_tty);
+		dev = device_find_any_child(&conn->dev);
 		if (!dev)
 			break;
 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
-- 
2.47.0

