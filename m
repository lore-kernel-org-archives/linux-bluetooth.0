Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663942FCC7;
	Mon, 20 Jul 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559236; cv=pass; b=sZg/ybnrKhmanbSERvgaJwEElj2Zhot9YHbjiK00PpVe2eiO4VR2Z51F2vEyXYAG6H8I+Rd57FuHXGel76hmpm6R0Et1zNsduxK8hqyTKAr2XB0e7ccfsWrGOmwS4/L3CxfCcAiuelu+ZcvleyOI2v5PtolQMyiMdaSr+3gmjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559236; c=relaxed/simple;
	bh=f6UcrTj4V5MTlZztUaPZWbW4iHEVAC76ZwP/yRYOPBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dj+50m9N//mcnmYGxEur8nqWNxOipaTOn/ecz1XyVrhqZ9iVI6QrLJMO5nmJJRS7HsIHgxPszBNol9qp4/eOfMCHd7pcaQtrtgRsLfC9QeFgMoibiHq98MiwGVyDyRfP5wZGcKXU1T6O/igoQ31i/UNii6pQ8x93Q7fjN/RbFFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TZRDPxBG; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Vgm0z95A; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TZRDPxBG";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Vgm0z95A"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4h3k6g1g4kz4BKL1;
	Mon, 20 Jul 2026 17:53:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784559227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mmip0ckF4SGtVVTTRuV0Vp3/0CuDRlOi/QJ3pA1Rr34=;
	b=TZRDPxBGYNYqNCkJgYl/398g0mR89Zr6SlCSzfyO5pOwdEE8fbChqcjXkHIrP/CWDiZyjP
	keYpfLKcFromfbArxQvpiLRXDCL/Yb2ulyZ0nPQyf6MEAIfaznKeftFr7MjoLz7XZzyaOh
	0V8alK0bObiToz2Qn8jVvCibcpQnDg5XOLPtsPJn65Rlv44MclTLE++Uff332Xgzc/OqnZ
	ZPvKjTGepN00RzRIhHu9pmK0c4GTqGcLEKvXcIuoPfQuOg6CUwoR7LqQtCrJVhNG8Ejpfq
	RD3RGB7ujcZ3Y0S5HHZa/gSgAmKnyhD86iw6GV+lTl5RApvwEct+4HrM0vQNOA==
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h3k6T3ksKzyTs;
	Mon, 20 Jul 2026 17:53:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784559218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mmip0ckF4SGtVVTTRuV0Vp3/0CuDRlOi/QJ3pA1Rr34=;
	b=Vgm0z95AxTXyjLSJ7k2twJnP9jRo2/AlvEVdYNdY8s19bov1ZybV0oy+QU+4Aj+gWq/3Ob
	ZmfLE3sZtwopYgolrHaokgsxuNLArsAEbn4IKGf8ikePnfMFsgM8nPBsnqbYMLtwbBbLBv
	WAa1jXffJmt9ZDal3oW19LB2l3gYx2E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784559218;
	b=Ep0V4Qm8z032jfFnd/kwZcCyIJSaLhPRR/C9FtBAxW7kq+ucY24TR7qqb3dYWcHnra8slo
	PbldM4zVKebhAGxDOsQaAislWP9ys+Arcp3mh8NN/Jljr1mvSJLt6k5BTWwO/sqRI/a860
	DK8GCPGnIkTdxfBUdTU07JM7Ldx2mzc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784559218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mmip0ckF4SGtVVTTRuV0Vp3/0CuDRlOi/QJ3pA1Rr34=;
	b=eLWAnPFvkvXShMyCRtHp4LPbkpMSrUjYKAf6+FBkZFkzzVSNcC47LKzcpjKvoKvn5jgG72
	8XsokFPH6ht9LdUmaugGueJ2i/Ia/e34nF9bTnpDofJJ8naJ++Ofi/b6WUCzqcT3DbfCwy
	1U9K1t1xYuzLid7BoGcvC3tZrzAEtCY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: clear iso_data always when detaching conn from hcon
Date: Mon, 20 Jul 2026 17:53:33 +0300
Message-ID: <f3d8d52dcb2a5464393623a56369ea244c144460.1784559155.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting conn->hcon = NULL, also conn->hcon->iso_data = NULL is
necessary, otherwise later iso_conn_free() will UAF.

Fix clearing of iso_data in iso_sock_disconn()

Fixes KASAN: slab-use-after-free in iso_conn_hold_unless_zero on
iso_sock_release() followed by hci_abort_conn_sync().

Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    The locking around iso_data and conn->hcon access looks wrong here,
    there's very likely concurrency bugs with UAF here.  These should be
    fixed in separate series.

 net/bluetooth/iso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2e95a153912c..babba61eb335 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -837,6 +837,7 @@ static void iso_sock_disconn(struct sock *sk)
 	sk->sk_state = BT_DISCONN;
 	iso_conn_lock(iso_pi(sk)->conn);
 	hci_conn_drop(iso_pi(sk)->conn->hcon);
+	iso_pi(sk)->conn->hcon->iso_data = NULL;
 	iso_pi(sk)->conn->hcon = NULL;
 	iso_conn_unlock(iso_pi(sk)->conn);
 }
-- 
2.55.0

