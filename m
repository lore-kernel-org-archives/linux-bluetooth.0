Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4223F888F
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073729; cv=none; b=tMDEh2h/U1Oi4FM2ErQXY1z+bpZt1RwdZ5C2BikoB0YEK5O7xhfWARaMhcttkWMSstedYtAhthPjQ4ch6bPpuXlX+EkXvY7irKu6CB2Wem51t32lZgouqqYoRrTK4CMxPS4s5kiKm7s7VmMYTyvlndU7/u9B4GqrzMB+HbukOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073729; c=relaxed/simple;
	bh=Hg0oPfSEMzlAH30nLif4oI/VCj7HVM3yhSgg2RE4a7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMF9Od8Q+rmDppvyI1UjF2TgZDSOrxLPEKmzpuHvl4OHlSNnZj8RkvMhkTHFKfxJtr9t9R9AefMIuAw93+WTt+XNya3gXPUmOuELcVo5wPB28stFTH6/cWkCslBbpJxXai1qiNIOks5rHqsgzPe0QHbEdcOJ8bsrKyB4rTPkr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=fJ8yvF1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=debAP9LC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="fJ8yvF1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="debAP9LC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C14D47A0060;
	Fri, 29 May 2026 12:55:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 29 May 2026 12:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1780073726; x=1780160126; bh=k+QL+bfMFbASM1xxALf45
	yymynLD2HvXMvpnMmAlqYk=; b=fJ8yvF1VsPROsUMOKSz5saDDOok0oejdQ6cSj
	DN9ruA8PeMLBX3v24xH68G4a48g30bUhDBTYRVltdmWQEURHmdPYS6mQL0qXyc3+
	8k2raOj8SbXceSGzWKTq3AhjaibyTTFTGoa7RN+vnJPlGVHOm4dtq6M6T9NGT5cn
	PrEj048PBprAFS1Js1mm0bGmJpM/SeQBezssapNGnMjvo1tHKEE73t11DskThmkS
	WAQLQtjzGCCy+RHC4IvSsNbmouaO7Iiwjbny4XeHDg6Jfg6zh8TueQA1/zObjUYV
	YX9FkpV1eXN3CODrIWJCm/zrNgNl3M+5Ryo2IIZS8D0ARbf3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780073726; x=1780160126; bh=k+QL+bfMFbASM1xxALf45yymynLD2HvXMvp
	nMmAlqYk=; b=debAP9LC0vB4lkOm5+cFa9Yk8KCN1gbrd0PQTArY1IUBzQ09ei2
	+EH4bFUuZksgPe/dffkTI1gm81WQ0XosxaaI2mT8x4je6ryK7zt7Ie/d0KGgRTyh
	UHBiobwBcYGGRqwPiA7i16TmW9N/evSIJa/lUUXgTeCiwSNfy1Z75vb2F/TcWv6Q
	y6CUysWljaGlupuiMwfirXoKIuV22DhByAN1pb5EANCad5f5sMhJpise0yxju7wI
	UTTcyb04eEQsLlhPOhOV+seiUX3ivxu3s7bkORc5cSSxDipIfmmjQSPlBFc2KVPr
	DaixwZvnmNV4MZRCeVG8FEkqxJXFMx2goPg==
X-ME-Sender: <xms:_sQZajgwMG5Ek5YKJmVfffGCQZ5FO5TnVdxds0rSSGwv-6WM5bbmWg>
    <xme:_sQZanCYpZzwAITRcwXqIgAhrn975i5FU6siL7r_CB65Otu79CcnEsaeJxGG5l8TN
    nNu_hXiTOz4Ei2-x3Lay9SM71A3aa4PU4MNy00LqEJQ4XaZeSqTNA8>
X-ME-Received: <xmr:_sQZaoGVoI5kXGAZHn-X7xaV-aFzM4cdKi6h26wg0eMRTnTKtBP746CzwdbTt4ZRHluiu6A>
X-ME-Proxy-Cause: dmFkZTFvc/kv8GDp/OqEIkqH9CGMZ4j0g2bGd1vSu9fytdQmYHecCUMxFOelEFwOwftt/p
    zeFmmwBX2wCje/A0TpMyQhC/pejy8Cn2VTarTMJ1oNcQtZNMjyvHxZ67SikT4DPxzjOXKB
    YFGxQ2ANtCahs1u2YOSZ/lcTk05YHtNQAy+g2IlKZioprM8PG5Ph+kCYAbZj4fYIY3dvoM
    bmn8MXrpG0my5aIR5qqlIWx3HDSFFN6setinrd5oFpREzBv2ygp1RxpmCZsgcuU0UOpbxh
    tJ4tN1O8+kvwKbwe26IoEfuQBKNR+mfsnWIHyMNfTjla6mddPFkeZ9HF77Mln2qkLTYTch
    e4eIm0F0YWEYff6DiPIGq9O475i30SGBhN2+YsFYVEr4WRdA5prgcRlOZWfUpNsnWgjy/4
    TouFg968wZyIUvLdUBDKsy3TolSMO/IO+5+Tq6rbgxJ4x7A/PDB6kYhcgtk/i7C79MtTl4
    2qj9wgby0/3xuCcoZKtcRhK6MmMerrr8YPdL5WF/KutWQwova40l55HsJ1yfexR57DR1iq
    PBFirslzjdBIg3FhJZBmvamBXs0M2u3ng0XaxibhczddQ/IfV18lEf/hZL6K9ppyd6qF8H
    G3gkbtkixwAnFCz5qcTyPFZU7IWRtw9mV2l2KIoW9iu1xhBTthMXVXqDMTqA
X-ME-Proxy: <xmx:_sQZavKbvYqPtJ9ZgD91L9PEwGnd-OALWrgSWHBaqr6FC4RwM4iwGg>
    <xmx:_sQZaskHMLnbarICx6_Bs-Q6GLIZ4gTprEFuRJbhUcsdZr6rDEBSgQ>
    <xmx:_sQZanQ0VMpTmVj7249PgYZ5CMV99bgNbEpN3A2tKWPrPamKTmvX_g>
    <xmx:_sQZauKg1Uel_qYyQz7Y6ebVpyYAVxII0eJXjCvWO4suCNCT6_odpA>
    <xmx:_sQZavXitJWE5GxRRdgCmO8QIUQGafHQe6ut25WwP71OC2iwr-T9UI4G>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 12:55:26 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v6 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Fri, 29 May 2026 12:54:25 -0400
Message-ID: <20260529165449.3553936-1-oss@fourdim.xyz>
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

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  8 +++--
 net/bluetooth/6lowpan.c       | 27 ++++++++--------
 net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-------
 net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
 net/bluetooth/smp.c           | 13 +++-----
 5 files changed, 98 insertions(+), 56 deletions(-)

-- 
2.54.0

