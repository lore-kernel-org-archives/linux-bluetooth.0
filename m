Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A31632F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514197; cv=none; b=UWPqVXYnGErJG+99ACSotk3Rm+moN0MQLGgAfkN9m4j8DMsSu23N6vJ0pkbso4UKgh+SjXMB8vRvj/iyjY3vRUzifBqHEvOIBEmszsHapCEmXMvKaW+iytt0vXzLokdkJobO5mXoUBAeP1eM6zTR0W3Dcb5tK5ZUepu3cTXI6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514197; c=relaxed/simple;
	bh=EiXNRcvL5jaHQly5ZEDqbgNS4xz/LhUJaLQLM1q4dzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=njefk+I2MLqiL/KabLPwgR0Li8TKoOeUUhyjKzuILL2FxXyCAaQX1PAtyiyvgJRX32gC/4WVhk7AEOdj5mRcxgr3x3qHIabt4lWvl5GNhipGHuzTqjcfLL1TbRN244/ubKmihdMmYli7hSuYoxDLDD0GIPDw2VLJ0uR6kqyKVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G33MR8W4; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G33MR8W4"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fd616acf0so3082965241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731514193; x=1732118993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vemY0lJXGvPatcII90iJ+Tr+KqxdWgIgA6ivYzOER3I=;
        b=G33MR8W4wrMVH/MxpxDaFSG38RZAVp1aRluahlHFj+OhPn+7E+utXJBoXVIOdgs/SF
         eDWqP+QNU0kG0PO9FDK/qA2apU/AWYe1l2swC6NtpCq/wD5JuM4CRPoQ5/yBSGPJYad9
         OhaTfvia8axpPTrfWwhgzsve+FflcDdgC2EPkJgRU7+bKTw65SoT9TVY8A+YTcvMMR6W
         ZOIwxl3uynw7K0ONcxZeHmyn8IomOu5wIAHuzlt7iGE+vMQ8aQ2LnLlkn3lTqHHqJYyl
         R0F/pZX8R6M/0hm/U7Z4SRB8VKI5gdUBSvksBYnrz214X/t4w3sRWWOBIdKKlnwaI/82
         k0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514193; x=1732118993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vemY0lJXGvPatcII90iJ+Tr+KqxdWgIgA6ivYzOER3I=;
        b=Tw097fBAIQXTRZt5gholhexjYxuSy1eRvndTuY7v42qn6ePhH6vP/+CSADkrDJf6ks
         DyaygjL3Ly282rP8T6hGSUmwlmRvTyYogFzK3aAS0pnq9Oi6/0AMnqhAON2mWdALQIuN
         MXgwPdBlJp1Mt4WNKiLON7alKfezBYupizVNu1fyxjZ0nspGQ8lGtIX5IQ0Wat2pKf3x
         2J3xKWpNjJscZAMxMTe0oDwKK/K94sOomztVIWkxjUnIOICtqMVtSli/ldZXdXt3/VhL
         qg8e4UV4Pxr5MoLeqbjSnlaL3i46HmSGy+tK4YhLGWkLwvVF7Joqw9ikN1KRl3/j+N/B
         u59A==
X-Gm-Message-State: AOJu0Yy7JyfRA0LO1ngNnfVFMorqNFWhQIVDmnQ9Dtd1Pcn51jWSKpu1
	AshFM0Ls1sfPyrZ92CTkZDUnyTJMscnJcn6SWEDYtR4I05XyDKUMndgsxQ==
X-Google-Smtp-Source: AGHT+IGc0fSngAnAx92PUiOo8Xp7kaPTEv0BGBYMobUfJeteQ9rvV5aEexExTkVC/qmEy7RwzvMnGg==
X-Received: by 2002:a05:6102:c07:b0:4a9:555b:fb50 with SMTP id ada2fe7eead31-4ac2987d3b0mr8078934137.20.1731514193008;
        Wed, 13 Nov 2024 08:09:53 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4aa9efe5984sm2107480137.25.2024.11.13.08.09.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:09:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: fix use-after-free in device_for_each_child()
Date: Wed, 13 Nov 2024 11:09:49 -0500
Message-ID: <20241113160949.1325502-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sysfs.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 367e32fe30eb..4b54dbbf0729 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -21,16 +21,6 @@ static const struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
-{
-	return !strncmp(dev_name(dev), "rfcomm", 6);
-}
-
 void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -73,10 +63,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
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

