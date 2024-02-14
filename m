Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937113F01D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948095; cv=none; b=dypbWhGRtMt0SIq7nKTQl7AyzZ4nyA6DJSjlJLdM44wNy/KISbGJhcQDkWlpFnZZNzNFkxnDtEsIgPCMqQd3MLEIXKHBRELekiXzG/gAewKD7xgKfJZn+Fdxd51/I09++7DgzMQi01ReKxlFb1ZyDptfambDoxmPDJqTNZKOo3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948095; c=relaxed/simple;
	bh=6+21W/GlIOBI4iHR5i89+VKDs8ZAU79zcgZrIeB3E4Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vt5ffLPSgslyuOhnOzl77QSo1C/QTKE0JxAQ9FKrO4xUvbJeKXfe4U0tfN0IvdjE1SaddSXFV2zxH98AgPELPzWF31Pw6243rKKeO3i9tOviGPXMFcYUifRN7Trhj6CZKnDDYY5XqwgkA5KjLMCbMhmYCsJhFivSTOLHSDONE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2z3LW4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2z3LW4y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A86CBC433C7;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948094;
	bh=6+21W/GlIOBI4iHR5i89+VKDs8ZAU79zcgZrIeB3E4Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=L2z3LW4y2mxpAN+7mTdvpnyumVZZs+OCDcngjAa/ux0cesbgX//0SiVIQ3NDCgcdm
	 JPC4s/VeHHxLUA63x7QTIvkZkYlFMOJHlQYxoH9Z6wuSFY4+vPfEfNGj2xdRoP4gNa
	 MohrxqD4inYZPLiGq2Baiq8iEX4ugIs35COKE2BUdMwgTE68xhbEPcyjDcoift6eXd
	 JTPoD0sLgIh0OtAigaFABoo9WDf5f+s9ZKqh8k6Ocp2RfiUFR3bDZYSUkQTsbjD0mc
	 q0v7ebhCHhdLZ9yOEpFD8KidZAQCXjVj2bgjFq0ldhz57AB76qAQdsj4HrfQLIAC5Y
	 Lk+eJWfPCT9vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878A7C48BEB;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ 0/4] Handful of build fixes and cleanups
Date: Wed, 14 Feb 2024 22:01:23 +0000
Message-Id: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADM4zWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0MT3Yz8/GzdtMyK0gLdNCMzYwOTJHNDYzMzJaCGgqJUoATYsOjY2lo
 AbAeMNlwAAAA=
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707948093; l=1229;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=6+21W/GlIOBI4iHR5i89+VKDs8ZAU79zcgZrIeB3E4Q=;
 b=bDFps1/ja+C/TdgQwvt3iNfcen6zyDUBzmVyHvJmiKCtYVuuots0cKTHtmYaRpmlXlsXU5iqE
 ciFA4gsckrwBIHKKuwbyoz6siWKKv2iVKELxFKcLP6D5KYBN44yovdf
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello list,

The very first patch in this series fixes a regression I've introduced
recently - sorry about that.

Namely: two separate patch series introduced an `install-data-hook` and
I didn't properly test with both combined. The former is unconditionally
set while the latter is not.

So if obex is enabled, we fail to create the config files :facepalm:

The second patch is a log pre-existing issue - we install dbus/systemd
service files, for obexd even when building with --disable-obex

The last two are trivial cleanups, so feel free to drop them if they
don't strike your interest.

---
Emil Velikov (4):
      build: fold separate install-data-hooks
      build: install obexd (dbus,systemd} services as needed
      build: drop %.rules make rule
      build: simplify coverage handling

 Makefile.am                               | 27 ++++++++++++---------------
 Makefile.obexd                            |  9 ++-------
 tools/{hid2hci.rules => 97-hid2hci.rules} |  0
 3 files changed, 14 insertions(+), 22 deletions(-)
---
base-commit: b55d98e5cc97e4ff8c3980b84f46c84f3b1c1ee3
change-id: 20240214-hook-fixup-f26304b71366

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

