Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064676;
	b=rnqyp13bD38LMiQvUxgsztWs7Q4S5ekBvJsyuoX4cIwgsvmDqY/uP0hS4dkq4Ds0NhV6
	 V3rshnGJh9D6sVrrH706dSiWgPwkAAwibHsrxHcdEW6yV6He7UaWTnBBqp/lR94l4D3xk
	 cYw06Tv94mMVVa4N6+j2ITD141YlLjFNee38LGbfupeV5jlYmuUoBF6eN6Xe6YO5bLScU
	 wdSnbErTsxqqu0adpVchUKo126ICF1BPgRb/dPOlmkShVD1f3LyfAYobFn1RTUdI1G5dY
	 4dNFgLvA81G/i6iu5DcFXRZzPm8T9nPO6bKaGhpKodXI8wN7hZI3kAUgZVVrR4oqSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064676;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=13ao+cobwjQAFFF3f31IIAdHqgjweUIiPtA03+gFxkA=;
	b=YFaLM79xKlMXQXCbHgldYDeowOpty9xs47/MAhE5au0bj5pXiR6n6y1n40mmGeibgono
	 1fxAe6/BwZAcW3z7xwxBk2ttglc8Vh7+gkkQLYZ6+pAfMPNhl5hArkTSN0+ZY7xWoS5WQ
	 NtLCcjv5mCaVDTX210qcyYzT8d6sEUAQ6+VXJFx8epfDMD+KqAAKyRsIS/XL6Ws0Q7lym
	 RmKlmiusCmd3Luf5ZJ5Q7PneKSbnBZGfzt5nDoQFVquW+doDRWY3W//CCsqQHeNlaaxjr
	 VveCoTbWATyA4+FGkH8gRz64oTdp8xzSXYc+gkvWo2ctNaPgSBlJx0lopqebOws+umQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=capsize.online;
	spf=pass smtp.mailfrom=capsize.online;
	dkim=pass header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=q6yLh1PF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NhsfnmKQ;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828F606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 01:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D828F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=capsize.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capsize.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=capsize.online header.i=@capsize.online header.a=rsa-sha256 header.s=fm2 header.b=q6yLh1PF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NhsfnmKQ
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F1D591D001C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:31:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 26 Oct 2026 21:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=capsize.online;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793064674; x=1793151074; bh=13ao+cobwj
	QAFFF3f31IIAdHqgjweUIiPtA03+gFxkA=; b=q6yLh1PFdFnTMJ5anA2IsyuObL
	nTdTWGtbaCVUXjssouQbSQRS5TwuXeLN6MuqTjMcYVFb76NN8Iw45NnmGERwMvq4
	eJG+gIDjt8SpUI1RUk02XO0IIx7YfKoTzpOcPSN5mZY2lnxWubEXUGnmRcIw1wME
	nNFosDlyAyEppC98CgSjjixM1GdZpDBvlljk+5Fssp4czjUcqjKQEEt9fSAIGP6D
	OVVT2qVAUrcEKVeImJu35y/EkWUZ7+6BkuBoZjCSPPwrz95bfi3urfv5rRw3gWxd
	OEQMgz7n9yWXlww1ORrK1AohcHsUeBSL9A+rvP0o0eN/vh2vO/3j+lU0dOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793064674; x=1793151074; bh=13ao+cobwjQAFFF3f31IIAdHqgjweUIiPtA
	03+gFxkA=; b=NhsfnmKQIzNiSeZanrom7JRJbWDw6gMzqWFWmnGT2SpVHm7IStN
	AOMW11qq9FeMSMe1tpRmqb2YoHL/P0QOIUAXvjcgfEZXIeUpWFFM6THvkM43xLgp
	ZRAwsD4rl4aHkhcCoDSi0hHlTD7eDa4hSdkRa+Rm9F13tyeStFD2zrvoBmiT/nlN
	OgxGbz+8ik+XY/V4ZvmeHj2aNZ/inQd+1NYZBlyNSF50hPIL+oQtHdFEG3nXd1Jt
	hUlLT0iLdUCEeAF3sYcEWYm1g19EAqPawp2esfDGWtX10Sfm8VhokC9luRoUhdHx
	rSm8PT2zp8YGKgJGozSkNg7c7L7HnrQj8tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=capsize.online a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793064674; d=capsize.online;
	mf=PGNvbnRhY3RAY2Fwc2l6ZS5vbmxpbmU+;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:B+hJPt6m9Ua+dKeXk2ajcM8xwpe/nm5e3A/XukpDzU+N14A
	EMj8QxPKSQ/B/0lkZWpOiTe2ukxJ4kgNBjTCTmV71NjUaSpSeDsp7WEMLDnKQ3+w
	8D6AP2tY5vW/Aq+4NKAQXaeg7UiWqzDSGdjFSrE69Eav+b8pM4pxKFkOllv/OLRd
	F+NQqmNXRSyOPiQNSggaPrkJqo4tyekmLxzTskZf8GqZo3F462eVZx14HMFs0dwg
	pnb1GzMz5/PYzcXwBIKNoZtWkfTyop02i15S6OU1JCjAfJj1iKpj4D09JcTEhrUO
	4hnuz/BV87lyLhJRqpidXUNlEaV3G+CRN+GgBOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:c8OXlc7keBqAc01NudYOhTeBmXXRfum3M/PC3DeNiy0=:13ao+cobwjQAFFF3f31IIAdHqgjweUIiPtA03+gFxkA=;
