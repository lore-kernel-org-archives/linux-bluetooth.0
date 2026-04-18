Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43055387348
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521494; cv=none; b=sple+bMoQVX4XaGK4PCsaOKqgTzCJr6rbMycFYQsy66o/NXSPuK3oSZsFGEr3v0kI/Z+6cf4U43A3/ZVzUER4NTsRmkSuAPTBpncEzl3P/exZZmnFdKCjOlQ9IY81JT21R0HIhViv8DdFsGbjCPzWmZXyCk/3phwvpImYChTtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521494; c=relaxed/simple;
	bh=75SaJH/4818ZH1XMXICkiJ53A7XN1diNK/TCVCvq1uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8CY5BkHVq27ert53x8ktTekTrcHQ2Ha/towU7z9cixdkgN+ERSMYKVkiCjfMUthcrvldfDHNAKBkmdQSvDRmPXGF+ugixCo3MxrrI4HQcphP0nRhgJa+0BIS0SEV+OX5n7Ywk2RbO7E9aSfPcW/M0Mqbu6+UYVg3+Rt7hVPRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3wq6bAx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3wq6bAx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso20355945e9.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521491; x=1777126291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idx9fu13KE37KbDr/9eNW0Nm/NLHNXIRnsyoiAYhbfw=;
        b=E3wq6bAxOsqrmmNCPl3zwgyWJ0EEyDPP7ZDGVI1KmiqTwIR8CGKl708Y/jfypdWdNe
         k7GRvXMGEToBnJIfchyqRFgPR7JYCjXN86bWbWWShs+rZLt3gWYI6Yezzq25pY0rJ88T
         W0Jk0jOoURfcH2EWGn0ECSnsorpmkuGoez3oDV15476tiOJZFjUZBnxm94wTZc2acKBD
         8T44+vqQMPrnGqhHKup8OkPzcEJzuSIU3gs8wMXj++7GFIms85mdO6gdHNxcllZsHwrV
         HCIqKiiOZN+gqqIh8OGHQwOK81Z19Sqe/vMwA2iNPy+pZgC9VfRXl8zk8lmTX0TPe6Zn
         V2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521491; x=1777126291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idx9fu13KE37KbDr/9eNW0Nm/NLHNXIRnsyoiAYhbfw=;
        b=H6V3QGw9mOzCObSa1NFyhQI1wfgwQB/Eu4XMp4oJZq24lKKHnqKTHCuQbuQ0MsU9ab
         qbR1OxGj/fEXHeRw2m7sq6h4AJ7J4nDhm7DB+HxNULo0PqkAABDjQ3Gzl6Jtui2G4Spi
         bx0N9SgnRIlovHUGkUyNRY3JvsaGtgLjDwAP3dmNnQgY0Gp1s9clj1GdeVOvYQyhr6Df
         wehL8bsly2WO99GWl0J8tXQt2Ec4YLqFxmUk9QUIGHwfvj+gCaa5k6RUcj4KCYEgTk7S
         feVvIDlaNN70gRcHoqmnmIh6ryPiDV+cy4lqe9nsHv9vZicqwFQD2A7G+gJd+MlwXb0L
         rkBw==
X-Gm-Message-State: AOJu0YzcvGvyfUwv4ova+AUckH1l3YXk09c1c34MChvaWBM+FyfqHAVy
	3PzE2qahKW74GLFQ3lev3v3rzpuMch5f58VO8odKqrUdHO9JfA+636A0LJ+TG+nb
X-Gm-Gg: AeBDietY+D6tHX+T40hnAeO5KYPU3ZFnRRk8aP6XUVC02L7L/M/BNR6d+HtEn+Z2si7
	IDNzCsHGUlruJyjanTZibLpNN+fb/RhYUICu4je8d0sbCqcL7IoZdtBNqtbHSwEKiKbjW8Yk5i2
	6Mky1wLnRoh9VXhcHIIO9vkOzb2gSDhNJ2ZhL1kXPbkrHZTTZEi/Ozuw7Y3g0Ah3Cr5teRRqPWt
	Vv1+y/KLht0mfnsIsiTPxCNhUPTRssg4CDA4Te1LJqD8qZBSA56iFg8og8K97/UHwzFDb7WIO53
	sU6KE8k2R5sME5z5pekUy37YfjQuP7GUOciAITaII9NuLqWarUqfUuewivSnoKUojjBN8iFu4lZ
	8fb5SCBoIPZ0KqigjmXI+R64TbVQe8ZNNLPqbgVSqmZRw1lPG/0b5rys+IlQdaSh/LqVGScSLbS
	iWNqHOgNpjzcpPDvuoi87+GQaq+BocURBmixlQIx3QxV4q3kS2xfs2Kv/F0yRxNjiIPikNtxTL/
	CKYTXiXdPKPYsSeQI0Ex6clFF8qo7FQOvBFa4/SsMS0p774
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr112308725e9.27.1776521491124;
        Sat, 18 Apr 2026 07:11:31 -0700 (PDT)
Received: from server ([5.14.142.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm12658347f8f.22.2026.04.18.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:30 -0700 (PDT)
From: StefanCondorache <condorachest@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	StefanCondorache <condorachest@gmail.com>
Subject: [PATCH] adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
Date: Sat, 18 Apr 2026 17:11:27 +0300
Message-ID: <20260418141127.243863-1-condorachest@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 src/adapter.c | 24 ++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    |  4 ++++
 src/main.conf |  6 ++++++
 4 files changed, 36 insertions(+)

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
-- 
2.53.0

