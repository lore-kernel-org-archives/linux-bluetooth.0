Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245332;
	b=nVnt5xB/upWus7ledXqW9OPktF+3hCrsWCNsve0s/NV9DLpUR9j93VpK6RkTy4W184tw
	 Ai7C+Xq057Rii5Cd7EmhusYoZ05b0CF86icgqmg8nuZwqh4YLUak7/feTbMpiG8yrMDXJ
	 PwXj8hIShriB0n4X3l0rCBSQxe1z6xhCldwpHWa4W4mGjdM0bfRwO9/pCf7oegW5pVDbN
	 U6WIAxI5xbp8hyLJL9q6Pls4GibeIHGt/swQslfhSHLUNRuGuAKyn4iOaVhDtCCyI6M3z
	 oOTN8kMxej24HVsULpVADMrbZyECc8hSyhkOHh6QC2HKvdvMbyxwbgbYc1C2mA5dxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xehfxoWBrgISLXlBo/1/2M9JN2iv5hKTOq6rJFCfrgg=;
	b=E0h5p7ImRREt4xn4p1EIFTXrB3ZSiZ1e3GxZgQl0o8FLJtRdFaUkALW/0GjaGlcNvsAn
	 GVxyX1R8Q45k3K3d/mSyrDXcDV9JYu3d8tHC2K93MjNKshFf0MLUV3SAMAZQH8rdrIk1h
	 9bW8PeaoiC3zuXysortujAvHOkVOZq38/k0EiT4oEPnICC+vvUdbwCkqIh63cjV7zKhqa
	 HqQQ5IZ/21cmAFu1nImpz3gZSmOlvdG4AEhNhsfbMR6X2rP2/oU2jB3+v8wtIaX1uD4/w
	 Jnxci5Iaq3XkwY8MPIia3B1FhHlDot8Js6t+Sq+MbeDTqckjiJUn5IrToJ1HvwM58Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRqPDBk4;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A26606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JRqPDBk4
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f020d0169eso8234315ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245331; x=1795850131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xehfxoWBrgISLXlBo/1/2M9JN2iv5hKTOq6rJFCfrgg=;
        b=JRqPDBk4Ykh2bcHqsDvCmq4KDoLGs226Qw8ABAVVkWkoT+zmRW7ZpF3CGl2DsnO/3u
         Dp5hA6OGw6HriAFMGCDEGneetWTMNjS/9aCqZ/PPRXm42opaw8r6qzjAyF2y+rI0Ym6B
         VAp2LMI15KFru/8a1DpK45TJctKBHpe01XUXim51zJ60p5g6Rdf0hG9IPHLWnw1r4z5I
         0CVZXOJUr0gBaDRojux2j4NBdo4ftDgrjczsbOvCDHAoHdf5TurrLoljiYKg5KeigfUD
         rfcd23LuPQW6v32/t8hMmK3O3vmkGEHSOCPqcaVwg8Mls4mUL+gI7vHw0pxejlcNmQ3o
         hSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245331; x=1795850131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xehfxoWBrgISLXlBo/1/2M9JN2iv5hKTOq6rJFCfrgg=;
        b=JP2aErItU0Eui1vRovKwk5+JYeKsl0nSKhKCCO3kU3PJrnVPNmGfdiLd7CUEJv3ZRe
         kC0PfmfiIrMIpeXJ2l4+Ia6CzulZMXCCy2zHa5Rc7UDw+UMvzed399vpzgFghLvUXZah
         VBTQnsi8ryWebJMaR2m2cN6W/AuZvkgvEWlZj2c9SzagDhffM+FAPtI/ySyNZjcfs40w
         xzZfv2yODHwyQTp2KHIeo7NxUsQ8TuDlTd0+cY/WXr/P+ZFAJvXrq89i1k17QKUc9QZw
         u50SKa/3rfvdeuRbFDxFIaWRlgkL80L/8DEp0Zhy6SUsThx8vA9tBsL6G33iPXqaVFl9
         dHCw==
X-Gm-Message-State: APuU4Z8CLMp/R3EEggJTDP6sdFF7hBkc+FArWxWboZDAxAzf0vhbqBfD
	rna9W5dn4QuxL2d0ef9wAZM282peBo5iFRF9DfiRUYKbeWmY7Ag8hKtT