X-ME-Sender: <xms:4v7fauS7QuimkmwxP5Kwq8-8GuQbnsByx12bm_tcOffUCaifDUJq0A>
    <xme:4v7fapx3_J-yTuX7Ac-wXd2T-s-X1f2hKxCa9l82K-naLGaW8HzANIHyw4SiOMJcJ
    4tvYBlFBFjmt8hPe3vXLIF-4Qn3xH8WFYK7sBV3P2y9dsYDb5Bf6rA>
X-ME-Received: <xmr:4v7fapcLDrL2BQRZKq1T1dc4-Y4GSZ1pkfAMLcjN6Ib7FodexPKmfkYsNJBsHeLOhn2ToSOYXEcFY2LSgwTKNmFH08wj_iFX>
X-ME-Proxy-Cause: dmFkZTEI/LavnTI0D1y0oCuBv3ffaSyIChaU7+ohi0YO3BhhgPN4HrY/y0W1WEGhQoEbsa
    RWECFxIuvLCK/qdIPmpLs+yt19dMLWNLxMxR0/ugYbX0FAnzeTWHc2MY7ainaEmT9Enbe9
    ZNf63x1neMCUK49R9CrQn/251bgqSNcI+Sz6AkANCpgWUWr9XJD+ZMiA+gY7KQlRxLat6E
    eZz0bxq9Pc0sbZuzj2qyJ+LnJ3kN3Nj6llKXK0BrY6lMRNx/ZOsSOrefk52Jp0jkBLprja
    nU8JDAKg5DXaJX005yySyw0X6yJKnTMH2rA49nd45RNBGiCMu8ktW+OuL4RCL+CUaTt+Yf
    uC168t/j9H2/Ym+ve+RR8AOdGVwgsWo36iiteTgpfQjlQez+V7OxxFF0crcgB2lzB0uOtf
    hPx6hLyfpDuz3pA0KqwIfIsiqjtdaOgDEG7ghLOxzWZWEKwResOlhhtv+XrVLX4RlJC9Gd
    FGzfsha0UIjrmS7NFSFA/7BlOK4zVoFwCZYYHkbWhvqgISU1xyeoO13cGhllodBSsxTnfK
    ju9knjFqQVDSj2UcNfdS4dlL5rHGzG7uOItVrSeoxI/ujjZ3OINcpMdRwHgw93xy7CLJVd
    llawan4BSNQsrypJUJ6uejz8TNI6RmjEMBahRdGxDMS90B6p9uvn1fRPkwFg
X-ME-Proxy: <xmx:4v7falLicjcA4xnXP7URRr_ZoiURTbjBYGGbxgTp1fVAmlWcllxQCA>
    <xmx:4v7faqGGnnwZJmklF6lhVG7XX1wK70hwC-3AvRSXc5mPyPay-pofiA>
    <xmx:4v7favrjd9Q0s46ih33eaVI_UYXf-DcUPe9iaOeajv3dRuOeGR8Stg>
    <xmx:4v7fajRg6_8YLbgvzgQ_ozzO2pmVWumbC87xCj3loc0OEq1i90oyUA>
    <xmx:4v7fahqMt8B1xNTQzmq-_FRH33BzEkfs-RIu1Ppdgarw1_Yyq2_vrttA>
Feedback-ID: ic30e4aa0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 21:31:14 -0400 (EDT)
From: contact@capsize.online
To: linux-bluetooth@vger.kernel.org
Cc: Capsize Security <contact@capsize.online>
Subject: [PATCH] monitor: validate Return Link Keys length before parsing (CVE-2026-105460)
Date: Mon, 26 Oct 2026 19:31:12 -0600
Message-ID: <20261027013113.555921-1-contact@capsize.online>
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

From: Capsize Security <contact@capsize.online>

Fixes public issue bluez/bluez#2687 (also filed as GitHub PR #2715 for
reference). return_link_keys_evt() loops over evt->num_keys entries of
22 bytes while the dispatcher only enforces plen >= 1; a crafted
btsnoop capture overflows the on-stack packet buffer (ASan-confirmed).
The patch rejects short payloads with the file's too-short-packet idiom.

Verified: pristine btmon + crafted capture -> ASan stack-buffer-overflow;
patched btmon -> clean reject, exit 0; boundary matrix + unit checks pass.

Assisted-by: Muse-Code:muse-spark
---
