Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA722298987
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018906; cv=pass; b=TANP3qDh0yPReZCicrTO2YxSpn+UVUGi5a3yErwXxd+eb9IG18QEPzPiR6bk1MUxWxpUcSQM3316/RTF+28fAU79EF09NBhIyxUcCiAbA0EIQptPLZL5m72g13f1aq8+98CzStmmGDzeSF6EmZqhe7G6sY+JDBmeVH63Zl8FzAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018906; c=relaxed/simple;
	bh=/Bnxe6wasam0JDTjtHgyhzvBFhVqQyL1P+p1g5Fp+0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss8AuxZY7oQ40G87rqxIli6XxMgKkQOku/dLAGTV6pg6yH7QCeBEM+sn/6BKNjfgCtNWGDA96zLY5toktfhY1oPJfxfP6NaWKBSky8zWnjaggfu7e/3Vb/QpLBJ+oc8ESiw5dOLWmdc3I/u34Q5FfqLB2Rm52qlsit6NkqmbHbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZE0i8p/R; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZE0i8p/R"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg42hJ1z103S;
	Sat,  6 Dec 2025 13:01:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8D0xB7m6SFQ/pbTfgId8FzX2U/VR7Db9LqpJcdjcT0=;
	b=ZE0i8p/R6LAn4wLf0hYrWgmrYPuNPsrr+ZMZfWS/uzEDDwnFDvGkFaXtEu/Ig/zFDN2Bx7
	CDhOR10mqcboaye2vaW0JFdAZIpCsNcQ8z/ryfhd5nstLHSG7Fde/ebhKF49QSQcRFiIdO
	IsvPpUT25JN7zATH6fO+sb0mif7ky4Q=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018896;
	b=NfnvKBhlfoCIHSKCWo9FP4F+6GPxzZV5HgvxuarGa8S6QdygHR9CZo3t5Db7DGGn8xH7kQ
	49u6BXxo2NKUE0hAxjRZUKet22ctXls3O+dA5LJ7yXFFdYCHqG+b9Y5GLgTPtaVr3RHBw+
	+dpELpbhNR7Ekwx0duIP1tn0Z2y1Djk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8D0xB7m6SFQ/pbTfgId8FzX2U/VR7Db9LqpJcdjcT0=;
	b=S2P0rcIC4OwKmGznlsxh7Qj4rkIIjkE5yj0uhsiYlRZsjp3jj4e4QP75lYFIB/oU73OQVc
	BNGU3XHw4iYTiBWq76hQ/4RQ4WizMK7nle3JOCbXdCI8R6izE7aq88t4t/4fBmeKvd7ozi
	c+iXuavg11oxkorDTGxFXwuOPbzbq0g=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 04/11] bap: use tmap/gmap macros for listing features
Date: Sat,  6 Dec 2025 13:01:20 +0200
Message-ID: <067155c7930a868f884aa4e9585809a6466364d1.1765018766.git.pav@iki.fi>
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

Use listing macros to generate the feature lists.
---
 profiles/audio/bap.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9cd649c7b..cda10a643 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -469,34 +469,18 @@ struct feature {
 	uint32_t data;
 };
 
+#define TMAP_ROLE(key)		{ key ## _STR, probe_tmap_role, key },
+
 static const struct feature tmap_features[] = {
-	{ "cg", probe_tmap_role, BT_TMAP_ROLE_CG },
-	{ "ct", probe_tmap_role, BT_TMAP_ROLE_CT },
-	{ "ums", probe_tmap_role, BT_TMAP_ROLE_UMS },
-	{ "umr", probe_tmap_role, BT_TMAP_ROLE_UMR },
-	{ "bms", probe_tmap_role, BT_TMAP_ROLE_BMS },
-	{ "bmr", probe_tmap_role, BT_TMAP_ROLE_BMR },
+	BT_TMAP_ROLE_LIST(TMAP_ROLE)
 };
 
+#define GMAP_ROLE(key)		{ key ## _STR, probe_gmap_role, key },
+#define GMAP_FEATURE(key)	{ key ## _STR, probe_gmap_feature, key },
+
 static const struct feature gmap_features[] = {
-	{ "ugg", probe_gmap_role, BT_GMAP_ROLE_UGG },
-	{ "ugt", probe_gmap_role, BT_GMAP_ROLE_UGT },
-	{ "bgs", probe_gmap_role, BT_GMAP_ROLE_BGS },
-	{ "bgr", probe_gmap_role, BT_GMAP_ROLE_BGR },
-	{ "ugg-multiplex", probe_gmap_feature, BT_GMAP_UGG_MULTIPLEX },
-	{ "ugg-96kbps-source", probe_gmap_feature, BT_GMAP_UGG_96KBPS },
-	{ "ugg-multisink", probe_gmap_feature, BT_GMAP_UGG_MULTISINK },
-	{ "ugt-source", probe_gmap_feature, BT_GMAP_UGT_SOURCE },
-	{ "ugt-80kbps-source", probe_gmap_feature,
-						BT_GMAP_UGT_80KBPS_SOURCE },
-	{ "ugt-sink", probe_gmap_feature, BT_GMAP_UGT_SINK },
-	{ "ugt-64kbps-sink", probe_gmap_feature, BT_GMAP_UGT_64KBPS_SINK },
-	{ "ugt-multiplex", probe_gmap_feature, BT_GMAP_UGT_MULTIPLEX },
-	{ "ugt-multisink", probe_gmap_feature, BT_GMAP_UGT_MULTISINK },
-	{ "ugt-multisource", probe_gmap_feature, BT_GMAP_UGT_MULTISOURCE },
-	{ "bgs-96kbps", probe_gmap_feature, BT_GMAP_BGS_96KBPS },
-	{ "bgr-multisink", probe_gmap_feature, BT_GMAP_BGR_MULTISINK },
-	{ "bgr-multiplex", probe_gmap_feature, BT_GMAP_BGR_MULTIPLEX },
+	BT_GMAP_ROLE_LIST(GMAP_ROLE)
+	BT_GMAP_FEATURE_LIST(GMAP_FEATURE)
 };
 
 static const struct {
-- 
2.51.1

