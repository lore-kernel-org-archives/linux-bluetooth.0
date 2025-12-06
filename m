Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30C222585
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018905; cv=pass; b=cFoNQRRzJZnvH6S/c41v3GGojX1F1drEjpx3ZlMx9pMwCfQjOUZi7caZThZjSrJr3anTB3P56RL1Q1MXX+42ckVJBhPJpQMx8JNCO/eeQFiuUXKLh5/3Rrv2WyzO+sDUkgfsL0Rg7Rc6bdAVI4pflXNXaPkqBqiikHnlantzQdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018905; c=relaxed/simple;
	bh=Yx9EhTObkF/kB+Nrl/srdut3SFPDyg9pfGgHiwCwII8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKlq4hRvgqiUvOtgNezvjY/5rxM6zlk5Z/zsNfarjy0ADktmnc8UUwcNyyJA2g1pvUaeKEyVZ5hUNA/HjDvGpTiBa1QBiA2sejo4Flt/44qiXbeyYdmcMreqRC+7NRn4tVztl+uTVkfjAWKumsDnfwd0PcJSnR/jRvZFGJOVh8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Vu6YO7rE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Vu6YO7rE"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg32Yllz104J;
	Sat,  6 Dec 2025 13:01:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MAQkqL+1ESGcuyoLxsxsYQdIWEkd9fBe2+WZXg6fso=;
	b=Vu6YO7rEvAF213K/vklknM04u15Gbd1rrHS2WiBiN6tQDeQJ7n0bUXVAvkofRrM8wisZ07
	THzAh454cN7Mfa+TcHJ6g6e8yAWa6s2H6st6j5baunTXiEDzbJTFfY8ZSxMy8vukgQp5FK
	yyWW91N5ElIqq8pgzV+weU80tjy1GyA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018896;
	b=jGTx3OMCTNtaEaDAZznQ/ldlB54U36xEarQmJOAz7TyaS9Se0+bbkXvuUcW99QIe/oe0ko
	qtnW+4bRl7CrXOmLFI/Bb+0tvqfGLyu4+EQ5hJk7PezeAR/ouPR+1t7PArbtyVkzeed+/l
	9eQZc4GGuyd/MgRaNvvrpBv+cW3tTrI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MAQkqL+1ESGcuyoLxsxsYQdIWEkd9fBe2+WZXg6fso=;
	b=U9IJNl3ZTLvNqMUVTT6B1ioRbaqcRTiu42oPBR906294xitqPw0cR5hAZin9ZCkNOVtf6X
	M3Sh4IZSTpZUHj8ZeFepZk2Rp/J+3F1ac1scxuOgAy5LicJY0/q9u0pUPrSOBtXYp2EeWm
	ktLBsjd0jJ+OxNVFgt70q/6DA9Q9+Ek=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 03/11] shared/tmap, gmap: add macros for feature names and listing
Date: Sat,  6 Dec 2025 13:01:19 +0200
Message-ID: <d127c7cdf011d7af03a7c1c10723491b83c4f2f8.1765018766.git.pav@iki.fi>
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

Better use constants for feature names to avoid typos.

Add macros for generating lists containing all features / roles.
---
 src/shared/gmap.h | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/tmap.h | 15 +++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/src/shared/gmap.h b/src/shared/gmap.h
index ef7d96e0a..d633bfe69 100644
--- a/src/shared/gmap.h
+++ b/src/shared/gmap.h
@@ -17,7 +17,7 @@
 #define BT_GMAP_ROLE_MASK		(BIT(4) - 1)
 
 #define BT_GMAP_UGG_MULTIPLEX		(BIT(0) << 0)
-#define BT_GMAP_UGG_96KBPS		(BIT(1) << 0)
+#define BT_GMAP_UGG_96KBPS_SOURCE	(BIT(1) << 0)
 #define BT_GMAP_UGG_MULTISINK		(BIT(2) << 0)
 #define BT_GMAP_UGG_FEATURE_MASK	((BIT(3) - 1) << 0)
 #define BT_GMAP_UGG_FEATURE_SHIFT	0
@@ -46,6 +46,49 @@
 					BT_GMAP_BGS_FEATURE_MASK | \
 					BT_GMAP_BGR_FEATURE_MASK)
 
