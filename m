Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF243932FD
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432833; cv=pass; b=AzRcD8Fv31A7j7h0SG3bbKiwIt491EqtKxVXZK/XDt5F1Q0kBSn2ufqQyleZ8Tcs2uoiodbm6xYfwdJYMMCdWSvkWhmqwEihHwKMTkjfmkIW0l1oOjwymZ0PtRX9aiRtSlhn/77NoiGmLRfGm2Gxo5Cw0b7JwcLgisQv7JHdLlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432833; c=relaxed/simple;
	bh=iTxWrHABHVLYXBNsv6Ij5iu2WRpF+HfR+PrTF9fP09g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAKPT9qhN5DdTqhmFByO4X6pRfVBKAD2Bm3B2VxYqVkGqdbZt3O+90Ub+vTVBwveh0l4mcxBAGwwZlBHTGCohEgwH0a8lAVzueiabNki7sCiYb4hRn7cx4NOPDUzdisiSKcJVluwnYJ4hAnnATWnVfudLes3vSuzVBvbgNGrwzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sxgFtj64; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sxgFtj64"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvf4j4RzyW9;
	Sun, 14 Jun 2026 13:27:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWO85Rv0LU+4Mbe2nDA30wWczWPLOM4uhdbTN+oeqgo=;
	b=sxgFtj64zYfm32WQoIKrNHTAmf+pxErTVu+n8DZ6Mi9SMHM30cuaBO8gjtbvXfscb7C8XR
	uN5sJi9ddxybarCtyLRJhufv6l/P6PNVlMFZCtZ+I1MXYKwzZZvDHSMliVqUZRZCA+itXG
	pGOIFpqevM7Csu1wrO9jcWVGAg/U9sI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432830;
	b=QdynkcGDXfQRPiLDJWCItabrzIWxzwFgvd+jRV8zonoVbneeWU3WcqpxjNQmoX2dyJHmu+
	weQKmpkQIBJrwcbQGsdDJ4zPtBUkdeKW3z3iZUIuEIu93NCnJDLJhASFDQKHCwqr7eZ8EY
	NOe5Ogam7IDCsE/Y/SuImw7za3efwP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWO85Rv0LU+4Mbe2nDA30wWczWPLOM4uhdbTN+oeqgo=;
	b=GD6jsYspi70eg1iIjlU76Ej6IT+MpDSQnHAX2TS9pMi/km+HdIbfihyWv3r4EsqXp5h+IG
	nMW5mbtzV76Q0WsD5G7eRyTj91kOaV+2MFM3V0MzSnaYJPSlFv9VFCvpCiXWzsC4TgTF80
	UlUEuivyBuzFXxlLaa2JLYDTkjaunvw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 4/5] Bluetooth: RFCOMM: Add minimal context analysis annotations
Date: Sun, 14 Jun 2026 13:27:05 +0300
Message-ID: <fdecc7691d31996172c43f875a59256fd14e6598.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
References: <cover.1781432726.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal compiler context analysis annotations, required for
compilation to pass.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/rfcomm/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index feb302a491fa..958081adb9b5 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -60,6 +60,7 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 }
 
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
+	__must_hold(&d->lock)
 {
 	struct sock *sk = d->owner, *parent;
 
-- 
2.54.0

