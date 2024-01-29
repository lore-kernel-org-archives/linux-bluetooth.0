Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB8152DF8
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=CKwfRuBdQZta6UZWpRkqq5az5XPdgc+SwPy7m+o7TI383m2znh/9ghQoQ9WyXCKIy9Lt/URwAoCJzyIFZHwD0DXBBGT0sQOKMSqbhiSD6Bdv4JIQoqCiMH5tHOt9ZelcpmyaR1mV9jcHXCw7W5gG/ePi/RMFVbxW63voMLcnoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=mb3vibSeCho7dxgk/hsygvpcHcp9zzLKyD4RpuB1Dx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBasCbcfIr+UXlCAbSsjTsRuxDoUdHj7kPoRAjXiBko1HDR06M6Wc8tPDon7zhmFQwDSiRwnX1vjJaEYJduhYo+fyzCpmLNg/Xp++5JgbUUTJKXH3d0arxqgePOsYwZrVK6XfiYIj8Io+b/du1bb49R7nGig/PqIWjjgaVSO41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hquQLg2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hquQLg2J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22A59C43601;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539457;
	bh=mb3vibSeCho7dxgk/hsygvpcHcp9zzLKyD4RpuB1Dx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hquQLg2J3Xr5ZqIP/iNSdbU8AqopGCuS4Cwmz+02dxdDwiWDxCkf7OpdM+zvVO3SK
	 lGpVPNNj1EnUg2c5OHoVF6G2tpeMBnZXKI181RXyMSiIL6PuBbSJKUTEuXVV7ggftV
	 v4Da3Cf0JtWsszL8QGilbpSzUhwzkMukKoSr88XRncZVtOvf/7wIZEc06DqVuMebb+
	 wwzyARtjRtdGplf8i+YFY9O5O1k6S0oF6h2h9q2Ebali6ivCvhAG+IbBwWIsk/0c6j
	 NAOo4r/3cZwDUsmp4rbnTJ+iEg+BAXo3YkCQUgcvibXMs1HqZPcIria3/wOzetkXL8
	 e34rFOhFoCISw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DC6C47DDB;
	Mon, 29 Jan 2024 14:44:17 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Mon, 29 Jan 2024 14:44:22 +0000
Subject: [PATCH BlueZ v4 8/8] android: export only (android) entrypoint
 from the modules
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-rm-ext-plugins-v4-8-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=3016;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=A9wt+5pbCxd+p0NIbARFNH3H5ujiQXTs0z8giNMkb3Y=;
 b=K76VOkTcnUI3PuCqNvoo+6kvKl0OiLlo1ASE+yYAnkjP5r9Rj//Yh7YSN/e0O+h4rIxOR315X
 gnD3Z6uYd5zCwHWjTq7ONZyMD3J1jzH8lXv82vqReehAVxtDA8bk/WS
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

The android specific modules, have a designated HMI entrypoint. Hide
everything else with -fvisibility=hidden.
---
 android/Makefile.am     | 3 +++
 android/hal-audio.c     | 1 +
 android/hal-bluetooth.c | 1 +
 android/hal-sco.c       | 1 +
 4 files changed, 6 insertions(+)

diff --git a/android/Makefile.am b/android/Makefile.am
index 309910147..e3756e89c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -96,6 +96,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-log.h \
 					android/hal-ipc.h android/hal-ipc.c \
 					android/hal-utils.h android/hal-utils.c
+android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 android_bluetooth_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android
 android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
@@ -195,6 +196,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hardware/audio_effect.h \
 					android/hardware/hardware.h \
 					android/system/audio.h
+android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 android_audio_a2dp_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 					$(SBC_CFLAGS)
 android_audio_a2dp_default_la_LIBADD = $(SBC_LIBS) -lrt
@@ -212,6 +214,7 @@ android_audio_sco_default_la_SOURCES = android/hal-log.h \
 					android/audio_utils/resampler.c \
 					android/audio_utils/resampler.h \
 					android/system/audio.h
+android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 android_audio_sco_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android
 android_audio_sco_default_la_LIBADD = $(SPEEXDSP_LIBS) -lrt
 android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
diff --git a/android/hal-audio.c b/android/hal-audio.c
index d37d6098c..f3d9b40a6 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1618,6 +1618,7 @@ static struct hw_module_methods_t hal_module_methods = {
 	.open = audio_open,
 };
 
+__attribute__ ((visibility("default")))
 struct audio_module HAL_MODULE_INFO_SYM = {
 	.common = {
 		.tag = HARDWARE_MODULE_TAG,
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index d4442e620..7d1e5ac63 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -1117,6 +1117,7 @@ static struct hw_module_methods_t bluetooth_module_methods = {
 	.open = open_bluetooth,
 };
 
+__attribute__ ((visibility("default")))
 struct hw_module_t HAL_MODULE_INFO_SYM = {
 	.tag = HARDWARE_MODULE_TAG,
 	.version_major = 1,
diff --git a/android/hal-sco.c b/android/hal-sco.c
index d7c08a68b..3d66ad357 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1507,6 +1507,7 @@ static struct hw_module_methods_t hal_module_methods = {
 	.open = sco_open,
 };
 
+__attribute__ ((visibility("default")))
 struct audio_module HAL_MODULE_INFO_SYM = {
 	.common = {
 		.tag = HARDWARE_MODULE_TAG,

-- 
2.43.0

