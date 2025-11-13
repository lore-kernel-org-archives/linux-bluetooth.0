Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DE35CB68
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052922; cv=pass; b=gQ5M8wJiYkkLPMhYPp2iZslQZs9epTBsTRYLNvvZ4Jkvsbs2eYP6fvY4mhZxYyYEcJnMejOzfudDGi0wpZ9wYz6ymDlQH8gJNv4ZqohjVoSC8d1bsE5t0NErrD6zsKQjwdnOM3iuNDOC0vgeQF8MpeUeK5Kxjk1oIMqWUAcwfjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052922; c=relaxed/simple;
	bh=TjDNZlkcOIVEtNlhr6lVLoAg9UFa8wxO8eiwwuWZNlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lB55OIriRNv6hUGoQTtzZidd8UM15te82oXIC2HO+INO9QS59Q/P9WduCQOqCSAv4g6Ds8dyipCg2+SXuzcIu+Py0fPlkCaJpRHfBTjJnu8TicGQLfM27/wFIQZhvRJwT2kk5z1VFgCaHLUZb9Ki1BnOVgSbop2RpE0vfuTQGIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JWMRc1uM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JWMRc1uM"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6mbn5Qpwz104y;
	Thu, 13 Nov 2025 18:55:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763052917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFDSGyHKOHWT5XAAVOX+1fcbs0jXZdKjGK2Pj1m/m/Y=;
	b=JWMRc1uMhH+0co59rlP5EQMgCBoEo/Gc9ge9SupSP8yLVMbfUlXl/vAtbFYmo4Hk4QdjVy
	JVXpJ50vn9vy1gVYS0UebrWdcwahJkZtDBGSoLViZ6aFpPGa+odgxsEGf1rsjwptotMRgB
	diIp1M/zJvClTR5b7Jw+tN7VpQ1Uqbw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763052917;
	b=o8XHX9Elzml67TpSWJv/UxhwfhQihNByZhyEbJ681UKhjRnO1JKPLTjaeT7X2JAXZjOfqB
	RH+n5M8qOSRSQC79zpgbJ+8l8nDMuzypMG5ErTL5eHscseQnKSTLe8heMzEnZbzerQkHEM
	q9ig7NXzYynVNtqU3LWnYpj2uFGefU4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763052917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFDSGyHKOHWT5XAAVOX+1fcbs0jXZdKjGK2Pj1m/m/Y=;
	b=PK0HGV4Cwokg8x83HcyD4Owc5T0kqZgetK9vlYIg5hZsevPCJvEkj06tz0CR8RlMYZyezl
	yAPgT+RHsPzv+Y/Pq0YO0BuvkldfG+3FwQimoI0L+L8SLz3pj8C80mQIlA4v5BkZ3+04s9
	v9y2On6vM5elOtXGSarH9+26mH0NQ5Y=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/4] bap: don't configure endpoints of all codecs at once
Date: Thu, 13 Nov 2025 18:55:12 +0200
Message-ID: <f23db78daee4c80f29c5e26f0d27063cb49bd9ce.1763052876.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
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
    v2:
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

