Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B683A7F6F
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348264; cv=none; b=QwQUpmzfCZeVIHbqwiV9FGF1BgKB7aWGwYXjD8nRcQuslI11+yWT3sqdnt2ZoLnb/T78meLjeg0IWxp/1aSexnahf5LKFvvHo7NviqUZR/UZ1MahzH+Z2NVgVOxsqy0Ma3Ad/oQGbPGoo1phx3uD65o+xsiJgDIAKG0LLAFLSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348264; c=relaxed/simple;
	bh=I7t5q5hv4eMLevE6KOcpV5PBeoi1BPFTA3lfTL1x0R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u3RORJH370yDHuOEkRP3AHyF0PgkaStZpuJMeXqDincP0orhV+2XJd+quwPGZFJMBUYgkCTFTB3YWOo7HR9nws95WXUSskER4skxYm4M/Z/znj0tfdEAFVmE5w5ET8/dEYOfHga4oEEvXbzN/9LFrpBpQSol6x6zU7Mg/I3FHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOGlVw/y; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOGlVw/y"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ba4a1a0325so21607165ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778348262; x=1778953062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mw3B+YxDKfj8tFV2xTgPlRdOE16ht898X2ckp1lDjzQ=;
        b=QOGlVw/yH2Ga4v2Aa1v3BLqy8v9BAEFe2VMttCytfKEB9JhkB/wF8FwP3O1Fvb6rHs
         wu59q+sjgClY0c4q7OVPLlODWLCdRFiILy5cUXs1KPGg9ldpxJCJAp1ksalzaWZpoDm8
         hpboFW9cw3cR/kdc9NzEaja8fEIoITXET4MGq+AzAvt6fJ06RAy0JqGSi9zJTLbRoWM7
         FnOOriJ0LB6AJ5AhIekIHO/HN6RF9lg2/DZdmDDaeN2pKArK/FAeuvxeDd0wZq8DO6kU
         bhnNOukJ4x/9cjcKiDiwWgGVHaVlRV6HfVum9WH3VY1QtkdbPvjLkFAlQU2XbFW5jZfc
         w8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778348262; x=1778953062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw3B+YxDKfj8tFV2xTgPlRdOE16ht898X2ckp1lDjzQ=;
        b=GCrxCGUcCv1QkJQO8wxW08FkRnrj/wGOkCQba7Y/YeOCLUwcjEWC9QaxygxcQ1ldV0
         JTBNHJJ+xV54cXL8b85faEJmVPQ4w+i/BKdJcTc3xAEeu3kN/Aeg1Br1BZwMF30INR+W
         N4S8sYVrPB/GfLhBn8TQh5eeIP/d8yNieFPwgE2DyiGDicAhZZQuaO9V+Obs3j3N7xd1
         /WV5I2Qg9S9CVCX7KIIBS7TIUK1pVMsRSYv+TP1zc6M9nwQViiiMzEgMv2UZOcH+ALT9
         XX2Kr/HvWJi+qL0AbxR3yPElQqgjmz14v8d5Y/BblQYBcJ3HODIzW3QDyzR5fvSTpIkx
         XN1A==
X-Gm-Message-State: AOJu0YxPsVKvKdY4QuGvVjDE2YyUv7thPHen2f6gMc9qGNZw+3FWLRL3
	CImds3z677d+dDObZtNb2ZM/FxrVjSMFpS5g0wS6hH31CBV05HLaBrbW
X-Gm-Gg: Acq92OFlU5t3UNJNCNFI4ki2x4kkqbI3zEanuS7QkfNhBaEM2UwJqCADMJ9gJHPce0o
	Yntsn1nwXilF3uEn+jW7q45KaC1YYGYrsUwTUAG7YGiRAeBjEA0DCP+WCBRijTUL0bRrPeXPyqG
	bDAktAViatQm+8o2KgoXRwsFI/sCrII9GkgJE31S7k+4D3fFe5G4qbJNdnBNgljRkhc5AOZKMnr
	JWN2K1uhhYeW5C8oqxOaYbDRJrT5boYfW0JgevDDKU1+/lnsBZNJq+4/j918P3lzDCXUq/vf7Rx
	5SaC7UgmI6OsLA/z6z2aMlvnK1XRTFGL3x8w3tbsrdscBv/SHvLnPpkYI+299UMmnmNBihMm8v9
	4KoSY4hQKhv9wa+7hEu9pbcNb7Pt14WA61wdSrvTSPkeqNSORJcVyxEkho8srOtTW8p3wNHhoEm
	i9ZecrJQAcOcJ32kOm1WJKVmfiQBEEK99r1oU0h76xcg==
