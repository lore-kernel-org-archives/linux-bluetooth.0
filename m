Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C777102
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456711; cv=none; b=E8NsNrYCNz4I062mEslfEk8DFBRAZuJjFyKF+EKVOrTAbmDwUVgL3FOOBVfwZyUydmNfUMLiQth1nA3PT8AP3ISHQGp8JkLfvhvrl96N+WVLqH6VzxKZkohhuklu0LyW+6q2ysdIeZ1iCMM1TmBnMWvFzsXq/jXPOx//Aq0I6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456711; c=relaxed/simple;
	bh=hZ3k6IhVwbAMwETSWrCgQChEpyGJItNMFuVpAL2vRoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCy+FaiGUlzhuz7tpUAcXV/QCY13vE+lUGrI098cZXyCzRP8NDfq+jab5n8aIk9HPcwI+N68e+XjLyxNe3SmoeWk7XoYjcH96KBk9sSGTLNB9hDHPT8+ZZ3Z7S28qQqkvBhAp7SevN67yoTU6drqH+pbnX0t1zo/aCRwYRZ2tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQKb3CZN; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQKb3CZN"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b24d969db1so412178137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2025 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736456707; x=1737061507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x97iKxItj8yWosP9nORRFm3AkK0S7fZ7AX5vPPpEdkQ=;
        b=aQKb3CZN5WK2D9/hcqMoUjcYNm6yBrJ+H17xjBlEF66edSPILgESMyY2lMeK7S7X3A
         21hfSaRzBlaQp9l3J5/OTMBI2H1EofsNAepV4AU3L1d4diN2DmuqLCpzH8oZguAO5wnr
         ydhDuBgBQLz0Fl6jEGqBJAfWi9SsT6DXwVHtuhlThi7IyjeZ4uAQy91Mf7MFXSkHZH2z
         2ojaFDlRBv7pSAwpCQHBrjngNhCrh9r7GoCzTK/kWrx6zWV336vsw/ha3Ste08M1sXNj
         vlrUp0z5FxCclZSgd7209XNYfHynBJtMAVVMLDn5p6gBVnpv+QIdfWRcfY5G1PIQ6E+i
         o46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456707; x=1737061507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x97iKxItj8yWosP9nORRFm3AkK0S7fZ7AX5vPPpEdkQ=;
        b=Trc36Rkd9Ao/HcN/GZ7QSNHz1COk7t6S5iPioWDZs3P+7BI3LaBOOsUF7OBZ5dVwXJ
         uD6hh0L996uBz0tiBYm8pdTNjILqTH8m8NTIIwo7Kamvcm/pXRLTWEBhDK1ty4Fb2lTV
         ceob7KL34xKW87MiMuzZd9Ck83DBBRCQ2HHfL3KbyqHXKbfbrl9pWCB1AAZfuRiTwJul
         /JJgQelNcLQjvrOffiYFfcwz2RGMwJJ+QgaOstgQ0LEMO0qSs3FV6bVYG51LUsddQXDM
         7AFhHZfTKjYXKZ4OPj02LJcHVjgdtTzULqtsOouFqF6Uv0QWsVY46legLgFxBECo9EyY
         4CdQ==
X-Gm-Message-State: AOJu0YyTiv2TBckMo2FgdGDZOG/TLHqFyV3n8/9iuLf/rlsS8sPKWwsR
	ZXVNsAjoLDndqJ8Xb5p/STELIbeo0lfueqYHxbgZmenRRS8OUm1hvvSzuw+t
X-Gm-Gg: ASbGncvht+cHJ9UMr9g4+iELOvVj9jFXl+/qx+b1ZOHrEwfC4at2ilo7NmokW1IshmX
	i8vWfwrGhqFOh8cfkkFIc9tX3PTa3Hsi4NtAautR5/A4EtPHwqo9GVronCvtVfhph/GC/ksDMoD
	y0ESp6eAYZAje6AsB5OBCEiSNEUMYSwmc97C68MYXalQ3m1Uur51bRAyFqQgoNzIvVdcMcw9k1V
	al/5cktZY/ksP3lmQbeJNxdETgDzcoK3dLYUk/P98jeYql80HwTofPXYjg2qoOtZndZGQRuHWQm
	b8erBXOxbWNU4PB3bp+6WJuPoS4A
