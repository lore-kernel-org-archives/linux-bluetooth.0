Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E21487F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125071; cv=none; b=aBYnIJZTNFrJUoZqoZ6J3p+N/zX/hatOljS0p7Va3U1fe3l70M1Wh3EYxH4PLlC5Z0XzOP95jJXP3msFFE4T7XaYGrW9cGdN87uPh8GYHH8ZSi2n54+Z8WRqU7VsuHDjeeUyV7yqkdtkRF2REFT/p7bTpNqvEHIUj97y5CunFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125071; c=relaxed/simple;
	bh=wTeEOGljoPPj7bt8lABFwyXE4QmvoGZuG1M0zlwMhsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=hYdwqVHOmArM3nF9LiiOY6nX3yAf11IwVbAtpP9ue7+q/xQQ21XAj+ctb3gDvxMRSjC/i/le68bkaTxDdt+OflNA9z7ByVugj1W/oE9MD4kgQqWp5xJj6/+CCGOlwCDMLwB2z6wXwPOgTkCWruBAlBk1nWNANaLVhmOQlA92NuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuXO+hT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuXO+hT8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13D18C43399
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125071;
	bh=wTeEOGljoPPj7bt8lABFwyXE4QmvoGZuG1M0zlwMhsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Reply-To:From;
	b=OuXO+hT8iRHyJYJTfyzUZTbeeJbFjK3w5U+xb/8ZfMT2aOjJCWNXWZGs04opH9jtr
	 mFMM3OYNHbKNRKLY8m8AliIe8T6zvzLwMa9DRrIyKkC8e9J7cRQz38kM7Gt3SgFj7v
	 h9jhndMA3H6zCITQGWU8yo5ZaraoZidH5iD0UM5sliRE+addrZx6uHwUcKWqMDBoBn
	 PYAw6bEFncW3hC7Fu0PV0nyD/Kd7Q4NeATR1ZrYXC6i3cmxVz+gyt/dHKrWpNkF4JO
	 mapz6By2KM076hSRqoWKBjsnsZJcebfKL+R/OPY7jUtF+PCobb9hLmQ3xfHn+dLNm1
	 G8EKqtRXEYD0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B2CC5475B
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 23:11:11 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Fri, 16 Feb 2024 23:11:08 +0000
Subject: [PATCH BlueZ v2 04/10] build: drop %.rules make rule
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-hook-fixup-v2-4-a6b192d1a6ad@gmail.com>
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708125068; l=1456;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=UEsIY+CXqI3XPUWceLYP33aIBNlVaH7L0YL+lTKbmps=;
 b=frTCv+KyKE2uUC+/vkrALuwfcbAYu6WVyB01rUlxWmdIvbryX+PkdSFNkCOwij/XiffbmSXWf
 ++ssiyBQkY0AI+L7VPcNmz51LXJtOURVA+rbTJUpElgxstT8AGsumVw
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.l.velikov@gmail.com>

There's a single file, so we can drop the makefile rule and rename it
accordingly.
---
 .gitignore                                | 2 +-
 Makefile.am                               | 8 +-------
 tools/{hid2hci.rules => 97-hid2hci.rules} | 0
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index c5d7f90ab..a5954658a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -37,7 +37,7 @@ lib/bluez.pc
 lib/bluetooth
 src/builtin.h
 src/bluetoothd
-tools/97-hid2hci.rules
+tools/hid2hci.rules
 
 profiles/cups/bluetooth
 profiles/iap/iapd
diff --git a/Makefile.am b/Makefile.am
index 5717c3dac..2d43493aa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -429,11 +429,9 @@ if HID2HCI
 rulesdir = $(UDEV_DIR)/rules.d
 
 rules_DATA = tools/97-hid2hci.rules
-
-CLEANFILES += $(rules_DATA)
 endif
 
-EXTRA_DIST += tools/hid2hci.rules
+EXTRA_DIST += tools/97-hid2hci.rules
 
 if TEST
 testdir = $(pkglibdir)/test
@@ -758,10 +756,6 @@ endif
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

