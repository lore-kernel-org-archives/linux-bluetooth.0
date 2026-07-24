Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3593B1ED0;
	Fri, 24 Jul 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924453; cv=pass; b=ZmIvW5GnMis88hgzkp7wXFQRXgsA1mjMRsz91vfiLxWKDxdWJSx5yLIEXZsx78QK1LU9h4R2tcCxyL4kxCSuKwPQZ5W1wzBiFB80R3GPF7oAnf7S8w67dCQJ0qAuLC9kWH3fbKbMjosW5zhmL+Ny9/UrlSDNAxh7cLHYNzZgRsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924453; c=relaxed/simple;
	bh=ALR5Hey1h7iT4ay7fhEOxY6T8Ih4UpfalhKZjCGkCTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzOj/AXDteEdqoeLXjQ5UD3ANw4NdPbJJV12lnQZWgNCKAb0Dsxap+nOAhih9gbXSaftH0UA+L6mDVxF0C9xa2i34pQ8iGEmiXpOvi2BXynHl9fSfZMi516E3ZFZmEs0PDYjJMkh2TqA1peEL854EtpTiV0Q8eD59G3Pupkdx1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=m886MbvH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="m886MbvH"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KB3437HzyWH;
	Fri, 24 Jul 2026 23:20:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bRRtWRb6d2zGegRge4CYAsYPMzrVUU76L0leF7cPA=;
	b=m886MbvHyH8eM4mWLxOFFuwkjCCRyhbtqh0+5Gaa3iaw7/H/YlT65/nt4LfLeZfVo8dvdt
	sZ/FlQShXAoA+IXdXi80te13bJPRyOkkcqBFOEmC2e2ckzLERIOmiOs3+1iJi08wMgowK/
	VMgvBcX7Eq9CvEK5NnAGw7xiPg9Ezlk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924444;
	b=iUZjDXQ1ZQ1deACwk6/toTEjuu0mdJl3jdno5dBGdyioDdUKaZ/i+VA7lZl1ihS/JjtEbc
	QGqjWz+Kx3mCWUEPk2UGKXKSQ2kMP9Hl0IoUqxSdwdEOC0zuEwTV/XBxT6wBUHlZO4D+yw
	iS+94IYmrGPQS6BggUV3DLe1Wqfgly0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3bRRtWRb6d2zGegRge4CYAsYPMzrVUU76L0leF7cPA=;
	b=ZT9LefE4wUkoUkgh/gQfglbDr0UnE5nmVTrlFOzsirwXPkOilv+7sqo1Qwcnep+7mEBC9Z
	/NPvjh5ZO/pHZsOY3ImrhFi7UkEkk3gsCoQNnTsL1aoDxRxTEvf1CRGScX2TuREUsgaQ0+
	3DmAzyKjeuAGwKlVqW/9bSDdNvKJbEs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] Bluetooth: ISO: lock sk in iso_sock_getname
Date: Fri, 24 Jul 2026 23:20:25 +0300
Message-ID: <868ddc69b94f3bae21707ac898cf4c385797adae.1784923689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
References: <cover.1784923689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing iso_pi(sk)->conn requires lock_sock, which is not held here.

Fix by adding the lock/release.

Fixes: 2df108c227b2 ("Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 299a9336b5e1..dbb8f43052f0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1472,6 +1472,8 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
+	lock_sock(sk);
+
 	addr->sa_family = AF_BLUETOOTH;
 
 	if (peer) {
@@ -1493,6 +1495,8 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		sa->iso_bdaddr_type = iso_pi(sk)->src_type;
 	}
 
+	release_sock(sk);
+
 	return len;
 }
 
-- 
2.55.0

