Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF926C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0BA2078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 19:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgE0Tjd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tjd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 15:39:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32666C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 12:39:33 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1je1tj-00055v-27; Wed, 27 May 2020 21:39:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R . Goncalves" <lclaudio@uudg.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] Bluetooth: Acquire sk_lock.slock without disabling interrupts
Date:   Wed, 27 May 2020 21:39:19 +0200
Message-Id: <20200527193919.1655228-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There was a lockdep which led to commit
   fad003b6c8e3d ("Bluetooth: Fix inconsistent lock state with RFCOMM")

Lockdep noticed that `sk->sk_lock.slock' was acquired without disabling
the softirq while the lock was also used in softirq context.
Unfortunately the solution back then was to disable interrupts before
acquiring the lock which however made lockdep happy.
It would have been enough to simply disable the softirq. Disabling
interrupts before acquiring a spinlock_t is not allowed on PREEMPT_RT
because these locks are converted to 'sleeping' spinlocks.

Use spin_lock_bh() in order to acquire the `sk_lock.slock'.

Reported-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/bluetooth/rfcomm/sock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b4eaf21360ef2..ad6ba6ce23436 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -64,15 +64,13 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, =
struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk =3D d->owner, *parent;
-	unsigned long flags;
=20
 	if (!sk)
 		return;
=20
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
=20
-	local_irq_save(flags);
-	bh_lock_sock(sk);
+	spin_lock_bh(&sk->sk_lock.slock);
=20
 	if (err)
 		sk->sk_err =3D err;
@@ -93,8 +91,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, =
int err)
 		sk->sk_state_change(sk);
 	}
=20
-	bh_unlock_sock(sk);
-	local_irq_restore(flags);
+	spin_lock_bh(&sk->sk_lock.slock);
=20
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
--=20
2.27.0.rc0

