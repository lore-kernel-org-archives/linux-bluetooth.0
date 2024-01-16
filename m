Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC21BDFB
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K252JN5p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7804C43399;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414737;
	bh=0Vb7kTdb0A76WHAp/STXf4r8mTrR6YGCiQsMYcyhpGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K252JN5pHmW3A2bQowESKprsg9DWLHFas9hyW4dcbQiBXqJi6Nckf5c03O5l+oM2V
	 8WfX5WL1HhfzllIjc37OFFyJmA1BbXpFqOWcDAPSO3FzpVdPNKvBw8TXanyOe+R6h+
	 F+X71W7dbkgiNHVw5zdEFduHoKcStiza4dMN3YCjnwGqG1wQqM8fv+gGAtemCIyUXz
	 cbzyg4euBsBa7LlQIjLi5iWy5mMmMiYTqq3eCEiW++TOMAoCdnq5WGwPEkSDrUDrgK
	 PjDI4SYKBfPIk8Qq9toDJHrqQYiFs9a77Y99oqvdDJV8wWFU+a47svP+nnsY0NRH82
	 idA5I2CdlKybg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B9C47DAF;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:18:56 +0000
Subject: [PATCH BlueZ 4/8] plugins: convert external sixaxis plugin to
 builtin
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-rm-ext-plugins-v1-4-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414735; l=1153;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=gF+1Vm3aKqaYd0ZkTF025smVpJMgkegfcG+hjjFJXCw=;
 b=kUynQFZnYf9MuFjN5dSFlklE/VFaOmgdGXGCWRH1Z4I4pirgmg2Noaf+g0QjP3ytTAm/S5dJz
 kFqfy1Z5LoAD3O/+OhKY1e2RZIE1SMGdpqrXYCYIOSdmKwCnttfalJO
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Sixaxis plugin is the only external one. It's a tiny 20K binary that
distros ship a separate package for.

Make it a builtin, which allows distros to drop the separate package, it
also enables us to remove support for external modules - both in terms
of extra code and hide the internal bluetoothd API.

This means that libudev.so is pulled in, which is fine since its ABI has
been stable for over a decade.
---
 Makefile.plugins | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 5880ed0df..7cf66fd59 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -110,11 +110,9 @@ builtin_modules += battery
 builtin_sources += profiles/battery/battery.c
 
 if SIXAXIS
-plugin_LTLIBRARIES += plugins/sixaxis.la
-plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
-plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
-plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
-plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
+builtin_modules += sixaxis
+builtin_sources += plugins/sixaxis.c
+builtin_ldadd += $(UDEV_LIBS)
 endif
 
 if BAP

-- 
2.43.0