X-Google-Smtp-Source: AGHT+IFfAj0jxKNqkEn9xrrkZWV4yUGkxJKR7reJBLSR/YNaIZDV/rNOqI9dZt8X7krgJUe3/o5suw==
X-Received: by 2002:a05:6102:a49:b0:4af:f1fb:1c36 with SMTP id ada2fe7eead31-4b3d0f9484emr7936335137.8.1736456706903;
        Thu, 09 Jan 2025 13:05:06 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f86d6fsm1530802137.17.2025.01.09.13.05.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:05:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] build: Fix --disable-a2dp
Date: Thu,  9 Jan 2025 16:05:00 -0500
Message-ID: <20250109210500.2324501-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109210500.2324501-1-luiz.dentz@gmail.com>
References: <20250109210500.2324501-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes --disable-a2dp causing build errors:

/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_init':
/bluez/profiles/audio/transport.c:1742:(.text.transport_a2dp_snk_init+0x49): undefined reference to `source_add_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_destroy':
/bluez/profiles/audio/transport.c:1578:(.text.transport_a2dp_src_destroy+0x14): undefined reference to `avdtp_unref'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_src_destroy':
/bluez/profiles/audio/transport.c:1588:(.text.transport_a2dp_src_destroy+0x29): undefined reference to `sink_remove_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_get_stream':
/bluez/profiles/audio/transport.c:397:(.text.transport_a2dp_get_stream+0x1a): undefined reference to `a2dp_sep_get_stream'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_cancel':
/bluez/profiles/audio/transport.c:586:(.text.transport_a2dp_cancel+0xc): undefined reference to `a2dp_cancel'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_remove_owner':
/bluez/profiles/audio/transport.c:602:(.text.transport_a2dp_remove_owner+0x34): undefined reference to `a2dp_cancel'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_src_init':
/bluez/profiles/audio/transport.c:1725:(.text.transport_a2dp_src_init+0x49): undefined reference to `sink_add_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_destroy':
/bluez/profiles/audio/transport.c:1578:(.text.transport_a2dp_snk_destroy+0x14): undefined reference to `avdtp_unref'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_destroy':
/bluez/profiles/audio/transport.c:1598:(.text.transport_a2dp_snk_destroy+0x29): undefined reference to `source_remove_state_cb'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_suspend':
/bluez/profiles/audio/transport.c:438:(.text.transport_a2dp_suspend+0x79): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: /bluez/profiles/audio/transport.c:433:(.text.transport_a2dp_suspend+0x5a): undefined reference to `a2dp_suspend'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `a2dp_suspend_complete':
/bluez/profiles/audio/transport.c:415:(.text.a2dp_suspend_complete+0x47): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_resume':
/bluez/profiles/audio/transport.c:555:(.text.transport_a2dp_resume+0x4d): undefined reference to `a2dp_sep_lock'
/usr/bin/ld: /bluez/profiles/audio/transport.c:550:(.text.transport_a2dp_resume+0x76): undefined reference to `a2dp_resume'
/usr/bin/ld: /bluez/profiles/audio/transport.c:558:(.text.transport_a2dp_resume+0xa2): undefined reference to `a2dp_resume'
/usr/bin/ld: /bluez/profiles/audio/transport.c:544:(.text.transport_a2dp_resume+0xd5): undefined reference to `a2dp_avdtp_get'
/usr/bin/ld: /bluez/profiles/audio/transport.c:561:(.text.transport_a2dp_resume+0xf8): undefined reference to `a2dp_sep_unlock'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_get_stream':
/bluez/profiles/audio/transport.c:397:(.text.a2dp_resume_complete+0x82): undefined reference to `a2dp_sep_get_stream'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `a2dp_resume_complete':
/bluez/profiles/audio/transport.c:508:(.text.a2dp_resume_complete+0xcc): undefined reference to `avdtp_stream_get_transport'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `transport_a2dp_snk_set_delay':
/bluez/profiles/audio/transport.c:659:(.text.transport_a2dp_snk_set_delay+0x95): undefined reference to `a2dp_avdtp_get'
/usr/bin/ld: /bluez/profiles/audio/transport.c:676:(.text.transport_a2dp_snk_set_delay+0x52): undefined reference to `avdtp_delay_report'
/usr/bin/ld: profiles/audio/bluetoothd-transport.o: in function `delay_reporting_exists':
/bluez/profiles/audio/transport.c:1000:(.text.delay_reporting_exists+0x19): undefined reference to `avdtp_stream_has_delay_reporting'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6378: src/bluetoothd] Error 1
make: *** [Makefile:4696: all] Error 2
---
 configure.ac               |  3 +++
 profiles/audio/transport.c | 21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 964206bf17f0..69a54ae586d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -176,6 +176,9 @@ AM_CONDITIONAL(SAP, test "${enable_sap}" = "yes")
 AC_ARG_ENABLE(a2dp, AS_HELP_STRING([--disable-a2dp],
 		[disable A2DP profile]), [enable_a2dp=${enableval}])
 AM_CONDITIONAL(A2DP, test "${enable_a2dp}" != "no")
