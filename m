Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28239AFD
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503131; cv=pass; b=oSQKpLLcBwuzAXr3bqwLJuMEwLKsx6J6jE8OuREPvj5Sget4FtdX/jMQWTHHRj174yoSaM5WqZOtAMWdAd/9taiNoJNMNvLGiNOPdbDS1Oc6Rzm0tPaAzp9XHkGAKMdNRgQDHthUNOqy7fQxtkDUzahSB1PlfF2N5iOSjZDyzS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503131; c=relaxed/simple;
	bh=1EqbKHDnY+l/l7Zq+8VPrkz8cJmkPDjgB7R48X6LDYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDPGgwsn4Tqkuq5Ne1dJtgzJsjFkl9h+9iH2/oT5Z/yAwp1QKFLkk+LOqXEtJTgZCjW2a/hn4OTuURykCLCbjt2cLCO0cihmYPNaBjH422dFBx86br1kbG/NdfMhfkd8NZfAwdXw66HNsE50qJEj4C/6FlAXQyfTehpkVF/0dEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nFOq1+Gf; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nFOq1+Gf"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8R57s4z49Q4W;
	Sun,  7 Apr 2024 18:18:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhTPF9hv+qTQNbUl9Ufx8o0mH3bQlDxzUC2fnUxv7vo=;
	b=nFOq1+GfxxkWUBVuwt4FXhXn2t2OcUsTWCExTFQ/YuIYyLCvefc0jR1NVcAeyvKfkl5pBT
	R5Hc3nfr+enj8+8+IMgFU5vPA41xoLzsw1WsfA/LSNDwxW9h6E9Kwzip0yKSzEl12b0+rB
	AYS9PpS0/uX54Iuif+POf9rHutk3kFS6Lswypnm9UYUmKvQx9X4/cwtfDwo7QOFsDMxTrR
	9DzvPdVL7UgLkHJl+PPfN2BaXDDR5KfZrV82/u/zJpHwNi4Luy7mbRnilaOTISDopcutYU
	seOhbKhw74ckPqCDuGzM0iWyUpHHwrXAYEdMpvkDkmR+xxTXVd4EZXWYCaJr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhTPF9hv+qTQNbUl9Ufx8o0mH3bQlDxzUC2fnUxv7vo=;
	b=Eht6JHtYYVZAO7JYjdRSO3pSlj2QV3JqpqDAW5NzMymo3lkhw55gl02303UWsLvqEMybjO
	1xIiLHlZ618zheC7izIvI5j9OOfvkbaJwzNRC2Rkp8YIzyAUS/v9MacVTEUPgZQvGEwWBN
	qyGkFcxQNKhw8ZLafbh5gw/tXYFYKWfLjeXKorxqF8REt9EqfkkYSolxe3vwATfc9M1fgA
	AR310VOCT86sXVTTyzqA+cbt95K6ZLtTzBWF4WCg/A8COCXsak8oza+8oC5wZsvbwu2Uo/
	VC+ATJvG3HS3ww96Jc3/PZ1EmPO2g84Vh4kEUloZSMAvVhPZ0MR6/KZPF8R3/A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503128; a=rsa-sha256;
	cv=none;
	b=KrEhHuYyqvftvLcTiZRPdQTrszuWlRCL/+zXfKscy539mwQyqoaWT2/ACbFdvGUWDbDAbR
	noT2/fY3ahzYpZ35YyxRQCYL31Nz531BD/tB8/824QjygYtjMOaOwY9ThJnoXKo9wxHDq8
	WZo8UEXVZEWWCX/tUD3Dc7U3TS4Y+zpjwM/2ua0da7dMTsKnlsyk4kIJbd0l5Xh+KD1ra9
	hEAFqI7Pw1qQmud2n/w5A8K4KjURz22zJ1sfK7Wpa6HGkLFRkESh04hIvJAjsajzTyKvPb
	D8RH0kXVn8k0Tjckg7DFfG497n4B22X3TUu1AbyK5e5PfFtLPnlrC9Zs3qjDOA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] shared/util: add uuid for Poll Errqueue experimental feature
Date: Sun,  7 Apr 2024 18:18:38 +0300
Message-ID: <154de61f1e87066cdcb14541a74e8634f3ad9b34.1712503074.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UUID for Poll Errqueue experimental feature to bt_uuidstr_to_str().
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 0e71fda02..ee59b94a0 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1653,6 +1653,8 @@ static const struct {
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
 	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
 		"BlueZ Experimental ISO Socket"},
+	{ "69518c4c-b69f-4679-8bc1-c021b47b5733",
+		"BlueZ Experimental Poll Errqueue"},
 	{ }
 };
 
-- 
2.44.0

