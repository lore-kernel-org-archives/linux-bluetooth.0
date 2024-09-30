Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91372C1B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740721; cv=none; b=oVrymOp0dbgUvQx2X2inaJ1EzcdIKaknOYV7b6cQAs3dHjAg856AjJ48MPikDVBay1M387DViNKvwyn8/4pvzb4dEP/ybdFkrBYdzkkTTzMQSQ3Wpoi4si4/NXr7Ngs9kCYBq2dgnxfQ4viS8P+1u7FZ/MXLR7L/OymQutkjIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740721; c=relaxed/simple;
	bh=VUMs7D01R+QmXr9RbaA/BAHf00eixsg5CWxfm3p9FAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUtjpNIpfV0k4JmRqtmr3iFrCRzRMtBSXpFQ28SbbdNftlivozrJuFxIA6n7MpOVnu3urWebLv3+LKPlFhulfOSqALD9jjsKzzyzijGkhBx4aP7vKdpv2sKTJyffVpc83k54bql4sXG/cQYeptw2GIWgjj5cZxyuJTOI0pzCIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDIPUXWu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDIPUXWu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7acdd65fbceso410381085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727740719; x=1728345519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUMs7D01R+QmXr9RbaA/BAHf00eixsg5CWxfm3p9FAk=;
        b=EDIPUXWuHdEqiuQVFCljo8TCPAEpzeaXLUFq/NJC6AguqJZ8yjPtFae3zcfcSaoNe/
         AUO5P3rLu2tOaedBehQVO4wtTq6OxD/spAZn+KcDQFoIqlMLnLY1lIJQ4O3KEjgPKfMv
         BjzgDDrfBwspsH2tF/OqP2omDM20Mq3XgEAWvbnvm+DXYgDo+kvgvmi89Va9jhY4CuN8
         cfalVt7scoS3UmJCimlFA4CyI1KRrpBIdPRgumfHzBPZZaMBCgQbIGkGuzoWuykLScOu
         k4PTl3udouaJQO6KSOKkHGdbr2DWC1SIaj3DuxgTsVGMuzLjj0HxPcks+fN8a/8nwnUu
         riog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740719; x=1728345519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUMs7D01R+QmXr9RbaA/BAHf00eixsg5CWxfm3p9FAk=;
        b=CAmYL6RPzI2qDWaEUfmK9f8RT3JyHADDQxMlFGJYsqgOEBzUCgYIBqKaO9JXXJ2t1a
         9X8XdoFpTQC6A60HkWFMexAhEGilMFqCeDHbqVliXLT3L4PPwRmZKgdhWzZKPbj1d4Xn
         ZfflJCnYRODpHBex0UeGRCLViXDk1IOVrPH4F4W7hL9X74085rXlDdoLSr69DAJxZF8W
         25eOUiO8uZ1MtUE/JNCJpEp61pZ95ORNHmgCfvmWyq0Kcv3XJmT8qfmYV8xIjGpP51an
         FYwOg5fY8CyzOiJAcBs9EmHPsi8+47lDTsbpzpI75N8R8ilLAvn4yGs6gcnWBTPZXkJo
         WfuQ==
X-Gm-Message-State: AOJu0YyRLMKSdRvtxtO2tSESVkbfgisHohY57Du5dfAkFg8GA4hfbf+p
	jxLTOi+WE5C5EJwEVPW8GAzKD7cgTuBMFn9aG93JAdohNVGBp7pLNzWTqQ==
X-Google-Smtp-Source: AGHT+IFkuXqQXVg5qZ6aAs2sppBDqo5VtFxMvU2r54X5ww6BwXBZ9DOf5BKR7hLNop6MRFihkK5Byg==
X-Received: by 2002:a05:620a:4093:b0:7a1:e2d4:4ff3 with SMTP id af79cd13be357-7ae378259e3mr2584345885a.3.1727740718586;
        Mon, 30 Sep 2024 16:58:38 -0700 (PDT)
Received: from tofu.cs.purdue.edu ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7ae3782b8e3sm455065385a.96.2024.09.30.16.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:58:37 -0700 (PDT)
From: Sungwoo Kim <happiness.sung.woo@gmail.com>
X-Google-Original-From: Sungwoo Kim <git@sung-woo.kim>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: KASAN: slab-use-after-free in cmd_complete_rsp+0x1b3/0x1e0 net/bluetooth/mgmt.c:1463
Date: Mon, 30 Sep 2024 23:58:31 +0000
Message-ID: <20240930235831.2919587-1-git@sung-woo.kim>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913165010.3240215-1-luiz.dentz@gmail.com>
References: <20240913165010.3240215-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Is this bug related to the recent patch?
It happend bt-next 667e8026261de5d230908, cloned at Sep 23.

==================================================================
BUG: KASAN: slab-use-after-free in cmd_complete_rsp+0x1b3/0x1e0 net/bluetooth/mgmt.c:1463
Read of size 8 at addr ffff888112f0b740 by task kworker/u9:0/246

CPU: 0 UID: 0 PID: 246 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-g667e8026261d-dirty #10
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: hci0 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xce/0x670 mm/kasan/report.c:488
 kasan_report+0xc6/0x100 mm/kasan/report.c:601
 cmd_complete_rsp+0x1b3/0x1e0 net/bluetooth/mgmt.c:1463
 mgmt_pending_foreach+0x98/0x160 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x122/0x290 net/bluetooth/mgmt.c:9474
 hci_dev_close_sync+0xbd5/0x1110 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_error_reset+0x1cb/0x420 net/bluetooth/hci_core.c:1016
 process_one_work+0x61a/0x1050 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x8d9/0x1120 kernel/workqueue.c:3389
 kthread+0x25a/0x330 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 250:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 mgmt_pending_new+0x5b/0x270 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x34/0x110 net/bluetooth/mgmt_util.c:296
 set_local_name+0x18e/0x3e0 net/bluetooth/mgmt.c:3857
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1726 [inline]
 hci_sock_sendmsg+0x122f/0x2200 net/bluetooth/hci_sock.c:1846
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x4a9/0x570 net/socket.c:1160
 do_iter_readv_writev+0x4ee/0x680 fs/read_write.c:741
 vfs_writev+0x328/0xae0 fs/read_write.c:971
 do_writev+0x236/0x2f0 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 246:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0x109/0x170 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x9c/0x220 mm/slub.c:4598
 set_name_complete+0x14b/0x200 net/bluetooth/mgmt.c:3799
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:641 [inline]
 hci_cmd_sync_dequeue+0x202/0x370 net/bluetooth/hci_sync.c:886
 cmd_complete_rsp+0x46/0x1e0 net/bluetooth/mgmt.c:1461
 mgmt_pending_foreach+0x98/0x160 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x122/0x290 net/bluetooth/mgmt.c:9474
 hci_dev_close_sync+0xbd5/0x1110 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_error_reset+0x1cb/0x420 net/bluetooth/hci_core.c:1016
 process_one_work+0x61a/0x1050 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x8d9/0x1120 kernel/workqueue.c:3389
 kthread+0x25a/0x330 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
