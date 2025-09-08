Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD82DE71C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367526; cv=none; b=qkW+06nc6A+FVHzl4FA4s2rkHOKkQEGPQR6LaAfysK+fJ/e+PJCl6JOgu9uTcRKgusFIMaiHz1AZoPMFV7zduiuyWYLPa+RT/LySvxeh6/R022Pb/04ePi+3NGmQhDjif/H5nZcsmmTnai97hYbiSRXwbIJW8hxEVcx+bnGDYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367526; c=relaxed/simple;
	bh=QCGyU0Q1xGnT6halnbNlBwojnhbMYxvQYqD/qtbrU0s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XROsJSJEPJnIfDcs8fh9hacSoRAzL+SOMmb4wfthT3nlvUBrdk12oL08K1adVOXdWhx+0co2/XwXKKNn+m/LUqvnXjRc3ER8O0Dm+nMePKJ1+HJMn6AB+/rbFnKLEbxMCztKuxWihzsQuWRsTIggzXMrK3i/0J9XziKmRJviRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S330YGTr; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S330YGTr"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-544b17b85d0so1832419e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Sep 2025 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757367523; x=1757972323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cvz9ZcrEGi1U1fkKk9XEs1XR8a5oR2VleOVT7WCPFM=;
        b=S330YGTruKtxSqSCia9TCFpXzkSw8KbB/I3GvXNU5qIVofw+QDc6pICIm+7MqhJ4ht
         7wSN7L6TjvM+jTFSvs7C8EPasRDSfwtlJnIBnBvVJEZJCd2/i8MYA4Mwjgwy6+/4gZ7c
         79vrI5ve9Fu59iOuPG6lqeJ0zpB7/zC/bjjfG2F0TZEpKo4tvzZLzArKGhfGp9ybbPnJ
         VJ7669M0E9vyR4EVWG6m7OgPXbr/7DI5/2fB/Ju4+laEe2OTquj1aJDRg8Dss/YxJHmz
         phsUaOfajomtH8AFFF03vA1wjZbli74nMytMQuZDC7Chx4aq5DmMEdKSB6tTO+TeWEru
         ChtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757367523; x=1757972323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cvz9ZcrEGi1U1fkKk9XEs1XR8a5oR2VleOVT7WCPFM=;
        b=emhgxkoqzowjnXCE9OeeeFExrSYudO1dATDD99awOMm4xCdv8kU4fS9TXFJwuvwnu2
         A9DZfGs9VBxv06OvIdBnNgU8MoySUoOd3NHlevSvmbpkQpT1UYyDPpTQ1ymIIcLY+cBo
         OjjiHzyLU4yPAE8UwzLDsxFF/88v8o5EakOFw3Ls30zFLZJVYW01mOcWWP6ePfX/ri8k
         E665sqKynxk9RIcFNww57Ll/LckTFUjWyPw7cPNn9iUquC7qraA5UdLmyrmBBWmS/nt+
         eD2a7UM5SPHm+HI/OrX7h8Fxg7V5I/uCfJ7cMhNaGLqc9T+I435QFcJR0s40k4MpJOoa
         J0Rg==
X-Gm-Message-State: AOJu0YyEVMsmRDJ1l6eFU9RMK9KG1oHqONXbi+NZI5rYPI01PfR1+dhn
	PJYqX2R0OvFvZ0SxJXEuNb0wQD5JkSKxQbgqnWaXPpaW3qv8EmlBD1T72YbCbTXmVZY=
X-Gm-Gg: ASbGncu4iqTrPUtrNbo9cGfesaZk6vq89fvTyO2mgHDA0JLMass+amOOvQsYwMzZlZ1
	jMejGaVkwuAy2MwRACT2QOQMOCq3hYoIA/dhiQ8+XWLuEw+JA/wbdgsFSToI63tdCy29ArTT0gA
	rYhzYmZpydu6dWwfy+sBsXDqZ8RtF42ciHcy66p4tBeWOvrnJoTgA3Ite0P8Ff+/1yZ9O4A0OxI
	alkWoG0ghHyVfDabM1XpikR1B5SdySBEm6CM7mulJihukYx/KDmnpBqGSOuxyf4LH2q+vIPXKxF
	JurypYBWt9Ohzd+fzdcRWop1/T2f9bvL+/a/L+2FxLts+zVvq7oPpUa8Z9vtonLUoMgj7Sjc2pO
	GacaYqsgo/1F2JGfKuTJ9+yqi53ejKIJUk6mtaiQgJrdBHdCB7p8Ikmu5hH6ixc57qw8zyzPEMP
	yb3j8xc4SkPMhv4RdF+bFwMMjfHZEDU26johk6UNlE
X-Google-Smtp-Source: AGHT+IFh+ZA2gsZmO5caG6/KUaSE8dxC9ZEiNEh+3XEIv6ils2g4yW3zLazS3gK31NDIK3c6ufnFfA==
X-Received: by 2002:a05:6122:3d01:b0:545:ef3e:2f94 with SMTP id 71dfb90a1353d-5473a3ae55bmr2051451e0c.1.1757367523209;
        Mon, 08 Sep 2025 14:38:43 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491464aebsm12986470e0c.14.2025.09.08.14.38.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:38:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] main.conf: Add FilterDiscoverable option
Date: Mon,  8 Sep 2025 17:38:33 -0400
Message-ID: <20250908213833.1518432-1-luiz.dentz@gmail.com>
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
 src/main.conf | 9 +++++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

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
index 86759d53c1f2..4c53376dcec7 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -148,6 +148,15 @@
 # The value is in seconds. Default is 300, i.e. 5 minutes.
 #RemoteNameRequestRetryDelay = 300
 
+# Filter out non-discoverable devices based on discoverable flags (General or
+# Limited).
+# Defaults to true
+# Setting to false is only recommended for an use-case where non-discoverable
+# device must be enumerated due to some requirement (e.g. not using GAP
+# discoverable modes for some odd reason which seems to be the behavior of
+# some stacks) or when testing bad/unintended behavior.
+#FilterDiscoverable = true
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.51.0

