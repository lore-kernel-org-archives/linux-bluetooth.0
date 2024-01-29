Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83019152DFC
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=ljos/ljdAsnZcXoj+NxB6TfxYUgVzMRuSQFAHleue92gcYLDinFyhb4tpS13etv7c532moJeOGyrheMZvDT98KiIdlKGnOSFkPosSryc/K1m+F/UhfPh+pKkD98wBpRjVgLLZjZuyLK/gTd5TOjtGzwF3PgudDJHgHJk/G+RvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=Qzw6fgFGlrKG70QEp7wKH52CmWymYEBdfMM/XdHZ8hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6KLB8h7mVtrUukETh6pXefQC+K2Spn9BLOCQ2Yc1071bm/aARvcjz2QKqCnqCBb3CW4dxnerOzvizHGNKIzKlzci9Ft22z6pwTM3jKPOpZy8t5Q0cd0UK+eIy6GIp10v9BsuWybnCQR3q+u2V2GyY+lyq0zYYsvJnr+8+iIu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNITHlbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNITHlbG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 109D5C433B2;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539457;
	bh=Qzw6fgFGlrKG70QEp7wKH52CmWymYEBdfMM/XdHZ8hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gNITHlbGiTdCPrrOk9yVI5olgTZjL4tXhCtcwqSQ8jVs/JsuXnQ5vwzUFqIPdrPLH
	 pYMLZqrTBVQWmH9dJKRe9AHnGMy2MfWUmfTpQhsIBaKNyTgVJ5jdF5vJaTVc5BOumO
	 7uGJ4x/Zt1S6IPgKJKboQKYAlNuekYmSo1bxWq2doJEYn7gbf34du1K2/JeqDZS2Ew
	 9Axh0Le92tEjY1sU3Q3EE08d/m3s/BmbaIzjx7jd2XTQj6ekeGx46Wpr/15uG0WTdN
	 B81uX9ypYnc5v1H/bbfpRWcqpJP0qGrrYYwtTSLupFj17DmjTvJyBt5vLCHMEmFJw7
	 ko4ES4oQUtLMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27A6C47DB3;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:20 +0000
Subject: [PATCH BlueZ v4 6/8] bluetoothd: don't export internal API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-6-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=1054;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=IzZa7BlZN0VGepZt+klnK6SKKS7pzNjz9SN5DmTUpUs=;
 b=FkuQqYebrVC3b9/ftLnlmF9PMnQDHOMAKSIc87QoJM2RED78ClpGc+9WOTf1J3hgEvSBTs2FN
 l42ytNeTFhJBhAonQLcyM3MPlHnqgUP+OB2hBhw0ZzwHJbz4WKooeYZ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

... when building without external plugins.
---
 Makefile.am | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2d5650ced..2b1b9acdf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -289,7 +289,6 @@ pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
-			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
@@ -321,8 +320,12 @@ src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt \
 			$(builtin_ldadd)
+
+if EXTERNAL_PLUGINS
+src_bluetoothd_SOURCES += src/bluetooth.ver
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
+endif
 
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\" \

-- 
2.43.0

