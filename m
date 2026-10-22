Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684050;
	b=oVOwNFZcx7rkyXkVSER4JbeX8GdXQ3y0WKODD+rQZTbX/UWdsZfJUOrujg4ves5ACSy2
	 Fzrfe45XjpQcfrmHgtu0TF4E8VnIKiEDeK6fbMO19XdDfs/FPghkBEYXWjNkDAoAeK9aP
	 9ZjGEBWofkiEvNs3sDfAWJ02xsXij8BRr34sztIlSTHpFYlvpruLGXBrG45GSblOXT30Q
	 CP0eO2/j7A0iMZhODIa9h7c/74N/1WtHCdsVFrXpP0ntf8DyHngdhMTo/HnqVeO5tFMq6
	 7cVrPx/SgER0ilohtBotPURtNXpMUCuamugye3PPAUk10QJ8PCeI8N3pP8VmGAvw5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0fuonw0gAMTId2EhdrffDPRQf9AC1csj8HumJye5ZLw=;
	b=sLxSltZd6MB//bE9FODPZfwcbDV0lE6NDAAhIDJTyAty2RILqtyGtttzKtv1yRSAZ2uH
	 AeyKwhxDpB96yXAkZyqD80+vUqh9yeFBsUpHsz95vemQmIMfUdLFfi7wkqj0tzE4xf5K7
	 BaFYdIlkUN1g/6aDi8DOffwZOjHDt9LpW8EBvOgzyXP9WoUe8tFgvfpZAHMmPZOq21lOc
	 Z3S82BVAXvueg3+/9HZrSBMWqjVVUqKqfNgb2CYnJw+M6lkfFIXbkxHpg0VOIhEMNzUrS
	 3JRGeAPXycTwkxUPwqExYRSosj4PSeEQ47SNXZZydsnXUeDVNIaXRjXw302QcJA6aIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k9IOw68M;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597B606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1597B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k9IOw68M
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eae12762c9so9104e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684049; x=1793288849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0fuonw0gAMTId2EhdrffDPRQf9AC1csj8HumJye5ZLw=;
        b=k9IOw68MxKmJ7Y0+P4jRlfw078lo672OgIP9GMwBaa1Xs4d/WPHFM5TtuDnxgexNH9
         3dVUEMQxF097iHWNeaa+VH7oPsGcKPqEVqPtWjjDDofQu8P/r89oxxgD1hS2UlWG3o5u
         0DOZsdDu9y2ftLtCIgRw9Mnxo3ulDjmpKZ5ZsuKcQp4KX51c26R0+Dt/VuUq5MutAfbS
         uaSwkhX4ByCVF57EeROpVNWQERREo81zB3w8oUUrr9DyVFneFQ54OGL928yehjy5TXo5
         aNLmJsunDTMZEbvgOOXgQ0ff3JkmQjStfzU/NU3GBDA6GYNidjgPR9EdFflUre0INn51
         PozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684049; x=1793288849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0fuonw0gAMTId2EhdrffDPRQf9AC1csj8HumJye5ZLw=;
        b=0U8y7XJwQsPQfS/DEkSXScdiOD62tII47DSjjNAIzP+CyM3G/JXl7tWdOrVTRp0saU
         V1DBqGXGpTFhTa2r4AYxTdyPUKsMpipCxNT65URHRa19C6g4TRisevoa63xqMwzjoWzh
         I9GvYqx8KNvZH2lFjQORQha7gsipNoHh2iIaNyi7xmMpx+wEbVB5x17CPdHXVIA73pBv
         URl6l37NH01r2iKOItg6ObG+UepFyg0MvyYgR2zhBURSae942jh8rqILnJq1SDAVOWgr
         j/sEha55TTFcRz/79CsVpkh1GPyytnumhSG9CubFPWcIS6coW+6ixnpaYM5b5BCgvPEp
         mrdg==
