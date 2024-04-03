Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C52149E14
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154478; cv=none; b=AfZ7T44oh0SkByCQGjlEUjngGSCe5HjF4OeWJrVhRqB8DpDdxnKxV8y/zi+ml0hbxY4xspTzp2quce1ggHKtjd7du1eRfaOHLEYB7Q9OGC42+my+AXGvtJ+hJyoB8jIXgphQebXdwlcsGbbUmL+S6jgf8tZM7ppf1CGnRRrRHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154478; c=relaxed/simple;
	bh=V5zDboOWLKCBD+kgckSQuxDbzmz/IroeXb43whbd8p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HH3bADlyxcyQp0lF9Ob+b4w7sqJi3uYVGvMiFqTkKX1YuR3vEhNJIId+/9v3KA018PKPLMmHT/wAppRsDbG4Yhs0zQoyklLteiDsCZhWQSCN4SAotZFEr5HJPwcInjPwzvMeE0nNt9LO6GPzzOAhdmIp7S7t4u7xZh+plNJoKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VqxySG08; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VqxySG08"
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:193:0:640:a325:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id B49B9608FE;
	Wed,  3 Apr 2024 17:27:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kRUjtqBmBOs0-6MEmlqmM;
	Wed, 03 Apr 2024 17:27:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712154466; bh=QDHrTfQGhkv9YhmdL+gS3wLPwdQkfetGjLEEMPvsCuY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=VqxySG08AOhdize/tjlPe1XXZodFboFUtnJk6DG5HxoPHpnS5YqPDPRYfwZSVQrO1
	 IffPjkxWUCUfrG6YtDXQDEqi7UzTnvqXcBx66fTggnqJH20x6xdlRJeqw4vMnf6DNM
	 ZHH7AXSfsUTcdaJYQ5digR7Flnarj5DLqgynjq2M=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [RFC] Bluetooth: fix race condition in sco_connect()
Date: Wed,  3 Apr 2024 17:27:06 +0300
Message-ID: <20240403142706.25748-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is intended to fix the race condition between two
'sco_connect()' calls, where two instances of 'struct sco_conn'
are erroneously set up to share the pointer to the same 'struct
sock'. When one of the connections goes away, it destroys an
underlying socket as well, leaving dangling pointer to destroyed
socket within another. Next, if the latter (alive) connection
enters 'sco_sock_timeout()', an attempt to do 'lock_sock()' on
a destroyed socket causes use-after-free write reported by KASAN
at https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 43daf965a01e..f8e5e4c3420f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -228,7 +228,7 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	int err = 0;
 
 	sco_conn_lock(conn);
-	if (conn->sk)
+	if (conn->sk || sco_pi(sk)->conn)
 		err = -EBUSY;
 	else
 		__sco_chan_add(conn, sk, parent);
-- 
2.44.0

