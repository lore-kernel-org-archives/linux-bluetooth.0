Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB34E571
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211522; cv=pass; b=kWF0hwx/Nn3EfBaXK8tVVneGm5UDc4oEu9GCZMm7wCVSypwBxadGMu4yMIcHFBn2TtuKJHE3YJzY1MNoDjntsahgfEen30azQqn4zEWERRhzRFFQh0M8u6oMqrRYluSOd5+sd7PI7dwt9ZFsFFzTWI3DcqQbUu0+fbhj+JvJt1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211522; c=relaxed/simple;
	bh=Jk8EOi5NkLnjPxiwHmIA2KNuCPAWYwkKUe8PHJRJLLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je+vO0r7a3fJjAc3upChbF9LhccpaZcoAbdt+vTpoTcTDaVTgs0cxEoUemtw07z0UdpVWur0c6E1EEI3boaFmRHBQDhRSQHkxp14kck4PL/JR95SMkCEo6Qn68MvMqaGZ1myGaMmFvuMT4JfeAFAsKqoiDkz7vyyIGJscFouKoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DPiwbuxY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DPiwbuxY"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7vFp056Jz104b;
	Sat, 15 Nov 2025 14:58:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763211518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNq2877iOyuVzLT0PRQe0/DdxSF5iPR6Z7csacvOINg=;
	b=DPiwbuxYbLUgN9V7aE+RXNEgRBW+IdrQaaEDaK/oSZqaTmOuhfShZyqz2bG0MyFlJH/GxP
	R9/nJ8dFEqdwNDBUCFuv2toZEqa8+owprCBu/+26PSnnuoamraq/istvU3lusy6xbLZ2Tw
	8TfdjVWRVT5Cjg8GDaIx4A8uu3CMDUA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763211518;
	b=te3JEOPk8zrB6GBXLbWSnybh6DAkPGiN5sGhJKLityPvWU2lHw2C48niJ5ca7rlpTeESZ5
	2Uk+B9NdSHrCXRSovF8cdLZzwYA2UfYttHxk04BeOtohrWMsGjNVW3uIyVLPkjCITGlZVI
	rAyOpZg0nsvPmChKwciJXlja4XHm0U4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763211518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNq2877iOyuVzLT0PRQe0/DdxSF5iPR6Z7csacvOINg=;
	b=VJ8d/RL17iytGimiNoLMcIWUzfX+Z59u01R0oyy2MJTkPkmrWAngrYjJ6uAjB3siUhTjyx
	oEK4/aTJ6BJVbiRUCuZDJQJsRpFJRPtnZSMzlHWSU/OrUk1qbaFr66hvIliRbv3uOZ5oJ8
	nmiJcl4wqCY62mDeGN5PVQjr003DhrQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 3/6] bap: don't configure endpoints of all codecs at once
Date: Sat, 15 Nov 2025 14:58:30 +0200
Message-ID: <da2831adb83ccd12e22e7756694fe347d3942691.1763211509.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
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
    v4:
    - no change
    
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

