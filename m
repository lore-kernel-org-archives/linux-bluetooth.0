Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244585;
	b=FyWaxwwdbFKvsSfVgYekKqz/kRWvfok7n3QXM1WT7miFPHWCKTnn9a4pyjCho5HE6Yw3
	 a+2ztT0Cz2pPRPIdtHtqNqMQs+JyCVxN5mG1HKQmNXL9XmusKSsSKpl0UNNLPmFf92ekU
	 BLaPc39npBCGb2vhSfpJW17xVyGXw6TJi5mYB2JwtMv63qX2a9V/VSqBwGCXVJMA27caV
	 UmvfkuMivLEfiQVQrzJ+XbT/kwN+ICbowxqU6JYIiSUJw1T4wflpN+xwCcXq2LZxuqrX1
	 cbgzeGgAW8QFr1ZjeOZ/kMCDzY+qjOoMBi9RREt6DwRx7mDjQEhf3divwfgjcFSyZmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nEJcc2N7i/qeRLdr+wgd+TOtAum7vq9L8QCB+1qczhU=;
	b=zXtVn3OqLadhqgWzGnrzNgE5QqCY7CyMrV3DX6h2mSECeWDbs21SWgVjDfzDmISJjxix
	 lljboNaQUCPEYv6ZJMJcDNKoqWVzQDlZBvgXWpQiTNFq6YYAlY1Fd5wBlV4V0/ZGNL6Tq
	 OXMwBf86dolBMUwRPVlVCC7G8u8d1F+kiQSTIK+QoJVpy62rXKmQUwlhFHEK3kok4WIBH
	 V1HW65IeOg3B4pEK5uy5Z7VazlL0cCVcUKal6BwnfCtG6rBsfpvLwKdWYtnwdHtaB5wrm
	 FOTGr+3PYLK60hhOMHLnlzi6WxtF+NM4QGNfNsMVBr4H6GaHKc3Egthm3DMBSMFcwcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tX6U/6jU";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED5606A339
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBED5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tX6U/6jU
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1428208b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244584; x=1795849384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEJcc2N7i/qeRLdr+wgd+TOtAum7vq9L8QCB+1qczhU=;
        b=tX6U/6jUz7vDCOfLVdIjOqPHfPD1dm430ZabHV+PfK3F/r5ZmJrcBAkmmVgZZMKr7c
         RQS32DjrXLxvundJ5IAld86RmP+wyoIWNrpUEqs+z+j95zKTIFgvr7anVZC++diOaU1I
         9U87HVlmmzL7y5UeEJZdMwffT9nVpKRoLCYo1n8XHWHMBb+he7sbfO6BZjQKLyZtkMRP
         vYRVU/WEPidvIdDBYwqXZQ4UN2V8zto9rfT0rWdHKnqlhesGdKE5h9YuNMUYSHRIwdvf
         1D6Fzq4xzAU8EV/RAVznkfw3e/QfGVlXJi77OC6fS4FjsTmUlJBLAkqcHaf+Y0NaVBpq
         TuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244584; x=1795849384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEJcc2N7i/qeRLdr+wgd+TOtAum7vq9L8QCB+1qczhU=;
        b=JobLf8bNee+juY9a3pFDRbQswNKf6ur6J1+jT/bb5pe+AbHCnSIYUngM9ZYwG9BRL/
         MBnEhjwW4wRh4hK0EZvTwK7SZ99Sf8RTCawIsESIOny/Xw+Bh04K1pfs33v3mtivoVYH
         D/JG3afCsN758J/e6Gyt0S/UO3q36xcKpaMDYArRx47+INLFm/moaENh9eWgGvUFnCfC
         5Z31INPNb0PrNbQv5ELueQQTHr3fqIzFykODe0RE+Pw2ePsEq8SXaj+OKfIHRDATERo0
         6XmWgZZZUhoQMOqDNluSJACJGmOOjGKNgpsqmgU7q8jh39oO2IJ/bk5PheAHf2TwJ/Mw
         BVZQ==
X-Gm-Message-State: APuU4Z8Vg016tOtT1YjnfgdNJJzjqE3lBIS6HFTrq8CM3kQ9ZRwsqkYc
	sVaxkXWOeObFvYvlJb4XaOab+DJXpiz71GS2kYRaPfJvc2N0RarnWfbD