+#define BT_GMAP_ROLE_UGG_STR		"ugg"
+#define BT_GMAP_ROLE_UGT_STR		"ugt"
+#define BT_GMAP_ROLE_BGS_STR		"bgs"
+#define BT_GMAP_ROLE_BGR_STR		"bgr"
+
+#define BT_GMAP_UGG_MULTIPLEX_STR	"ugg-multiplex"
+#define BT_GMAP_UGG_96KBPS_SOURCE_STR	"ugg-96kbps-source"
+#define BT_GMAP_UGG_MULTISINK_STR	"ugg-multisink"
+
+#define BT_GMAP_UGT_SOURCE_STR		"ugt-source"
+#define BT_GMAP_UGT_80KBPS_SOURCE_STR	"ugt-80kbps-source"
+#define BT_GMAP_UGT_SINK_STR		"ugt-sink"
+#define BT_GMAP_UGT_64KBPS_SINK_STR	"ugt-64kbps-sink"
+#define BT_GMAP_UGT_MULTIPLEX_STR	"ugt-multiplex"
+#define BT_GMAP_UGT_MULTISINK_STR	"ugt-multisink"
+#define BT_GMAP_UGT_MULTISOURCE_STR	"ugt-multisource"
+
+#define BT_GMAP_BGS_96KBPS_STR		"bgs-96kbps"
+
+#define BT_GMAP_BGR_MULTISINK_STR	"bgr-multisink"
+#define BT_GMAP_BGR_MULTIPLEX_STR	"bgr-multiplex"
+
+#define BT_GMAP_ROLE_LIST(role) \
+	role(BT_GMAP_ROLE_UGG) \
+	role(BT_GMAP_ROLE_UGT) \
+	role(BT_GMAP_ROLE_BGS) \
+	role(BT_GMAP_ROLE_BGR)
+
+#define BT_GMAP_FEATURE_LIST(feature) \
+	feature(BT_GMAP_UGG_MULTIPLEX) \
+	feature(BT_GMAP_UGG_96KBPS_SOURCE) \
+	feature(BT_GMAP_UGG_MULTISINK) \
+	feature(BT_GMAP_UGT_SOURCE) \
+	feature(BT_GMAP_UGT_80KBPS_SOURCE) \
+	feature(BT_GMAP_UGT_SINK) \
+	feature(BT_GMAP_UGT_64KBPS_SINK) \
+	feature(BT_GMAP_UGT_MULTIPLEX) \
+	feature(BT_GMAP_UGT_MULTISINK) \
+	feature(BT_GMAP_UGT_MULTISOURCE) \
+	feature(BT_GMAP_BGS_96KBPS) \
+	feature(BT_GMAP_BGR_MULTISINK) \
+	feature(BT_GMAP_BGR_MULTIPLEX)
+
 struct bt_gmap;
 
 typedef void (*bt_gmap_ready_func_t)(struct bt_gmap *gmap, void *user_data);
diff --git a/src/shared/tmap.h b/src/shared/tmap.h
index 9d872f0b6..9b37dc226 100644
--- a/src/shared/tmap.h
+++ b/src/shared/tmap.h
@@ -18,6 +18,21 @@
 #define BT_TMAP_ROLE_BMR		BIT(5)
 #define BT_TMAP_ROLE_MASK		(BIT(6) - 1)
 
+#define BT_TMAP_ROLE_CG_STR		"cg"
+#define BT_TMAP_ROLE_CT_STR		"ct"
+#define BT_TMAP_ROLE_UMS_STR		"ums"
+#define BT_TMAP_ROLE_UMR_STR		"umr"
+#define BT_TMAP_ROLE_BMS_STR		"bms"
+#define BT_TMAP_ROLE_BMR_STR		"bmr"
+
+#define BT_TMAP_ROLE_LIST(role) \
+	role(BT_TMAP_ROLE_CG) \
+	role(BT_TMAP_ROLE_CT) \
+	role(BT_TMAP_ROLE_UMS) \
+	role(BT_TMAP_ROLE_UMR) \
+	role(BT_TMAP_ROLE_BMS) \
+	role(BT_TMAP_ROLE_BMR)
+
 struct bt_tmap;
 
 typedef void (*bt_tmap_ready_func_t)(struct bt_tmap *tmap, void *user_data);
-- 
2.51.1

