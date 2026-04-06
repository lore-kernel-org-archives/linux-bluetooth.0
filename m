Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EE31ED7D
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474641; cv=pass; b=RPNoeuXtMRjX34x+/3s/UZ5Pn7SgdtjLihihx86oOAbwZz41jWcmEFVC1BvBGcNd13wL+7EaIA527ON317taGeACYtSVLTSGlCX0CCT+Xsl45l218qvI9QS8G3LRgEW3hccvL3aKeTgBrmzdXBV03l363nL7pp/akGN2WVHu0jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474641; c=relaxed/simple;
	bh=8OU8IjY1ymU/1mUD/BHsd1DEEDPIV3nMucOe41r3diM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayCswOf2ysFOrdJaJtloz/op+WEZ/eIZ0HDfnKYxEHiotJyNBZwVFo3esbytf80AS5AamTi0qN5vCy/1QMvqpEWRS0I2StHlYgx7hmpLw5MCSmASYU72uJXSXcQ4cBAzc6fDzpEH2DOqwJuKqxzAX0xrom7KSCy6rqEr4DAJylU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vQkQEl6l; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vQkQEl6l"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq6R14Fhqzyvg;
	Mon, 06 Apr 2026 14:23:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775474637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSHKJxGPvWKNPeJV9fs+lj/5KiQ+1Wto6Zb88peLcKg=;
	b=vQkQEl6lyWm55OM9+eB/GaFgoOZlmD2dxOsmR3u5nxbKVe+qNddIMHaIfFhkLkUKleY4C5
	ScdR4EqVfTZ2ny+KuG5lkyeczkZoJPMv4VLzUWck71u3LS0wapR5u5lEIRfVomh3hvLDVX
	5k7l2j10v4/yLGdfzE84SHEwTHoOMg8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775474637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSHKJxGPvWKNPeJV9fs+lj/5KiQ+1Wto6Zb88peLcKg=;
	b=wrMSplxFNqXvl3GSQ5u2AWcWI3dMC9MLT408kFRDbDaGVIxp9ozfEASUBajY0Dr0A7QC/u
	qAe4hBKO5QVPq6h460D4EfN36gcSrZU/FbAwL33E0Mctn4uCH2PbiU3R11cRxcjgJfX1QV
	vQk3BoOSkGJqQ9T8kGk6hl+vZv9wdBs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775474637;
	b=JacN+DL3TvUTNH22eXxSvJ8hEIoRPzAr7hMUAXa0ARdXAtxwd0n74XIYK6xM4mxiIuypAb
	d5an2hBHVgXi+PkDbO0IquqIPFHiDn+FysqJUCS0Pmv7E3Ipgd3Gar87VUkQKwLUc9aeLW
	c6YEiDOEKsulLHI0ValbB1N9I4pp6Yc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] emulator: Remove assigned but unused variables
Date: Mon,  6 Apr 2026 14:23:51 +0300
Message-ID: <fd80644965a38ad2d7cf098859908fdae3f13778.1775474498.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
References: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.
---
 emulator/bthost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index b913c8015..2732b7f83 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -904,9 +904,8 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 			l2conn->mode == L2CAP_MODE_LE_ENH_CRED)) {
 		uint16_t sdu_len = len;
 		uint16_t slen;
-		int i;
 
-		for (i = 0; iov.iov_len; i++) {
+		while (iov.iov_len) {
 			if (sdu_len)
 				slen = MIN(iov.iov_len,
 					l2conn->tx_mps - sizeof(sdu_len));
-- 
2.53.0

