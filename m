Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158046F525;
	Tue,  7 May 2024 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082184; cv=none; b=NjoTVaABLKUkpnJ7sTkjtcb7nYv9Jmgae3egx+2PjHU8UYzkSICwCDQmOQ9WkDsaRsp/bJdcsni0miu/S3m1vFFY9bK/LTt6zMKIrBQtnephKxAJiVHyInzv7yVXKLcQ66hB24PT95vHPC60hlHFLvsy9saTnH/ChL3aAiXBYsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082184; c=relaxed/simple;
	bh=48MNBx4lKU8jug/3dAjRcd+PwBhYp8+m1AtXcjxvV+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0EPHIIqqr0R6YiX+xWNz9/qNtck2kXXV24FA3iy76r1v3eltRqWKH0mgyVKbYRUkxRas7iAqesiIungxjZLAIH1jLKF2WPkMx6X0w2bcs8kGdz7/tWEHYHVerWGfgtpyIW6O6F5t+JeuyC776BANipRUoBOs1qA/6WYZJ7k7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 668D72F20249; Tue,  7 May 2024 11:42:52 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 0DF652F20245;
	Tue,  7 May 2024 11:42:52 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH] Bluetooth: RFCOMM: possible deadlock in rfcomm_dlc_exists
Date: Tue,  7 May 2024 14:42:44 +0300
Message-ID: <20240507114244.120751-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was found by syzkaller.
This bug is also very similar to another RFCOMM possible deadlock
in rfcomm_dlc_exists. Both of these bugs are present in syzbot.
Patch fixes two of these possible dedlock errors.
Also this particular patch was already written in march of 2023
by Hillf Danton, but seems like it just got lost or forgotten.
Links to these bugs and original patch on syzbot:
Link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
Link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
Link: https://syzkaller.appspot.com/text?tag=Patch&x=133a6835c80000

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 net/bluetooth/rfcomm/core.c |  2 +-
 net/bluetooth/rfcomm/sock.c |  2 --
 net/bluetooth/rfcomm/tty.c  | 11 +++++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 1d34d849703329..d8502914e3602c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -490,8 +490,8 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 
 		rfcomm_dlc_lock(d);
 		d->state = BT_CLOSED;
-		d->state_change(d, err);
 		rfcomm_dlc_unlock(d);
+		d->state_change(d, err);
 
 		skb_queue_purge(&d->tx_queue);
 		rfcomm_dlc_unlink(d);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 29aa07e9db9d71..cbff37b3273407 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -865,9 +865,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 
 	if (err == -ENOIOCTLCMD) {
 #ifdef CONFIG_BT_RFCOMM_TTY
-		lock_sock(sk);
 		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
-		release_sock(sk);
 #else
 		err = -EOPNOTSUPP;
 #endif
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 69c75c041fe10a..5be21b987141fc 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -403,9 +403,12 @@ static int __rfcomm_create_dev(struct sock *sk, void __user *arg)
 		return -EPERM;
 
 	if (req.flags & (1 << RFCOMM_REUSE_DLC)) {
+		lock_sock(sk);
 		/* Socket must be connected */
-		if (sk->sk_state != BT_CONNECTED)
+		if (sk->sk_state != BT_CONNECTED) {
+			release_sock(sk);
 			return -EBADFD;
+		}
 
 		dlc = rfcomm_pi(sk)->dlc;
 		rfcomm_dlc_hold(dlc);
@@ -422,13 +425,13 @@ static int __rfcomm_create_dev(struct sock *sk, void __user *arg)
 	}
 
 	id = rfcomm_dev_add(&req, dlc);
-	if (id < 0)
-		return id;
 
 	if (req.flags & (1 << RFCOMM_REUSE_DLC)) {
 		/* DLC is now used by device.
 		 * Socket must be disconnected */
-		sk->sk_state = BT_CLOSED;
+		if (!(id < 0))
+			sk->sk_state = BT_CLOSED;
+		release_sock(sk);
 	}
 
 	return id;
-- 
2.42.1

