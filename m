Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7118D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355700; cv=none; b=FWf7c8u+mHL9SNalLZk7pY2QI5lHkD92ILb7tuLcYC4RLOWURkXA2loCygKVIU9WWFEq2OmCcFoXEjujHnPGcLiMdZXM3+cruTJIg9s1kVSD8BJmN7Q1ympBibX/czpHt8CtidMTkRptaV6/OA2QBiElTfcELMtH0QXj2WCbkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355700; c=relaxed/simple;
	bh=JrqGrZ4NHYUvADCc43JNJ+Uwso2BlGQdgK+JQGUjfDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUZuAvwT9CnKXxVPzfDq34YTw9vUaD6rM0nTnOGErhNXd3mq6Ovofl3EY9rvKHtUzHU/dDfIFrw9vNidArJFPPMC2cArqDrwuSv8heiFFWXpW8tMtmvHWYZzDNNywPKSYy0rnvJFVx0Hv/hfMMHHHuz/RnJBQPGIZIZE7DL9ceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com; spf=pass smtp.mailfrom=system76.com; dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b=WAjvW3/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obxn67lf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system76.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b="WAjvW3/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obxn67lf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 308531140256;
	Wed,  8 Jan 2025 12:01:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 12:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=system76.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1736355697; x=1736442097; bh=LLm2s04Bi1ZJ64J2eSOlE
	x9k31qBpNw8MKRxyj22X1M=; b=WAjvW3/utD49hQZdAOVgmYngs9mjWZJzdDVp/
	q1jSGejNQD68wtNAuq19cLlNqFrdzty6m/7wAvf2lrznkyq6r3/BUpMZ0D2o4lwg
	WQUM7R6zVG+4Xu5b2pHrDQm/SCC6rnllei5tVdSQpsfsr34zTSYBaAyX7vva4e0N
	Ec6D8yQaFzeCEilRQJtHJ6pVOWlvnTCw5wRsK7To9Ii7ZvdidAJJFBPJQair0g9J
	jZ7odB6yLshoM3j9xa5yYfMLF0F1M6grd2GpRR8/f7Daao4uLQdfU1AQLJGXvVkw
	spbHs68nC0x1cRwFOGnWTLE92IFE/3i7icZqy34J7ZxLNK/5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736355697; x=1736442097; bh=LLm2s04Bi1ZJ64J2eSOlEx9k31qBpNw8MKR
	xyj22X1M=; b=obxn67lf8BFjphqLYwhMNeeF/yIeY700kQXJPZYAAqC6CzZel0r
	kNmxpKWHBDGo1N4mwXapqyaqytRO+7O9jozinTHViYfBzi21mhLF9X/AsCEbUB5a
	Vsgq5Z44aJ2h7z7bWciERgPfIkdX2wBU6mHIzJs4CjtmfYfjBL8tEsD8zmb96331
	nJx/IkHJY99paDveqPXsifv9Pck0eMiiQPh0cZLg8hkGEaBKedzQsHk9q20gyNnf
	qwcSDPXn1B5nvy1VQ64hcd8OhiTfLuaR+maOtN1UHk8+Q57VWjdMvdVHR1mqNx0a
	RIcAMCCYlBgp0RLznlGsIb51F1U1ZiS1+dA==
X-ME-Sender: <xms:cK9-ZwmIMfuocmMLF08adAT07vPwKOT3n8yi9LgqMpnQfXqZcAcgLQ>
    <xme:cK9-Z_0dkfJSxU9zZ9Y8xDqDtGigQ-M5cvnx1OxNNk24s_K9d8IWOCwXB86zc1Cbv
    -uZmJ4vvbEPndiCBQ>
X-ME-Received: <xmr:cK9-Z-pqV6uLimFYvz4MQbsUVv8uv9zf-omCGtGUKHIcOqI_Vtl8Aw3cTkZejeO1jOZlnYlMVCRvu2r0YshbSpMpxn9WkvSbBT3b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfhimhcuvehrrgiffhhorhguuceothgtrhgrfihfohhrugesshihshhtvghmje
    eirdgtohhmqeenucggtffrrghtthgvrhhnpeekgfetfedviedvhffftdffgfeifffhteeg
    uddukeeifeeuuedtleeftdevueehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehttghrrgiffhhorhgusehshihsthgvmhejiedrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinh
    hugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehprhhoughutghtuggvvhesshihshhtvghmjeeirdgtohhmpdhrtghpthhtohepghgrrh
    hrvghtthesshihshhtvghmjeeirdgtohhmpdhrtghpthhtohepthgtrhgrfihfohhruges
    shihshhtvghmjeeirdgtohhm
X-ME-Proxy: <xmx:cK9-Z8kt4j7PgGpLkX1UcIZWGTOCNETWzMzgYW6k3ydMAGTz3A15fQ>
    <xmx:cK9-Z-3Y_7pu9zwk7NZgSEHYsu4hWu54UBhbAUlUAuJOFyODNKoPRw>
    <xmx:cK9-ZzvnNn0Dpc9jTUGSBWnHrhWVSlG5_g7ptUmkRMXpFOnB8rGggg>
    <xmx:cK9-Z6UHIWvbblu__hCKPfDUvnIyWnMoGCvGw3Y8r17hOrKExo2PpA>
    <xmx:ca9-Z3khIiKe-Z27BrODQQQw46Eu4ESSQqik7WOwK6ufkk0a8W1FV7zk>
Feedback-ID: i1761444e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 12:01:36 -0500 (EST)
From: Tim Crawford <tcrawford@system76.com>
To: linux-bluetooth@vger.kernel.org
Cc: productdev@system76.com,
	Garrett Wilke <garrett@system76.com>,
	Tim Crawford <tcrawford@system76.com>
Subject: [PATCH] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
Date: Wed,  8 Jan 2025 10:01:11 -0700
Message-ID: <20250108170111.16824-1-tcrawford@system76.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Garrett Wilke <garrett@system76.com>

Signed-off-by: Garrett Wilke <garrett@system76.com>
Signed-off-by: Tim Crawford <tcrawford@system76.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab0506148e84..71caf297aa70 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -483,6 +483,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8851BE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.47.1

