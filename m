Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885C1DA23
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518869; cv=none; b=Ul+EUXp/SjJ5+fBCYy/HS8CIvdjXkP/+ftuLXuY9bBlVOcWD8SNoG8eBnmglvbh6O7HiRuh1Yfl1+OvRh6/HgUG5OiLbjd9sWpo62vDHs0KqirAb2k7CW73KyidDfRIp+IMHJtnbHZ3vSr9XgRcZDHcbYIdl0Kmx7fOyloUKmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518869; c=relaxed/simple;
	bh=pjrNB3XJRLM7lx/BQ4favoWovX8Mb0l8vNkhzUbTk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Njq1WaBvjVKx+pFS4jK5unGOoh0dDPp9HEk98gTTJCMNnvsfGjxHrI28Ejev1P8zxtfiyQnW+W5JS4Johc8SmiebyHYCOVeqGOKErSkc2Z6bYL+3d29nIJIdDh8D+WUiP0BOC/GogDLz6afWYpfHU5ASzZA1eAfKSj3LkcYzPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCXzvXJC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCXzvXJC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d74086e5bso1422283f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776518865; x=1777123665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrXL/i2ehCIeC/uq5baz1/hnSDHS5FoTDfA7Ofn+8Sw=;
        b=cCXzvXJC5Bhcung2G1Is4kOPpZ7hy/aOw0BorDyQCIabEQD8ZtvePtGeJCPlCSZniP
         E+IsltM/NrelDMezaN2rtOuDeKVAjI2K2byET5ApxcMNjLfawyghHAy47roaq43DDEz8
         OtUJ7ldxBN1XweuhWyanOn4g8yCFCmovqXNh51rqqs4zXxzqNq/Qt8F4wt7dFro2gGvm
         jqFNz+cLc8kUcgzbBI/XWwyafLNx4YvZAcc4vx75EV3JPIYO7CjYjV0oTQc7KCAquNrs
         Z7zAZU0mgyIQWC6ztkSMAAolFuemiPeQSifMjVr3eu4vG/bzqKsqu+S4SDSzgR8K0FbY
         gxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776518865; x=1777123665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrXL/i2ehCIeC/uq5baz1/hnSDHS5FoTDfA7Ofn+8Sw=;
        b=T52YG/1ev7Ic4D2+Rq3QDxTuurcK1/fOPTOzmjkHmX9mpRbWbB/PDFFvZfe6I9OPtm
         VsgQ7I13QKGNMl4znS//kxsVD55ND6o16YUnxL17cxkRM1myleSoklDmLWKys1fimpEk
         omuGjD67WbO9ocupBWfjarnUWlNIdqscm6oQIxc7MiYWzp548j8m+uSt80vhdOWBHPIW
         FZMISYIknDbZoTbEYQ+yDNmlFuN+iWZVNS/c9LWT4ygqbocRgC9eLcS7yoPsvROLq2yR
         3kZzQyg/FnHmXerkfW7Q7j0MNxIw5jQykWZ4JVwcB7Cmo2II9hYfjyqvUenXzN8JkbG0
         kRjQ==
X-Gm-Message-State: AOJu0YyvFVLwROl0Sp3mynjHhAMkJmCUt/kWXHEy5C1iXdRb0JKqtM9H
	/9UkSwtHuiXo+J2iso/cQaex5e8mewRRBr+EWizDCQEapFOSrDZndFzgPF7GVjsy
X-Gm-Gg: AeBDietjq+d/cQQ8uMIi4+Kx/oU5e3gYo+d2+EvSYfovcxL+wRrCJenleK6vqHs6NSk
	GjfkO6J12ZFP0Rt/zuJT9xjRyHFpTbIwn+T1TtHIsVhhLMiO0YwU0W9nAPqC2RTBpdr8/+dC6gZ
	7mfCDRGTF3DdY4jSOpXSmNP/Ls+R+nQiLBiRusADtmyNc2KZw9ACDgmX6RewYJl1RncXRr0rY5u
	UQfdQm3hdbvA98o0/ijBsWahqvXiTVJRYHjM0YhopktG98vqVYr9BQfsmsAWOqcr8WgOxuV66dm
	aLhkSAC8AogVVrJaJkICvGosYfFXiMTrrjEqVkuv8OFOWNU+wAJaffyN9vyK7Oird7Su5xBBTSr
	eecXgbuG9zajhMJwfosag/x/3ocQd7X1/WLqIKQHQW6Vz+1f0SmaihJ26aBjs+B2LOlL/iB31Bj
	BrbXm65eXYkshhA+4H9yf64HkVqCSGKcKjMUoIHP405dGVZ9eJa223hi9v2xT3TogdJCGbLzjlk
	J3MVcg6Zp07sLcjZnVKspViGobDYFbwUJ0sCqkObwQhjYvWzvU=
