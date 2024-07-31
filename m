Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0271A4B47
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417638; cv=none; b=CHZf5f9UCCYkZkGSxEQKxmbeYFzGYnA4nZzjD2Wu+xR25jxmTwfF7X3Q7K3iT0DMi2YidEjbBSJLn6WytlrWR8t9VIbhHg4qLxzDg88MnoJMrGPWx++eIZdQY5wBi5p8lQ1uG2Lh9KVV4ulwM6B6T+TKVR32adk7cNrAgA/UE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417638; c=relaxed/simple;
	bh=fqVROj36jGgnAplYULAM7G8uPL8WqevDHmipsFVRm0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4IGmLtZV5acy/O2NAkEzfLuCWFB0ONUVViLsEHK7TsbATVJbAal/fN2fMOKN6vBAM9S/EpNRykAHH0fEuOspt+cWYjIffMwFk5Z0brcRLMz2D8uFHCAYe9emGmoyVe6ussEpgAZFyndATaiN14kQ8RVKaAPoV84OaVbESWYkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=IvyDcI5m; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IvyDcI5m"
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:89:0:640:35fc:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 7E9B960AB6;
	Wed, 31 Jul 2024 12:20:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UKSsc0Bb6Gk0-uUAMZLTF;
	Wed, 31 Jul 2024 12:20:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722417631; bh=Se8pRohnsZdUKGnnNceppDXZLmaJGsTOrz2Vx6yixCo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=IvyDcI5mqRiBCD/r7GwVvsDMqTrb3hsERRFfEw3vwAO5mZ4Dv8EOOYWiHCrH0o6H4
	 WRxvx1shs+vVpA2It60tzLDsvYDR1Kvmekp1j6Mymm/N0+UpvL2LM5xcCQnkg1AXHL
	 X8CutYvdLLRycRJiNxPIj3YPdkmxyPqBT19Jmykg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()
Date: Wed, 31 Jul 2024 12:19:36 +0300
Message-ID: <20240731091936.476484-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing call to 'l2cap_chan_unlock()' on receive error handling
path in 'l2cap_conless_channel()'.

Fixes: a24cce144b98 ("Bluetooth: Fix reference counting of global L2CAP channels")
Reported-by: syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=45ac74737e866894acb0
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c3c26bbb5dda..9988ba382b68 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6774,6 +6774,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
-- 
2.45.2

