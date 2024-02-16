Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493461487FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=BoGc+XQPcEtjhiULswXuRd8QPOttLFOhSkaFKuxmv+fveBSk/Yu2/dZTanbWh3j41HsPMb99vx5BGZ6ln+qVYBa4m0au+AcXnsExJDhWDyt2sGe4+pgwQzJl+9dgC6TJbiOFoGaiFQU1wZ89Yo5JUqYjqpg73cD0RfYrNjfQ+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=glCqpWt4oAuD1Ji0ik8N7GDUfG1S32Xnk6mB4hYp2c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLgzIlt5FvAhCUTw0uTxkC69+sHy9w+qe7waHf1NJBGkv/XMluzeij4cvqZ2YbyIMc3RsZSCAJKcEyroQAMz+1E/PaP9Ygh3HY07JAUhyXzCSvbiXy1/3aHdkk/HjoYhsrP9tzQDdukYeWch/YgF8fqFwIwyhwhj2VDfpBEVRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWtPFjt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWtPFjt9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20D6BC433A6;
	Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=glCqpWt4oAuD1Ji0ik8N7GDUfG1S32Xnk6mB4hYp2c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZWtPFjt9BtQs/W6jsAC9ZucQZjqbVM9HDZCv34ZPkdOmQd/gubTRwYk4eHTX7iUta
	 Ih4em7Ije+Q679n9yNuwMe4djsdsnO+ZbGWQUK8JKANfuJGmcJdhi3rSLaCIpXqH9A
	 TaAnNkmv8biJDu4VNpmjPt7j1wx8hpJEvAWZb3dfQamemw0VfwyV3Olgu2Ct0/HYjn
	 W309jRCKuE+l/EPBAB+A8IC0ML3ZulIMOQ0y/HhqtG4hja8wJV6ZTDsFiLmXoM+4iS
	 3T0WK8d+7V0bBVu+Gwcs9wfg9+QApPQThwWcHbrToXoV1pgqdBeqRHx0BjRPlXkKLm
	 PQtHgWBg5fbqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC71C54764;
	Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:09 +0000
Subject: [PATCH BlueZ v2 05/10] build: simplify coverage handling
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-5-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125068; l=1002;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=F7HjqEFBfzVfrOcOwzbG4BM6hzjjRaT6Ip2Olxc4hyo=;
 b=c72IAGHa37cqH7M2VSCdaRImQqKk8qNj2JMssAafC7dD0yy5p5pbfHE0hKaaG9HwmDPlzfLgi
 WrV7URNzSNFB1HVZfnal/4EZdAl7JiLZ8iHfKzdtxrIKxvoQaYt0s9k
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Makefile.am | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2d43493aa..94df43869 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -787,8 +787,8 @@ ell/ell.h: Makefile
 maintainer-clean-local:
 	-rm -rf ell
 
-if COVERAGE
 clean-coverage:
+if COVERAGE
 	@lcov --directory $(top_builddir) --zerocounters
 	$(RM) -r coverage $(top_builddir)/coverage.info
 
@@ -797,15 +797,9 @@ coverage: check
 				--output-file $(top_builddir)/coverage.info
 	$(AM_V_at)$(MKDIR_P) coverage
 	@genhtml -o coverage/ $(top_builddir)/coverage.info
+endif
 
 clean-local: clean-coverage
 	-find $(top_builddir) -name "*.gcno" -delete
 	-find $(top_builddir) -name "*.gcda" -delete
 	$(RM) -r lib/bluetooth
-
-else
-clean-local:
-	-find $(top_builddir) -name "*.gcno" -delete
-	-find $(top_builddir) -name "*.gcda" -delete
-	$(RM) -r lib/bluetooth
-endif

-- 
2.43.1

