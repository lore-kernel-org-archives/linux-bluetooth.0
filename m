Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62C38C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=vEP7cplVqquVy/UOniSq2Vp85MsYE755mh6uPQAqt62K2xIbyN3GJSzr2UB3kxd19PIuh0hojRnUjbggIC3Swa86g3qR0lvhJWh7hTcjUbjtiHf/1nQr1pvXQpKAXuizbN2vpE4TGzRq1wa59Wv3+G1sbCX1roznAsYqZYobP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=jAEahC6aEhwGsx03XeCGs0r51Ila42pXjrHeGrsvCtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMKjriNaYRThgSWgltxQHSiqlSJjnmwvForP41miwo3MgCxj6xULR+ISht59fBvWhHwY+2UHUquHF6HDyYYdhvtdNeAW/R7eaECOV3sGXPH+NAOUqABFqWWA5aIfMlgYXnQZVASmpwQA/taUZc/mzkVU8EtOu6x7uaTKF8FrXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpAn5Z+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpAn5Z+D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B9E0C433B1;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=jAEahC6aEhwGsx03XeCGs0r51Ila42pXjrHeGrsvCtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qpAn5Z+DbOd8P1iHF/tc316/IXFisRrbo/tHB9lrK/km6WTBekIggJXya/VblKFxK
	 6gKEXfvAFPmuypQtSPp3hiiYXB1lcb+BDf9OTSz89jQi67Jl3kKmk6ZdH6U0hmvXlK
	 lwIn2jBFarQUG8jkkulAf2/q4GX1ykPg8Mt/wWD752289CqKa5rL3CbS3ebLZbmStj
	 QnW8s1qFpuZnNe4ndo8PfvZ+i/DDn+UurSSZnMSPw9v5oIntmaBELHwkNDcw+qF/Go
	 CLDa+GwXVMfvqtChbcwn1VYEuJMUFzPwUtyIHP796tjs71x9guKkVEYDBgFo0mJO+4
	 4dpAGiu/PIlqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68189C48286;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:31 +0000
Subject: [PATCH BlueZ v3 6/8] bluetoothd: don't export internal API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-6-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=1034;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=oJMu/7JQ1+IQo+7iiJJvhOj5+NWG/IUCz9D6MPY+H5E=;
 b=gqoFk2vwm70LpS2pC9QJH75kEM3NxbTIZ63sgK1kmGy8o1KYGJBUdvV7TSpU2mVkhjacaZfIw
 CZLlNz79mG3C7O67OgjRegHIEjZ+tlvivofPTx7n18hwMKW+Ksv6+eq
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

