Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A128CF42
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207839; cv=pass; b=rPF9KWEl0YZleho8+qZ7XfkcfUhrNaHqGKZ4dVjUzgS5/krPpHO5cIZ5R8qI7oUSK/v0DFYOPW9MyzwLJCbZNBv/X4e7Wo7Hhj8FjtbDCl1IdvoYvtZicYP56aDk0qGgEQ2mb9gmdVzyFui7FhVF4ZcZoJarmZxI0EC43UGIDLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207839; c=relaxed/simple;
	bh=40aRMez+yLqeLoQvPecUb1Vh5Kfzwi5GXhBw07Prveg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEa40vse2aMoSHiMf3q6JrdAcoobkDH9fcTG68Xwv84Dhf/CydeOYOsB38OMHi1+3v1S37/qkoFT+RBPuM4y6Mg4Hbp7WoplprewPqnD/3FRZBDNXQFrPPQqW4GfY1qQuyzMLCPedHvzRUpH4HZer2ZDDI87Ewqgsen+pBIlq78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=r79Y6vYd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="r79Y6vYd"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7str5yf3z104b;
	Sat, 15 Nov 2025 13:57:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763207828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw4w7wls86fNqidW/axG1faSPX3wMn4Iyr3o4XeDzC4=;
	b=r79Y6vYdYPdiuw00oPScWVTQbgm4e5zkMi4mEtaMDoP9PcLHOSj1APB7Y6xDbAq+5W8L4Y
	g2nsoFBfL84wRcr1vCHBjmFjl433EFiuRTrgIQqNRT/gfJzbStXirbmvgTwbT9rXP1LZGU
	X36rrNhrrouQ4cKqlcueYQDZHhSQbLE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763207828;
	b=jOZx4zDIohCpc80Z2y0icxlYM7OX8ewjsI5SQinxjUwIr+S3PIsDrO99nd3POUjeOlA9gZ
	5nHcARQDHpCOQmpYB1t0uyHq7WEkUfjZV7N1TQMSD/I7e5b20bvmzHSPMllYOYiTajKwxz
	9qv9R+17LwgL/5Xtrb2ac6VfTEVl1Cg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763207828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw4w7wls86fNqidW/axG1faSPX3wMn4Iyr3o4XeDzC4=;
	b=MEuRVXNp3bHpAKFyxsj4xmidBQOsPxASFUi4vY/2o1riaRSTLgTCs5OkslmYjwKr2M2TWU
	hrH2R4k52oV7SFKNb0adlTAnAyvi0HRQZMxs8NZOvu9N6/0ANzk1a1RHw8E46LhAvN7sg3
	JbOQtYBgp4W/tu52GvED+isze8ZG+FM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 3/6] bap: don't configure endpoints of all codecs at once
Date: Sat, 15 Nov 2025 13:57:03 +0200
Message-ID: <da2831adb83ccd12e22e7756694fe347d3942691.1763207813.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device is connected we currently try create all streams for all
endpoints. If there are multiple (= vendor codecs), this likely causes
creating multiple streams for same location, which is not allowed.

Change it to create streams only for the first endpoint, for each
direction.

Sound server can later request switching to another endpoint if
necessary.
---

Notes:
    v3:
    - no change

 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ec3502b06..b07d65e68 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1922,7 +1922,10 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	bt_bap_select(data->bap, lpac, rpac, 0, &select->remaining,
 								select_cb, ep);
 
-	return true;
+	/* For initial configuration consider only one endpoint (for each
+	 * direction).
+	 */
+	return select->reconfigure;
 }
 
 static int bap_select_all(struct bap_data *data, bool reconfigure,
-- 
2.51.1

