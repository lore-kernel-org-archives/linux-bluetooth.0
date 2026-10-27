Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071704;
	b=2GuX7eUzdsYBAR322a0X4oux79SMjvGn6FBCVEHhFXeF1FutlmZeda94PMqVpzLS6sas
	 bldL6WRkpL8uoH2TnrvfNyvje30VkY1kG7GngNy/Nj+l1CaeSmWhbImSHA5fVKCJ/2dsd
	 7NzxANoBoMtdrSMUQJz3fxNsOgmomiFrF/DZ+gB/qz1d5PB4cluk7sraYTRL4h0owpFdd
	 YnB27qYZiGH066+avTvd+vsNzEOk2AFWMA2w2hDxRPZKvl9r3OASRIBDtz1CrvA7+UeSc
	 yF686aQqwC64OGTz3DdcBB8RuLB+8YfmyQKQHFFIXEw/LHEVUY7Jnhqev1B8/OXAM/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071704;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RnmcQzVYTX06ofp+ExVviwvNJ2mlmloOPWpcC5ua9n0=;
	b=U6O4c+KxxwOXaDGMhpaZcmo3W653S3OMRdqkPKrqKnXpOp/WM0I9W8hvQ363qkvXKiCa
	 n8nAesw4ZXfJz/y1W6hXiNiRenUe3xPq9XQI1to4GzSBiY07xegbWUlxq38rLL0Uasfix
	 9nDwfOY5x7jXogitsdZ7hx+hgYjFnGVnmgFSfdMSI/qaGtIPbD6RcD880L4YAmo6YZssI
	 QBCPmpK2H+nRN07DZ9xCzur74cTHSDyene9pieb9pLTZG8k4uSQ1ixfc6DxCHYWBhucky
	 N/kDkBMtznoo//VsrQ/kSCJ6T5xn/ReHaZCMKo73v7t1N7tFho9IzmSXFpFjptCKVoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=capsize.online;
	spf=pass smtp.mailfrom=capsize.online;
	dkim=pass header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=JbIMfXxu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ewAo88qC;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E943606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 03:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E943606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=capsize.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capsize.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=JbIMfXxu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ewAo88qC
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABB817A013E
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 23:28:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 23:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=capsize.online;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793071702; x=1793158102; bh=RnmcQzVYTX
	06ofp+ExVviwvNJ2mlmloOPWpcC5ua9n0=; b=JbIMfXxuIRxpJ/7EJaj4WU7Rkp
	tEyrMj6RDoOG4r2og5SzO7BpHocs6OgxptXu7elGhZep6xIU06a9vZEN73DZ5zZO
	Feear35ZOMWyqwhAeyZvC7GpU4+2JsSSGcLpSrM4QNjuBy/PGLaa+zRpWiHGY6Ew
	SJxks6lyvKRHaCPIYaLdVZHL9k+Lpcf54TeSIzz9Rnl/wB0Dj9RznulQF6mr6v7A
	yn4Tr3SkSm2r5R28BSIpys1gEnelRK7sEIl+pPyZFLOxtPX3m2hhENrGWqv7VwoJ
	93v4c7Xj4QOQfIp4qVMZmv3SbA4MByFarn9o/T/ZI1Hi7LzoSxhhxrJUBvxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793071702; x=1793158102; bh=RnmcQzVYTX06ofp+ExVviwvNJ2mlmloOPWp
	cC5ua9n0=; b=ewAo88qCL4gWoRZhKxmdWwH3zNVdQcLBwG0rrJOuq74K2OmGRYR
	ymvNG6KtXe5BfiG4uIQ0KW48OkINdovyU5b5I05+gjQ+ZawUjPD1XbE9HMULcDMu
	BOA3eRbBYieSA7v5+bwE7WgckoHSu013m5SDgogckRDyIHvS9C6Ce0aF+FiC9C0R
	ymdPV7Ig4WreF5edCHkV0GIXsqGLnAZ8Gd2gece0tLhdkhHmzE8Fh4RAd5eBVQGM
	FcVwXLU+5fn8I3v1BR6P58stxjq57hK1BxI0Ps4gqvlCTqeHS6s4Hs/KXwxx5XhK
	pT8fRlz2U2f/bEOBaoqhe0JeDDoXDFxyO/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=capsize.online a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793071702; d=capsize.online;
	mf=PGNvbnRhY3RAY2Fwc2l6ZS5vbmxpbmU+;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CN0K9PALCeSiv5CJPjKADyMrFafwrNq3D1wSmsWR2awClBJ
	KQwCumcP5x82lKQi4hnXWDJ0n4YTljJm83fI+4ruFIYWBSXHNMJOmRuqoQrFBMNd
	u3GynJVM6BkH9H0vunkstxzySSNFVaqyYCx81dsj3GybCph+67UHv70pvEOr/wmg
	FdggtdnJnKLbzOWvvd4+SimimtwvH1qpaY9p1+v1UeYp15GnzcAzS5CIu5lh6W7O
	nM6t2Bld0lj2l4xfAQf1j6DrEqFQXETVQWOwtexvE25pqj2GtGelzWr70YHl6ctI
	uAG6fbDvA1XKvwYpDQZnie2wVUPSY+wS9X0osMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:QtnREnKpyqn4LJyJcGJOxggj7HaOGohyG0hCvO5ZwlU=:Wp2cXhqUNAPVWxMbzhxdNGoaZzgvWY5ClzHCqYWkd7k=;
