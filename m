Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF62609CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973574; cv=pass; b=mBamj2g2D2RwKs9/fdZ800o32EcgGtFETZjl2CwEz3nycDuSPjFsPxob2Y3gtBcAiv7nSB2hguD8+/wBPiZMeHIzCWYipxJboZ3RHiOwCSadGfyqU4cEpwwmuRHoTTVgZLZlzRUwWNnaP9j06q1QO9vo6L0T8SA3e8b51BLPDDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973574; c=relaxed/simple;
	bh=6MFscxgDu7o50Nb+9iz6Yn6Y/uzZ3eYt+9IriewrEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ8uVr436PLokFt5E63PVX/7WOhMfDHtrhXckUncdYeerzWbxv9vAiqgO1EpufXiSJvNLEffVEoCpMFlIADkyOK1OMCTRuGNKk4ve9/DB5ZUaPhCpZRP8yt0zORFFbPvvX+RR1ypK4D2UWu9KcIyznicd5TrIdedwJNpmORmd3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JZJyuAhu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JZJyuAhu"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d6CFm2ykBz103y;
	Wed, 12 Nov 2025 20:52:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762973564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2no0KdLda76kaRT7zKBsQfQVNTbDu1LRl6jiHXFYrQw=;
	b=JZJyuAhuXiZJruKk8oBcy76SRj/D8CMLQMANIg1NsYrkQOTWpeTr/nKleUdzLxNu8coy7M
	euu4/9B/D2WgXqIm1Ls5VtDkOCo94ox/vkYlkw3zD2YTSXPrmerqp8M3LE18mMeUlVL//G
	n99OJ+dFuxYd9oUxsMIwB/cYN0MuLdY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1762973564;
	b=tV4q3q7bhQi5HaihjC7FCZ7099JxeEco7+RaPdvw4vKnL1uP5KAXDSDaPplDPcbk+OiVu6
	IYUvP2iz0jgPTly0XZy87wpu9dADG+DHJQ4asGPGAdBGY707cJq8b45SPp6+PPkaI6H25a
	JEIJUIZrmukReg+5TReec5Q0VUVyJ9U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762973564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2no0KdLda76kaRT7zKBsQfQVNTbDu1LRl6jiHXFYrQw=;
	b=I9F7PhNAFyniC0sSOkfouYPeM4N8RY+XO7zehm5AKGOtP1XTixEg+SIvWsCAGE1WF0CweS
	Hv1u5SVw+u4e/J/cr2l3DCWBZ2lk1rT3waKjmEf+6KK7b5K5Xy0GWPu9Q5wUpwTPdwamAS
	LKbMwkJKa5mfBJ1NVz7Vh22RUolLVY8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] bap: don't configure endpoints of all codecs at once
Date: Wed, 12 Nov 2025 20:52:38 +0200
Message-ID: <05307c82b36d8b598d4405fcfe23128f0ac88d69.1762973380.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
References: <5d291ba409a0736f7074a7e42988570d29ac58bb.1762973380.git.pav@iki.fi>
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
 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9fb879345..873111528 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1921,7 +1921,10 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	bt_bap_select(lpac, rpac, 0, &select->remaining, select_cb, ep);
 
-	return true;
+	/* For initial configuration consider only one endpoint (for each
+	 * direction).
+	 */
+	return select->reconfigure;
 }
 
 static int bap_select_all(struct bap_data *data, bool reconfigure,
-- 
2.51.1

