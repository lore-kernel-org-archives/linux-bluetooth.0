Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A627C09A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113209; cv=none; b=A8oybKFns/OspNPyRHMLr3DLX0I49Pi4L/kveE7hvneVY0mLBq9Qj0vwDVworHIawlX30XVjlUDewPBSHxhSDeVbH8TbVRovPSitT8uTCkYgBrOflPTh9HDkrXptPFp7Jz9vKFUBdEHuGuNoh7sszVxQ63dRtmW7ZCgJRPUc6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113209; c=relaxed/simple;
	bh=vO/p/EGIY19QllT/8hNfL/Q7T8irm3JK1ATqVxlrByo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J36MZ6D3higX1rkEML1EWSMmazj2qNKR+iBvi0BVGN1t3PBwDAkDGAwOjisX7rKVk8DH+/Vyc1elHGnFasCy06qYOaxSBCnA30lMgvZHcTcplOKyzy7XYQFn97bLh8xQDUzHf9qr7k6fo8NeZTAwviT/bE0NZdmv+6egIUJxhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYDlPnlu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYDlPnlu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ED97C43390;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=vO/p/EGIY19QllT/8hNfL/Q7T8irm3JK1ATqVxlrByo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CYDlPnlubzeRmSDa90My8S22HOLm6UVVUnxL0Cb0VFwwgYvF9hhVF4n/5YLFhl4Ei
	 fXoNysxu6aQkvFP04bIN5vrLoZhcpzuDND17SxTos/UhD50XqJoeYZghmhm5awDITr
	 QG9pfMj6BdQMlhz5VPqC8K/D7hJPrpVDZ+v0dN9tIJNsEIIY2RslTDpMnCFttHvBFG
	 vUBiJ5+DeuN0LjK/xI95c51tBpTAzJ7SSqqNQrycR80SLbjdkwHaMsQiCsg2E/Qc3t
	 PYmNYSzxdTRYjBUoj64MMkE13sog3RWpiw62FexaPl23Cbcl3wrZPZgsPtuehaDUB7
	 kCBxCHO+unGKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E16C46CD2;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:20:06 +0000
Subject: [PATCH BlueZ v2 1/6] build: remove unused variable builtin_nodist
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-autofoo-v2-1-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=721;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=mRorcTTMdiR12GxUJR7RTE8pAyiDxz8fyZaYph6MM1Q=;
 b=zYqpeqpBTSvsRBWWKT221IWpEpNM0P32h51uAVI9lHUQ/oF01kAMS/Ek8I1BJbR7dUYmkNext
 cxrAAo1co8WCNEQCZpgzylVKkIf1lqit+gfpmomnaMPIQvohS9vswNk
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e738eb3a5..a470e40cf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -288,7 +288,6 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
 builtin_modules =
 builtin_sources =
 builtin_cppflags =
-builtin_nodist =
 builtin_ldadd =
 
 include Makefile.plugins
@@ -350,7 +349,7 @@ src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					$(BACKTRACE_CFLAGS) $(builtin_cppflags)
 src_bluetoothd_SHORTNAME = bluetoothd
 
-builtin_files = src/builtin.h $(builtin_nodist)
+builtin_files = src/builtin.h
 
 nodist_src_bluetoothd_SOURCES = $(builtin_files)
 

-- 
2.43.0