X-Gm-Gg: AZFdTZdB/7RhO6sgwdLSMbnIUvpNZ/IUvPB7H5oOBIWC2+6HVnyEaC/u4TYADnjH+HN
	3o3/EftTQQAU6z+yOtGZx1WyHOpISZjiwEK5x6H+5n/XivmhMPJ5MJwJJavZsugbpnXEnvVRdxI
	Eo17+9TYNCZztjnNx7JHtqeZV3qarRtUgbuYpCObE7Tc4dWzxdiewyVbs0aZyp57yo16vxg0wm6
	EQXOo/QwQZR2GW0jopueBw6H8cYrMZEQxqOrvFRQaMN1ukhBXRPGw4KRDHvUQyTSANTg87VCO9k
	bSvBmZah2ogfdjFnDKiqN1svZXte1FLyCPfmWmgeIEw3dS8jdvpJefT3qXwa+P3PfNJ9jaPh2B7
	wvTBtkX4d+Y1Im9UlWffYXze1HnQlZE57xi1eenxxcB1S6d9jqKFMBRySTG+KrV5Y0OEIxa2LLu
	2O2tOdOzlijOLesLNrP9WKFeVt0iVgyP/kiihGVafOjhLbDFDzoeY2iNHyVBPHpLVxxUKJnpPVE
	c85+njJ4eF9/O8LlrHv/15+K/oUnENaOrfWW22fF7K1WWDWoklu2TrmRKzgwKPchc2yIg1EmIp8
	ydbeond7ME/d4dW5DP3k/OPY
X-Received: by 2002:a05:6a20:914b:b0:3e0:ca2a:f9e with SMTP id adf61e73a8af0-4014c05d475mr6448666637.39.1795244584024;
        Fri, 20 Nov 2026 23:03:04 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm2477793b3a.13.2026.11.20.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:03:03 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: RFCOMM: Hold the listener across child unlink
Date: Sat, 21 Nov 2026 15:02:51 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
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

rfcomm_sk_state_change() saves the listener pointer, unlinks a closed
unaccepted child, and then notifies the listener. Once the child is no
longer on the accept queue, listener release can finish without waiting
for that callback:

  RFCOMM callback                   Listener release
  lock child socket
  save parent
  bt_accept_unlink(child)
                                    drain the empty accept queue
                                    drop the last listener reference
  parent->sk_data_ready(parent)

Take a listener reference before unlinking and release it after the
notification. Track that reference separately from SOCK_ZAPPED so a
different state does not release a reference it never acquired. Drop
the DLC lock before either socket can be destroyed.

The excerpt below retains the headline and stack traces.

Keep the socket reference across accept-queue unlink, as commit
4bd0b274054f ("Bluetooth: fix UAF in bt_accept_dequeue()") does for
the dequeued socket.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in rfcomm_sk_state_change+0x3a4/0x3f0
    Read of size 8 at addr ffff88810bc8b188 by task krfcommd/75

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? rfcomm_sk_state_change+0x3a4/0x3f0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? rfcomm_sk_state_change+0x3a4/0x3f0
     kasan_report+0xe0/0x110
     ? rfcomm_sk_state_change+0x3a4/0x3f0
     rfcomm_sk_state_change+0x3a4/0x3f0
     __rfcomm_dlc_close+0x1a6/0x6d0
     rfcomm_run+0x1b7c/0x5390
     ? __pfx_rfcomm_run+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_woken_wake_function+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x280
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x175/0x220
     ? __pfx_rfcomm_run+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 513:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_noprof+0x2d7/0x770
     sk_prot_alloc+0x13e/0x260
     sk_alloc+0x37/0xb40
     bt_sock_alloc+0x40/0x3b0
     rfcomm_sock_alloc.constprop.0+0x56/0x290
     rfcomm_sock_create+0xe6/0x170
     bt_sock_create+0x171/0x330
     __sock_create+0x2c4/0x730
     __sys_socket+0x141/0x210
     __x64_sys_socket+0x77/0xc0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 515:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     __sk_destruct+0x64f/0x790
     sk_destruct+0xb3/0xd0
     __sk_free+0xdd/0x370
     sk_free+0x51/0x80
     rfcomm_sock_kill+0x108/0x310
     rfcomm_sock_release+0x122/0x1a0
     __sock_release+0xb8/0x270
     sock_close+0x21/0x30
     __fput+0x39f/0xa60
     fput_close_sync+0xff/0x200
     __x64_sys_close+0x8c/0xf0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/sock.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3ec2fb4ce5804..948f0da417bdc 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -65,7 +65,8 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	__must_hold(&d->lock)
 {
-	struct sock *sk = d->owner, *parent;
+	struct sock *sk = d->owner, *parent, *parent_ref = NULL;
+	bool kill;
 
 	if (!sk)
 		return;
@@ -82,6 +83,9 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	parent = bt_sk(sk)->parent;
 	if (parent) {
 		if (d->state == BT_CLOSED) {
+			/* Keep the listener alive across unlink. */
+			sock_hold(parent);
+			parent_ref = parent;
 			sock_set_flag(sk, SOCK_ZAPPED);
 			bt_accept_unlink(sk);
 		}
@@ -95,11 +99,14 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 
 	release_sock(sk);
 
-	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
-		/* We have to drop DLC lock here, otherwise
-		 * rfcomm_sock_destruct() will dead lock. */
+	kill = parent && sock_flag(sk, SOCK_ZAPPED);
+	if (kill || parent_ref) {
+		/* Socket destruction takes a DLC lock. */
 		rfcomm_dlc_unlock(d);
-		rfcomm_sock_kill(sk);
+		if (kill)
+			rfcomm_sock_kill(sk);
+		if (parent_ref)
+			sock_put(parent_ref);
 		rfcomm_dlc_lock(d);
 	}
 }
