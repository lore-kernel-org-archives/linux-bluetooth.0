Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2F3DDB1C
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965097; cv=none; b=nW3eJ4fzCIBG0hry9Kh7PwfvS2XqSIjYZpVwJxmOpdlL0aqJrdFUM6HXFBVmctmiBmgS8okddhRU4h11LMlFnUkESF4GFCnaHiB4BTsp1ia05hFKWhkFEkpos4Rn2VvC7j31vVCBXph0nYEzaxX3XpyyQp7mYXxxebnfag0ahP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965097; c=relaxed/simple;
	bh=OoDmUc/8XtCceK9p+h+/SE9QHPZ6p/OJ7DDwunZIJxM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=td7pv3wDTeMzEB52koCvwOscO9te/shb6iueLftcXWxFz4f9CL7MyV9VoNKpx4GbDhpjmNpRsbbh+vGzAvubVo/h7ZEwk5g10spX6jKss3ngkaylBwvG9eF+cXIA4VTqUgKPmgoXM2kwNnhUYe8vcu038GMFx49KMSu6vdOA93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCCDx1TP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCCDx1TP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so27380555ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785965087; x=1786569887; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEee5sfGqkAQFl6GZPGNdx0Fm2VSIMtcRUsGRdoNGMg=;
        b=qCCDx1TPDdJml2ne5nwDLwWBNQqi8SLcGVU+rBAgIZ9Rg5oMAZVYkk1Y1xDiJ90Dcn
         +xjc0qom6aU42s2U4wXyTcnRaH4Ltkl9UlbABBoCwSloqUevRQcXWHygh+j8Nr3y3qUW
         lFwJCtWKivs0byqd98XySNG7ympI2IXeeIV5WscsOfVaki8bCb/A2dd5mdPJ79g8jaoq
         1RaC1hVBPfvT2ZQoYfk3/i4VqIKkdFyKbFiVly+SPyp/38ZaxZ50hbLB+zxc/eBE0fuG
         RaguvjJ78LDDy0t8X4q/0HQ8n4VpzNIy1pM9c17jXVNJO4Ty3XvvbOYZZLXmJHvzoSg1
         QEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965087; x=1786569887;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEee5sfGqkAQFl6GZPGNdx0Fm2VSIMtcRUsGRdoNGMg=;
        b=atQGJr50kMC+gxClBlsta9Ul9tcfVC4yvAO9ccAPVbcOzaV8IEs2L5bPxSQTR2wI39
         fSa9JGEuVXljEOGX23ZEKoEIstzcJsOywSVMIJf1Hv30Biz7knbGYnCmHGSzrRBSgR1e
         QxwMKrvsijW4z60oxsXQcLQI9rHZ5ytLxJlun5G6LhGeAD9o6IRkR3uarNNl63i3LBVj
         wf3NPObyc9LfhvTMUQbtGEt5Cwz/+zRCeDvTtxKY2uwKlns67SXGnKkcu52eTFpIJB9+
         BOn2HFMDiJCG412Svu14H6k+03k+KZqpqjUJS3VpKEqGy8d1ysIrrd44p3kZXXey38Iw
         5OcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpdc6Ersi4V0R7FJocW3uBYO7uaE/+QZIC5akw1XMTC5pi6Gd2ndFehqv+i/1NDyVId2XPAwvq5f1MQHPBPR78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQYa31wzWvrtmWl8L4r+fWlFcBzkFkxbo90lht9B3lCvMywE8
	TWV1m6hnntk0MENVW3wVKgmd3qe6rg1tQVymbyEPxjYXVHrzkf2FYONF5HGrwv9oPlVScLStXRO
	Gbw==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2ca:d6d7:6943])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c10:b0:2c7:f4bd:91b5
 with SMTP id d9443c01a7336-2d0ca15d0a1mr118249685ad.0.1785965086682; Wed, 05
 Aug 2026 14:24:46 -0700 (PDT)
Date: Wed,  5 Aug 2026 21:24:34 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805212435.48618-1-tkjos@google.com>
Subject: [PATCH v2 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com, 
	Xiangyu Chen <xiangyu.chen@windriver.com>, He Zhe <zhe.he@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 1bf4470a3939c678fb822073e9ea77a0560bc6bb upstream.

conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
so this checks if the conn->sk is still valid by checking if it part of
sco_sk_list.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Resolved trivial conflicts in net/bluetooth/sco.c, removed
extra reference on sk ]
Signed-off-by: Todd Kjos <tkjos@google.com>
---
Changes in v2:
- Removed redundant reference on struct sock
- Removed Change-Id tags

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/sco.c               | 17 ++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 43b4386018e26c41c914f87e050a0fe958700135..85bab90a6921ce1e9b9025647e23fafd97117ece 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -317,6 +317,7 @@ void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 			   struct proto *prot, int proto, gfp_t prio, int kern);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index bef5b6330dd807504292671301c860b96c2ed18e..0af14e3318e7e02173970a1af8e183723bef2c50 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -184,6 +184,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	const struct cred *old_cred;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 01a01d6f01c309a6333859784261d97335dda413..2fbd9c93440ce4936d47b3bd47aa1dc28da82c20 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -87,9 +97,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -192,11 +200,10 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-		sock_hold(sk);
 		bh_lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sco_chan_del(sk, err);
-- 
2.55.0.629.g250fe7f194-goog

