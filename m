Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C23B27C1;
	Fri, 24 Jul 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924453; cv=pass; b=kpMzOhZ1rcLAwBijMQ+zyvpzEPKKvQHhio+278zINX8RoNg24iqJuRluqBKqYEFdpjzwwtEUIZwzMKmjErdmtU1Mrz6FzJJgAGiegRURp788y1zelL6AgD/gGe2Y+c8+Hgv+xCg8gLWkXpMZ51XsO7hTBPDgrLusRF6+0j0VdGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924453; c=relaxed/simple;
	bh=zBdnU5qqOpG2EAi0UHShZDaqXgYifMh/DS9uXCqR8RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geTeqehYz/KOibh0qiBkBDmCf4aXN5BNdnUTQGtGWUTFmpGXZtFdmd+U5CtVP+iiq8ujFPcH7LL2khomlhPzHxglnba3st8OfbIEz55FvWB2GriUo8y/tgE+yASxqxTt2mFD+IXujQj+SYjX0qatC67s+ufsjDfakFg6VRV4cDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BEZgnSEJ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BEZgnSEJ"
Received: from monolith.lan (unknown [89.37.63.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6KB86SxWzybb;
	Fri, 24 Jul 2026 23:20:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784924450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q2K2lP9evOiz1Steo7+JHozlCGL/NBNyKabBb6lZCg=;
	b=BEZgnSEJUCIPvpG9qnIRt8qaisZzHCTOgh7pk4iqj88qtKWxe0/MG9s2aodqjJMlZq8pPY
	6NIx5eK8OaanMvLdSpC+kUlVPDjwKRIdWzOJCqRDf+SMAWFuu+4YA8ta+QBfs+LOq968Eg
	xE0bQIcsBCGulvqBZry2CzUJWMVudMs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784924450;
	b=kiaBZKANL8Tbdt7AvYQiFhi09wDH+psJgEs3Fwc1D2lCmnKivX+puaRup9T8Hhd9AeOMMt
	nEd6DhyACaeFisStcyL1eWlh8wzC8cYnddLcQH0A44w/VLFZVyb69dRAhGcTw3B1qVucbl
	u8U7Pj0kE/wfVFpNPbNu0cHTtebrQWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784924450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q2K2lP9evOiz1Steo7+JHozlCGL/NBNyKabBb6lZCg=;
	b=A9gsuSVO+qM0dfsaqnRYQE/jj7OVa/uhi1zzdo/ks1dt7P02/eSz4Ci0L4oawJKE3b87SC
	ZTgfLdvfJkMW4xZ3DfUqVMkUkOQ8nVAGSLSZVy6GFhQXWoCoWu7AtzzpKF5QrbmEZF95IR
	yDKiEwAQxUkY7vSIzXqnNclLi0Flk8w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
Date: Fri, 24 Jul 2026 23:20:28 +0300
Message-ID: <7b2ce38199de98371bae313cc69dc25d7ab8768b.1784923689.git.pav@iki.fi>
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

iso_sock_rebind_bis() updates socket iso_pi(sk)->bc_num_bis before
validating the BIS values, so it's possible to end up with bc_num_bis
inconsistent.

Assign to iso_pi(sk)->bc_num_bis only after validation.

Fixes: 80837140c1f2 ("Bluetooth: ISO: Allow binding a PA sync socket")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e51253e5c161..5de4a2f886eb 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1039,15 +1039,15 @@ static int iso_sock_rebind_bis(struct sock *sk, struct sockaddr_iso *sa,
 		goto done;
 	}
 
-	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
-
-	for (int i = 0; i < iso_pi(sk)->bc_num_bis; i++)
+	for (int i = 0; i < sa->iso_bc->bc_num_bis; i++)
 		if (sa->iso_bc->bc_bis[i] < 0x01 ||
 		    sa->iso_bc->bc_bis[i] > 0x1f) {
 			err = -EINVAL;
 			goto done;
 		}
 
+	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
+
 	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
 	       iso_pi(sk)->bc_num_bis);
 
-- 
2.55.0

