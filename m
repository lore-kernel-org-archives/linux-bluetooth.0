Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B629B78F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640121; cv=none; b=IFoQtSw1bbhPTyzlWLhnn3jeq+zwy+0Xo7Sxtk8svNpFF8AqWRLgE6L9/9FxsqJyFvmp+PP8QMuV+4hAFtfMU84j4YLBGlCpMVE67KMvQlJ3guvUVy8qP46A2HSxqkoo1H0DWW4rRp1nsxqNJ1+tmDCHmCXukzOolyhK6Sk0Sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640121; c=relaxed/simple;
	bh=2t7p/HRwThqJwGzDnt7TDsZxfD+yruzdjZn1jDN0sQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjfrA/hkEtdY0eW6pD/rpmfJSzieFv8MR/tUMPh2U0ifeY2WrUPC9XnD32kgxVlJjDzX1DixcUhiokH/nPMLSRf03uEeCp+4CEZhKqdrS8kAvdsCb4qkKM3SJ+76uQdktYJJ1zWdcmokyNe06g1qDBiI8ih3DeoE23DgkTSHgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=PSf5h2l6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="PSf5h2l6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82ce49785a0so2535275b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1775640120; x=1776244920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BWbonb6YEpd8mfEe4MSeSOlf/u/glaQYAc6PmCIl+8=;
        b=PSf5h2l6USZAUmkFYPxNSr2LssB7U66P5tcNEhM+sjR9U0OGJFxK40FaMXieUiYj1N
         I/xivR5y2jhbHIIPXYPfPtfyCv5+OZUqkE97deXjHNc9NeRnREe4IibjOxxAIeqLRwPC
         ljfzKlZjrYLNbo4Fn6glDSHOvm05QTr8co0Vv0SF+XOjyX13uHWY+9eLaJOsWIFJqm9t
         O5Q2rrleWtTLowCoe+3QUaJCtUO6rFp1TolSVsSLoTtyWiEB2UOQHiBe1sQwiEgZyYgJ
         B5fFdiQf3r7Wck3kEjgOL3qUsQRAoPRulwd1+2bMTwTCmg51hagRfZ+rkvlDJsWNjVUo
         3Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775640120; x=1776244920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0BWbonb6YEpd8mfEe4MSeSOlf/u/glaQYAc6PmCIl+8=;
        b=JZspNjqBPZVXH1Gfqt2EkHJ8j3wyXwU9G4yTHsflF1INXk7KMUIh85L227/lRLLm5w
         XsFx/xVkt6i7lz3Q0BxIWBy74M9TLh0y0lhViU0G3eck2dfdf7Bnaw99gUicNezAhdPs
         XUaI0vBZJ6N3PqGhliaAeTERueYzsZ1rdkntmsDDxaFsdIwrhRYZYGP89kJ7hZ8BPDnH
         nyx60lynvISPecNaC+8N4ED5rP7D7HCpq7ZKUwW/E2EE/91jmzJXdwBVGRb+HRhN/zfZ
         1dNjdSoCgVNtrZYauB9iHqQaRuU2IVTqtzmILHV6u3+6aH7Rdpsa3XIPodvyhaijHuiZ
         u1eQ==
X-Gm-Message-State: AOJu0YycdXzJ5PL9nvDSdUspC5WLMWtw2oCQQvGwKXNVKT4hzutJalF6
	Fb5ezYttVDvagMZbJ8fyIho7+YcDCYCQeOQPNmoKzawdxDOSTlHqs6RndVCBGBqbJgR8TW8oK1h
	WlRk=
X-Gm-Gg: AeBDieuNl7kyAQVRa9+VBL5s9hNskn0UtR0TbJAQ9ii4A9CTZrTZndng7SvpbBHWf4y
	1Y4VB3MHc4FSfH/lUK8VvlQ+SNzQ7gJ6DCkjiYjqSAi0OqpYNPewFmhm3IJZ86byruQaVvNb67L
	ZH6JhggdshR/agxiah9C2KVMYnidEl9HHsp0eJ0GRwfF7p1b2b5YcFIQe6BRRkMYjriAi3zqOIu
	XAKpX9pddbZHtQ1XXSroLLt8AyTnk6Dx1j1THBRZOM3wqqjwaPRwhlANushucLb5zdarJn9pPy1
	VHIc789vOpSil7hQaOxqcIeTlyplhf7UK+HQYSwhdPxjSwhvy31k1RqP6SdxEqJwsahmmfUn595
	oX6thaile7mw91C9MKfnC3ik8xsnbwZ6/6z5KgsV/V9FC/0ACMik6JuNNIWqV9jq4KiHNBytjRX
	MXj8aopBOGHfC5zSkH2wR5rdVpQkpCdvfwuQFxor8eDWCYoyUoosHmxfAk9DxejRVDmFUyAg0d5
	6tYPDyZXvZWN2zahLZc9qiOVOBL
X-Received: by 2002:a05:6a00:4b4c:b0:81f:ac78:ed22 with SMTP id d2e1a72fcca58-82d0db53f18mr22129058b3a.37.1775640119820;
        Wed, 08 Apr 2026 02:21:59 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b76c0fsm18941593b3a.15.2026.04.08.02.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:21:59 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v2] Bluetooth: Add Synaptics 4384 Chip Support
Date: Wed,  8 Apr 2026 17:21:28 +0800
Message-ID: <20260408092128.1915973-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaihsin Chung <kaihsin.chung@synaptics.com>

Add BCM4384A0 and BCM4384B0 identifiers to the Broadcom Bluetooth
subversion table and add device tree matching for brcm,bcm4384-bt.

Signed-off-by: kaihsin Chung <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 2 ++
 drivers/bluetooth/hci_bcm.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f9a7c790d7e2..21ef875d6aa7 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -515,6 +515,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
+	{ 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 874d23089b39..972685e83b8a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1609,7 +1609,8 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
-	{ },
+	{ .compatible = "brcm,bcm4384-bt" },
+    { },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
-- 
2.43.0

