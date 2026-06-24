Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1839B4A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336985; cv=none; b=pV9AGvNLxsehzYWQgbJCN0f5tWR5nVc5sltqYY+QtZ3Mm+qZfQ/PaOLZaNcEC6miRRT1YOUnHKtjcYr/U1iDtZwAxTv0Iq9WbZC+tBkH6TTJ9BB5Mwfzx636Ju+nEv2ZZI71kkxL3mtz9e+9hrFXJW4JyQf2h9ONLVMxe2QXYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336985; c=relaxed/simple;
	bh=qE4N6Xr9R584mGU48XpYmUMDEV1hvMJtbH9U2Ed9J40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4V67gbO4VFh5agYljXamu6QSntkgxLmn0OT8SnDQ81IDRuYfev+GpXcH7o292LlDSNvF96ftgCp1meFn792wAn+CnUxpVSm4bVMffLcYDX+JQsnWhslMCdlitgE91GAW0N1muZ06yZHV9zW3YsDlXtOwc8gKV6YaU7T0sVizak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662b95934dcso1833828d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 14:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336983; x=1782941783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmgjGWM0j89/br3tsWKoK02HnLRohq9KDsVxNgjZfnk=;
        b=BfYWOQeMFqxPd4jHVt+ylez1vZGnsofOmEK0zu7AXBJLiLwSvaf8cA2udY4vsSIdg9
         9WTpGj7SAbR0ZJMHYh1kEp/Vf6/DIJ4b7AxR9KTJBdmE4ji2GdcfbHSmpx98nI4Cu582
         W3cFu0MfVzg+5gsUXizto8XsFsaVriJDJGdtsCdrWaoo5R8DCKly4uy88L/vBKGNT6Ve
         WXh3omld+/0xHx336ykpVvAIObo3tux4g2/GOW00G9CXmKVNPb3knFi2gFnjXKsj4Q1U
         iUXLTh6/mQxDGN4STvgvjMECIQlFJDLzR3/ZIQrvholkMkwWqCDDClhB7TApI7fP2gSD
         eQ1w==
X-Forwarded-Encrypted: i=1; AHgh+RoNV7c9lluFJmge3IKX5TUpNLpsHBlczxIjD0CVsJlN9KBP1nljKMiNNnkA54T8mpkEgEJHYiDWeFr08zC+uN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l4jTNlfACOc3S7pDXChS0lwd2XguhVOj8ItpoVd4yROXTGDa
	a0jZ0c0xR4GHHlCognBT1zyZ3/iiYA2yd9DS5uquMwL7mu6FlHTi70IV
X-Gm-Gg: AfdE7cn+l0PbDzvaKi0LjF2xS6VBKzDpXqvRF5KSccED2qdbwXikYrRy7calf4JUPOX
	n56EwiGuj7audoH05ycekVhFjfNd7CvsfSbwXvBOz53mZXeya6INtIVdbjK5RwlkiSywPGY9rPm
	pxQuo9tIpxLf/sDMWxh/h/gXzx3NNibIcw4NGbtdmDaDZmUsDd8RPEyhNerU3YHaLnuDTE4IySd
	tK4unvTMqXvRmqp+8Qqsu0XXolIPzGmpqXmQn24c1iZrkpMb05l5UndeB6kvy0d6MZ3AzJK2Efz
	+tToPQt/496d9qVho1qcEVwHzG4zwdbI0mX+YsolLpph/7k5QYEw2ACzjwBTpe+tbLQ8yJg4E3Q
	tVdYsFT8ApmaBGFJxLULiqAmckwQ4jlo20HyRvKjN/BMjPeq9s1/kWtUB8yPqF/q1ATCmr9Cxxa
	nMoza05XshWnt/yBfdUE4KszRZwe26kgk=
X-Received: by 2002:a05:690e:4809:b0:663:ac22:81 with SMTP id 956f58d0204a3-663ac2205acmr2766955d50.24.1782336983360;
        Wed, 24 Jun 2026 14:36:23 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-6647f926750sm465119d50.12.2026.06.24.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:36:22 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: sco: Fix a race condition in sco_sock_timeout()
Date: Wed, 24 Jun 2026 17:33:04 -0400
Message-ID: <20260624213304.1460149-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_sock_timeout() runs asynchronously and lock_sock(sk). If the socket
is closing while the timer is running, it holds the same lock
(lock_sock(sk)) twice, leading to a deadlock.

CPU 0                      CPU 1
====================       ======================
sco_sock_close()
                           sco_sock_timeout()
lock_sock(sk) // <-- LOCK
  __sco_sock_close()
    sco_chan_del()
      sco_conn_put()
	      sco_conn_free()
	        disable_delayed_work_sync()
	                           lock(sk) // <-- SAME LOCK

Fix this by moving disable_delayed_work_sync() outside of lock_sock(sk),
ensuring that no lock_sock(sk) is held before sco_sock_timeout().

Lockdep splat:

