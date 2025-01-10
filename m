Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFD2063E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524299; cv=none; b=oXEOn8DQqFc6+iWT6dRBsu/jUKBV+x669a3igabwWyWClntfQf7xpjsxfsgB4ZX6m/gJnHL2dQevCcTSt/TEvYca0XEe2vO4bhm/X7vQNCK1hSviWaVqrsr1x5HPciZDy4e/Bx8l+m3odYBwkMevzR+bw7ed/budt5QlnkZOilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524299; c=relaxed/simple;
	bh=5OQR+EX0KhVwFV0HzlJFKWmVijB6WNp4k4IlXD9owLI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Hc2T6k1gM2gN4I5e80dNC4NuIbAcrLYXNGOhhMRDH2AZ5uRC9me5j7SitjqIQ6VnfS/XerU5O+9iXDXDtSpKlkE9Mm3WPA1j2eu45/T9+U3b6rrCpV7KHnMTtBgHsO0tXe9faJ75gR3yX8OvvZO/2/0Q9g8NS960SqmkpPpo7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1HGkKG+; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1HGkKG+"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-518c46cc6e4so644288e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736524295; x=1737129095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AWKmm6xf7TFu+ToPDoIQVCEShJ7ZzVdTIXVA1sA5QU=;
        b=j1HGkKG+fIJNxmgMI+rrNa7+PQ5XWwFEyGfY07kJ3MRiju0tKI3RPQtWteTCpUWUf+
         ru3Ozj8NC9d12XIJXpWhL5bT+vhJHaUfyaAmbj9n5BnnXMWlbH+YrxzmtTTgG8puHY6n
         H2gww9FEVjnDSG0O4KD6PmrJ7M+C3KAJCyAgrTvdJG72DqBG2Wh6M3/ep1rCOBnn+ofh
         o5uMqOJYda9ZWK4veeirdbMjFul8rr+SmMVCFNpqA7NocJgviRux8p1ir6QxCIFyJ6GW
         BOg+lULKbRLjkgWmjwlSK7oA/H/wnhK+6nzUNLlDNU83uS6+UAJSrAd+U6+aCKDVV/3c
         ow1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524296; x=1737129096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AWKmm6xf7TFu+ToPDoIQVCEShJ7ZzVdTIXVA1sA5QU=;
        b=Z7ycHI45Qu/r/+VkZAf0IaPaC6xWki0L3eY1sVI1X6Ydiq7BUQ2cV/sq4Db6TgKP3M
         C8rBpHGlDu7oeVb88SSpCI08ugRSx9wfAC/c1HBwZTGwD7c+VITtHLpzJ/8tIsYLrCf4
         wlL00WjAShI1HblkVvFE7+4BJiJTbqnhKgZzMmFUIhYZCjl5EXuEsHv4JVc57Sg4LIWg
         jGxQrWE4QEk3cM6iGyQiZuEpyeeIXgpRCMIa/fax8fCwWWZu5aiwseECPcwJl9YogmO9
         +mr4dGPbxUalso2RhW68Y/g7dF7y3l3u/Lw9ikRmQkQDKUXEwm9Y+B7qiPRBUxIxA+hK
         +A7w==
X-Gm-Message-State: AOJu0YyYl9gofSfoJZU3B+VMB17/O4O4CORptjsSjBvwCVM1JKdUfpQf
	Om/SxdJgt0y1l718uqQkVJc1G0aj2JkvzxsdhDFsZyIIzvRcosws+zeQRpfL
X-Gm-Gg: ASbGncstNMAjb2DUl8aFBaoAHk5eelqAYWhTWLCIrG6ryn/B8nXeqy5mWdnvD/6YEJD
	NSunANZkx8SCELAsqa63mxOXYsrOsEz1oiBTW74YPV9dBXOHDU6tQxa7mJHFTxOdO5CJDXF8xeA
	VAh+TYsmjTxbO5QbmZ+cKEjUQr0Lb+vqlIgNAiVXX+zJk0kHU5MGZagqiCsFGTUfJX5DpqkEiaH
	+AmiKdTwIQHcN516ModxpZanEnDOEVyQDV2VAmMAoPlXR72/ne+imaYZ7FhPt2COhg8AchQyecP
	xtPW+bl4+8p8xvoDozVPye3CO9bm
X-Google-Smtp-Source: AGHT+IHfJOxwNKjiSuxBcqi7iDwOqSKagNVKkHDIr+2hYMmBaMRhvTEyerzL3eKpPiw14+l76QYfQg==
X-Received: by 2002:a05:6122:50b:b0:518:773b:39f with SMTP id 71dfb90a1353d-51c6c46d0dbmr9658878e0c.4.1736524295586;
        Fri, 10 Jan 2025 07:51:35 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fd03b23sm2273811e0c.40.2025.01.10.07.51.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:51:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Fix --disable-asha
