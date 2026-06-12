Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652E312819
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274919; cv=none; b=JwQLJT+N1vv7n5+1bmBZ2H0b83VUUauCXcrK/mnEADtgO9YgbcaXDWm7vZt3hOwr7CnOTiP7mSq2MeUIT1zzlkK8ULL+8vs4hiOtVyRq6eGwoq6g6ZjfZMD+V1sTn0bUDtIXckuu+E2WWjY3diE+V5JDxRU8L9w02bwyfhl8ZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274919; c=relaxed/simple;
	bh=IDByotaC80HObteyFucUck8JEoCTO3ZeuaF901zLIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRgNERC+uaUl/67qxJn8aZV+XObz9ZGfaRSr6DjdGaRvV1RK8qsAeDf2EllrwM6/JuDDIDTzL82Q6a1BW22KFPSB1LhFUBm6sX3jVetQoze4TuqMFupeTxGtXv2o1wSlW9PikNHbgEd30L1PyDx4+cpcjKJrYhwirCIRIcm9Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=CdABEfVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvIZEFL4; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="CdABEfVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvIZEFL4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BA3451D00197;
	Fri, 12 Jun 2026 10:35:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1781274916; x=1781361316; bh=ryFjvBhAX9M3U4WL2fcfp
	Y8v8xHYRqgw3JVkGF2wxkM=; b=CdABEfVGXAlJMtoKYWy8wnVhWledtwD1+8CnI
	d3P2dp6qs1vDBsstarK8eddPylhf71KwZi+zNkpIdvb6DuIWpqitvC9OKk3bzfTz
	6TT4qjitsVTycz1hh/w7x1zumK4V0i9dOiMAszImdL/ZO283/SZwef5uihm3Ysoo
	MDKtG+C1uTCk/bsPhF6QI3BQ3EEboH6Md1wMaTwiFdtaDQXf1ABpUCGbun8rnfYJ
	ly7HErwO2aDGPf3TSUvBBsJ8uvxOmmHRFfheR/D8g/FkVNuD49iTMmWfm1lu569U
	Zz1nrDmUYnsUFDZk/JuIG0KwvcTWIUCu7SzeiEjVw7cbqh8Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781274916; x=1781361316; bh=ryFjvBhAX9M3U4WL2fcfpY8v8xHYRqgw3JV
	kGF2wxkM=; b=HvIZEFL4CxrILYCSXp+uCZqif9qcQiZ2ma+12arbHC54l8y1/QV
	bgz5+/rQvrXpzzCuQNk2OhnN05EngIIMVDv2pyjnVCwOoYXAU7nlWCmTDOwFH4lJ
	w7WeBTYPFZe7MDnBOwI6dLRZo6eGRZElvnRwpPZ2F4cD3s/xz+7v2iAsdKdwQYeF
	6UMDwnSIWd0Xsy0yJwOOnM8ualzcwnaEPFKGvKdlB2xrn2haiFviAJJK6qqrtTtn
	vrjRvLx6EIW+M8bqJbzyaEnKcb1XNVBoQLHB2sF26pjDT/z2H+qPGokolzcVN7XB
	eHzSLF0F7QcEJuWz8WwWuhuaXkorHr0e+4A==
X-ME-Sender: <xms:JBksatQFDO0fvv3D-u9aLY_uYfSitEgQIkrbYJ_3x3PhN5-hzpUdjQ>
    <xme:JBksauPqnKROU1OfTwAOdznxH7LG_l-fiKOqc5idis2l0VT0wdsB1n7lvH9d_lEi-
    oN3dgCQ3aqxhAMak2rUGYHaC6EDjdOIT-WyCH1kBmAPVFzCcVVnH2o>
X-ME-Received: <xmr:JBksagP9manioqLf60-hZBf5mdsaDcE5lxWH9SptKByGl51AWX8PmZDg66hT48ZZh2vB0h0>
X-ME-Proxy-Cause: dmFkZTELU42rbWsnZm5g3wsXzzgCo0QFaYxQvc56PT1xMIUX/XUWK9i4Bvzwc1EiwlwnaW
    CeQjKlRuNPldg5s5TkZuRbrfkGuG1erADkv7lJxMgvL6wR0w5eCWY215GFskJ2oHI1hl7v
    hFAE6ZMIYul0W/Y0KiWOM6FbDMxAFzwOthIh+WO/qq4dYQbB/lHTycZfo6+husZoAzXtRT
    xkjoMLsflwFVFBGtuP5iD6Dl/9U/QTkmXL8WcbfC4sm/CP5xHvEWiTRfoMuegC61DLwXu3
    lwMKfv+vR/vJigDz0+FLMobf2+E5uT0zQlcVMf84Ici9f/iTiQGMlJPXTjln8IPSDtPpmS
    G1abxJHvU8eEtojKxdQCSmQF9jDuGC5VQBVIseAOEOQfRoIL4MGSMR3fN2sPMVFJyplyGV
    WlZ9uWmGi/YOga83USMw43FrokMN1v0je0gaRTYmWtQ+J0jNr1PeYebPDgoPDE+6tMuJNp
    UKZqSByEf3aPHQ1aKMjt9S3KrdyWffPLUaWks9KioZ/xRSUdbyRp2ACuA2RwcL2meHQpyU
    m+A0+3o3s1A3oBE23o5QnbLeFP8gOpO57PdVqbHonqxs0IChLZE4TJAB2PDNvdnvsUkM+E
    /Y6Uq+PYdsJXGpoQA165k2O+iMxtC8kAYtOwBzJRS5flTPWaRYSmRCeC9Dnw
X-ME-Proxy: <xmx:JBksauvvb1EHDCAdqfuH8ynlaxFb9gda8uUWvhmSGltOX5BsY5IwZA>
    <xmx:JBksaqXEO58VK59hcGULsVOcn0slLvoYJOpE5pVtE-AlFnOt9y9o2w>
    <xmx:JBksamt5zOc8wyoL998fNPaa7-9z1HCZ200mE5abOfziDG3QDB0fNg>
    <xmx:JBksamXenI2Mha9V_y_vCvb_8Mdgg4fgCFxchKFTzOrDU1GqK3SfTQ>
    <xmx:JBksauPuROUWHU5JLLRe42VRDAP8YuSv_-k2mCjQDgLfR8LNmFGMzhRo>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:35:16 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v11 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Fri, 12 Jun 2026 10:34:26 -0400
Message-ID: <20260612143449.3045055-1-oss@fourdim.xyz>
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

Compared to v10, rebase against bluetooth-next.

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

