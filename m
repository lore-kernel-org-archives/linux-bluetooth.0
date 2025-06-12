Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8F78F4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706273; cv=none; b=Euidw6MploWnDB1eDgpxpv2BWTHUnX3SbPQvSIoGzEIZdG4rzzJkwxT59MmxIb12GrOyy9hXCwlbhxA/SbO26MGo4SVvQ8EabX6rmEVE26pTQdsZA3yvAKMOsMoH3IFEgmLo/DDtyFvPgrsf4iO6IWfvqIsgEwvCLc+nX9GdAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706273; c=relaxed/simple;
	bh=2xaDBbW3p/NzxFMw5RbplFMMUhcZCtv2lWoQPaPTm3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hzoJsaOQGtoGepFVAZTuXvevEen7tnG4hbLJBnsjmp7M5wz04lEhb75aKEzkp7CLPOfTZwSOrMvhwfjVNV2QdNyrngETMuhsHt5xGe5Ql9Ahsh+NIRPv+KBf5LGQEh27v3w2YwDhdkEwo+nd0e3Au/oPcuFFE2INyp8YqLTZiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYk4ZU0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYk4ZU0p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94465C4CEEA;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749706272;
	bh=2xaDBbW3p/NzxFMw5RbplFMMUhcZCtv2lWoQPaPTm3Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dYk4ZU0pBcGCVZQrIM399a9kETCiPv6mOATesg83taUELUd29RXd1B4ZSkv9NNyVo
	 omdrAhQP6ZlWw6g/9OjK59gl8BHaQvNOWXQwM6yj0ZzSVRhndsBygIK1f+QgikXLSe
	 kKdZqQJKzKybt8iFbDUu87OX/gugiaPtmivgftRMi6zJTsMBOxuWvic58pLPjGkUsu
	 1Fv+4sexDvaf4IUCdETZzWgGsylM3nJ/pg+ELgDBlQQJU7CwNHr9KT62txJbwz6OZ2
	 XC6VYitTng42Bbmy4qGFZV+6FGonGHkwo88qcOQvuRd5e/0G5cttzYuYhl1Ut9dEwN
	 m606rJwGiX2lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84507C61CE8;
	Thu, 12 Jun 2025 05:31:12 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH BlueZ bluez v2 0/2] bass: Support for Encrypted Broadcast
 Source
Date: Thu, 12 Jun 2025 13:31:00 +0800
Message-Id: <20250612-bass_for_encrypted_broadcast_source-v2-0-9128a437b595@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRmSmgC/5WNWwqDMBBFt1LmuynGakz71X0UkTwmGlAjE5Vac
 e8N7qCf5144Z4eI5DHC87ID4eqjD2OC/HoB06mxReZtYsizvMwE50yrGBsXqMHR0DbNaBtNQVm
 j4tzEsJBB5oQseOUsYnWHZJoInf+clTfofsEv1GnufJwDbWd75ef5V2bljDPx0FLzUhRSmpca+
 tB6czNhgPo4jh8I43wV3wAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749706270; l=733;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=2xaDBbW3p/NzxFMw5RbplFMMUhcZCtv2lWoQPaPTm3Q=;
 b=V+XJYm64c1F1XqC7ASdiFawab3nrp/zbYuh2WhsF9O60camRyQiciel4s7MQyIIVXIWxnbWS1
 rjBPO/yDRM4Aqb8YnEF03INZ5VS7q/TZ0oTPQSwpZsbLvty1i+0EHVw
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Changes in v2:
- Submit shared/bass.c separately.
- Add necessary comments.
- Link to v1: https://patch.msgid.link/20250611-bass_for_encrypted_broadcast_source-v1-1-69b8b156488c@amlogic.com

---
Yang Li (2):
      bass: support for encrypted broadcast source
      shared/bass: Move cb->handle earlier in the flow

 profiles/audio/bass.c | 32 ++++++++++++++++++++++++++++++++
 src/shared/bass.c     | 29 ++++++++++++++---------------
 2 files changed, 46 insertions(+), 15 deletions(-)
---
base-commit: 95b72bbf1fe42216d02a5ebb99bd18e9b69b6064
change-id: 20250611-bass_for_encrypted_broadcast_source-f68417fdee73

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


