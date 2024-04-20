Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1328B669
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624781; cv=pass; b=TSb8Y42xJSDvf9tFwuag3CHUjqYvDENdxq34A7JyV/S3g+AK4iyVsKVGq1hvhC2Ogx6t5KQPpsJ1pHYZyXk3MRjon7HM+2n1wLupuGrL9pcNAo3vGiWfI5pHRPGePjW5M3z6kR8Iu489tZhUS0GrOOuPVzS61IzLsc0qD0MPpKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624781; c=relaxed/simple;
	bh=zqiPHR+HkZimkvSKdPD1i1KA/4ApH+WaCqYLUaFBv7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suY6Yw6ML6ndcieeSPqco1avrpkcrH6ro6YCvCPWuxtCTjGt/dK2XY8tOOQdJQfU4d7u8ELEyldNTFAi3xfXl+9Ix3m/h74Zbbf7C1h3FKQSXvCkDEoK2BvBcK2NuqWtWIUGmmvmRMkeBX6mm7GdSsQSH53E9w3aO278U+MWGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=N6C2N3cJ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="N6C2N3cJ"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VMDyb274Dz49Q12;
	Sat, 20 Apr 2024 17:52:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713624775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PH8hst8663AvQId//Tjx4gzmEJph7gf8qqxNVOWI0jY=;
	b=N6C2N3cJZ5J8nfOf7NG9V2WyqeAN8Hn74tBTozLjixIY9TBB9xG/q20fOFrXid5lnca+iK
	kWvdAddcdlc/1BKnXJ/yk+50BCTEI86+z5Z/l4G2wCzEhTBeeg/h5uFgaussMy63W85ZDi
	USfe8ZzCoSHr5Pn6yO8vKrAd+P8R4co8dPWBxmhEPf3ASnKH0m4/METIcixO+sagnbLLX3
	jATk6L8lG4cOgKnU8oRTbEJGFT0PVtFbGrAlE40ZxQVQc2Xfw5rWmvOsXkKSwuenl2hSWp
	xV4KDSQVVYoy38lx27yday+W91KMPqz8XmZNMD3Mroa3PaclYWpxM8jBXiFwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713624775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PH8hst8663AvQId//Tjx4gzmEJph7gf8qqxNVOWI0jY=;
	b=Up1W78N7RaK/Cbq3SH/LDGhd82sR0lOQESddlTgs3WW5lrGA9JfP4bjRCkfLH9RMnA+T2X
	HALcEP0+JwxhyOmors0SicdGu9lNkZKRpmRl4/JtGgTT8mb77BchaeTukRs+leYSYJzITD
	vlDVd7AuwsHeFHVfsHrWMooWQJ5j+QKs0ecui9wzNyDDBQ4lUsiIkPVWbCY0ICM5csW3T5
	IRrbQq3yUuY7qA5aFeQAPPfid+ew0zP7WanRdPqmy1ZDtjSNj312BJgh1e+AYLx4dYSCsu
	kipzwRu2Ip9tyKtD/VpkCoS6MrQWk3tyj/X6G8sBOd2llNgrivFLTn/+bA3LxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713624775; a=rsa-sha256;
	cv=none;
	b=tXcE/u3LonEOt9v3AJ2lcSyg+k/smK1IUIBwWzubYhtoYTLk+00aPEDkODMGHd5k0WLlPL
	wX9bWHRLyXhAEB+guBpHAKmym4+YN8enMmTpq+TcTJiG//ClbiWgM8jiUVZJsc3s6V4wFg
	k4VgiA/CuR5MLnNJARyBJY7Ss/5ExJLrAY8tOxHsnAUR5qIfaD7LcegQZMusi18ebQeErS
	NTIBQ9qJzdS+re79Fl2qnQlWfBv9EV/RnIOJMfhCVqTrvwMICXGMhp18gFzraU2S+F6e6d
	w66GLhcTqfB9UxzDtDo06nX08CeIvMGqqSY7sZ9jkR8ZILj1hOSQH4jOmiNWlQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: call select_cb on bt_bap_cancel_select() to clean up
Date: Sat, 20 Apr 2024 17:52:48 +0300
Message-ID: <7f5110805a5180fb910d735f631c6f3b9a19dee4.1713624621.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have bt_bap_cancel_select() to trigger the callback function with error
code, simplifying the cleanup when ep is freed while SelectProperties is
ongoing.

Fixes bap_data->selecting not being decremented when ep setup is
canceled, which results to transports not being created thereafter.

Fixes: 41d6c4e1c92f ("bap: cancel ongoing SelectProperties() before freeing the ep")
---
 profiles/audio/media.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 144f6bfc4..07147a25d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1055,7 +1055,6 @@ static void pac_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t cb,
 			continue;
 		}
 
-		req->cb = NULL;
 		media_endpoint_cancel(req);
 		l = endpoint->requests;
 	}
-- 
2.44.0

