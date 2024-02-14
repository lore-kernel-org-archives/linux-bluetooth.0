Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84A13F00D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948095; cv=none; b=gr6hpVVhKxV4s28UwLH2tAUlGHaQW9HOb00mfS7d1B/8UoXgcE54nl70TiAHApCYT2M+TkSj7s3loole8AH0ewZMcBmNNiWHRq0vgTXzNv29lrhiw1qwEVwDG+OLDWoYYfAiEbFtjdIIG9dVSO207cY4XaG9tnQXHhWabn9slEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948095; c=relaxed/simple;
	bh=NhV9bTJvPRubuJkD/cHqg6ghROXUU3yqJ8TYiAFxD94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6FVFsLEmcWU6a2+7hkOFL9lMGn/zG3l/9/i3T8hn55un131xxjt9TBSsSm72RsszJSrJ5bXZOWNEc43eJApLXQUpAnuBnBtHLVUDdonEXSIPj1KVgdLQay6C0U8ci5rcp1Oi0PU2s7SgFNISToyrwJS5mkjoJoj032Y23iT6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OttFP6Y0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OttFP6Y0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3A88C433A6;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948094;
	bh=NhV9bTJvPRubuJkD/cHqg6ghROXUU3yqJ8TYiAFxD94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OttFP6Y04UaNV918FWQz8CmFarAjSwnLvEooEApGKQF1f7N89hyMOLRfC8k7i6V33
	 x3D02hE9I+uIMeytLAO7lQBTxQwVirPYFUJg7t2HxR8jCryqQyrb0q4XeTX1zMRr8D
	 N8HA1ILfXsK6dFRNBaG/v9orPFb82EZn4yAgbxnyPBYsVSdwlyg25eZ5CKi1FFdUjG
	 jWqW28SKGPsDrH8hmKHz9N6i3UjYBHzV3DnnVPvvaKiQIsu7uvS2a5xFtMf61IQacY
	 0j9zRsLh2ecZqGAmc8woVHil96Dv5Hg/68zn/yIjMM9iHr6JisLOGbDwupuUMplzTr
	 bP6H/YTIVq3QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8374C48BEB;
	Wed, 14 Feb 2024 22:01:34 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 14 Feb 2024 22:01:26 +0000
Subject: [PATCH BlueZ 3/4] build: drop %.rules make rule
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hook-fixup-v1-3-0e158ffea140@gmail.com>
References: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
In-Reply-To: <20240214-hook-fixup-v1-0-0e158ffea140@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.l.velikov@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707948093; l=1176;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=IVYTUizQHoCmhehLtiA9Zi1WMPZ5FTKhQFWT9gvpdBU=;
 b=461SVuM4K0438sRUXtx6E81zgpURXT7OCxk7ZdNSzOd1QiFwNhLfdVra27u3wtgTctzs5vXpn
 qTg2Hpru26ZB1W/+BYmCa10tnA7BH/vsCW+udLIvGwkB70RCzr2dkoh
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

There's a single file, so we can drop the makefile rule and rename it
accordingly.

Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Makefile.am                               | 8 +-------
 tools/{hid2hci.rules => 97-hid2hci.rules} | 0
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e67551761..b0845e707 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -435,11 +435,9 @@ if HID2HCI
 rulesdir = $(UDEV_DIR)/rules.d
 
 rules_DATA = tools/97-hid2hci.rules
-
-CLEANFILES += $(rules_DATA)
 endif
 
-EXTRA_DIST += tools/hid2hci.rules
+EXTRA_DIST += tools/97-hid2hci.rules
 
 if TEST
 testdir = $(pkglibdir)/test
@@ -764,10 +762,6 @@ endif
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
-tools/%.rules:
-	$(AM_V_at)$(MKDIR_P) tools
-	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
-
 $(lib_libbluetooth_la_OBJECTS): $(local_headers)
 
 lib/bluetooth/%.h: lib/%.h
diff --git a/tools/hid2hci.rules b/tools/97-hid2hci.rules
similarity index 100%
rename from tools/hid2hci.rules
rename to tools/97-hid2hci.rules

-- 
2.43.1

