Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9436262FFF
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916516; cv=none; b=KlFU20XKz5fHLGZhkyWC7kI0RuQCr0LJt5SJk15k8qJz4fzDky6DxSMF5chSeR3pzeXpDM/3xQ6Q/OoU3Mcp+wYVZ0CkT+uIn1D1xmiMfuAytiMS4EqtR+qlmG8drdumXwF3wsBTkTE02rDxnFM0n/ENly9TAXCxlwh3qKeUziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916516; c=relaxed/simple;
	bh=Nc+ss5wJXN0etEVRSYm+qlvGUDMk0Cr55Lp0DbZUqXo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i20V7KkTF5hCWUdHd9ScNCUuqic2H07j+vycIH/mtKbny/mZ/MSEP+AAxP8bZhPqx4bi275ge+NxU8DQN4Ggqa3VyKJWCjVlXKiuejAF8u6rfIBUfhlCSL/M7kZsTIEgCEa+gun7qpRjgfsSMxmEek8Bc5SCUtfPb26RLHoZiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSI64l7B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSI64l7B"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74d12fa4619so1086520b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751916514; x=1752521314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTe3WY4dFU7lk8Hr4ohTVbCzkrWX3p9PvAxpN+iYtRo=;
        b=sSI64l7BoK3HolCoJbYE0WT49LGUHqATx4QuuOooiuib0aBDEL78HbdfYoUw/lAJYO
         PmwDDGal2c3AjdyaTVd/X+YULqzsyr2Nj5hiRawb+47MawzM3Fxq8mu13yOE4HZqaOoI
         8QPVUltxqF7omuOs2HsJ7YgSjpW4U1gr7OajWl4RZdtvlvYfgAIAIDN6FXkOtNsiEEFd
         9qC7IpAPrXHV9N4bDou1Ilej+r93ANxoXp6obIoQqKu0lxEMjzjeKbHZepf8dTAwkqYU
         h3TC7nxV4dbYWp38pVjAvzO0W0GOfTgY2qsgb0VfqL6A/0Yn2C0YoCVamF6OBCKQ/nBU
         5pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751916514; x=1752521314;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTe3WY4dFU7lk8Hr4ohTVbCzkrWX3p9PvAxpN+iYtRo=;
        b=Xls6Z5GQHmI4RiHL679dCMhJXCissOFO1m0VWTHC10iorS7l8FYczT4279GbLrZflh
         Uhpw7TC+mjJQlXC34S8YWiYG4d6c+1f3epEYcnV/g+Qsn4LCiNTYSUrA+9GVILgwpDrh
         C5xzGPnQrl82WTCuKPI58wIltm6Ho3xS8Ur8PagPCyCg3fF15eCUYd722tZPrd8VKqgT
         8SnqmYCbmbhAHW4yP5qOUQXsShGPwVQ18lscsrRm4oJAicwnhUKTFnFSN5swz8jrzUXW
         zplhG1Utb77MK+iuMVY/MfQQ2SzKx4sSLigQo4z7pHO2usU/Adz/S7h5KMClc7B9aa8W
         1P9g==
X-Forwarded-Encrypted: i=1; AJvYcCVtAs2Wnm7+9SPqzz+qpdTB2JKRxc6ooGbitAzN2tF08s8968jg0S1Sw3xCGuWfV4sJcdgvqP8GvVD5rSBUlH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zam1158ZXDkVzUodDVlI5QuZ9kR2twQldSTRj2Tz1dkgMThn
	pXOSbXxg5LtigMTwZA00Unq+zcFuq6CofDV48NBSEwzQ8vtVbhNSq+yheXaT+9QXtXaTUzsK21/
	bHf/DGQ==
X-Google-Smtp-Source: AGHT+IEjebccA0AcwrkhzfmVQnDO+LKRW19FLJzhW4ssqvGSHadrwtadBvMoSiYtLzTL7FTydsdYDSLy9Lo=
X-Received: from pfbgl7.prod.google.com ([2002:a05:6a00:84c7:b0:748:df06:a477])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1905:b0:749:bc7:1577
 with SMTP id d2e1a72fcca58-74d24360040mr551884b3a.9.1751916514178; Mon, 07
 Jul 2025 12:28:34 -0700 (PDT)
Date: Mon,  7 Jul 2025 19:28:29 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707192832.3162227-1-kuniyu@google.com>
Subject: [PATCH] Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "Marcel Holtmann '" <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-bluetooth@vger.kernel.org, 
	syzbot+e4d73b165c3892852d22@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported null-ptr-deref in l2cap_sock_resume_cb(). [0]

l2cap_sock_resume_cb() has a similar problem that was fixed by commit
1bff51ea59a9 ("Bluetooth: fix use-after-free error in lock_sock_nested()").

Since both l2cap_sock_kill() and l2cap_sock_resume_cb() are executed
under l2cap_sock_resume_cb(), we can avoid the issue simply by checking
if chan->data is NULL.

Let's not access to the killed socket in l2cap_sock_resume_cb().

[0]:
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
Write of size 8 at addr 0000000000000570 by task kworker/u9:0/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:524
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

Fixes: d97c899bde33 ("Bluetooth: Introduce L2CAP channel callback for resuming")
Reported-by: syzbot+e4d73b165c3892852d22@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/686c12bd.a70a0220.29fe6c.0b13.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/bluetooth/l2cap_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5aa55fa69594..82d943c4cb50 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1703,6 +1703,9 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
-- 
2.50.0.727.gbf7dc18ff4-goog

