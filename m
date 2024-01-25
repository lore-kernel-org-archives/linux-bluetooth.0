Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443D7FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=hggfsj0ry/WjBkBvoODEteVp+QQwYvK0kUSVbSky7MSVl22wEAChx7O2XRRuI4MTEzJgeQ3RhhaXY/yytjsFxCR0g8IxteJHAEgPWdTUq+YDPDuGb9DkTEOG0fWwVpq3BfRJyo6NCgN8STR7hOxOGe4NdD+xJfmUbwGygTg8KWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=mb3vibSeCho7dxgk/hsygvpcHcp9zzLKyD4RpuB1Dx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbpxzUyxsw+LFrNidmoTI8frNAvdoCRhDKYthnvFtcDJYnhZCScs/VwDC6Rup41wY0GcQZyjMhC2l5qLzm0ddt2cDHZMFh+Edu2eEWxBf+gyu2ZI88vlSUBQ+EtHPvZ9VAh/C7NOhJg1IHsSIrhjC3XmDBqg73ZOJZ7RS1Q6pvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJFb358M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJFb358M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F90BC433B2;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=mb3vibSeCho7dxgk/hsygvpcHcp9zzLKyD4RpuB1Dx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rJFb358MzAw5LZ67Gm+tYneIvcCoDvCRCRy/QdV+iJTsfe0YaUQLvZa7YloIuEQXL
	 V3CJcfhNWZTbDcMwfQIZRAhnpIO0Qjv9hLyqFuL7ZECdwQowoBWoKAPH9DlygdBqz/
	 suxCr5wp9PVkpTx1UAVPtL9akZUUFhK5gAt5VDwpNTbWJ/3Aa5p6/IIcjDIvBVlxaH
	 gqKKRo111rGm4iBmQEcWuLiQCzXsi4olReWBzRz7KcpK9UpGijsKRg6X4sHifbJokA
	 thXEyLGuf881VhoW234eP3smjdcSZ1Ymz8atAkqBm6p1jprXVdDYQ7Nj5Q1EOtLJom
	 n5V0UCjPEBzsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A1C47E49;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Thu, 25 Jan 2024 00:07:33 +0000
Subject: [PATCH BlueZ v3 8/8] android: export only (android) entrypoint
 from the modules
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-rm-ext-plugins-v3-8-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=3016;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=A9wt+5pbCxd+p0NIbARFNH3H5ujiQXTs0z8giNMkb3Y=;
 b=/aEvjGs3MbYixjLOan9wWHGqwyPZWWCZK59mBHKklNkQ5PYGLAlkoCB4NKv7P+fayVcjuXLYp
 PAWOS9I/kbvBH54JomfS9UfDqU1y7LBVAgRtWiLL4eDfiWL/x3R/AXH
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