X-Received: by 2002:a05:6000:2890:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-43fe3e16c4dmr10703249f8f.39.1776518865164;
        Sat, 18 Apr 2026 06:27:45 -0700 (PDT)
Received: from server ([82.76.107.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm12734336f8f.12.2026.04.18.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:27:44 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Bastien Nocera <hadess@hadess.net>,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH] adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
Date: Sat, 18 Apr 2026 16:27:40 +0300
Message-ID: <20260418132740.235614-1-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bastien Nocera <hadess@hadess.net>

On systems with combo chips (shared Wi-Fi/Bluetooth antenna), background
LE scanning for auto-connect devices competes with active connections,
causing audio stuttering and Wi-Fi packet loss due to antenna
multiplexing via Packet Traffic Arbitration (PTA).

Add a DisableDiscoveryOnConnect boolean option to the [General] section
of main.conf. When enabled and an active connection exists, the option
suppresses adding devices to the kernel auto-connect list in
adapter_auto_connect_add() on kernels supporting KERNEL_CONN_CONTROL,
and gates trigger_passive_scanning() on older kernels.

The option defaults to false to preserve existing behavior.

Signed-off-by: StefanCondorache <condorachest@gmail.com>
---
 client/mgmt.c             |  4 ----
 mesh/prov-initiator.c     |  3 +--
 src/adapter.c             | 24 ++++++++++++++++++++++++
 src/btd.h                 |  2 ++
 src/device.c              |  4 ----
 src/gatt-database.c       |  4 ----
 src/main.c                |  4 ++++
 src/main.conf             |  6 ++++++
 src/shared/gatt-client.c  |  8 --------
 src/shared/gatt-helpers.c |  4 ----
 src/shared/ringbuf.c      |  4 ----
 src/shared/uhid.c         |  4 ----
 src/shared/vcp.h          |  8 --------
 tools/advtest.c           |  3 ---
 tools/btgatt-server.c     |  4 ----
 tools/hcitool.c           |  4 ----
 tools/parser/rfcomm.h     |  2 --
 17 files changed, 37 insertions(+), 55 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 71fcd21ff..50558a313 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -67,10 +67,6 @@ static struct {
 
 static int pending_index = 0;
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 static void mgmt_menu_pre_run(const struct bt_shell_menu *menu);
 
 #define PROMPT_ON	COLOR_BLUE "[mgmt]" COLOR_OFF "> "
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index d46081c7a..29c0be713 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -18,6 +18,7 @@
 
 #include "src/shared/ad.h"
 #include "src/shared/ecc.h"
+#include "src/shared/util.h"
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
@@ -34,8 +35,6 @@
 #include "mesh/agent.h"
 #include "mesh/error.h"
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 /* Quick size sanity check */
 static const uint16_t expected_pdu_size[] = {
 	2,	/* PROV_INVITE */
diff --git a/src/adapter.c b/src/adapter.c
index 6df66b3e0..4a18adfe0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1594,6 +1594,18 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
 	if (!adapter->connect_list)
 		return;
 
+	/*
+	 * If the user has enabled DisableDiscoveryOnConnect, suppress
+	 * passive scanning whenever there is at least one active connection.
+	 * This prevents antenna multiplexing conflicts on combo chips where
+	 * Wi-Fi and Bluetooth share the same 2.4 GHz radio, which causes
+	 * audio drops and Wi-Fi packet loss during background scans.
+	 */
+	if (btd_opts.disable_discovery_on_connect && adapter->connections) {
+		DBG("suppress passive scan: active connection present");
+		return;
+	}
+
 	adapter->passive_scan_timeout = timeout_add_seconds(CONN_SCAN_TIMEOUT,
 					passive_scanning_timeout, adapter,
 					NULL);
@@ -5717,6 +5729,18 @@ void adapter_auto_connect_add(struct btd_adapter *adapter,
 		return;
 	}
 
+	/*
+	 * If DisableDiscoveryOnConnect is enabled, suppress adding devices
+	 * to the kernel auto-connect list while an active connection exists.
+	 * On combo chips (shared Wi-Fi/Bluetooth antenna), the kernel's
+	 * background scanning for auto-connect devices competes with active
+	 * connections, causing audio drops and Wi-Fi packet loss.
+	 */
+	if (btd_opts.disable_discovery_on_connect && adapter->connections) {
+		DBG("suppress kernel auto-connect: active connection present");
+		return;
+	}
+
 	bdaddr = device_get_address(device);
 	bdaddr_type = btd_device_get_bdaddr_type(device);
 
diff --git a/src/btd.h b/src/btd.h
index c84a600d1..07c4d85ba 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -144,6 +144,8 @@ struct btd_opts {
 	bool		experimental;
 	bool		testing;
 	bool		filter_discoverable;
+	bool		disable_discovery_on_connect;
+
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/device.c b/src/device.c
index 470340c2d..28515054c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -72,10 +72,6 @@
 #define DISCOVERY_TIMER		1
 #define INVALID_FLAGS		0xff
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define RSSI_THRESHOLD		8
 #define AUTH_FAILURES_THRESHOLD	3
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 39e6a2593..680a52952 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -54,10 +54,6 @@
 #define UUID_GATT	0x1801
 #define UUID_DIS	0x180a
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct gatt_record {
 	struct btd_gatt_database *database;
 	uint32_t handle;
diff --git a/src/main.c b/src/main.c
index 818f7c06e..d7ddf5643 100644
--- a/src/main.c
+++ b/src/main.c
@@ -92,6 +92,7 @@ static const char *supported_options[] = {
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
 	"FilterDiscoverable",
+	"DisableDiscoveryOnConnect",
 	NULL
 };
 
@@ -1072,6 +1073,8 @@ static void parse_general(GKeyFile *config)
 					0, UINT32_MAX);
 	parse_config_bool(config, "General", "FilterDiscoverable",
 						&btd_opts.filter_discoverable);
+	parse_config_bool(config, "General", "DisableDiscoveryOnConnect",
+					&btd_opts.disable_discovery_on_connect);
 }
 
 static void parse_gatt_cache(GKeyFile *config)
@@ -1283,6 +1286,7 @@ static void init_defaults(void)
 	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
 	btd_opts.secure_conn = SC_ON;
 	btd_opts.filter_discoverable = true;
+	btd_opts.disable_discovery_on_connect = false;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index d31dd1b8f..22507c465 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -157,6 +157,12 @@
 # some stacks) or when testing bad/unintended behavior.
 #FilterDiscoverable = true
 
+# Disables background LE passive scanning when an active connection is
+# established. Recommended for combo chips (shared Wi-Fi/Bluetooth antenna)
+# to prevent audio stuttering and packet loss caused by antenna multiplexing.
+# Defaults to false.
+#DisableDiscoveryOnConnect = false
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df1541b88..a6abe8ac2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -25,14 +25,6 @@
 #include <limits.h>
 #include <sys/uio.h>
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
 
 #define GATT_SVC_UUID	0x1801
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 8dee34a9e..b3d5d8f1a 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -20,10 +20,6 @@
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct bt_gatt_result {
 	uint8_t opcode;
 	void *pdu;
diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 957d355f9..7460dd483 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -21,10 +21,6 @@
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
 
-#ifndef MIN
-#define MIN(x,y) ((x)<(y)?(x):(y))
-#endif
-
 struct ringbuf {
 	void *buffer;
 	size_t size;
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 207afa55e..919618a71 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -26,10 +26,6 @@
 
 #define UHID_DEVICE_FILE "/dev/uhid"
 
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
 struct uhid_replay {
 	bool active;
 	struct queue *out;
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 89efaa09c..e031beafd 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -23,14 +23,6 @@
 #define BT_VCP_UNMUTE			0x05
 #define BT_VCP_MUTE			0x06
 
-#ifndef MAX
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
-#endif
-
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 struct bt_vcp;
 
 typedef void (*bt_vcp_destroy_func_t)(void *user_data);
diff --git a/tools/advtest.c b/tools/advtest.c
index 7e744dca8..a67a03c43 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -39,9 +39,6 @@
 			"\xe1\x23\x99\xc1\xca\x9a\xc3\x31"
 #define SCAN_IRK	"\xfa\x73\x09\x11\x3f\x03\x37\x0f" \
 			"\xf4\xf9\x93\x1e\xf9\xa3\x63\xa6"
-#ifndef MIN
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
 
 static struct mgmt *mgmt;
 static uint16_t index1 = MGMT_INDEX_NONE;
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 449c34203..18e8b9542 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -48,10 +48,6 @@
 		print_prompt(); \
 	} while (0)
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_RED	"\x1B[0;91m"
 #define COLOR_GREEN	"\x1B[0;92m"
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 834f83e7a..1903d859b 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -34,10 +34,6 @@
 
 #include "src/oui.h"
 
-#ifndef MIN
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-#endif
-
 /* Unofficial value, might still change */
 #define LE_LINK		0x80
 
diff --git a/tools/parser/rfcomm.h b/tools/parser/rfcomm.h
index b1cb1741c..d1b093a90 100644
--- a/tools/parser/rfcomm.h
+++ b/tools/parser/rfcomm.h
@@ -33,8 +33,6 @@
 /* Returns the P/F-bit */
 #define GET_PF(ctr) (((ctr) >> 4) & 0x1)
 
-#define MIN(a, b) (((a) < (b)) ? (a) : (b))
-
 /* Endian-swapping macros for structs */
 #define swap_long_frame(x) ((x)->h.length.val = le16_to_cpu((x)->h.length.val))
 #define swap_mcc_long_frame(x) (swap_long_frame(x))
-- 
2.53.0

