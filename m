Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064677;
	b=rCQHRkeSDUyR4kBjcNEZsmoBNb85rGr/Q6yjRs5ikFlRbMjHnSi7W6JKl4hQwutOj3Dr
	 RrgG7fNWAFWsF1+MdfhjHFggmQsBJCNBhjkS7hH9Im1Iwk1CMt6xmT3Wr4UOxYKqXFJsO
	 vnU2lzovOje8Rh5y+DMIU4XuKsoVN7v/p97Lu6+zMB9aUHjRmOszieYmTcK7O1bANwbln
	 HkRfN5HX9SQgwoCQjQMWR58LhXygITc5oIzrnVMuJjaDSC6BtC2NnpA38JpJCoJNCH0we
	 0L/OB37zBragfnRRcsRfYfJdpkQJ1PffZWXj2RFAFgFrbiImZ5K2gpcMXFCBofxW7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064677;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bXqTFXOjfMd+f0x1OwnRtS2R4bcIfDr3jXNH1MZO59E=;
	b=F6S7xvH+ibUz2UTGmhf9OXTnn11rDYEykFPqahZUXfQzORXXcK0cZARHykc5wThBHT1u
	 0WbhhL2RTpz7G59g1h/0B5BbXbB3M2ezs5TcUfA+59cBH3vqHzRU+AC9lyOYQ/zA5ueuX
	 WFizb3is1WfsWzzR/9cH9qBgzHr6jU+2RJzXN90mX+RXwd9F0hh8NVuCcbhGuUHZdS0qv
	 SvkKeQ3OwqBL2X/pafqiA+e9oAkQL9cc8FVIyb7mkEcQm0/JshFrTg/7KiEepn8FC5HSJ
	 frJ1RulzXujvBjL/Yfu7IWaIsSEv1lOtqa23fdc1RD4eSCDWLb4evivJ/78taJ9ptlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=capsize.online;
	spf=pass smtp.mailfrom=capsize.online;
	dkim=pass header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=J5DFAk7x;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="T/OVZRTH";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B3606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 01:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=capsize.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capsize.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=J5DFAk7x;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=T/OVZRTH
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DCE11D001BC
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:31:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 21:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=capsize.online;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1793064676; x=
	1793151076; bh=bXqTFXOjfMd+f0x1OwnRtS2R4bcIfDr3jXNH1MZO59E=; b=J
	5DFAk7xyu3Y1Nz+WtAFyV8ecZryhFthHKejMJZjWIf/m+6+s8mb/3pSrMWFDTrlS
	QbI3+kod8c4IZDiHGcNAQ/fVaN4pYFGBoU3elQog0sgQdHlVr+A8RbHirCqkO9TZ
	cJU8uiQu4XrO3tqrOm81mtJA6vzuEUEzqkSv+RhDMTPlYF6D1r+WULw/hq2Rc3Ju
	LmzECPHWbbxpgV/4Kh7HAkvE5NKVmo4fKk7rA6ztTn2uRk+Vb4H+tevBdttkSAxZ
	xfaG5li1Nftuos7WwOFYBoSFzued8jPpOMBNvK49Od8+eVQo7c0uOUaaDEVIcTHM
	bOPD6kFyidV0MlLMkJryA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793064676; x=1793151076; bh=b
	XqTFXOjfMd+f0x1OwnRtS2R4bcIfDr3jXNH1MZO59E=; b=T/OVZRTHS4RMPDLxX
	psTMr0l3fEewmVqKSteNI9/2UkB9AsH8GBg0Hb5gLNN9KqRNuPuB2uXvYQx5FxEW
	7JL9UYzEv41Q4WbnAZvEwanIERFpQsykrhEkvEmzQToVP5724O/AkUKxVKlKiFlS
	c7CyeiXM1vL8KmHnG0j+Xijz6xhzjeOeQE7RZpP9jZQPuKgrFNWHQQ10Zx+ymvXN
	UQ1y8QF86eM/5BYWJcFqxC/5dOgTNej4vbzkf5dkFOVeek0ZBFrQwxu+ATS46B2w
	aJRQGcPQkryGwz/9ju3lGuQzQcXkhCP2UlWcx1D+H7M0m2ViAYhjpYzJA/2AFysF
	4oqnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=capsize.online a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793064676; d=capsize.online;
	mf=PGNvbnRhY3RAY2Fwc2l6ZS5vbmxpbmU+;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RdxdLgKeaUBVZtjO575b0vl+F4Br1JxhCO94ptsFrj4t0X6
	JPWqWRSfRobSzG2lSXquDRA6+vHcwJmf3UtUH7uwxZazDOwZgWYrFnMJ9vjRBTjr
	P8iRMqQdFUZotrpT+LphbKQERz3jneAQajKA0g0U7AwL/l9Tgw0aU+C1kW4jxpAu
	nZARPdn5F8iVBwzN5QDMgqT2e9eGoCPAdj37ZJknMM74OQAdXmYX6XnEomERIeoF
	KbPv/4hp8hAjnrRKJQtMhVERBtdXiEWrlaO60LmaioJSUWDfUZ2G3NDnHWfChKc1
	j8H7BgT2i9pEyiEStXbGrwFsBSSuiHYo6VeBYfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HBwopU6HGLG7h57+kAtw2q8qJ2Q7n0n+JEPdvdL4o8E=:S8ZiCaHCW/2lHBlTX8EoqAJ1kMU43pmkpauaMowYNVQ=;
