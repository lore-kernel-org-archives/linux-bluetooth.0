Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35607E573
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=R9jAu92YCxBMH4QXsHQI60jWUncafBpq79ttHs2y7GtqYVdyMJdiDQ2GJ5LEGRbul3HVu6GvJ6jO575qEj9VOMV69pTrGHwkmcTPZqIYr1HslmzBopr/Sj29e0VfMpO96uzLIwCmIrtDG/fpkuwJzNoFAGVL6Q2MR3lsBZtPGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=jAEahC6aEhwGsx03XeCGs0r51Ila42pXjrHeGrsvCtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgRguZoWq1Rm5vuVEDTsEWoiA/kM9laCGy5Hat+FbeZtS3RmX3yrFv1gCWk9sOn1hSUpEMtgvimrC7CZoD8EyCZHdXUnv0BzYqeksl1Hyk/ze9pVlZaDbgDO4+rdADgEkeifFJXy3qHiJSbvxFAWa/auSaBMH6O061bHTal2unY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/faLm8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/faLm8L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5860EC43141;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=jAEahC6aEhwGsx03XeCGs0r51Ila42pXjrHeGrsvCtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/faLm8L4EpnthSqOCqqxLyhVGrm0mrrsk4AvQO5Ndo40nE3d8AT4uhuzDglfdM1q
	 mGdZ/g+lJLUxN4zGrdfg9f1DlR7R1nUFX1ItaBPNLL7bl4CGAuRy35v+/+QZJQCfNZ
	 6P2gr7BsvkMTF8XyOSxdoyKjQnHZVQV/3st1bR6Wkml1f5NtQeQKTcNycLrzAgoGum
	 /ZKwInx2sr87+CAZsvxblMgOhcpy8mGS4jcLDD755yQxcIfa6HVllAB/tZ6fkOlS1N
	 fvclX08RrUXOw8GgcHu25SkiKvOvTI1mlRh8ot+ik4BWdZApKK9OlPhb8EoGNqa/nC
	 6ZLRi1ZrajC+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A3C48277;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:08:02 +0000
Subject: [PATCH BlueZ v2 6/8] bluetoothd: don't export internal API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-rm-ext-plugins-v2-6-5244906f05ff@gmail.com>
References: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
In-Reply-To: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=1034;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=oJMu/7JQ1+IQo+7iiJJvhOj5+NWG/IUCz9D6MPY+H5E=;
 b=fi+Ga2uBjswJhuLcwfqrNXKN4gTb6++ttuRLheLaIspBr3aooFyjWU9kCOzqEwtQoP8WX8ZYE
 +arFE/3cOj+ChkzgiGgPFjFvRZHWCAAZSk3f93RUlEYlkAbVP17v3Cf
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
index 1b82e8551..b98519e84 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -293,7 +293,6 @@ pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
-			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
@@ -325,8 +324,12 @@ src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt \
 			$(builtin_ldadd)
+
+if EXTERNAL_PLUGINS
+src_bluetoothd_SOURCES += src/bluetooth.ver
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
+endif
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 				gdbus/libgdbus-internal.la \

-- 
2.43.0