WARNING: possible circular locking dependency detected
6.13.0-rc4 #7 Not tainted

syz-executor292/9514 is trying to acquire lock:
ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: rcu_lock_acquire sect/v6.13-rc4/./include/linux/rcupdate.h:337 [inline]
ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: rcu_read_lock sect/v6.13-rc4/./include/linux/rcupdate.h:849 [inline]
ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: start_flush_work sect/v6.13-rc4/kernel/workqueue.c:4137 [inline]
ffff8881115d5070 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}, at: __flush_work+0xd1/0xc40 sect/v6.13-rc4/kernel/workqueue.c:4195

but task is already holding lock:
ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock sect/v6.13-rc4/./include/net/sock.h:1623 [inline]
ffff88807db3a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_sock_close+0x25/0x100 sect/v6.13-rc4/net/bluetooth/sco.c:524

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       lock_acquire+0x1c4/0x520 sect/v6.13-rc4/kernel/locking/lockdep.c:5849
       lock_sock_nested+0x48/0x130 sect/v6.13-rc4/net/core/sock.c:3622
       lock_sock sect/v6.13-rc4/./include/net/sock.h:1623 [inline]
       sco_sock_timeout+0xbe/0x270 sect/v6.13-rc4/net/bluetooth/sco.c:158
       process_one_work sect/v6.13-rc4/kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa99/0x18f0 sect/v6.13-rc4/kernel/workqueue.c:3310
       worker_thread+0x8a9/0xd80 sect/v6.13-rc4/kernel/workqueue.c:3391
       kthread+0x2c6/0x360 sect/v6.13-rc4/kernel/kthread.c:389
       ret_from_fork+0x4e/0x80 sect/v6.13-rc4/arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 sect/v6.13-rc4/arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&(&conn->timeout_work)->work)){+.+.}-{0:0}:
       check_prev_add sect/v6.13-rc4/kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add sect/v6.13-rc4/kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x1888/0x5760 sect/v6.13-rc4/kernel/locking/lockdep.c:3904
       __lock_acquire+0x13b4/0x2120 sect/v6.13-rc4/kernel/locking/lockdep.c:5226
       lock_acquire+0x1c4/0x520 sect/v6.13-rc4/kernel/locking/lockdep.c:5849
       touch_work_lockdep_map sect/v6.13-rc4/kernel/workqueue.c:3909 [inline]
       start_flush_work sect/v6.13-rc4/kernel/workqueue.c:4163 [inline]
       __flush_work+0x70f/0xc40 sect/v6.13-rc4/kernel/workqueue.c:4195
       __cancel_work_sync sect/v6.13-rc4/kernel/workqueue.c:4351 [inline]
       disable_delayed_work_sync+0xbb/0xf0 sect/v6.13-rc4/kernel/workqueue.c:4514
       sco_conn_free sect/v6.13-rc4/net/bluetooth/sco.c:95 [inline]
       kref_put sect/v6.13-rc4/./include/linux/kref.h:65 [inline]
       sco_conn_put+0x18f/0x270 sect/v6.13-rc4/net/bluetooth/sco.c:107
       sco_chan_del+0xe2/0x210 sect/v6.13-rc4/net/bluetooth/sco.c:236
       sco_sock_close+0x8f/0x100 sect/v6.13-rc4/net/bluetooth/sco.c:526
       sco_sock_release+0x62/0x2d0 sect/v6.13-rc4/net/bluetooth/sco.c:1300
       __sock_release+0xe1/0x2d0 sect/v6.13-rc4/net/socket.c:640
       sock_close+0x1c/0x30 sect/v6.13-rc4/net/socket.c:1408
       __fput+0x2bd/0xa80 sect/v6.13-rc4/fs/file_table.c:450
       __fput_sync+0x15e/0x1c0 sect/v6.13-rc4/fs/file_table.c:535
       __do_sys_close sect/v6.13-rc4/fs/open.c:1554 [inline]
       __se_sys_close sect/v6.13-rc4/fs/open.c:1539 [inline]
       __x64_sys_close+0x93/0x120 sect/v6.13-rc4/fs/open.c:1539
       do_syscall_x64 sect/v6.13-rc4/arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xee/0x210 sect/v6.13-rc4/arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 net/bluetooth/sco.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fcc597be5bbd..c05f79b7aa31 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -570,10 +570,23 @@ static void __sco_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void sco_sock_close(struct sock *sk)
 {
+	struct sco_conn *conn;
+
+	lock_sock(sk);
+	conn = sco_pi(sk)->conn;
+	if (conn)
+		sco_conn_hold(conn);
+	release_sock(sk);
+
+	if (conn)
+		disable_delayed_work_sync(&conn->timeout_work);
+
 	lock_sock(sk);
-	sco_sock_clear_timer(sk);
 	__sco_sock_close(sk);
 	release_sock(sk);
+
+	if (conn)
+		sco_conn_put(conn);
 }
 
 static void sco_sock_init(struct sock *sk, struct sock *parent)
-- 
2.47.3

