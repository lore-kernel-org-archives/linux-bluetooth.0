Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970A1BF24
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDbTe6RE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0301C433B2;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414737;
	bh=VOUgU+W9sQouYjhtj03LinlC9rIyPBaoSzF3Oj3T5G8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NDbTe6REztrpZn/IsDukGwIqYQvzvqVnlpvERp4V2e9HsTsMJ5lrYpgN9RMoOpFJw
	 rhVoVRm87KV+ccYy7jz/K7WLBz9lT/mECjUBr8Tc0ureBkg2AoZsjQ/pEW2jwRuPCl
	 bkw4hkqw1zSg+evepwIglZyTqS4InSFSl2tren1myLmTcW8AthHlvO2iRLggNiegG/
	 +Ex2P1XZkZiXrgL12JjFVvB8EKu4Y1ArEcYv2iB99VpW//f0dgJIWItIVGzGuB+hL4
	 soCdUlyw/7pugdAZSaYc8rhZM0KfM8TBTYrK7WAwcPGdOWIsz/cTKNWwTNx7nhhaUA
	 mkciVOUIqGr9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB69C47DA9;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:18:59 +0000
Subject: [PATCH BlueZ 7/8] bluetoothd: don't export internal API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-rm-ext-plugins-v1-7-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414735; l=1432;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=U5NIyzd+tGCF6EHhbw0tLLdXoVXk3Dye+U0qia+JOu0=;
 b=o8nMbPxFFidp1At3vvsR198xYOmPY5IXSPve88wvXLaP0h98s/bXrMjLtl5lygPNb2tQsW/kO
 TiN1eE5NS2MBOASDJQtntpvaSXSTAnaBdArXQnmQSogYvWJaDfc97W3
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

With the final external plugin gone, we can keep the API internal.
---
 Makefile.am       |  3 ---
 src/bluetooth.ver | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4db3a2953..c421f53c4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -291,7 +291,6 @@ pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
-			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
@@ -323,8 +322,6 @@ src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(BACKTRACE_LIBS) $(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt \
 			$(builtin_ldadd)
-src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
-				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 				gdbus/libgdbus-internal.la \
diff --git a/src/bluetooth.ver b/src/bluetooth.ver
deleted file mode 100644
index a96fda2a1..000000000
--- a/src/bluetooth.ver
+++ /dev/null
@@ -1,20 +0,0 @@
-{
-	global:
-		btd_*;
-		g_dbus_*;
-		info;
-		error;
-		debug;
-		baswap;
-		ba2str;
-		/* Don't break LLVM sanitizers */
-		__asan*;
-		__dfsan*;
-		__lsan*;
-		__msan*;
-		__sanitizer*;
-		__tsan*;
-		__ubsan*;
-	local:
-		*;
-};

-- 
2.43.0

