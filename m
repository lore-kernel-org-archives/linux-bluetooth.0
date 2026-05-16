Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3C3D4114
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930104; cv=pass; b=DpTutzj+unc8g5DASBMicJJ1zmYxI1Gp8PD6lscmKvnEWhg16ZlezBshxp6g7NE7sAhmMtN2VZ0zdAaoHZJ9wRWl0dVyTtzqHciviSLrE1q7iK3eeOeGYNdyJ5EWMcvXhNAJydqXg5WMHbbQtI3b4HlGzeTZiSFmOSTqFwrzPW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930104; c=relaxed/simple;
	bh=41dZk8SsuGHIfzRm0ExoWidN9fPcn9JaOINVwA9buzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4dc+wk7muuX6a1ihBOJt8rHwoZifEuecQEk71a+qxvf/0YJyIpu8y0vo1JtZBSdQ/g0TGl8jRnQwR+zcKJhLFzSmP55+d3xU48Ok2/wbfpTabvJqCKYfaWjKtNGVWiiQ2b33+S63xzn32+wfzq3o3y5m/ZogQafBbownZ4CPNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=roazQ4Lw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="roazQ4Lw"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL75wlBzyXG;
	Sat, 16 May 2026 14:14:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0AiDDQ3+Xoeg7AtZa2Dt2X37dr4H9yRFEIoEvQkdH0=;
	b=roazQ4LwL5j5e2Drf2Ms/ZyWC4ptOEFBWNhNaIdN+U8utLlcjCSbBqRAfxYPzxLpt1EKYH
	rmKy+H6IWVE9zSpbNQbGBcwYnm565xk6db0gAOIQtcOhVU3fwNcEk5pWfZnvaFB3sc5OhL
	S23gxLh+5o9l+DvmFuOQ4G5eqURXFyI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0AiDDQ3+Xoeg7AtZa2Dt2X37dr4H9yRFEIoEvQkdH0=;
	b=q59HFUnsEGBIDlvelYC8mBfpuTODLZW4wQou+R+hj9NskPI6gsuOzSZahovHwZYMnGkLHJ
	OI+g3aJJ3y9NIxbg5NAjau6Iqq+m8b97sPfML8WfWI2nsCKq98nDgfDCZaA9v+0WeQul2Y
	FGFm48DjYjowBHo4KiCF4Vj1xVW2Tcc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930096;
	b=c9GiN4ZnvUTaC4rf+2k5WVbV10MWu0rtz80WIdDinR+bdojSMMTBQ90/XQ+QlSf96MfN4m
	LVhdW20ibuFd/zkfq2IOMasAPu1QwKW5m6/Sa+G2vkofJxBMmVNZ/6IBSOBGy8Muwrye5f
	cwQ0gYYAFQvaAdWICLQuA3zl0rUhRZ4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 3/5] Bluetooth: ISO: lock same hdev as what is released
Date: Sat, 16 May 2026 14:14:35 +0300
Message-ID: <cdf9785ff87beb5528993ef4714e3ae9dad237e3.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
References: <cover.1778930064.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bis may be deleted concurrently after release_sock(sk).

To avoid this, lock the hdev obtained in iso_conn_get_hdev that we have
refcount for.  Also, obtain refcount on the hci_conn to avoid comparing
freed pointer in the race check below.

Addresses valid context analysis warning

net/bluetooth/iso.c:1095:2: warning: releasing mutex 'iso_conn_get_hdev(sk->conn).lock'
that was not held [-Wthread-safety-analysis]

Fixes: d3413703d5f8b ("Bluetooth: ISO: Add support to bind to trigger PAST")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe872..34991fc7e0a7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1027,13 +1027,16 @@ static int iso_sock_rebind_bis(struct sock *sk, struct sockaddr_iso *sa,
 	return err;
 }
 
-static struct hci_dev *iso_conn_get_hdev(struct iso_conn *conn)
+static struct hci_dev *iso_conn_get_hdev(struct iso_conn *conn,
+					 struct hci_conn **hcon)
 {
 	struct hci_dev *hdev = NULL;
 
 	iso_conn_lock(conn);
-	if (conn->hcon)
+	if (conn->hcon) {
 		hdev = hci_dev_hold(conn->hcon->hdev);
+		*hcon = hci_conn_get(conn->hcon);
+	}
 	iso_conn_unlock(conn);
 
 	return hdev;
@@ -1065,18 +1068,16 @@ static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
 	if (!bdaddr_type_is_le(sa->iso_bc->bc_bdaddr_type))
 		return -EINVAL;
 
-	hdev = iso_conn_get_hdev(iso_pi(sk)->conn);
+	hdev = iso_conn_get_hdev(iso_pi(sk)->conn, &bis);
 	if (!hdev)
 		return -EINVAL;
 
-	bis = iso_pi(sk)->conn->hcon;
-
 	/* Release the socket before lookups since that requires hci_dev_lock
 	 * which shall not be acquired while holding sock_lock for proper
 	 * ordering.
 	 */
 	release_sock(sk);
-	hci_dev_lock(bis->hdev);
+	hci_dev_lock(hdev);
 	lock_sock(sk);
 
 	if (!iso_pi(sk)->conn || iso_pi(sk)->conn->hcon != bis) {
@@ -1093,6 +1094,7 @@ static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
 
 unlock:
 	hci_dev_unlock(hdev);
+	hci_conn_put(bis);
 	hci_dev_put(hdev);
 
 	return err;
-- 
2.54.0