+if test "${enable_a2dp}" != "no"; then
+	AC_DEFINE(HAVE_A2DP, 1, [Define to 1 if you have A2DP support.])
+fi
 
 AC_ARG_ENABLE(avrcp, AS_HELP_STRING([--disable-avrcp],
 		[disable AVRCP profile]), [enable_avrcp=${enableval}])
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 1b9c66e4940d..ad0df7238fcc 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -38,13 +38,16 @@
 #include "src/shared/bass.h"
 #include "src/shared/io.h"
 
-#include "asha.h"
+#ifdef HAVE_A2DP
 #include "avdtp.h"
-#include "media.h"
-#include "transport.h"
 #include "a2dp.h"
 #include "sink.h"
 #include "source.h"
+#endif
+
+#include "asha.h"
+#include "media.h"
+#include "transport.h"
 #include "avrcp.h"
 #include "bass.h"
 
@@ -387,6 +390,7 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 	return TRUE;
 }
 
+#ifdef HAVE_A2DP
 static void *transport_a2dp_get_stream(struct media_transport *transport)
 {
 	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
@@ -675,6 +679,7 @@ static int transport_a2dp_snk_set_delay(struct media_transport *transport,
 
 	return avdtp_delay_report(a2dp->session, stream, delay);
 }
+#endif /* HAVE_A2DP */
 
 static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
@@ -987,6 +992,7 @@ static gboolean get_state(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+#ifdef HAVE_A2DP
 static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 							void *data)
 {
@@ -1067,6 +1073,7 @@ static void set_delay_report(const GDBusPropertyTable *property,
 
 	g_dbus_pending_property_success(id);
 }
+#endif /* HAVE_A2DP */
 
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
@@ -1197,6 +1204,7 @@ static const GDBusMethodTable transport_methods[] = {
 	{ },
 };
 
+#ifdef HAVE_A2DP
 static const GDBusPropertyTable transport_a2dp_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
@@ -1210,6 +1218,7 @@ static const GDBusPropertyTable transport_a2dp_properties[] = {
 				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
+#endif /* HAVE_A2DP */
 
 static void append_io_qos(DBusMessageIter *dict, struct bt_bap_io_qos *qos)
 {
@@ -1570,6 +1579,7 @@ static const GDBusPropertyTable transport_asha_properties[] = {
 	{ }
 };
 
+#ifdef HAVE_A2DP
 static void transport_a2dp_destroy(void *data)
 {
 	struct a2dp_transport *a2dp = data;
@@ -1599,6 +1609,7 @@ static void transport_a2dp_snk_destroy(void *data)
 
 	transport_a2dp_destroy(data);
 }
+#endif /* HAVE_A2DP */
 
 static void media_transport_free(void *data)
 {
@@ -1684,6 +1695,7 @@ static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+#ifdef HAVE_A2DP
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
@@ -1744,6 +1756,7 @@ static void *transport_a2dp_snk_init(struct media_transport *transport,
 
 	return a2dp;
 }
+#endif /* HAVE_A2DP */
 
 static void bap_enable_complete(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
@@ -2410,6 +2423,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
+#ifdef HAVE_A2DP
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
 #ifdef HAVE_AVRCP
 			transport_a2dp_src_set_volume,
@@ -2426,6 +2440,7 @@ static const struct media_transport_ops transport_ops[] = {
 #endif
 			transport_a2dp_snk_set_delay,
 			transport_a2dp_snk_destroy),
+#endif /* HAVE_A2DP */
 	BAP_UC_OPS(PAC_SOURCE_UUID),
 	BAP_UC_OPS(PAC_SINK_UUID),
 	BAP_BC_OPS(BCAA_SERVICE_UUID),
-- 
2.47.1

