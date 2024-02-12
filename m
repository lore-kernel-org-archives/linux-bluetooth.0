Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4D47F45
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768160; cv=none; b=O3rIvvbl+r6up6FvQ280DC0CgmduSNQ141M6xDOrBS+f5Gq4ZFNInr0GPeSrl5gBeWxVhguLSlRGOITzz44DHpeVgiUJt7oMvVRBqBLOfRyo4UXqcQy6GZSIMu0YkHd4Jr/zPm6Z0+zjkYylloHv92Xs7CYLiRHQk0LWaCT+QDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768160; c=relaxed/simple;
	bh=27XdaU5KU3C2bMi40N4HgMXvKSJ93TxqLasPGlGSRXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llVAxSpY4hWMwfQu+M0KJuMhUn4nbX/QU2ZChUmbbghUQAg1wTn1wIZ3MgYwiBGQxjtt9tOD+GA/Gt2Ld60BKa45QrdmHRTROnG08oSPAtahveD70BW0QzU+i9LwGGbUFGuVeXbv2awgBuP4MIe14ZPz0tQi9K7BO88lhXbhtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOh2mfug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOh2mfug"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDD7AC43390;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768159;
	bh=27XdaU5KU3C2bMi40N4HgMXvKSJ93TxqLasPGlGSRXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fOh2mfug0XH1efusfa3c5//Pf24v8EwSKgO0byfnrIOVKNzfzvxR4NLw/oAruwLCw
	 yEv02F4jc7rodPbWNlbbfRnRAD3GX2HZGkDy+VD4og18uJO/VkwA612vkg7H223oSK
	 pumD2Q8FKDNZ4TgEAZGezMQJz141FuGbzhgBREAwNbQm6vFqX8uu92UHo91GJWYfUH
	 mTK8uRA30e7q7sAqccjhVHO/SzJ/FMwrRBbI7zuwiOLuhMkRqpN8qDRQCP5aXIWSpj
	 o1D3FdpUkfZ7EurlL/PegBRszPlQut8mEgJp+hDVKzCzs2mG3jUhJnyx1qzjV21NHq
	 DIFNirI/yKRhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E51C48BC3;
	Mon, 12 Feb 2024 20:02:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 12 Feb 2024 20:02:38 +0000
Subject: [PATCH BlueZ v2 02/10] adapter: Remove experimental flag for
 PowerState
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-disto-patches-v2-2-8bab1bd08f4d@gmail.com>
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707768157; l=1246;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=kBWJv6IuMJzmAjsIKoWIKgJU/uFwFAGgPEAJK3EPyjo=;
 b=LSHYBrMDViFmJ9LE74zZVT+TFh/TVVCv3IfWPUs/pVGdSerKyT8KDIekdk5AkN2qnf/SMst4S
 tGIHN5/O+yDCpNkEjeK2KSFdcqA/m5b+pwsSGcZCJD6AHSazBQ4x4/G
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Bastien Nocera <hadess@hadess.net>

Now that the feature has been tested, that the API is deemed adequate
and the reliability sufficient.

[Emil Velikov]
The feature has landed in Sept 2022, with inclinations that "we might
switch it to stable in the next release", back in Nov 2022.

Today - a bit over 1 year later -  various distributions (Fedora, Gentoo
and by extension their derivatives) are carrying this patch. I think we
can say we're reasonably stable and can merge it upstream.
---
 src/adapter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 022390f0d..ef1e66e4b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3914,8 +3914,7 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Alias", "s", property_get_alias, property_set_alias },
 	{ "Class", "u", property_get_class },
 	{ "Powered", "b", property_get_powered, property_set_powered },
-	{ "PowerState", "s", property_get_power_state, NULL, NULL,
-			     G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "PowerState", "s", property_get_power_state },
 	{ "Discoverable", "b", property_get_discoverable,
 					property_set_discoverable },
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,

-- 
2.43.0