X-Gm-Message-State: AFq9FYIdE4Q8ROEiS5upVE8+Cnpn9uYlIPzvMSTlIzfnyY0TRDHA4x0w
	JN1Kuqim5R8rFziwnuQrbJExW6gHsemz4BFf0938Y4mXrLS1O/WE2mxWJW6iKfQi274=
X-Gm-Gg: AYBFou0y8iC4TZJgNrb4NLtnfHCAJbqTmW+e4yImlCJ0QRd3K2BLf4ETbo7IZ9Q/ysL
	/b1B3KyhQdC1iU4Hr8p7dfyzKU6N/Z0/Bwr6z5noxsIJKLuVXCsqVsmEt1HIzHZv3Sxqp6NgQbF
	HODTrkjgnuGlCGk/l9by7l70Io+DZYj9h84M4sPiOkQhBtBUikN7XahLf0V+jyMI2zmHO2KCubY
	8eWQaB/b9T+IhS5aFZXIbysBT2ox5RSPPJPrDwvxlYYRWqUMw/9daCqZ+QHigabXrIhLbNAU5qN
	ivLOWxbHx1XE7m4Fgsurp8vRiEZbqScaYE7LILZbbRzicTd4Jf2jo5JaKUK+jgfvl+kqCzlgs4l
	l5qIakV86fMb+6Gn0Uc+iKe7PV8PcenTLY1zbtEHGpoc5rKLvuInVmt7CSYGEDDLWJ+Z/Z2U1l5
	OL944p9qAkYQyJrFaKHKVwfbWzj4ysMzyf2EzMb/yO9C0Lu9ynPQ1G0Z0vvGOzl/cB9HUAYX/dm
	GXksKB+LDi2dfInjCrhS2g32W2OmJVIQ5Ps8kB7BeUaAuyF0iuctKpb/5nIFmIineEgLrPxRDUa
	oKODFZUrCWzFwsUzlIaVQcylaUquG1IFhjBPMe1hsY9A9w==
X-Received: by 2002:a05:6122:1d10:b0:5c6:81c2:5496 with SMTP id 71dfb90a1353d-5eaebd6d8bemr2743613e0c.4.1792684049007;
        Thu, 22 Oct 2026 08:47:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 21/27] tools: Build testers that do not need GLib with the mainloop
Date: Thu, 22 Oct 2026 11:46:54 -0400
Message-ID: <20261022154701.3959500-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remove the remaining GLib uses of mgmt-tester, smp-tester, bnep-tester,
ioctl-tester, userchan-tester, mesh-tester and hci-tester, unused watch
ids and g_assert() mostly, and link them with libshared-mainloop, which
does not read the clock on every iteration.

mgmt-tester under User Mode Linux with test-runner -T:

  GLib      42.6 s
  mainloop  20.3 s

Assisted-by: Claude:claude-opus-5-5
---
 Makefile.tools          | 14 +++++++-------
 tools/bnep-tester.c     |  7 -------
 tools/ioctl-tester.c    |  6 ++----
 tools/mesh-tester.c     |  1 -
 tools/mgmt-tester.c     |  3 +--
 tools/smp-tester.c      | 30 +++++++++++++-----------------
 tools/tester.h          |  8 ++++----
 tools/userchan-tester.c |  1 -
 8 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 304dbf135e98..9f0dd897c607 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -136,7 +136,7 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_mesh_tester_SOURCES = tools/mesh-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -145,7 +145,7 @@ tools_mesh_tester_SOURCES = tools/mesh-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_mesh_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -172,7 +172,7 @@ tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -181,7 +181,7 @@ tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -204,7 +204,7 @@ tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
-tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
+tools_hci_tester_LDADD = src/libshared-mainloop.la
 
 tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -213,7 +213,7 @@ tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_iso_tester_SOURCES = tools/iso-tester.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -231,7 +231,7 @@ tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_ioctl_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-mainloop.la
 
 tools_6lowpan_tester_SOURCES = tools/6lowpan-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index 1c53d024c0f8..8c7382b815c4 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/bnep.h"
