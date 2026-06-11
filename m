Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22A318EE7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190518; cv=none; b=PuSUnepV9NIkUQ2Ybg5in/GrjgJCE2OHIWcXK65HZW5mtDM37DXCc+lnp7rAu/wMpW3rOY3tID4cAXbNdt1FWCIXPw7U0E2cluOGlf2KrUnyRyD64/5xPsaZ6h4fch7UpOWR4dqMiG61Gf0wywfsqYYw+1nxu1Bks4YgwLeehyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190518; c=relaxed/simple;
	bh=6ZV2uQEqrloR+KAM9TQgeaAPtoSHPJwgINBlYdfTC84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFyHfHZWI8JP5Tmvs6jXsSTjXIAfx3M+6I5udWl53LVc+UcRsNLtrh1hw6IOnFeFVI1Szel1X2qMPRk45qVZdZTb6xygbs21ubke2twBTRDKwYUkolXNRl+OIIMaVQdbJ8xaBw70kzKVGuI+RqRqebPLux9uRRlYaB2bLTA09hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=HUDevCpG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUgK29Mc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="HUDevCpG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUgK29Mc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F4E0140011F;
	Thu, 11 Jun 2026 11:08:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 11:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781190516; x=1781276916; bh=m3+vMYfq5qEiGVfRQThi+
	jfWcE868+o1IJpFaB7SXHo=; b=HUDevCpGxFw6O1HU+LbToPBwM/T7vwj9T+YGi
	Um0hqQ2sdvy1V+346+8BvDo5nhcI3DMT6IMz6r1idnZKB4lc2+mlY5q4htK5pV5G
	PCkOZehuvDfQLPnzVwNx961iO30crSi7TBJh7GON6M/3NWtz/jZCt4AbxBAD0udu
	yLVxOoFgEUpNS22wff/H5WQu23cCZV1RGv6l7JeiRtzJOaZ8TQ/fe4hV0vOp4ROM
	T2VoQE3pCmHEKCpqXIUGDEb8cs9luI8pd1zN1oPKhlACcEzKhHM6f5n0qaog9BXl
	aSGhhGz120m/vm7K4qmClMFELxQBSRdJKsm5g+43zCsZv3RjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781190516; x=1781276916; bh=m3+vMYfq5qEiGVfRQThi+jfWcE868+o1IJp
	FaB7SXHo=; b=hUgK29Mcy5GjX0FQOlHu9YFaVSowACimM+DyAJ+qIDDtlxD0yto
	ATj4/seLciWoTcP+uEz8oxUgMa1omjRrQyRJ1F9LGU+tPczlCQfCLFnFbOUCvgsa
	Cw6eJ89ZDPvlmL4NEnfLLEABF172IGhNVn/ZUui6DVR1w/SUcTDSYmkaySV9m7rj
	KQQOmYIMvYVsQf6jh6drPU8Jyo+duSSed33Hur5HOvDx16IubzU6m7w/vSym/q8u
	DNKFES3b9PgsLV8YUAonGWJ+7MtHj8Xz4hNURms5O82g4109nJkImoMqqtKK5ORT
	rO/9H1VserRZHCbe+WHXsB0gTU+AYz3zM9Q==
X-ME-Sender: <xms:dM8qalUpE85m690e2l390OfKNOtLRDNJzB-OFL_2aBE3boMZI7SHpQ>
    <xme:dM8qatDueHe5-m7jK5Nwrzzn4x9HnU4AnsWshyGDnYfVYZSyuyNKuCgNHJqugc2d0
    No-FO9xpzGcvLTkijng7Kw3nGXIQA0GTMsv3Narg9mnJ3_L9FTKBcg>
X-ME-Received: <xmr:dM8qauyWSkFwnY_zCbf0qYECvUYhokh8Z7D5bVdWMn6f0BJApjFvul2gmaHHlftzhaFyluo>
X-ME-Proxy-Cause: dmFkZTGXzjW+IqXxlbEep9sqk67X92uyrce235jwUxxVZRSBFpvhtO38Z13dGrQu1p0H8A
    evB4AUczQ9lhVCLTz1RvD0PvPgf/I5BZlrcDRy51yhQPVc08qfEwPza4Fo0nH21BjWMWFl
    AJ1khq34ILia7yWrifxRhP1M0299KU9M1TTzr+yLHB2N3nrBHNHYawZekHL0PW3+v2MbbD
    8ikMXIpOjWIxRmEkZGi/rvB4rigRXdxN72kGnIJyBZoxrIOTTKuYWBAboVLht8hisnPYVC
    Yn0vWQ+G/2cpXdz3sg0AqD/U5eTSHuJI2Pf1KMNFeGIBVzi7HeB8hgwEqsSxlvXGZxibDh
    fYlPJop5J2ShBTtyJqpeFx1IvWjYHVi2VNzLIiPqKUfjDNoTfn/AOyV0PJjMkW/aqPcwDx
    vNpl2XN8mrT9q7+RItThP42LKDJIg//rcgomtHW/4jXvCanADUiNGXBdc6f58ASYvYGF64
    zS1qJFxvil3oBQDTSCCG5uvcYk8Kk2bnJjBYu2MWWVB9VsvEAuzhxo94a19Cf8FusfcoqX
    2fV6I6EHKj0E8nF34HC046gl+VqJx2s/alTm3FGSYhPNhr7LbZvxWOyi181xnATC7uy+fq
    AA08+K/7U9LqiuaXloB71ryJoa1yUwX+yUXqSVoep7FJqSModyz1+s0TdqTg
X-ME-Proxy: <xmx:dM8qaiDOtIL1q1NUn-kMnzk_orasCvG1_KMOngwossOLHaBo6FFzFA>
    <xmx:dM8qajb_DUguLo_2lPQVQoonkJ1yLJAkTDgH1USkEqL1LsS7cpfXJA>
    <xmx:dM8qaiivmWWGQtO-9KZcM9jVp4zmPvwUhbxX9tUiIauzFKUY_8kKlQ>
    <xmx:dM8qat6NgOwoIZUJr-T-v6w9FNLIeocv8FisIJi49PuwPFjnRwEBPw>
    <xmx:dM8qahA9xy-FQ3lsp_SHRjvYT_-BOrK4PArZRoqkpPjUs4LWSSnrjCle>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 11:08:36 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v10 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Thu, 11 Jun 2026 11:08:04 -0400
Message-ID: <20260611150822.2166160-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to v2, addresses comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .

Compared to v3, rebase against bluetooth-next.

Compared to v4, allocate the channel outside the function and pass it in as an argument to avoid the use-after-free.

Compared to v5, extract the channel init to a separate function.

Compared to v6, balance puts and holds on chans.

Compared to v7, rebase against bluetooth-next and refactor the chan refcounting.

Compared to v8, adopt the philosophy of one assignment one reference. Make refcounting easier to follow.

Compared to v9, rework on l2cap_chan_set_defaults so that new chan's default comes from pchan and
can be used by __l2cap_chan_add.

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  10 ++--
 net/bluetooth/6lowpan.c       |  18 +-----
 net/bluetooth/l2cap_core.c    |  78 ++++++++++++++++++++-----
 net/bluetooth/l2cap_sock.c    | 103 ++++++++++++++++------------------
 net/bluetooth/smp.c           |  27 ++-------
 5 files changed, 127 insertions(+), 109 deletions(-)

-- 
2.54.0