X-ME-Sender: <xms:VhrgakL-RGFSGkfBj94tQ80iOcIkVzLyd48VBeGXY67evvmzO_cjCw>
    <xme:VhrgaqItO-BdzuiL_v1gAlOAE9G6MPy3vXgE730Wez1pnQUeKNaKRCMH-WYW0Z1oC
    UOB6M3gi8pDKolxzln_hUkD5rhg2ciTaFf6F6eYn0pP6U3q8tVt8A>
X-ME-Received: <xmr:VhrgaiXw0mXs7CFXfnG3O8KEbaqDLk3I0yo16jPlgbvM9U5c1efEyhx7XI5eAfnOQG3QVeSBvaNSLHYR6K-l5lxkNYiiOGCV>
X-ME-Proxy-Cause: dmFkZTFwSitfexMEMxht5D+jACWuGKjBL4GW3kSN2pzzfsI9cTREw/5wBMOjw5ygrfXnmK
    QQOfubgyeDfxmLkWE8AewbBGUL8WCFP5vy2o/PT6m9T98x2wLVSfKJXEy/RU4+HsReFIcy
    p5sxuAsJncEl0bKNWC6KNc7GamZrhlmGOYUnmq3lbUJ21mIOFIOE0iBH9Eu6U9njInxG0B
    xP//n8eVCw7Bx3Zvpyp57fggtLTwz3Wrf7B7ip8yMo1sra1qvsP5jaLmg7RcmU0oIogNnl
    j3T8v6Z2uo81StTY2EX+j3XX/cF7pf4znOoLn9Wz3Isy+70h+Sdrw4NkLUmqfrT9T93SPu
    o2qnqnNk01b6+B0ilFaI3+/6wjyfU8N6dqAZ6A/iL/A1i3y8EQshj/cYkE7yi+I9YAy0Rn
    IRE8+TUK1n+czDg+A3LJ3sFdBH8RBl04HWoDgK9WY8/kf5LtDQYVxaXxTURuyPbtYU/lon
    k5IF8ZBCb7qNFTD5VmWzWjZY33/lBK5EVv2g8Mbfy7Hu1eq+tvfnliLV88n1cwVreX0Kf9
    R06LTOIYiNn4pUVsvDBuJprVqfYPblEYw2f4h7kj2C2dpn9esPnEC0A2LhD2omcWgyr0kw
    DRUXURBX1l9QL9iIp4V+nenPMm34FxJ1gvXl5pMf6USKhuK8rZ1iOwIycwMw
X-ME-Proxy: <xmx:VhrgasjGh36Z76iVTHUnM5otRDqrJIleDbReuZf0iXz8o4TpNxnELg>
    <xmx:Vhrgat_QjXaKS0CX_qVhtmBnoeTAzbNCoJwBYqLJU98NvGLYVnmqKQ>
    <xmx:VhrgamA0NnHrt0tpt-2H8PmbywagYdnKU1HyuO3NxwtSV1cQQFp_lA>
    <xmx:VhrgaqI_N0uNMMqq4K8h5S6RAdQhvpc7a_jHiz-erMV8RhsHIjpPmQ>
    <xmx:VhrganhVEIWcanq8Zi6xd6boQnhMsvm8kGTtOixCJJkpLm9M-pQZGlAO>
Feedback-ID: ic30e4aa0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 23:28:22 -0400 (EDT)
From: Capsize Security <contact@capsize.online>
To: linux-bluetooth@vger.kernel.org
Cc: Capsize Security <contact@capsize.online>
Subject: [PATCH] monitor: validate Return Link Keys length before parsing
Date: Mon, 26 Oct 2026 21:28:21 -0600
Message-ID: <20261027032821.1088858-1-contact@capsize.online>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

return_link_keys_evt() loops i < evt->num_keys dereferencing
keys + i*22 while the dispatcher only enforces plen >= 1.  A crafted
btsnoop capture (evt 0x15, plen=3, num_keys=85) overflows the on-stack
packet buffer (ASan stack-buffer-overflow in print_hexdump via
print_link_key).

Reject payloads shorter than 1 + num_keys*22 bytes with the file's
existing too-short-packet idiom.  No integer-overflow hazard: uint8
promotes to int, max 1+255*22=5611.

Verified: pristine HEAD btmon + crafted capture -> ASan
stack-buffer-overflow; patched btmon -> 'too short packet', exit 0,
ASan-clean.  Boundary matrix (valid 1-key, zero keys, exact-fit 2-key,
short-by-one, num_keys=255) all exit 0 ASan-clean.  make check passes
on the scratch build.

Fixes: 7d103ce15295 ("monitor: Add support for decoding the return link keys event")
Assisted-by: Muse-Code:muse-spark
---
 monitor/packet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index a301e1ae7..e51cf7bb0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12224,6 +12224,11 @@ static void return_link_keys_evt(struct timeval *tv, uint16_t index,
 
 	print_field("Num keys: %d", evt->num_keys);
 
+	if (size < 1u + (unsigned int) evt->num_keys * 22u) {
+		print_text(COLOR_ERROR, "too short packet");
+		return;
+	}
+
 	for (i = 0; i < evt->num_keys; i++) {
 		print_bdaddr(evt->keys + (i * 22));
 		print_link_key(evt->keys + (i * 22) + 6);
-- 
2.47.3

