Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F02868D;
	Tue, 11 Jun 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118176; cv=none; b=IWH98dlPHrDmttp2UEYPgq8QUWUzm4ElUBhOaO5oKQp8wkuaqMdzOEccqiHrkczg9o4SR5Tq83pSgEst2wCsWvv/22Dq1YT1g5l/1atU6ouTZ1VCrNyuNYPZSSIZdZfVYH3toUHu7PSIUJV18Z8Isc3L9CMbw+CCaqnamCMLWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118176; c=relaxed/simple;
	bh=SD9Ox2uEgLQshHdPNaSlBqTcE1dEXOGR6zfPNYTOHgQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gRg0h3g8AMpgDt+iiNFVrobDSQs7LXwU0Y4T73GRULf9WYk67jSoOMk1Ylqx/8w7/Oj/dudX+2LaTgid8DbTDg2aYLWJjMYFRR4wkVZtNbiu5iID89hHTVDrRqCYNNNoCNvXqEbeplWvNaKLppCcsLdwNnQuA7ixG5KkfELJxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f42GHxX+; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f42GHxX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718118165; bh=EYZJeMpHWJRkQqovyVl3G5DqtUj1NtUFyItaVN67Ogk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f42GHxX+j+2EYRXI3DgQqOOzhfCb1/4MUj2V49+H5LEvRrxnPjG9SJL3EvyuQGROY
	 fHxwfiQK+gIAouaqOYeYLQHeI2KmfWjrix+fUP3lVf20Kql43B4glSyVYJZvV29OxT
	 Kfmena5swtfEepp8mvkTVJ6CmbqvqzhGj2tp8EBs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id C9107ACF; Tue, 11 Jun 2024 22:50:17 +0800
X-QQ-mid: xmsmtpt1718117417tpy0idpsl
Message-ID: <tencent_0CCE4C90A7C306FCD2EE466AC9882EFFAE06@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NotV1rPa9aT9fXzjVDRjmoVre1tPCLpk+PR3dw+8o/OClgcieWx/
	 Z+J5aQb0hcyNQhrKegLlWcSOX1GZT+vxFZChIuE9eoFfdg8zrOdWFS45YmTJ1zxgm49m2a5Yv597
	 ayyBDbo595mOsHMJG253NmqW2lX91Y1WXnha9C1NdTJ9+aT5y8rrRGataNf1TqhDOVqC8YC5EBvg
	 j8Rh1bP5ieC+tMEDRD9jogUAKLrFFnS4/Xiy4XoZPQ5ukc22+2YfjFoNofsOe07X//cghIuYcUkG
	 1QgFad5EkH57Nhoa2lukc8qcxFFH4CnSrB5Fx/v11Pi1BUwj6TZ1/7irlxVF3BsfAlCSMmiFnZIA
	 weQoZ88Y6+NjeMyqKbnL6NHmEvTMo5aBfq2Gt25MZSPBBhuGBZNiRDhm9YhZqbbGVS7oslzoHvdL
	 CpI0MUeQzrTJNFVNuYO+CmuEVgtIeZp/RdWW2ATCXFf+BPHJk5fL5kHQv3hS8OYTlHRmmyqVzYQC
	 bOeHuPDBrQI9h0oT6+NP4h92rTJCfmeHvW5BUMW6ItkgUhiZhINnrnRFM7qIMHcajXPY6K1WLtOx
	 mgH3/Vx32vYLjMyK7H+2EY3uWDCOhqiExPVKfLnM7QljgC7RnRob6nIVL+nUKcZBaaFVgjsLukiR
	 OmY9M9eRpQlzLuKoPdaE9+t5yysAT9cZmOkj6A4st8wCsSRv5JJTmEMn1eYFqvGk06yl6+tDrnD7
	 omiAWwxi7fdqAL/Q31TAT4PeMzl6NUoYGKRg8HVv/JyIi9GwJcO2Z6WeowkdGoTtFAiOD1BZx8CD
	 FgKuiaL+FnsEJ9xhgYPruS3mJFuvxXbVPxvDX9adD+bRDJ+MdtCWHzs2yeTXElhe2U0/QqAhNvZ5
	 +/RF+6PmJ4ubmXwi2AXDmDrr9LhAXrIhE1TG5oHOn0tE/q/X8ecCrIcw/xT1U2uAMtsvipmo2K
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] bluetooth/l2cap: sync sock recv cb and release
Date: Tue, 11 Jun 2024 22:50:17 +0800
X-OQ-MSGID: <20240611145016.2085712-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0906d061a468b93@google.com>
References: <000000000000b0906d061a468b93@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The problem occurs between the system call to close the sock and hci_rx_work,
where the former releases the sock and the latter accesses it without lock protection.

           CPU0                       CPU1
           ----                       ----
           sock_close                 hci_rx_work
	   l2cap_sock_release         hci_acldata_packet
	   l2cap_sock_kill            l2cap_recv_frame
	   sk_free                    l2cap_conless_channel
	                              l2cap_sock_recv_cb

If hci_rx_work processes the data that needs to be received before the sock is
closed, then everything is normal; Otherwise, the work thread may access the
released sock when receiving data.

Add a chan mutex in the rx callback of the sock to achieve synchronization between
the sock release and recv cb.

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/l2cap_sock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..f3e9236293e1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1413,6 +1413,8 @@ static int l2cap_sock_release(struct socket *sock)
 	l2cap_chan_hold(chan);
 	l2cap_chan_lock(chan);
 
+	if (refcount_read(&sk->sk_refcnt) == 1)
+		chan->data = NULL;
 	sock_orphan(sk);
 	l2cap_sock_kill(sk);
 
@@ -1481,12 +1483,22 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	sk = chan->data;
+
+	if (!sk) {
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
 
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1535,6 +1547,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.43.0