X-Received: by 2002:a17:903:1446:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2bc7a99c150mr28136335ad.11.1778348261984;
        Sat, 09 May 2026 10:37:41 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec232esm58010745ad.81.2026.05.09.10.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:37:41 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
Date: Sun, 10 May 2026 01:37:27 +0800
Message-Id: <20260509173727.412674-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_get_sock_by_channel() returns a listener from rfcomm_sk_list
after dropping rfcomm_sk_list.lock, but it does not hold a reference on
that socket. rfcomm_connect_ind() then locks the listener, queues a
child on it, and may still notify it after unlocking it.

rfcomm_connect_ind()              listener close
1. Look up the parent on          1. close() enters
   rfcomm_sk_list.                   rfcomm_sock_release().
2. Drop rfcomm_sk_list.lock       2. rfcomm_sock_shutdown()
   without pinning the listener.     starts tearing the listener down.
3. Later call lock_sock(parent),  3. rfcomm_sock_kill() unlinks the
   bt_accept_enqueue(parent, ...),   listener and drops its last
   or the deferred-setup callback.   reference.

Take a socket reference on the selected listener before leaving
rfcomm_sk_list.lock, re-check that the parent is still in BT_LISTEN
after locking it, cache the deferred-setup bit while the parent is
locked, and drop the extra reference after the last parent use in
rfcomm_connect_ind().

The buggy scenario involves two paths, with each column showing the order within that path:

  rfcomm_connect_ind():                  listener close:
  1. Call                                1. close() enters
     rfcomm_get_sock_by_channel(BT_LISTEN,       rfcomm_sock_release()
     channel, &src)
  2. Return the matched listener         2. rfcomm_sock_shutdown() runs
     after                                  the BT_LISTEN close path and
     read_unlock(&rfcomm_sk_list.lock)       rfcomm_sock_cleanup_listen(parent)
     without sock_hold()                    sets parent->sk_state =
                                            BT_CLOSED and SOCK_ZAPPED
  3. Later call lock_sock(parent)        3. rfcomm_sock_release() calls
     and bt_accept_enqueue(parent,          sock_orphan(parent) and
     sk, true)                              rfcomm_sock_kill(parent)
  4. After release_sock(parent),         4. rfcomm_sock_kill() unlinks
     read bt_sk(parent)->flags and          the listener from
     may call                               rfcomm_sk_list and sock_put()
     parent->sk_state_change(parent)        can free it

The lookup path drops rfcomm_sk_list.lock without a private reference,
so listener close can mark the socket closed, unlink it, and free it
before rfcomm_connect_ind() reaches lock_sock(), bt_accept_enqueue(), or
its deferred-setup callback.

rfcomm_lock serializes RFCOMM core work but does not serialize userspace
close against rfcomm_sock_release() or rfcomm_sock_kill().

