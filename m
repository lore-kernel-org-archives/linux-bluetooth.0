Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62060141986
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948095; cv=none; b=G0LsDPjNgHVd+9Vp4N9DECiwa1FylkLuLVOoMRulrEULDrUdLtS/psdEdhxb/MTcNrpHBBuURKmePBX6D36VvUTbf+Sr979vd54hIl1EJpY+OsF8WbnKlAX7hfvsRB6bA0qdclL2twIqbf2mJuaxdztR0pKGQwHIgNhCs8/oSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948095; c=relaxed/simple;
	bh=nMbEmDtu+nbz7C+PG/VK6/9mg55pKxG/RHldlP9WHq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4oS4kfNG8kOQHVfjRo50gVVBw8BTHGzumgPa0M6guGWuNaHRTJLF0V9wV/EcaZsQkn0+7C3Vm53sguSVK+u0nBpNCcmNsA/UHLd8oTfoBSUGzsxIINoRg7xC1NLIGKpQ91F5lKaxQWDf05pV7YZlDcx2CdTi7r/ZAocQ9YUhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF3SLao1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF3SLao1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F30A5C43394;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948095;
	bh=nMbEmDtu+nbz7C+PG/VK6/9mg55pKxG/RHldlP9WHq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bF3SLao1XU0GYdWHIRyxD/Kbq6YgStBjUc4055ZXtYvLiZGCCEiCz60m3hPt8NtaK
	 gDogMG3Qyhjw4uHWX68aPTbMKQffOMO9J3Onne32Z53pNGgwxervBqTmB8cIon+zk4
	 7pp6UT4r9uwOHxgmcxxaVtBeqrtqQsq9+/AljbDtwzk0UZ+2xFqr4rmbZO73eH9M/4
	 5spxozFtCGh+PBTfLhfO0xfwQAphwEIyH5/UvaEd1NyoGAXLvU+fajihEVlR6l/p/S
	 P/QvgEVNFayItxXbSnb+7IMKMI1AEQz5b6OMvNdgKTHRkwGpW6wiAB3ByXx/ZSzgp+
	 fyHjTfWSvuFwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6AC48BF1;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 22:01:27 +0000
Subject: [PATCH BlueZ 4/4] build: simplify coverage handling
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hook-fixup-v1-4-0e158ffea140@gmail.com>
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
In-Reply-To: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707948093; l=1002;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=ESy0gP0YuVBpkapzmcgkbeJQ/DjxQ37O4UDqJ+8xAZc=;
 b=dEsw1YM+JtmX/r12Xky6gnaUXB/m7NAH4937n9pxQnTOdfDoLV+C1KBKOVldEbbazABA5Y6kO
 oyz8+2Mm9MTDwlHe0WJ8743GiO+12pPDboqvHlkR2wtO0hpUl2c25lX
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
index b0845e707..08eb32852 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -793,8 +793,8 @@ ell/ell.h: Makefile
 maintainer-clean-local:
 	-rm -rf ell
 
-if COVERAGE
 clean-coverage:
+if COVERAGE
 	@lcov --directory $(top_builddir) --zerocounters
 	$(RM) -r coverage $(top_builddir)/coverage.info
 
@@ -803,15 +803,9 @@ coverage: check
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

