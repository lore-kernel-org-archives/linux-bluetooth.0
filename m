Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A91F2C45
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003636; cv=none; b=YYfhIGdGamrZJ43H1wjBMPBG1Azy5MU/19RaxR+O/U89Bk3Hqcb5iF1cedDFzWvJKDTUw3G3paPPVs9t5N16OxlVm2p0Sygrs6R00gI796d+wJJZ8u9O0FN3CsuFQgKYbQBBrQKvLZBVJgjadNiyPZQlb+MBNWcU1RJ6kTmzmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003636; c=relaxed/simple;
	bh=uEHm9S4+iiGkoazaSv2sUIOZtF6RfK18Gjb/SIFGf/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RyjoMUJ9wNWdqwvOHfFDJYhHz3OuMiuFOza/0rqhu4uQtFiMNDN0SnDL/Cib78lObAF86DTJPtnf8OyH3txf2PibDkquc8KUq/u1kqhGr4cShYDPG0nLtIO3fg0laq1snGcLaFKYggxcOTBhzVyFtp7XqTT7om8Reu6rbAYmK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTTAijZd; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTTAijZd"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-530cf611a7eso487520137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Sep 2025 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757003633; x=1757608433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyfy86lZz+Rr6sx8BFoqIO0KgBKj9WwGGOPTshRQ/iw=;
        b=CTTAijZdO0S0uiRMIl4LwOVesmq0KyNFlYZkaNcko0+njvVrTIVFG9zuEy4PQCSn/i
         AaP7k/qIGavKa32LdsABmRLg7e+9Aufxdhk8XvGVwLVAoBVqW0pGNVYptp67/cU/PPoz
         6s55RSg/Mp8AVbbyP1GHLQiOLiRBHQbwoUuMi3Gr0hCfcbtYkN2TYVXc9w2QhNHmO0FW
         JIEcoYvobzQQcwAlYjKNqe7ISp0HrpBV8weyL08eluQPW3EIcgZqPKn1lN98FbkUEbGS
         0eyg8P8GsP9bKHpctc+9yrUAacJI2G7wax5hAV/VcULFPBYkyeugiEy5hV0W80h+Xzfd
         wArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003633; x=1757608433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyfy86lZz+Rr6sx8BFoqIO0KgBKj9WwGGOPTshRQ/iw=;
        b=DRp+SUX+HYliIVP5iuvJkO6pdxGrZWRkHa5DKNGfxA/3Di1znhynnOx5DvhYpFPm+5
         Pke5R39rH2BIiauZ4q+HlwEojTTyW3Sez48Jx+nHCIizB0wTP4YaURG7iv8mYKveKV3F
         U8jEgRL3DiL7OOa8IeYMJXtsKBdjnutnCkQqwcMvhwk9rnYs4IIQBk7+GueahFbiKBlI
         U2iv/Ejm2oJYyKnwebUyVghy10cLHQ3I1pVxTEKZDEFHt0KQLKN6cFVAjsiyODn8tCcF
         H+CDOOaWvVgw7UQJElzI/CEhk+r/uiYzRtVa/f/se0Oks3vLZTYc6AT0JvRqw2hQ7JEy
         +mSw==
X-Gm-Message-State: AOJu0YwolfdBps3P4ogP3keTZvHE3TC2SHK15++hg9GL7VMFez9F8Udq
	rBU6R7JdKjGVaisZBwTZRd5473H816BR5GC30epwrQM/+pT5YLmIEgU6giUUZcNE
X-Gm-Gg: ASbGncsWdezL3VVTc8pYOshVIFSYDY8P2NSIuWbdC6/rLC4DNz2I3+s78ps7wyRrAau
	ZMP7e0soUsMkcXxK53lrQsTcNec2ujzt3GGBg/WTSouifNMZiANEyYTMKObrU0s3EnKcxJDk0Tc
	B0jbe5qptawpmBrBR+T0t7W2q+k9y8K4I3/pq3BUYE5LV/lpXPnfZDdIVir87DqSEmKHenR9iAO
	fCg43bv9zygFa656ngrGjUOs8C/mfyGVrYIrvfszD1uyKrcG95agRFakyyOvRliaetCizTku8cM
	MirbhwPw+xXB0a9Mup2SvVlNYykRGR2URkFuzd4T708eMKBnv0WAsITbL1YB8sOzYIYHnYjywLR
	8BcleST9/C3YPGsqFakjNuqC9+5PL5ZXG+Hv3fiqyPFdUSS5/X4147qulzpk/k4Ny9GhMCEg9e1
	clDi9LQf2EnnDLF9+c6SvM8v5Bc1oqrQ==
X-Google-Smtp-Source: AGHT+IE+lc8lgNxdbZomwG97JXRyrfTpCbg+hJiDoIRYS9oKBS0qexB2h0242Bv5cp/zkyOPj2SMPg==
X-Received: by 2002:a67:e010:0:20b0:533:ff66:698c with SMTP id ada2fe7eead31-533ff6673f5mr2203662137.2.1757003633170;
        Thu, 04 Sep 2025 09:33:53 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899f14c7752sm2585421241.4.2025.09.04.09.33.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:33:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] main.conf: Add FilterDiscoverable option
Date: Thu,  4 Sep 2025 12:33:43 -0400
Message-ID: <20250904163343.688862-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.
---
 src/adapter.c | 4 +++-
 src/btd.h     | 1 +
 src/main.c    | 4 ++++
 src/main.conf | 5 +++++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 549a6c0b8324..dc5ba65d73fa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7239,8 +7239,10 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 
 	if (bdaddr_type == BDADDR_BREDR || adapter->filtered_discovery)
 		discoverable = true;
-	else
+	else if (btd_opts.filter_discoverable)
 		discoverable = eir->flags & (EIR_LIM_DISC | EIR_GEN_DISC);
+	else
+		discoverable = true;
 
 	/*
 	 * Mark as not discoverable if no client has requested discovery and
diff --git a/src/btd.h b/src/btd.h
index 18a5eb88696a..5c952bf17956 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -142,6 +142,7 @@ struct btd_opts {
 	bool		refresh_discovery;
 	bool		experimental;
 	bool		testing;
+	bool		filter_discoverable;
 	struct queue	*kernel;
 
 	uint16_t	did_source;
diff --git a/src/main.c b/src/main.c
index a542d0fc50b0..1c7390e6329d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -91,6 +91,7 @@ static const char *supported_options[] = {
 	"Testing",
 	"KernelExperimental",
 	"RemoteNameRequestRetryDelay",
+	"FilterDiscoverable",
 	NULL
 };
 
@@ -1062,6 +1063,8 @@ static void parse_general(GKeyFile *config)
 	parse_config_u32(config, "General", "RemoteNameRequestRetryDelay",
 					&btd_opts.name_request_retry_delay,
 					0, UINT32_MAX);
+	parse_config_bool(config, "General", "FilterDiscoverable",
+						&btd_opts.filter_discoverable);
 }
 
 static void parse_gatt_cache(GKeyFile *config)
@@ -1239,6 +1242,7 @@ static void init_defaults(void)
 	btd_opts.refresh_discovery = TRUE;
 	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
 	btd_opts.secure_conn = SC_ON;
+	btd_opts.filter_discoverable = true;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index 86759d53c1f2..55618be5c923 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -148,6 +148,11 @@
 # The value is in seconds. Default is 300, i.e. 5 minutes.
 #RemoteNameRequestRetryDelay = 300
 
+# Filter out non-discoverable devices based on discoverable flags (General or
+# Limited).
+# Defaults to true
+#FilterDiscoverable = true
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.51.0

