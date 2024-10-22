Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D11CBE96
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629268; cv=none; b=tDCY95Q5WHSV2sHe7Jbe8VWIaX5y2l0VvDfwx0/k/noprVzHS7G+Lv0sw2uKH9q1HZ8GgrK1anlfa2W6+Ba2Tay5kIJZb18dGlWherNWlcTHm4DA4cgROMZEiBCzlpXZRXXyoF1wKs5Yhop2WYOEpJpX+nc2BNb7jbQf9BVEgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629268; c=relaxed/simple;
	bh=FbnWDlGzQwSTuWjYQkL8SYulg/1Mlfc73PgFxJGVYuE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=seSrRY3aPOzihZCeNrfbPbpRakBwIzoVukHs04U0iyEhD/m3sXS4KJPq0FYnYwOtq9m66ygGqx56LbLiKcrlqUuYja/IGozjsAQlPqcuWRS42B7FPBal98AfaJeRMWgOTzHcmqggrEKvouGvL13HM0qZOYbz4IP90VLZMcCSMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/MCpxFU; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/MCpxFU"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d399891d6so1529325e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629265; x=1730234065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBZRz5isBD+ib4HWMibbG72kcJJ6+vF1lUB/8NcHIbc=;
        b=P/MCpxFUw2m9PzoYfiGDOtxEke/NiPuPyZq51F96wnvvWkabgfAfidttPl46Ko7wE1
         JKacfNsNQ31+cqkoLNvIr2O0sSgP5exKl1dcibE3Yw3a2KClWYAYpX8GWNwVaRFdzkOq
         kEnj9ClX8wcRCfi2RrC+YlgXpjJLZr/LvcI5sa5s5uDC1XCdo8cpUyCrM98FEh0TDsgs
         Kk6IFfo1UqVsskI0ycTRgTBmRMNdkPvKauXn4/EHvZjFycjwoP3sapjmGmVasnTdp/Ka
         mTS6JDJK8ipJhFjKfUy7lkkj0vPMJ41Lm3zI7zKtrEhvEbQJEt77GiCRb5fiG4NyClOb
         T6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629265; x=1730234065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBZRz5isBD+ib4HWMibbG72kcJJ6+vF1lUB/8NcHIbc=;
        b=O4XMaD+t5PUw5oS5pIbrIp7VuldoySVX/Tou5aEzcjgWSI4TnJ4Ito1AASa78sEC8g
         acjR0KZ1g+BdUzPR+cHcYu3POEG3HGQAF3MPTscbCHvlGsjZdjdhnc8YdX/HowcIOQbv
         fkOlK877XO/rOaPjFEg+UtJ0+JkSE3AAcTyndb400aytD5TV7DF92vkV5XH0qUJBGeyV
         E1YNlex29D2urdq5bYvL4x7rxqv83lnqQqKH0mlCIp0cX3CcdQ9qZgjgiMk+o8kimYYJ
         quAxbkbOkBtZmkD4s7ln+TDKdZ7EYwFagOMJIIbLGhUtAtHw6291sw8mwGGBITSL6wxl
         LiyA==
X-Gm-Message-State: AOJu0Yx1yJa4z1egRuQOqClVB04Eq677EvOO5wm4jDcZG9U6tb4pMbtT
	U3DHeezfkYuQHrxpwHO2rUe+zP8riEf/kqbbd03MK66YDRFuooZL8ia10Q==
X-Google-Smtp-Source: AGHT+IFs+BPOsXAFoi2JbQgHOuINcDQhyPl3BkS2IcoedrggHPw2hGxAlF/SgTvDGiOwPNL/Rfm+6Q==
X-Received: by 2002:a05:6122:3bcc:b0:50c:55f4:b529 with SMTP id 71dfb90a1353d-50fd0313353mr557055e0c.8.1729629265210;
        Tue, 22 Oct 2024 13:34:25 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dc78sm834971e0c.2.2024.10.22.13.34.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:34:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: SCO: Fix UAF on sco_sock_timeout
Date: Tue, 22 Oct 2024 16:34:20 -0400
Message-ID: <20241022203421.2126673-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
so this checks if the conn->sk is still valid by checking if it part of
sco_sk_list.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/sco.c               | 18 ++++++++++++------
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5d655e109b2c..f66bc85c6411 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -403,6 +403,7 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index e39fba5565c5..0b4d0a8bd361 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -185,6 +185,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
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
index a5ac160c592e..1c7252a36866 100644
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
@@ -194,9 +202,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-- 
2.47.0