X-ME-Sender: <xms:5P7fakNgEVlAoE2RLs8sYDgVSNi3kc4XtuDBxh5yTg7PmrkKIqJxSQ>
    <xme:5P7fag_OOTmqGEh2z9tatUIaelf4-4kztPPp2amba15mjidOpa86dl-i4ynY1VIlp
    VYV-d1_OUSTwqRM98K8R0e1ClYD0q9a-L-YdTZKf0D3qyfoQBxAIQ>
X-ME-Received: <xmr:5P7fao4s23jtcHIfadk6YvEwsxg5XAyKJietaNee9GAO3fFCdQHkNk_6J8oTnn62QF38E4rV5oA_GFm0r1d4wzslk4w-a7u0>
X-ME-Proxy-Cause: dmFkZTEEwruZ+APjwxEliKAVU9yIAvuioluaEl15g8iNAsUL3Pt6eji2POnx7v3GX2lVWW
    Nq0bMJE9ju6VFu/am0/JqqAcEbwwZXpA/QffcXNgdifTLvHRMfpuMk6W00Sis4FNKF+IWy
    AfWyji2uDKlOtElV36aIrZscQ+TSDxaeEDF3JkweLk4a+DFJ4ShyVgyVErCZd2Ee73vJZ9
    Adc5iunhEeEkgW4yhF06MLnRDsVMY0sAfiNiMVSLBc/HD4+hdnLhNLZ2Mjy7C3y/gh3CKa
    fiQtIVH1Fxeec+rosBCoT9m5unsAJX0ktKUBC8s2wB91Wk3ASGC29flBYAPV+vhLrizmpU
    TN7WgOE/xtFtbIG7VIc+KWbQQQvLWlD/ohjdM8aMV0dtPDG1et1dlZnfysrm9j5t6adDw2
    hnHVGx4I977KdWFrBg2fMiSVYSjKSxr277cPSeeYVpWE5y+KgUinFWtRqfaQckSn3xXelI
    WM6jNEA53GARZQs7/Q3sdnK9DTYhmQ0IHoPx51FjMGLH+50xae2j1OijNSRW75dDggxyvc
    Bcw4yHV6j3me8cuaM6tlqrS/Ui/aQnRld4iSVa7DsQCwTzwdofzx1qesBv0Oqra79LSPKF
    eo0iXxArBGOTf1HLYJkCZWomuPHK01pZvf9UU9WXZhw9BKO3JRMah6d5pMvQ
X-ME-Proxy: <xmx:5P7fan3VG77NzwCBo7E9TvmVCSqw5dGircZpKBzvlwcPVSjPmnSruQ>
    <xmx:5P7favCxqhKson98JKlrq1l81MhEXBmejoI502bT2r4ZsR_DTfDn6g>
    <xmx:5P7fap1OYxVlKTe3EapE4_r3EEIFi99owM774pDwAeK1QQEmaZJ8Pg>
    <xmx:5P7faps5Os5b475jwYNZrU4HoxS-MDdvUdEhJGm8p76MRtBZK5Ajdg>
    <xmx:5P7favnLot9MeL5i3sC1B6SAhTu1ijdy7uyidy-7jhoeJ9ooMpRNoiSg>
Feedback-ID: ic30e4aa0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 21:31:15 -0400 (EDT)
From: contact@capsize.online
To: linux-bluetooth@vger.kernel.org
Cc: Capsize Security <contact@capsize.online>
Subject: [PATCH 1/1] monitor: validate Return Link Keys length before parsing
Date: Mon, 26 Oct 2026 19:31:13 -0600
Message-ID: <20261027013113.555921-2-contact@capsize.online>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027013113.555921-1-contact@capsize.online>
References: <20261027013113.555921-1-contact@capsize.online>
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

From: Capsize Security <contact@capsize.online>

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

