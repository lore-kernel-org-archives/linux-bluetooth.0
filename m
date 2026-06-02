Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FE3DB62A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405011; cv=none; b=c95hSZHLMCVIU1YBQUuzY+qu27l8sO6HoCT+hJkjpVPxDY/UDiCVXuxJsGqIetwkp1bjDLImEj0vrgvz2Op65aeQa9OdUi/v5o3XI9jjtvwu1Fk+6cQdbYFnhgJVBJcs9m8u4qS+KRGoig8qVUo7K0NMQmGQf0Vi4AL7KcshhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405011; c=relaxed/simple;
	bh=leOJhniyuKqVIM/7EMNAqVGfgdCEbwzV1q8KcwJ9svM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFK6JJ73iePknpJWRtjz7I5p/d2zzveJpY5WZEpTuJIgK7nowkNJ0Ipj2cUHMz45tCiuNaXkdVYJkU+1SdNJsaxrJd3PaMl+TKCFNh+iexkdbnJcDao7A6uYG36wV7GeCdH1vByqGGmt9O2S3EqnLuHPq6dc2h6HddGrV4pjWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=M3ZwRMzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BD/YgOS6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="M3ZwRMzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BD/YgOS6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B8A001D00112;
	Tue,  2 Jun 2026 08:56:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 08:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1780405008; x=1780491408; bh=PJ+py5EH+i0JpMWcphgQS
	CifEnWiVPW8m0Ez5YJx3jI=; b=M3ZwRMzqxkfruGDjflQFM4mI26AR2ZsqYWhj5
	fTcZHrAKA70wfEoSUf+Q1gNozUSc+FigpKwT7Mt96jeD5+Cw0rKsGqyoX7Y4hgao
	WbWlgoMUz4VRvRcqVYMCGH4cR6Uy6P6+c/WKOtfccFUJ10OaF2goijLapp5b6ybn
	2+hGPLk7ylg/fr8+nNAhzjD1IDOpBIBIUF9AE7cLtcSy6IkyURq+xhp6Me+nDMwe
	Nf/aSSwq+MzFzEWJ7c+A0vbUQc4czJdRbdF8BOHELuOvpQp0HTnfsDj27MbDfCst
	ZtS/pTmLukjjb7yLY/xaIJ4NGq8yoYKLuBA6po1tKW9lMMeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780405008; x=1780491408; bh=PJ+py5EH+i0JpMWcphgQSCifEnWiVPW8m0E
	z5YJx3jI=; b=BD/YgOS65AL0EnL9cxkhyknGfsCknxNl8YdIpLgVlReclTaUBYz
	B9NRGlr+Xf/2RjditvdD60yM0le/hzOWfLtsu1IxuII0mw6cOtQiQ0f3S6WaeEKN
	gMhb54q6tma/SFo4bEJnJ0h5mnVqtd0cMCmq3srt2fVKZGw/8bhoOjHeqp9/LBau
	Rc5lQ0of2NzC9XE2eOz/0K4MS4/CEvyRE8gXIR7Tdfe7vP+TbPcaBFDZq8TVpL4R
	BSB9QTUNVtdfqPxWiaADPZDJWZRyiw/lWNU2ubIR4PBMOW9l98seyNAQjs4OEJ/x
	uDaew2wG+IFfCWPx4EZrkWFZOYY+noe+lsA==
X-ME-Sender: <xms:ENMeavrQ3Q84hoA3-y2NoozbQwcyNX3kTDSSPh_jVKvNL63sZV9IaA>
    <xme:ENMeagpX2eCYfxCaeRYo7pbpRqHaUS7HGrcAZlZkp-4A6qrlAYGi1QFnmmPQdxIsU
    0_g6y3ytIEe7rxQDaM_iIVGelFcl3ntiqbsz54_RVqBYabg3OROaCM>
X-ME-Received: <xmr:ENMeahMZ31caaHsn2CLlpyqX5vbo5hIFFDzCGpcY-0im8iNW6_80YwBeWIysU4YXefjg418>
X-ME-Proxy-Cause: dmFkZTEcd9LQIfpU8iixrUL0LJH9ZFQoyIa6K8oW64HCX8/VoHJYmSHp88f+3xjGDb0p/n
    CWpefXOJY8HgzEG//0ty2yJBlAXu6rQwttBlLHGiSymV1pLCSAUJi0JjYlVo5OQBXSAlI/
    GbWbo1zWDnZ5+QDWfVVyIzITq1NELsQ0z/2dJKMLYk+A5mIIqC3ALXgsuKUuL3mtJuYFoL
    VSShQgdonlBSPtsIXuLkcXuYEcpLpde0LpmFYRG73kd2lHxYe5ehOtZu7zwfr/7GC5RMVq
    u+zEc87iChzbI1slbFwX3kGH+/rabwsNfT10Q+CXSmid21u4QFdQJG+pTT7XSI3UXum9O1
    3iuulwWLSyJqV5jv/VGqcgTDIWgY5Yn/UR9+/+r5VLGkyQmEQolONZjsr/KmDNvD0RE3T8
    PFzzhrmi92xk9SHAoZz9/EN+agJm/3xaJKmdzFavN6ZKRKClWamsNpm9yWjZPDBYvARi8N
    2d8X/6N83/jDRxbXUN6PGQiMEkIGpkX6q2lE788bN7Orcq2bPKyYZ9dQS+4dH9JL4V4WsB
    5E/3A6hjp1qJSbYuL1wwZvAX6i+vRONosKMM/6usvngmHyTyvbJ6HJgWNoG3KI1GOVzjdm
    HlbW8cD+Rd6xEFzB61x7T7o5xPZ2WRu71uWX2hIRapmhtpapehWg+5gAYvng
X-ME-Proxy: <xmx:ENMeahzNKEtHh9AgaYFqaQOb9PGZ6IMwl5y9EwCi0LP0d9Jb5hkNow>
    <xmx:ENMeaquyt7MDWg6Fp7HUiUzJ4R1XIBFzGAYJL3AlENCQ4WeOzZMR_g>
    <xmx:ENMeaq4C993z6gdZfft1jIUvNaiWmZ1tPeQXaVBIsNZUuOTZz0yVUA>
    <xmx:ENMeapSL51Kaz8CHWtncht8eBMkQVjDOd64C9YeTGHfqZtYY7eQdTg>
    <xmx:ENMeancwgQzrHuGKAw2C2cpDKYAChU1wcrJ_LlwRcm_o6orb8mSytgsI>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 08:56:48 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v8 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Tue,  2 Jun 2026 08:55:42 -0400
Message-ID: <20260602125618.2520506-1-oss@fourdim.xyz>
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

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  8 ++--
 net/bluetooth/6lowpan.c       | 32 +++++++++------
 net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++-------
 net/bluetooth/l2cap_sock.c    | 76 ++++++++++++++++++++++-------------
 net/bluetooth/smp.c           | 18 ++++-----
 5 files changed, 126 insertions(+), 68 deletions(-)

-- 
2.54.0

