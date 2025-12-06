Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211F286422
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018908; cv=pass; b=LhDAleC95Dzuu8lIcCo+xxngJZsX9TibBL9bdrh7lcKNKj3LMWGuOXdcZgY3rOqUjS+fM/Qjfz86ekbm+CCvrAHnPs/Pn2TdJFrhka7j50FTrqMzXz3CEhzr0juLNu76v4djpVn5nmHQI82kIvk9iAw4IHG8LWWwt3SisG9LXBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018908; c=relaxed/simple;
	bh=Rz3Jd4uukj8/6VYNuxbF0dJ4oKcvdnBIJXL2gCIAFqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS/fzhUuwColYRzQ2cbKrR9lfpPlu9sZQ2FFxIc5Ty/Ufc7Gyd2SD4Pe2hN3sSFIIjiQvuQNw35yY6yD8fJg01FrK6inqPEYdvScnU03hrtg/zU7dKRZnasojd88dUDYmUxRmtly0n7of6BQfs7W76B3gdZqiORHY7pspJmFVc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=C++cgN6Z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="C++cgN6Z"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlgC4x4mzySY;
	Sat,  6 Dec 2025 13:01:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOi60LsTDCeuID4cgsYGOyYcDJuIFGMG+t5r18fSCN8=;
	b=C++cgN6ZEYPwyrprKUxqgjT0d8IA8Q9/77ACGH/vC7ValOHiH0RI/YjwqCpTFJqINaLlDM
	Sq1aYB6tRLnX+uI5Z7nhOoPIaoYwULmp1aKBSR23LZ2hWdPrbeDIAa8ykprC/FuOSt63Es
	JkHMW5UXXAptTg50eUVChI+ZcE5dErU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018904;
	b=JuL8yiQKwMnayQxCcmDf7XQlpG3ClznInXhFdmln7Js8O5C+x1evtEpiuq8e1+O0X0V8uM
	AimLRykY5w1exPrQ/6FCt/U2NQOU+kQRIff60UGY/SRu96Pyn/KK/fM8+8nJ4I2r52Fvie
	CTgzBnFkDDeutvltyV6bhWCG9Txje94=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOi60LsTDCeuID4cgsYGOyYcDJuIFGMG+t5r18fSCN8=;
	b=Jnn1WhyMvQmrpwBdv72mYcYEpotGUXhHv/EM2POqLn0gvQz2rymSB0y6oidxgXTn6YPOFN
	jI04Dlq4/qsa6ai6umrFjkW8R48cgEzDEYf1bTwRmAHiR5XakXINmsKbKrbtq284WLPys9
	gjSAPvyKCf2DP68CVaZcx7yjGCis634=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 10/11] tmap: remove service on device remove
Date: Sat,  6 Dec 2025 13:01:26 +0200
Message-ID: <5f5b4980673dd4d7967d55feda1f5d54ad135bb2.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.
---
 profiles/audio/tmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/tmap.c b/profiles/audio/tmap.c
index 2525c33bf..23e72165e 100644
--- a/profiles/audio/tmap.c
+++ b/profiles/audio/tmap.c
@@ -141,6 +141,8 @@ static void tmap_remove(struct btd_service *service)
 
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
+
+	remove_service(service);
 }
 
 static int tmap_adapter_probe(struct btd_profile *p,
-- 
2.51.1

