Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3277E105
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701682; cv=none; b=bI6HuygBICYLzfEMgt3X66qZLHEfsWq/x+K7dY1OEnss9hG5eJZIJKlGxGQ+1A8Lp4U3x2tUQKBGy83gU88v8UTLrid/7XRuTzq1M4Rg3LZwra6dOtqG1RJibFQNhGnB8vmCLDPrp/oI3O6QJ8I4vVOaGnRUcRVymQTkFxM35Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701682; c=relaxed/simple;
	bh=yQYASTdJe7iCb30FczCDF77ikFy8Ug8Hq3nfZfl3u9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsejxorhPZ0GpiMTKVhRFdKtbHWDrGGo5OejwZVkDJkLxaZLYB4FWeyETqDgj/SvxAaP4jVYw5rWpP4dK3N0M1X/62YGaJfVMo72z+1WoK/VQUZSmbAEwd986Nkk6qNj5YD2Q+LzqqFKfz2ITg5qKsNpNGn59+3Ngir4OF8m2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net; spf=pass smtp.mailfrom=arunraghavan.net; dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b=JjRFXJ1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEd8eKVx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arunraghavan.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="JjRFXJ1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEd8eKVx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74EF37A0120;
	Thu, 29 Jan 2026 10:47:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 29 Jan 2026 10:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	arunraghavan.net; h=cc:cc:content-transfer-encoding:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1769701679; x=1769788079; bh=o3R3ISdGVp/yQgqo83xYrmGdLQEgmRON
	xDmT9KHuNdU=; b=JjRFXJ1OIT7jui1+/NgW9vkT2F8VnAIR7luc0gEitL2mEq6V
	vrPvIV1wKx3C+5ZbhbENTWQREx7+6r3kxPNPrcs5bB/7laq6oevyT0xp0HxK8m2T
	bKKgVt32iBNBn2+CQR0+isR36usALf+5xwZrB64T9cgxD8G4pHJJ1O0G+eBgtnku
	sdtreLKmhUr3zXE2AwvM1oXSP4nxiGsDFNynBYUHTa4iTd4YVxa4X449K2PsM94x
	V1+8MnYU43zHLjWHjWRD52Wj3rBV5x0knjnKevPXYmRRJYroCqETYAYffqMD7O3S
	YqRRRo9vVoOQJh7xLnkJ68U1FPBvlQfraLkJXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1769701679; x=1769788079; bh=o
	3R3ISdGVp/yQgqo83xYrmGdLQEgmRONxDmT9KHuNdU=; b=YEd8eKVx54jkUXjUf
	UMW2Fm1DoGFzM02eintWgzvOjOzkpnpuaJ1BttkT9bYFo/oyXt+NhnZ+mLJuVmae
	zj3WDhge5k3S3PcQ3/NgnESDBeM+AekXXDmqdmQNqBqE+ch8MGwzwHj5p96RrLUu
	ukujxYImSbzjguOnOy7RRnUgR6W1EnhNlco+XLCEHTLWYjP6bZfepha1+qySNv46
	YSFLzye8P9fBQT84Ueqk6evYvGZphCsPEzwH/kMaZdFoGqChh8DG6CU75LVZkXAp
	qrXVszUsaWOpcb+k7cRrqd8EczNNAasu6yBl+Oan4mtakutt68r1G9MqpBG4ULur
	fOYlw==
X-ME-Sender: <xms:L4F7acNs9zAHJa5-lYbCCl2ylRfjQfU2lk4B6Wie9-5NE7VPFlM27g>
    <xme:L4F7aaZ4pjQDXJS0ge7WjGELCTrCP58ngetWTM0ApkhnF2e9cavwl69lhdq_e1Zrx
    6UStW0uKQtmRp_RVKvtdfoOWatRAlaDf4rgJeqpOKFHn151nZWG8w>
X-ME-Received: <xmr:L4F7aQqLzFzk9MchdKyKYQ_ZGlcppNrtSYes9dvYulyFaKq9qO9LcFKlQdy-9CSuHozSjmIx0NkFYW9sBqR9pLXfKenaQvtx3WI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetrhhunhcutfgrghhhrghvrghnuceorghruhhnsegrrhhunhhr
    rghghhgrvhgrnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieduheehtedukeeuheeiud
    evgeelgfelvdelgeeftedutdeutdefjeekfeejfeelnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghruhhnsegrrhhunhhrrghghhgrvhgrnh
    drnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghrkhgrughiuhhsiidrsghokhhofiihsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrrhhunhesrghruhhnrhgrghhhrghvrghnrdhnvght
X-ME-Proxy: <xmx:L4F7aeayBAqMhttMtpLzdnWJhT2GLlS0GAzMlisr7IFQp8ylu9CGYA>
    <xmx:L4F7aYRLJEcalMgv0ReXtVRm9T-lLwLT0pasPd1ZL-eiC26XiLQEXQ>
    <xmx:L4F7aV5Ajgb-3NTQlVotdl9TLpjtjyu_Rb7lbEIjXaw6MtFIJ-Xrdg>
    <xmx:L4F7adzl4OA-pc4IerVuNp_IF-HR9CINr4A8EuV6c_X35fhPv8JKWQ>
    <xmx:L4F7aRRwL3FsQTZGi7POkSG3ynm9tn5TNlcfgbGASGnaVfzrVoN1uhtF>
Feedback-ID: i42c0435e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 10:47:58 -0500 (EST)
From: Arun Raghavan <arun@arunraghavan.net>
To: arkadiusz.bokowy@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@arunraghavan.net>
Subject: [PATCH] media: Fix G.722 @ 16 kHz codec ID value reported by transport
Date: Thu, 29 Jan 2026 07:47:52 -0800
Message-ID: <20260129154755.410853-1-arun@arunraghavan.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128103809.2679085-1-arkadiusz.bokowy@gmail.com>
References: <20260128103809.2679085-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.

Reviewed-by: Arun Raghavan <arun@arunraghavan.net>
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b68290aed..772af1014 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3752,7 +3752,7 @@ const struct media_endpoint *media_endpoint_get_asha(void)
 	 */
 	static struct media_endpoint asha_endpoint =  {
 		.uuid = ASHA_PROFILE_UUID,
-		.codec = 0x2, /* Currently on G.722 is defined by the spec */
+		.codec = 0x1, /* Currently on G.722 is defined by the spec */
 	};
 
 	return &asha_endpoint;