X-Gm-Gg: AZFdTZeysAFAg03UlCGzgj7+5eAydV6zeK8Mq+phfQ+olMG7PQ7EWyeznsDA5bOpI9M
	/3B6wEU4O/tuhm8aAB7Wgugw36J8g+k26HBAaG17Ff9barsOgME+tTE3b3NYgYdZo2CjmSt2bN6
	JH0aEWK1AQk03KAXkvD051go8oNjaYwKbNeqjz48sAZuqKbjBX2qZF0Yg8z7zX+S8CG3p6OxPJe
	xPYCRv5AiWfhaOSHcnc0YTkJwnDnKityE37gYALruQaz8eiSLpYmUTtDGH8C6iP/UgOvPwIPtIa
	UlJKTSI/VUQ/Y+A/BFOAwl6vi+8xNIBJKOb+YCf3eorsnEHmiEMkxmX6BN9HYgZv5jKMJJ581HL
	febuCf25f06S5YV6z0AMHMcdauX45n/XARj2VFGOOb2bGyJepemvoixu5VFwtWe57cp/jI5j5Nl
	AHh37LaNfvHSb93NK2sQOMZ8iksaW9kNiOCPdXuBxJAXm8/UZzp+OcRE16aHXLygvTAabv+h+QR
	i47GDjaKMeUWLO5MAW+bO6fedYy38+B4Iw+rbCwgzP7WekKx9+YPMQoSBalIY7o0GhadDMYnZXY
	YcrTI1htdn4yJ8FHe8mcCLR7
X-Received: by 2002:a17:903:4b04:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2f03f17d159mr56885465ad.14.1795245331194;
        Fri, 20 Nov 2026 23:15:31 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04f6049dfsm13508675ad.19.2026.11.20.23.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:15:30 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/3] Bluetooth: MGMT: Claim pending pairing before immediate completion
Date: Sat, 21 Nov 2026 15:15:17 +0800
Message-Id: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0167-v9-45c99868af18e41665a3-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pair_device() publishes a pending command and installs the connection
callbacks before checking whether security is already sufficient. SMP
completion runs without the handler's device mutex and can consume the
same command during this check:

  Pair Device handler               SMP completion
  publish cmd and callbacks
  hci_conn_security()
                                    remove_pairing()
                                    complete and free cmd
  read cmd->cmd_complete

Use pairing_complete_cb() for immediate completion too. It claims the
request through remove_pairing() under mgmt_pending_lock before using
it. If SMP has already claimed the command, the callback finds nothing
and returns; otherwise it owns completion and release.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in pair_device+0xfcd/0x1070
    Read of size 8 at addr ffff88810b001f48 by task python3/561

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? pair_device+0xfcd/0x1070
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? pair_device+0xfcd/0x1070
     kasan_report+0xe0/0x110
     ? pair_device+0xfcd/0x1070
     pair_device+0xfcd/0x1070
     ? __pfx_pair_device+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? do_raw_read_unlock+0x49/0xe0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_read_unlock+0x23/0x40
     ? __pfx_mgmt_init_hdev+0x10/0x10
     hci_sock_sendmsg+0x128b/0x22e0
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_socket_sendmsg+0x160/0x280
     __sys_sendto+0x425/0x470
     ? __pfx_hci_sock_sendmsg+0x10/0x10
     ? __pfx___sys_sendto+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __x64_sys_poll+0x11a/0x430
     ? __pfx___x64_sys_poll+0x10/0x10
     __x64_sys_sendto+0xe5/0x1c0
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f2c2833e687

     </TASK>

    Allocated by task 561:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     mgmt_pending_new+0x60/0x230
     mgmt_pending_add+0x3b/0x180
     pair_device+0x633/0x1070
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 522:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     mgmt_auth_failed+0x238/0x3a0
     smp_recv_cb+0x1ccc/0x8d80
     l2cap_recv_frame+0x16f4/0x8b10
     l2cap_recv_acldata+0xe9f/0x10e0
     hci_rx_work+0x5a6/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

Fixes: a511b35ba4f0 ("Bluetooth: Fix incorrect pending cmd removal in pairing_complete()")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 68fc33542645d..947d308145e37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3853,10 +3853,8 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	cmd->user_data = hci_conn_get(conn);
 
 	if ((conn->state == BT_CONNECTED || conn->state == BT_CONFIG) &&
-	    hci_conn_security(conn, sec_level, auth_type, true)) {
-		cmd->cmd_complete(cmd, 0);
-		mgmt_pending_remove(cmd);
-	}
+	    hci_conn_security(conn, sec_level, auth_type, true))
+		pairing_complete_cb(conn, 0);
 
 	err = 0;
 