Date: Fri, 10 Jan 2025 10:51:32 -0500
Message-ID: <20250110155132.2647060-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes --disable-asha causing build errors:

/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_set_volume':
/bluez/profiles/audio/transport.c:2362:(.text.transport_asha_set_volume+0x2f): undefined reference to `bt_asha_device_set_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_get_volume':
/bluez/profiles/audio/transport.c:2345:(.text.transport_asha_get_volume+0x9): undefined reference to `bt_asha_device_get_volume'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `get_asha_delay':
/bluez/profiles/audio/transport.c:1566:(.text.get_asha_delay+0xd): undefined reference to `bt_asha_device_get_render_delay'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_sync_state':
/bluez/profiles/audio/transport.c:2216:(.text.asha_transport_sync_state+0x8): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `asha_transport_state_cb':
/bluez/profiles/audio/transport.c:2245:(.text.asha_transport_state_cb+0x1d): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2252:(.text.asha_transport_state_cb+0x94): undefined reference to `bt_asha_device_get_fd'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2253:(.text.asha_transport_state_cb+0xa0): undefined reference to `bt_asha_device_get_imtu'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2254:(.text.asha_transport_state_cb+0xad): undefined reference to `bt_asha_device_get_omtu'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_resume':
/bluez/profiles/audio/transport.c:2290:(.text.transport_asha_resume+0x19): undefined reference to `bt_asha_device_start'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_suspend':
/bluez/profiles/audio/transport.c:2303:(.text.transport_asha_suspend+0x1e): undefined reference to `bt_asha_device_stop'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2307:(.text.transport_asha_suspend+0x48): undefined reference to `bt_asha_device_stop'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_asha_cancel':
/bluez/profiles/audio/transport.c:2318:(.text.transport_asha_cancel+0x17): undefined reference to `bt_asha_device_get_state'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2320:(.text.transport_asha_cancel+0x22): undefined reference to `bt_asha_device_device_get_resume_id'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2334:(.text.transport_asha_cancel+0x61): undefined reference to `bt_asha_device_state_reset'
/usr/bin/ld: /bluez/profiles/audio/transport.c:2328:(.text.transport_asha_cancel+0x81): undefined reference to `bt_asha_device_stop'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6378: src/bluetoothd] Error 1
make: *** [Makefile:4696: all] Error 2
---
 configure.ac               | 3 +++
 profiles/audio/transport.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index 69a54ae586d7..6a19487f622a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -234,6 +234,9 @@ AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
 AC_ARG_ENABLE(asha, AS_HELP_STRING([--disable-asha],
 		[disable ASHA support]), [enable_asha=${enableval}])
 AM_CONDITIONAL(ASHA, test "${enable_asha}" != "no")
+if test "${enable_asha}" != "no"; then
+	AC_DEFINE(HAVE_ASHA, 1, [Define to 1 if you have ASHA support.])
+fi
 
 AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 38051e64d617..a4198d23a390 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -48,7 +48,10 @@
 #endif
 #endif
 
+#ifdef HAVE_ASHA
 #include "asha.h"
+#endif
+
 #include "media.h"
 #include "transport.h"
 #include "bass.h"
@@ -1555,6 +1558,7 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ }
 };
 
+#ifdef HAVE_ASHA
 static gboolean get_asha_delay(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1580,6 +1584,7 @@ static const GDBusPropertyTable transport_asha_properties[] = {
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
 };
+#endif /* HAVE_ASHA */
 
 #ifdef HAVE_A2DP
 static void transport_a2dp_destroy(void *data)
@@ -2210,6 +2215,7 @@ static void *transport_bap_init(struct media_transport *transport, void *stream)
 	return bap;
 }
 
+#ifdef HAVE_ASHA
 static void asha_transport_sync_state(struct media_transport *transport,
 						struct bt_asha_device *asha_dev)
 {
@@ -2367,6 +2373,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 	/* We just store the struct asha_device on the transport */
 	return data;
 }
+#endif /* HAVE_ASHA */
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
@@ -2447,7 +2454,9 @@ static const struct media_transport_ops transport_ops[] = {
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
 	BAP_BC_OPS(BAA_SERVICE_UUID),
+#ifdef HAVE_ASHA
 	ASHA_OPS(ASHA_PROFILE_UUID),
+#endif /* HAVE_ASHA */
 };
 
 static const struct media_transport_ops *
-- 
2.47.1