Sanitizer validation reported:
BUG: KASAN: slab-use-after-free in lock_sock_nested()
Read of size 1 at addr ffff88810da92250
Call trace:
  dump_stack_lvl() (?:?)
  print_address_description() (mm/kasan/report.c:373)
  lock_sock_nested() (net/core/sock.c:3780)
  print_report() (?:?)
  __virt_addr_valid() (?:?)
  srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
  kasan_addr_to_slab() (mm/kasan/common.c:45)
  kasan_report() (?:?)
  __kasan_check_byte() (mm/kasan/common.c:571)
  lock_acquire() (?:?)
  rcu_is_watching() (?:?)
  rfcomm_connect_ind() (net/bluetooth/rfcomm/sock.c:952)
  rfcomm_recv_pn() (net/bluetooth/rfcomm/core.c:1432)
  trace_clock_x86_tsc() (arch/x86/kernel/trace_clock.c:14)
  __lock_acquire() (kernel/locking/lockdep.c:5077)
  rfcomm_recv_mcc() (net/bluetooth/rfcomm/core.c:1645)
  do_raw_spin_lock() (?:?)
  mark_held_locks() (kernel/locking/lockdep.c:4308)
  rfcomm_recv_frame() (net/bluetooth/rfcomm/core.c:1738)
  rfcomm_process_rx() (net/bluetooth/rfcomm/core.c:1933)
  rfcomm_run() (net/bluetooth/rfcomm/core.c:2114)
  find_held_lock() (kernel/locking/lockdep.c:5340)
  _raw_spin_unlock_irqrestore() (kernel/locking/spinlock.c:196)
  lockdep_hardirqs_on() (?:?)
  __kthread_parkme() (kernel/kthread.c:259)
  kthread() (?:?)
  _raw_spin_unlock_irq() (kernel/locking/spinlock.c:204)
  ret_from_fork() (?:?)
  __switch_to() (?:?)
  ret_from_fork_asm() (?:?)
  kasan_save_stack() (mm/kasan/common.c:52)
  kasan_save_track() (mm/kasan/common.c:74)
  __kasan_kmalloc() (?:?)
  __kmalloc_noprof() (?:?)
  sk_prot_alloc() (net/core/sock.c:2233)
  sk_alloc() (?:?)
  bt_sock_alloc() (?:?)
  rfcomm_sock_alloc() (net/bluetooth/rfcomm/sock.c:271)
  rfcomm_sock_create() (net/bluetooth/rfcomm/sock.c:305)
  bt_sock_create() (net/bluetooth/af_bluetooth.c:116)
  __sock_create() (?:?)
  __sys_socket() (net/socket.c:1801)
  __x64_sys_socket() (?:?)
  do_syscall_64() (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe() (?:?)
  kasan_save_free_info() (?:?)
  __kasan_slab_free() (?:?)
  kfree() (?:?)
  __sk_destruct() (net/core/sock.c:2345)
  sk_destruct() (net/core/sock.c:2402)
  __sk_free() (net/core/sock.c:2417)
  sk_free() (net/core/sock.c:2428)
  rfcomm_sock_kill() (net/bluetooth/rfcomm/sock.c:192)
  rfcomm_sock_release() (net/bluetooth/rfcomm/sock.c:912)
  __sock_release() (net/socket.c:713)

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index be6639cd6f59..677c9cd22fb2 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -122,7 +122,7 @@ static struct sock *__rfcomm_get_listen_sock_by_addr(u8 channel, bdaddr_t *src)
 }
 
 /* Find socket with channel and source bdaddr.
- * Returns closest match.
+ * Returns closest match with an extra reference held.
  */
 static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *src)
 {
@@ -136,15 +136,25 @@ static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *
 
 		if (rfcomm_pi(sk)->channel == channel) {
 			/* Exact match. */
-			if (!bacmp(&rfcomm_pi(sk)->src, src))
+			if (!bacmp(&rfcomm_pi(sk)->src, src)) {
+				sock_hold(sk);
 				break;
+			}
 
 			/* Closest match */
-			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY))
+			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY)) {
+				if (sk1)
+					sock_put(sk1);
+
 				sk1 = sk;
+				sock_hold(sk1);
+			}
 		}
 	}
 
+	if (sk && sk1)
+		sock_put(sk1);
+
 	read_unlock(&rfcomm_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -934,6 +944,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 {
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
+	bool defer_setup = false;
 	int result = 0;
 
 	BT_DBG("session %p channel %d", s, channel);
@@ -947,6 +958,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 
 	lock_sock(parent);
 
+	if (parent->sk_state != BT_LISTEN)
+		goto done;
+
+	defer_setup = test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags);
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -974,9 +990,11 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 done:
 	release_sock(parent);
 
-	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+	if (defer_setup)
 		parent->sk_state_change(parent);
 
+	sock_put(parent);
+
 	return result;
 }