@@ -37,7 +36,6 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	unsigned int io_id;
 	uint16_t conn_handle;
 };
 
@@ -198,10 +196,6 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
 
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
@@ -288,7 +282,6 @@ static void test_basic(const void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->test_data = data; \
-		user->io_id = 0; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
index e957b0d01bfa..d9623d8f796c 100644
--- a/tools/ioctl-tester.c
+++ b/tools/ioctl-tester.c
@@ -20,7 +20,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/mgmt.h"
@@ -50,8 +50,6 @@ struct test_data {
 
 	uint16_t handle;
 	uint16_t acl_handle;
-	GIOChannel *io;
-	unsigned int io_id[2];
 	int step;
 	bool reconnect;
 
@@ -782,7 +780,7 @@ static void test_ioctl_common(const void *test_data)
 			}
 		} else {
 			if (ioctl_data->param_len) {
-				g_assert(req_len >= ioctl_data->param_len);
+				assert(req_len >= ioctl_data->param_len);
 				req_len = ioctl_data->param_len;
 			}
 			memcpy(req, ioctl_data->param, req_len);
diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
index 4412bfdb727e..896cfd1f208f 100644
--- a/tools/mesh-tester.c
+++ b/tools/mesh-tester.c
@@ -21,7 +21,6 @@
 #include <errno.h>
 #include <unistd.h>
 
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index abfe57dad0c8..58dac1317623 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -22,7 +22,6 @@
 #include <errno.h>
 #include <unistd.h>
 
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
@@ -12599,7 +12598,7 @@ static void test_remove_device(const void *test_data)
 static bool hook_delay_cmd(const void *data, uint16_t len, void *user_data)
 {
 	tester_print("Delaying emulator response...");
-	g_usleep(250000);
+	usleep(250000);
 	tester_print("Delaying emulator response... Done.");
 	return true;
 }
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 581f3a233704..29027d98a852 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -18,7 +18,7 @@
 #include <stdbool.h>
 #include <sys/socket.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
@@ -31,6 +31,7 @@
 #include "src/shared/crypto.h"
 #include "src/shared/ecc.h"
 #include "src/shared/tester.h"
+#include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 
 #define SMP_CID 0x0006
@@ -41,7 +42,6 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
 	uint8_t ia[6];
 	uint8_t ia_type;
 	uint8_t ra[6];
@@ -229,10 +229,6 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
 
 	if (data->crypto) {
 		bt_crypto_unref(data->crypto);
@@ -293,7 +289,7 @@ static const struct smp_req_rsp nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_1_test = {
 	.req = nval_req_1,
-	.req_count = G_N_ELEMENTS(nval_req_1),
+	.req_count = ARRAY_SIZE(nval_req_1),
 };
 
 static const uint8_t smp_nval_req_2[7] = { 0x01 };
@@ -306,7 +302,7 @@ static const struct smp_req_rsp srv_nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_2_test = {
 	.req = srv_nval_req_1,
-	.req_count = G_N_ELEMENTS(srv_nval_req_1),
+	.req_count = ARRAY_SIZE(srv_nval_req_1),
 };
 
 static const uint8_t smp_nval_req_3[] = { 0x01, 0xff };
@@ -319,7 +315,7 @@ static const struct smp_req_rsp srv_nval_req_2[] = {
 
 static const struct smp_data smp_server_nval_req_3_test = {
 	.req = srv_nval_req_2,
-	.req_count = G_N_ELEMENTS(srv_nval_req_2),
+	.req_count = ARRAY_SIZE(srv_nval_req_2),
 };
 
 static const uint8_t smp_basic_req_1[] = {	0x01,	/* Pairing Request */
@@ -353,7 +349,7 @@ static const struct smp_req_rsp srv_basic_req_1[] = {
 
 static const struct smp_data smp_server_basic_req_1_test = {
 	.req = srv_basic_req_1,
-	.req_count = G_N_ELEMENTS(srv_basic_req_1),
+	.req_count = ARRAY_SIZE(srv_basic_req_1),
 };
 
 static const struct smp_req_rsp cli_basic_req_1[] = {
@@ -367,7 +363,7 @@ static const struct smp_req_rsp cli_basic_req_1[] = {
 
 static const struct smp_data smp_client_basic_req_1_test = {
 	.req = cli_basic_req_1,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = ARRAY_SIZE(cli_basic_req_1),
 };
 
 static const uint8_t smp_basic_req_2[] = {	0x01,	/* Pairing Request */
@@ -390,7 +386,7 @@ static const struct smp_req_rsp cli_basic_req_2[] = {
 
 static const struct smp_data smp_client_basic_req_2_test = {
 	.req = cli_basic_req_2,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = ARRAY_SIZE(cli_basic_req_1),
 	.mitm = true,
 };
 
@@ -429,7 +425,7 @@ static const struct smp_req_rsp cli_sc_req_1[] = {
 
 static const struct smp_data smp_client_sc_req_1_test = {
 	.req = cli_sc_req_1,
-	.req_count = G_N_ELEMENTS(cli_sc_req_1),
+	.req_count = ARRAY_SIZE(cli_sc_req_1),
 	.sc = true,
 };
 
@@ -455,7 +451,7 @@ static const struct smp_req_rsp cli_sc_req_2[] = {
 
 static const struct smp_data smp_client_sc_req_2_test = {
 	.req = cli_sc_req_2,
-	.req_count = G_N_ELEMENTS(cli_sc_req_2),
+	.req_count = ARRAY_SIZE(cli_sc_req_2),
 	.sc = true,
 };
 
@@ -549,16 +545,16 @@ static const void *get_pdu(const uint8_t *pdu, size_t len)
 	uint8_t opcode = pdu[0];
 	static uint8_t buf[65];
 
-	g_assert(len > 0);
+	assert(len > 0);
 
 	switch (opcode) {
 	case 0x01: /* Pairing Request */
-		g_assert(len <= sizeof(data->preq));
+		assert(len <= sizeof(data->preq));
 		memset(data->preq, 0, sizeof(data->preq));
 		memcpy(data->preq, pdu, len);
 		break;
 	case 0x02: /* Pairing Response */
-		g_assert(len <= sizeof(data->prsp));
+		assert(len <= sizeof(data->prsp));
 		memset(data->prsp, 0, sizeof(data->prsp));
 		memcpy(data->prsp, pdu, len);
 		break;
diff --git a/tools/tester.h b/tools/tester.h
index 9df600f900ad..2728a54e5c03 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -20,7 +20,7 @@
 #include <net/if.h>
 #include <sys/ioctl.h>
 
-#include <glib.h>
+#include <assert.h>
 
 #define SEC_NSEC(_t)  ((_t) * 1000000000LL)
 #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
@@ -65,21 +65,21 @@ static inline int tx_tstamp_expect(struct tx_tstamp_data *data, size_t len)
 		data->sent += len - 1;
 
 	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
-		g_assert(pos < ARRAY_SIZE(data->expect));
+		assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_SCHED;
 		data->expect[pos].id = data->sent;
 		pos++;
 	}
 
 	if (data->so_timestamping & SOF_TIMESTAMPING_TX_SOFTWARE) {
-		g_assert(pos < ARRAY_SIZE(data->expect));
+		assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_SND;
 		data->expect[pos].id = data->sent;
 		pos++;
 	}
 
 	if (data->so_timestamping & SOF_TIMESTAMPING_TX_COMPLETION) {
-		g_assert(pos < ARRAY_SIZE(data->expect));
+		assert(pos < ARRAY_SIZE(data->expect));
 		data->expect[pos].type = SCM_TSTAMP_COMPLETION;
 		data->expect[pos].id = data->sent;
 		pos++;
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index 9164fc33f5d9..febc28371501 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
-- 
2.56.0

