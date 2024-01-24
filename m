Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DC136665
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139866; cv=none; b=QEbDsX+nlOLBFZYqk4NC772pQyaCO1i48gip1f+w+Ob3i5GMqz8juF6a8NUoqjSRXw3R87uQZJb22t0OWj5C+0sPv5vqhs2GwldwMjHngyDT2BBZgLfl4/0uRkpyUbvTWmChEyteDGE40JN/Nzw+KLaCminxXvwoQfaFk3LyZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139866; c=relaxed/simple;
	bh=SZC36PDMnhQtV9HQ4kO8DTUsZZgA4I9qvtrM7R1hRjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoF205hqZxMhuVgcTDbdfIVGUBeZjvmD1MqxRpvikr+59Y051wX5YBpmEdQ6RnYNoq6js+CVtVdba3WmznA9+xCANnSHiq+umvjzLYVNIYDkDvmnSf4ocPIc9RPCBIywGl5SIP7BJlRT54BSw9KU8BHFSABt9uQXyVf+cVnA0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIf+Sd4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIf+Sd4W"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79746C43390;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706139866;
	bh=SZC36PDMnhQtV9HQ4kO8DTUsZZgA4I9qvtrM7R1hRjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qIf+Sd4WiIb4P+811YbYwXWn12VAVnfOD5UXDWfCiT28NyCO1QsPVvXwFidFS+zjW
	 DFY9XnvggnGXCR6+H8pp7lVR1mmeB3PLMMi46ZOyGHXSjqq+I1a79dYWx+y3nWDowD
	 ANnUejk+PJeUl5MABaM+udDj4wWsuJsAd1nqBn0EBlJo9HvecIpjKRPuJ+gKWP1qLF
	 eleS8A9XIDbU9G9scUS0ZNwqWZzpy5yiiZbdymg7SArzCPm6QfhwAzuWYXSeNS6G+t
	 /bz/kneBUf3D3KrTEUc5RuWwjxoBmOMPzh7NUv1PfaEfGZuyGXKrRm48QoIlA63FF2
	 hQCFgqZpGQfXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A6C48285;
	Wed, 24 Jan 2024 23:44:26 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 23:43:57 +0000
Subject: [PATCH BlueZ 3/9] adapter: Remove experimental flag for PowerState
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-disto-patches-v1-3-97e0eb5625a3@gmail.com>
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
In-Reply-To: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706139864; l=1246;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=907K+oAngYC7pmuFcmxrsqecEUrqtrXyAL7kN0F3kdw=;
 b=XREYpy9XVrkc9ztO1iDu7W7roH81XDwAZEzP5H4+sYxmg27eu07AxvZ91uBpEX1CF+Dsht2Va
 IRUaDlHE7tcDhiTNEpOr5G60lT0wZGTi6QP0BCoGEsN38hddUW4W7h2
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
index 4c6b8f40f..31ccaf54b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3956,8 +3956,7 @@ static const GDBusPropertyTable adapter_properties[] = {
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

