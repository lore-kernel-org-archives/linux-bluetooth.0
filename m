Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60668211293
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527501; cv=none; b=fuW9IxoUYaC8tyJHrwp977EmfRXbXI2Dt459cd+UJz6XVbj81gHs4Fpuy50jLW9JNihp1DUa5zDD5fFgELJSQHshcxRwwNQROW4lD/5Dy/y36yKzNNJDzFmtraKaq2hf0BQbexcJBcCCCtMFzZQS9FsMADWyuRNx6JftrT+TbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527501; c=relaxed/simple;
	bh=5OQR+EX0KhVwFV0HzlJFKWmVijB6WNp4k4IlXD9owLI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QnfMI6sh/e6LemUN/kQvX6Q52Yz1j4v7i5jZJVB3kMaiidZ6xArhJDkV7k9IWa46Wvh/jRg0qydXrWaUieiLXkkDr5XbSOkurY4kKef1fiSVVMem4I45HGN8KvwMd0nGbk2TPDUU6W9vVUJmqCRxOpVb0fFQnq1qodJ7824XtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbITpd0n; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbITpd0n"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85b95896cefso612777241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736527496; x=1737132296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AWKmm6xf7TFu+ToPDoIQVCEShJ7ZzVdTIXVA1sA5QU=;
        b=MbITpd0nCjoZmrCywttYSGx5Gg034242I5k9jxW+KIkWv3fLj/3O6SDq4pzMhoYNaf
         xKhb3VmFe1LWZoTZVKtNrsMy5+BCf2721Upf/SQ1CEcptenAUltfy9kMs4aFlyFagAjt
         zjKoNFtgiEI+2VQcr2EomOpREONaielP6c25skDAdLrfZVdR6eEPESoh75BIPI/A4Cwi
         AUrMqB7ueov8QssqatHJOtpHimnp/2AMsBO/251gvvypls1Y7ZYeOXKcliajvln+FYH9
         OjZ6q9W64QHzgmafwMaTsKfsZC+SHg3wZJqvz3jj45T6uyqhX1EwPbPNBVWVtRjNp5h/
         x+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736527496; x=1737132296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AWKmm6xf7TFu+ToPDoIQVCEShJ7ZzVdTIXVA1sA5QU=;
        b=ZUBNL8lwvMNIpKQzMJmXLhAQobT5l9JXg8UFHbwKP4NjUHpQUK9KEZ9q/a72bsrDkd
         diMeh2ROEtblqIZ/JC13IqEe2929zIZHb97EiugRfq2jhusqOPb9wt1R0oo65ZHCXXJJ
         Sxnb6T0C05HsSLH096GGTLJDUQ5DX2lvCNz+hBItO0sgwPPGPj2wd3aL5dVySc8q9SPr
         fACwfGIWTnvVPEPa4gfumy0FvY49PEKvedkmim1z2Z9B6dWZtPMYdqfJrxiqR2cm7BGf
         qzqM6hX823EceYfZorZkk8feok+iXeOGi1QkCF08DEQHXA4t455+Xau0yz5+R2X+QJMS
         7xTA==
X-Gm-Message-State: AOJu0YwCRG6r9ab0BxjU6HjrxJKoOEi3SC+nDw0d2RnE49U/4+ghwrdr
	GujaMc9Lh3MNVFBA3q0+t0vtG06QMckxKeUWPnn1egXS8hCKVtWDfCqL4BlC
X-Gm-Gg: ASbGncuLd3YrnnutxWTpl8zn8bK0neD30//nk94iS8soAxUWScOYhPj7whaOcsOyEKj
	OZoRAkd64K/4zCneIywTt+FkK6ZyftEUEqI8EgPqzc5/xtmF/kqIcKavw/yMxMFoWYQBczFfzoh
	/xl35IjA/QDkd+UgngxWa/jm8MDnbbxAoTJNxHQhwXjayg3oJcyV9Gi51xMdjgYy2Egmy2qSr4k
	+Gi+dFFYrPcM5Sq+Be8sXU82c1vZsKeY8b+01U7IRooYm7vJhMiCXDaqr4jjlSASDCvIWvkrG6o
	WgRh6KwOLPvrjEVA3nhnB62iWbZs
X-Google-Smtp-Source: AGHT+IFnVop9w0ezLi4VFb876f2v2vCRrjiect0i/hfT04uDlStml6QwoDsliPz1NIxnzuwBwQYFlQ==
X-Received: by 2002:a05:6102:6e88:b0:4b4:27dc:ffde with SMTP id ada2fe7eead31-4b427dd00e7mr8093972137.22.1736527496536;
        Fri, 10 Jan 2025 08:44:56 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623157902esm2986295241.32.2025.01.10.08.44.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:44:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Fix --disable-asha
Date: Fri, 10 Jan 2025 11:44:54 -0500
Message-ID: <20250110164454.2660347-1-luiz.dentz@gmail.com>
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

