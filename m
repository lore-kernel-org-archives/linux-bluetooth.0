Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0F927E074
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765311989; cv=pass; b=kfh75D3koZueN0UBfrGP2YfLjsxHPmNtgs/h5kNeFqME7YY29QSgIvBXCltNPqsZINEZxBlAMREvjBpdFg4GtFTwScwHhfNbUZQHgN+8gAR9hhCLtZINwxoeEI6qb+E4PX9ehgnJisILkO2Zm2kQFA/eOsVH1ze1n8/Vg/M1znc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765311989; c=relaxed/simple;
	bh=NeOBcBbY3lGU7cV3Tt+OpKKgs9l5srDVHaF7Tdbugbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6GqiTPAdDJjvaGMvlZWzmotuReiNUnfQ/DLQZ3t8wlhmR8j4CpDleuV6PXyatWqEBX7iFu10gNMThsw5HAItvwDR/Uqv0Me1O0R499GWogg7v5R48TDbaHcBI3HqQk44NOL5blWLipRkvV/fUiO0PXEEf9M6ycikLBWnKC+yyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=omKhsy0r; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="omKhsy0r"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQr3D3SSqzyQH;
	Tue,  9 Dec 2025 22:26:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765311977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BHA1b46ghLm7K+SUjbgpnR+ON8ltm34Qi/5TxCHZ79g=;
	b=omKhsy0rcKM0xr7PUzoEv3TisklgBC6955qpIsGrMMGmbP9ysUbDrkfAyOw9kYZAV0/9qL
	zgMdZYJMwDm8M+Mft4iT6GhX3OtCrQPdV0zGvyAQHI4fYoGQ+r0DNYzz65vhqMXMwSh0G4
	qc73PNQPrWmjw/3TPgqXU3NBv+y0xMo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765311977;
	b=ZHXExCJeZptuKaCwOX9NainRnNJcMD2yugYfk8YiOVUTwDOlzGI3R212hfHPHj6yKWxMpN
	O+gkJ7hJcCbPjkU5BUKo3SeNMhvNnpoQvLykjGa83apyvLAlcXEewxsq05z4+AblRy2Afs
	XZ13MMNZMtFGkTre8EM/HP+w6OkXl3Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765311977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BHA1b46ghLm7K+SUjbgpnR+ON8ltm34Qi/5TxCHZ79g=;
	b=Ed87VUJ+Wp6NCNPH95RdmmLtGjRzK7+M7P4Rrjdtal/8gRjlJcrRCGjD9WWQkpjtuqMv4n
	aBzINpUVthGagb1JbQr9qGSszPW9zcFB3eqUMZ1gPn6wHtl8Y1BeBZOByaHp0ShTd/TTT2
	3Jh+xbUXw1UVh50Dp2+JhIj108Wvwsc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] unit: reduce macro expansion volume
Date: Tue,  9 Dec 2025 22:26:11 +0200
Message-ID: <8da87c1000bbbb062d302b74518351a8ba65075f.1765310255.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

define_test() in some of unit tests expands the long command sequences
three times.

Make it expand only once.

This reduces preprocessor output e.g. for test-bap.c from 23 Mb to 5 Mb,
for faster compilation.
---
 unit/test-bap.c  | 4 ++--
 unit/test-bass.c | 4 ++--
 unit/test-gmap.c | 4 ++--
 unit/test-micp.c | 8 ++++----
 unit/test-tmap.c | 4 ++--
 unit/test-vcp.c  | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 83457bc7b..2da427694 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -121,8 +121,8 @@ static struct bt_bap_pac_qos lc3_qos = {
 			data.caps = data.cfg->pac_caps;		\
 		if (data.cfg && data.cfg->pac_qos)		\
 			data.qos = data.cfg->pac_qos;		\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		data.streams = queue_new(); \
 		tester_add(name, &data, setup, function,	\
 				test_teardown);			\
diff --git a/unit/test-bass.c b/unit/test-bass.c
index 8d914cffa..0cdee043e 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -491,8 +491,8 @@ struct ccc_state {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		tester_add(name, &data, NULL, function,	\
 				test_teardown);			\
 	} while (0)
diff --git a/unit/test-gmap.c b/unit/test-gmap.c
index ce9eeb8f9..8b37efd18 100644
--- a/unit/test-gmap.c
+++ b/unit/test-gmap.c
@@ -54,8 +54,8 @@ struct test_data {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		data.cfg = _cfg;				\
 		tester_add(name, &data, setup, function,	\
 				test_teardown);			\
diff --git a/unit/test-micp.c b/unit/test-micp.c
index 9c4f834e7..ff17300d5 100644
--- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -70,8 +70,8 @@ struct notify {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data_mics data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		tester_add(name, &data, NULL, function,	\
 				test_teardown_mics);			\
 	} while (0)
@@ -80,8 +80,8 @@ struct notify {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data_micp data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		tester_add(name, &data, test_setup, function,	\
 				test_teardown_micp);			\
 	} while (0)
diff --git a/unit/test-tmap.c b/unit/test-tmap.c
index 937dac6ee..e75d62119 100644
--- a/unit/test-tmap.c
+++ b/unit/test-tmap.c
@@ -51,8 +51,8 @@ struct test_data {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		data.cfg = _cfg;				\
 		tester_add(name, &data, setup, function,	\
 				test_teardown);			\
diff --git a/unit/test-vcp.c b/unit/test-vcp.c
index 71c545656..4a60842e5 100644
--- a/unit/test-vcp.c
+++ b/unit/test-vcp.c
@@ -59,8 +59,8 @@ struct ccc_state {
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
-		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
-		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		data.iovcnt = ARRAY_SIZE(iov);			\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov));	\
 		tester_add(name, &data, NULL, function,	\
 				test_teardown);			\
 	} while (0)
-- 
2.51.1

