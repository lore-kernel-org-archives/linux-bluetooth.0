Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBC3ADB97;
	Fri, 24 Jul 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924528; cv=pass; b=U0W9u8zcF6o7+twTE/ERvxv8QTmsqF+rVpzp6u9gNlirdLGmLcjkH+f1iCNtotoWRnvo0uf2aC4Ykp40k6F7FMMUKEh+CPn8mJUaO8ecBz3O7L1BDxRsUhcKXI+Vrn/XGs/S1GohII33edfwquvSVpVJqDBIH64A1lbu7fdL7xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924528; c=relaxed/simple;
	bh=n/+mhAVUxazbWJa6Bud9xSojL6eW7r1MVvaLMyusoXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR9SVqSYH2BYPbIEvLAzDkRCmS+4d7/C1mZVGVL9ggwdB4xGRQnq55xwxzTW5OAxwEb/b/MHyuFH1zavYqb9YUCUEUEEW/ixgwpcg21YhSD/FMIDfYwtpCbjF7T/0qiyi9cuBLw2RMY4W/VNWJ28eHvut806lQjRq2FA3XDR2pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Lw0rC9iw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Lw0rC9iw"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KCZ4VM6zyPm;
	Fri, 24 Jul 2026 23:22:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VDcVRE0XFMxw0TsZdeSr2A6qJbaBYCqcIPzVhQA98U=;
	b=Lw0rC9iwdvdvtYRWn5fS2PzbbUDZva7tfC4ogJYzGVsNZ5PL7wzYi8ae4bh5eLRLRLQsUB
	+8I0rivsHk68F5SM9R2fYUnPNO0qj27M1Cqkg4zfm73fzBtCcONkXr+l75EappEtsfctyg
	D+7PzgPyYhCAEItWuDJLfDr6YSGq+Ow=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924524;
	b=Le85S1U/JM3a1lawV+InZFpFN9eH0j26anhNCBo4enp3bkrWUs1U7xqkVLVSMTnZAlEu/n
	U7AeNI8vZ/cz2mnj/BV+qo3PKgKK+py9z3ONrmjXe0DeAGe2kBVqS7A3tS30n2bsw6LW7v
	Ya+H5WVwlEFQeSJSvjkPaWtzL6bc5/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VDcVRE0XFMxw0TsZdeSr2A6qJbaBYCqcIPzVhQA98U=;
	b=rmCbBI5IbGnLe6EyrT03KbyxJJxE55+vDHLMaPv3Qg8UjW+uoixTFfaIQ6c3fAnsTI57XJ
	zliNbpynDVP5yY4xXaJSDN/nRWe/Xf2A8DiGk2hx9wqmTj5CloxKHatG77VuCqUrTQg0eB
	h5HihkQbF7gh1yAl7KE1F2izOHun8uc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] Bluetooth: ISO: fix refcounting of iso_conn
Date: Fri, 24 Jul 2026 23:20:33 +0300
Message-ID: <f6f26dd792edde315f27480f61f36cf9cc0bca0d.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iso_conn_del() and iso_chan_del() have a race that results to double-put
of iso_conn:

    [Task hdev->workqueue]         [Task 2]
    iso_conn_del                   iso_chan_del
      iso_conn_hold_unless_zero      iso_conn_lock
      iso_conn_lock                  conn->sk = NULL
                                     iso_conn_unlock
      sk = iso_sock_hold(conn)  <---------´
      if (!sk) iso_conn_put          iso_conn_put
      iso_conn_put /* UAF */

The extra put for !sk in iso_conn_del() is currently required since
failing iso_chan_add() may leave iso_conn not associated with any sk.

Fix by having iso_pi(sk)->conn own refcount when non-NULL, so
iso_conn_del does not need to put it.  Adjust the iso_conn_add()
refcounting so that conn is put if it does not get associated with an
sk.

Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of iso_conn")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index bfd39baa8503..30de99ba4b30 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -108,9 +108,6 @@ static void iso_conn_free(struct kref *ref)
 
 	BT_DBG("conn %p", conn);
 
-	if (conn->sk)
-		iso_pi(conn->sk)->conn = NULL;
-
 	if (conn->hcon) {
 		conn->hcon->iso_data = NULL;
 		if (!test_and_set_bit(ISO_CONN_DROPPED, conn->flags))
@@ -145,6 +142,14 @@ static struct iso_conn *iso_conn_hold_unless_zero(struct iso_conn *conn)
 	return conn;
 }
 
+static struct iso_conn *iso_conn_hold(struct iso_conn *conn)
+{
+	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
+
+	kref_get(&conn->ref);
+	return conn;
+}
+
 static struct sock *iso_sock_hold(struct iso_conn *conn)
 {
 	if (!conn || !bt_sock_linked(&iso_sk_list, conn->sk))
@@ -210,7 +215,6 @@ static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
 			conn->hcon = hcon;
 			iso_conn_unlock(conn);
 		}
-		iso_conn_put(conn);
 		return conn;
 	}
 
@@ -279,10 +283,8 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
-	if (!sk) {
-		iso_conn_put(conn);
+	if (!sk)
 		goto done;
-	}
 
 	iso_sock_disable_timer(sk);
 
@@ -320,7 +322,7 @@ static int __iso_chan_add(struct iso_conn *conn, struct sock *sk,
 		return -EIO;
 	}
 
-	iso_pi(sk)->conn = conn;
+	iso_pi(sk)->conn = iso_conn_hold(conn);
 	conn->sk = sk;
 	clear_bit(ISO_CONN_DROPPED, conn->flags);
 
@@ -427,6 +429,7 @@ static int iso_connect_bis(struct sock *sk)
 	}
 
 	err = iso_chan_add(conn, sk, NULL);
+	iso_conn_put(conn);
 	if (err)
 		goto unlock;
 
@@ -529,6 +532,7 @@ static int iso_connect_cis(struct sock *sk)
 	}
 
 	err = iso_chan_add(conn, sk, NULL);
+	iso_conn_put(conn);
 	if (err)
 		goto unlock;
 
@@ -1310,10 +1314,9 @@ static int iso_listen_bis(struct sock *sk)
 	}
 
 	err = iso_chan_add(conn, sk, NULL);
-	if (err) {
-		hci_conn_drop(hcon);
+	iso_conn_put(conn);
+	if (err)
 		goto unlock;
-	}
 
 unlock:
 	release_sock(sk);
@@ -2551,8 +2554,10 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 		struct iso_conn *conn;
 
 		conn = iso_conn_add(hcon);
-		if (conn)
+		if (conn) {
 			iso_conn_ready(conn);
+			iso_conn_put(conn);
+		}
 	} else {
 		iso_conn_del(hcon, bt_to_errno(status));
 	}
-- 
2.55.0

