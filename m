Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244589;
	b=tcTGqFzpBBVFgNT4HHHL3PyRTGcgxTR38APKyyxMKX6DN5fbfpTThZ/m0BDjLSTr3yle
	 /QV3cjPkvVCJoiMApOqe17Oh3/uXLxdeiYaOSDvFqS24ZhF7oO6nauBzh3xv2iU0WPgg7
	 3/224cGZ1ON0peS2qeRlDWMPOuwirUx1XcQE3OC/C2IDvyXuwn+na8WN+D8tek6zWHC1m
	 Dj2EnSBdTZb4IlAwZ+PQc1KoCZXthU4ckSTCxNy+2IEn7pgQYek1o4WAO5DzR7bpLq+97
	 60u4CEMKhsYStyKw01KNaBXgge0bf82V4m/E43up2y4WLq8Ni/JXo8wTozUS2CxwOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zW1+nYJZJVczs+5olEiRlw7lVib+eaHnFXEw3TWYskI=;
	b=PC1nGrS9bO/vCITdUQ6KGlZKPdnytIY4NfeOGATGQUAxeN0LpQaPzqdPQriRxX/chLaC
	 xHpNdO/FXaACpgxHhnOFXTUr7SmuoJUoL4ObGgiEtiEZnSt6/9vRTmL3o6A9iM618pORb
	 aoBS7JIWLThr4k6X1Wbk3eJnO2Gi8NFXBW1W21QQfCzzME4NVBPniw3J9KlHLTh2wycP5
	 lJ2lkmkNfa5lnRWS50jbdXt1H83nYR8DvGMN7qp4rbmgWp2lucL3g5svr0vTIbiR3JT0j
	 IjoNnlXpKrf+2+1WRSRQcibPKzCb12P2Q/t6an3a9lhXtxOEGFSP8r/DBq5UqFp0dYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7FIEMXG;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28ED606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F28ED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7FIEMXG
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so813074b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244588; x=1795849388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zW1+nYJZJVczs+5olEiRlw7lVib+eaHnFXEw3TWYskI=;
        b=A7FIEMXGXU7JQe2/BL6p6Ypv/aRiY+cbVu/eneOSLdvyHAM0o3KpmPYHgNQ0GGKOxW
         GFMGRp/G+foiQ68hypYnN7qlZLsbXkQb9s3GWrSc0ETMHllOFs6U3Va6tEZ5Nf9Q8luN
         I8YAK6xXb8qEcEqD3S9Z0nSblMMzzp4KuWE37UyjqVnOSeI0SKcBoNspsTcxMyDSAOdW
         GNDguHhu02FTfQNAuCYtmCiYR8LoeG1BSDtyHjHXdG+h2eoFwGa7/t5Kfc22QSibtWw2
         5usaOl/GGEGANYDiM80/d9tqeZAsTrzyguBB1xqCo1Md0tmPKO1ATgQuyBsWkem2Nkub
         mVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244588; x=1795849388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zW1+nYJZJVczs+5olEiRlw7lVib+eaHnFXEw3TWYskI=;
        b=ElZl1VPWbOh9Jkd3H1fe3vdFW2++qLztYU9v2RCksSdJ3U/ieiMn9ZQUXVtOJwg83/
         81YM6Ge2WO6F0ucHajzl49b0nMcXsVvB4UtLr8uFEJXHDdFbTdoHqQ4sJwCepLE011LI
         rfRxm8cA5ihOCp3jRBr15z3HnuV5S1wQMTq8sRnVzX8DUtKBH0p+2abTG0YEbiA3NT4U
         2Q5rKJVxJyvL53wr6N4nO7Aj0fCmvpaW6Ibg+lbJ21ZHcLWZbsYZA2c3vCoehNK1E1EG
         eq0X/xUbAEP+4idU+pgeKaIYauVv98NtFNmcHpNHz+6/Vo3GJ4jtmOv33qT5rTp8dQfZ
         0PfA==
X-Gm-Message-State: APuU4Z+0ibnhkDvEiQ2jR3HELkF2CF/0EWhwTyH9FvIZnqksu2Sm7lV1
	ZgNg51sor1Vhxwjd2duXxBWXpMl7XnFtok3RfAbBXPLX47mqlFjKQVLd
