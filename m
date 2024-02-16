Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6114E2EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=p3qTnaD3UUt1l+6iaa9v89C8fpP7g7lZe/DeH2NUHSv6ajZzqC7vVoUcsXpOu31Xj57mm8iABm8/P9IWpyf02wmiAUU3Xky8bO7ZCqSHT8K/B5aZLUoBTAsLqKHGBomYqF/IknCmhCnkQpuKbPy6Rgezm+VJbAXTkiF42/j9QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=75tt4amu75ekwISqU1kmUcocTLdfhU5k/4bfjvIZgQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=u+Hg+0tBe4jLC8Q0LVi9OQw9FNs2EyjfHAnzyco0FYsGrWTk6aykFJtl+3v06XmwwmNRVrAa7GerqitbVVPiFe290gOO90k2r9znnrxfoCCy7X1VZ49acUeYz0+i+NzB0+Aa1tcG7m6a8GBLBjBE3Olbvb+hVJ6cuAQ/6hge83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScsbB53j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScsbB53j"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38926C433B2
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=75tt4amu75ekwISqU1kmUcocTLdfhU5k/4bfjvIZgQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=ScsbB53jK1ZmXqd9NUx/UdphdvlT0P0eQaCmwE3umn7NXHA+U2IHjYIuHQnUm0DRq
	 2kJOGyfVY9SYguablKiiSSOMnfiR8IJppBnucnLeJksvskVrmPuUHKkVvx2Ex5OUg3
	 QkKoZi8G4PLT27LB3rLvxawxrVBNXDUT5hkyiD2HzGAVKNBN+ZXY1BEw1L9apubpGA
	 v0BkAIoizRN1gAhxjfEwB/lOQv1XQZw0obJWlnGB4vYewavhBBL3YrVerrlq0Vr2Qy
	 uzoDh9LAczJaCMsB3Z0jDpEqA+7WJ+h+543h52uyFn6Kul2fzmjzHygFm4i4XtBV+D
	 hijUL2mT4/2qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D1C48BF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:11 +0000
Subject: [PATCH BlueZ v2 07/10] gitignore: add org.bluez.obex.service
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-7-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125069; l=400;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=g0lVHzuaBBARwiB2Yc0yacc+yEkZDozfWorUyKbfBdc=;
 b=47KhO18sgWeZ/I1/LFS6zTxvR6jhbRbsZD2WmhnX/STaOIEd0XIoOKTW3efxdw/eM2fp/VsP3
 cSlnrqFEzYmANSAhlSuZwdK+KFFLvNQMDWOnxxlAaBuDoU9/A75o6Wz
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a5954658a..4da95f275 100644
--- a/.gitignore
+++ b/.gitignore
@@ -168,6 +168,7 @@ mesh/bluetooth-mesh.service
 obexd/src/builtin.h
 obexd/src/obexd
 obexd/src/obex.service
+obexd/src/org.bluez.obex.service
 tools/obex-client-tool
 tools/obex-server-tool
 unit/test-gobex

-- 
2.43.1