X-Gm-Gg: AZFdTZdIq39FrEufb76kyiNsU9mJ6uajeS71QN1nijJwAkjPZY7AtjllXt+jVmLsSnT
	Wpp/LUMfPuF67vAE70D5x5xHbfbTz8FQO+b9LCoWhV/cYmhnEe16HjAfm1eCWX3g4ycoz+A/wbl
	4paNd3seMUhpZaiSe0XWa+FyWvWiW3VSwRBFlQYuk1Ur5l4lxOqnNjXyyj0w12Jx8xVIvMz/Wgf
	RpirTHqFbJ83TJ6qifQTPP/RQVM/huTbdCaaJ5t0kGvXuoNA4xzxiuzkfwMc1JlTCD8WZOOKKzI
	JWYpvDf5S6oUeEVvGJNqoyUNhBSb9xMKkwHotbovPCMBNbOPf76AkaKNhaQj4k8bqkb2OQp70zM
	4OyR0MeG7CkaQJQWjtZxbnPiLb5SxJOYpnhYN2OXdVzyGuy/RZ0AncuzFHQnw1dLFOO4dSekToI
	CkizoiVdI6wvU7B+lvGa4glJssqt2TXj1f0A/h/IZ0b8FF+mAajh8+OoDuACMpGLRdhLmPaGAXL
	OggMU28Gb3gOfg3rVvQ+FjJVNB/JlnbiCbew8sFwh0JB9usNhOMPeEeR9O5rcA03Gl9b3nPA52G
	i90WjRbf3YF62C2tYuFgLCjP
X-Received: by 2002:a05:6a00:929e:b0:899:3439:c8d5 with SMTP id d2e1a72fcca58-8c87bdb5470mr5246786b3a.14.1795244588208;
        Fri, 20 Nov 2026 23:03:08 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm2477793b3a.13.2026.11.20.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:03:07 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: RFCOMM: Close the socket before transferring its DLC
Date: Sat, 21 Nov 2026 15:02:52 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-2@gmail.com>
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

RFCOMM_REUSE_DLC changes the DLC owner and callbacks to the TTY before
marking the old socket closed, without waiting for that socket's lock.
RFCOMM_CONNINFO can have passed its state check before this handoff:

  Socket getter                     TTY handoff / RFCOMM worker
  lock socket; check CONNECTED
                                    replace owner and callbacks
                                    close and free the session
  follow dlc->session->sock

The replacement TTY callback does not serialize with the old socket, so
the getter's socket lock no longer protects session teardown. Close the
old socket under its lock before replacing the callbacks. Existing
getters finish first and later getters reject the closed socket.

The excerpt below retains the headline and stack traces.

KASAN report as below:

    KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]

    RIP: 0010:rfcomm_sock_getsockopt+0x60a/0x950

    Call Trace:
     <TASK>
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_rfcomm_sock_getsockopt+0x10/0x10
     ? __might_fault+0x135/0x190
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? free_zapped_rcu+0xd0/0x1e0
     ? __might_fault+0xdd/0x190
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __might_fault+0x14e/0x190
     do_sock_getsockopt+0x342/0xa20
     ? __pfx_do_sock_getsockopt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _copy_to_user+0x7b/0x90
     ? srso_alias_return_thunk+0x5/0xfbef5
     __sys_getsockopt+0x113/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __x64_sys_getsockopt+0xc2/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     __x64_sys_getsockopt+0xc2/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7ff8b2e9007a

     </TASK>

    RIP: 0010:rfcomm_sock_getsockopt+0x60a/0x950

Fixes: 08d1914293da ("Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/tty.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 198c7dd1a95b4..676fade1ee8dd 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -286,6 +286,13 @@ static struct rfcomm_dev *__rfcomm_dev_add(struct rfcomm_dev_req *req,
 			skb_queue_tail(&dev->pending, skb);
 			atomic_sub(skb->len, &sk->sk_rmem_alloc);
 		}
+
+		/* Finish RFCOMM_CONNINFO before replacing the callback
+		 * which serializes session teardown with the socket.
+		 */
+		lock_sock(sk);
+		sk->sk_state = BT_CLOSED;
+		release_sock(sk);
 	}
 
 	dlc->data_ready   = rfcomm_dev_data_ready;
@@ -389,7 +396,6 @@ static int __rfcomm_create_dev(struct sock *sk, void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dlc *dlc;
-	int id;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -418,17 +424,7 @@ static int __rfcomm_create_dev(struct sock *sk, void __user *arg)
 			return -ENOMEM;
 	}
 
-	id = rfcomm_dev_add(&req, dlc);
-	if (id < 0)
-		return id;
-
-	if (req.flags & (1 << RFCOMM_REUSE_DLC)) {
-		/* DLC is now used by device.
-		 * Socket must be disconnected */
-		sk->sk_state = BT_CLOSED;
-	}
-
-	return id;
+	return rfcomm_dev_add(&req, dlc);
 }
 
 static int __rfcomm_release_dev(void __user *arg)
