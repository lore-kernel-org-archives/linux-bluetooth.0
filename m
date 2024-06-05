Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307719D8A6
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598366; cv=none; b=ntDe4nMnw2gtPVvYAQb45IRN2KwhpftF9hTNevJfxTiPhenFBdgBrOkkUgsbWHjudzSgZe3vzudMY/AynwMAp19R4WEnn/OHIQ/DzvRqvKEBMYhoNb+AjOM+Zz2a3x8JZLDEZ5szfhZ9l0q/sBTYn1/RoK/cnselp7ndYAH5UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598366; c=relaxed/simple;
	bh=98eKj+zMZGx7mO5i1rKKPVRkckQXY5qYiLkWflZjUf4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mwQ3v1S+wJTuzHHqC9tZjCb7F8gic+TkElo+slgmaAcsUTo3hFoWgzf/gcD+dLDsm6Ijce1PYqv+T/hTs2eJHh1IGjPrw6jJS0MrspAxC9YaiteEpaQw/ncqla3tck9axWjvsLHhMFlne5sbanYRW937x01wxIM6+xWF7GDjb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU9iY7DW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU9iY7DW"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f9398390fcso13614a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2024 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717598363; x=1718203163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKZJ3nAd3O+JmEeVCfwzK/RMlporSz1eJzDT1PvrxLg=;
        b=EU9iY7DWxpLcLyPz219UrKG/wQ/xWiH4po8KYTVcMptDgygVCS/pBvmqMsYLkRxD86
         tV/iUss6qlvPaRTJIYu7VwOJbvC3Iuq2bglPZgCDxpmnwndSgsrUnm9uij995XpntjSs
         KswEe5Mm0VSEg36tXUnrZ9za+0ZysiiyN5adGFRZO3Ml6QLexSQC2L43NRjtSRdLcc25
         Ol6icG0JzgjKH2ycK9MFuhrmUn48KOt8EXlIr5gR9yyhd8FqHC8MXqqEh7fLS5xOex2A
         DsoiffRGHlQasTBOTJ4QnV/cLSDnHfO7lU00Ako3505ccNUaz0Ncg3b/ur3VDChPmrhQ
         ypYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598363; x=1718203163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKZJ3nAd3O+JmEeVCfwzK/RMlporSz1eJzDT1PvrxLg=;
        b=oVarmszcCh/0C1arrqfCYFCO1VHOH8/Sf5cEQ+rSNlXPHSdCaTG7oCkgyzO+a+xvng
         zwBRwZGIJkX07ixt2sNYD0StvcTCxacsOxMNtA817Kkb6bzcdy7Ix8UmW4rzv3xkOBET
         1SGvq5KIBt9dvE2syaeb1gpOiuSfci7BdDgBjPMR/YUkJ8Xw98CHRgwUtqUuuY0WJmTE
         6KmTF3nc4ICPp7FJnpCmTG3bphp30Hb8SN3Qplb42YdrSMIca/e0FSpNz1loL/go9s3H
         e+YP6g1ru+zEXxvxVInYFLhzEAVuzoh2R1vWnES6oT9b54FlXLjkXqLl+KiMJStq/1UM
         CwYA==
X-Gm-Message-State: AOJu0YzR5qWANKXN+XBCKk8grVaqAZ8TyJV9eRLQlXdpWsQFl79OpEjt
	tg8M/Bc4aGLWDdBv4OV8wZNB9q3imeTMIBdOW8peNlg1qpxtajqf9i+agg==
X-Google-Smtp-Source: AGHT+IHxUxbKqm6nRgZY+5IXGgQgqjmuUBl+pFdg5ZtEv1OjjttjxDQgaGV8yIuIfxutMX+x/II2bA==
X-Received: by 2002:a54:4505:0:b0:3d2:368:9262 with SMTP id 5614622812f47-3d2043d1ecbmr2793297b6e.45.1717598363037;
        Wed, 05 Jun 2024 07:39:23 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80adf286a81sm1586222241.26.2024.06.05.07.39.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 07:39:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"
Date: Wed,  5 Jun 2024 10:39:20 -0400
Message-ID: <20240605143920.498159-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts commit e1c178f96a07fc43ad7523fdd4c93967843e4f60 as the
changes required in the kernel were reverted as well.
---
 src/adapter.c | 72 +++------------------------------------------------
 src/adapter.h |  1 -
 src/main.c    |  1 -
 src/main.conf |  1 -
 4 files changed, 3 insertions(+), 72 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 017ad891f9ee..821d94592451 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -148,13 +148,6 @@ static const struct mgmt_exp_uuid iso_socket_uuid = {
 	.str = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 };
 
-/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
-static const struct mgmt_exp_uuid poll_errqueue_uuid = {
-	.val = { 0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b,
-		0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69 },
-	.str = "69518c4c-b69f-4679-8bc1-c021b47b5733"
-};
-
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -10058,44 +10051,6 @@ static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set ISO Socket");
 }
 
-static void poll_errqueue_complete(uint8_t status, uint16_t len,
-				const void *param, void *user_data)
-{
-	struct exp_pending *pending = user_data;
-	struct btd_adapter *adapter = pending->adapter;
-	uint8_t action;
-
-	if (status != 0) {
-		error("Set Poll Errqueue failed with status 0x%02x (%s)",
-						status, mgmt_errstr(status));
-		return;
-	}
-
-	action = btd_kernel_experimental_enabled(poll_errqueue_uuid.str);
-
-	DBG("Poll Errqueue successfully %s", action ? "set" : "reset");
-
-	if (action)
-		queue_push_tail(adapter->exps,
-					(void *)poll_errqueue_uuid.val);
-}
-
-static void poll_errqueue_func(struct btd_adapter *adapter, uint8_t action)
-{
-	struct mgmt_cp_set_exp_feature cp;
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(cp.uuid, poll_errqueue_uuid.val, 16);
-	cp.action = action;
-
-	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
-			MGMT_INDEX_NONE, sizeof(cp), &cp,
-			poll_errqueue_complete))
-		return;
-
-	btd_error(adapter->dev_id, "Failed to set Poll Errqueue");
-}
-
 static const struct exp_feat {
 	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
@@ -10110,8 +10065,6 @@ static const struct exp_feat {
 	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
 		codec_offload_func),
 	EXP_FEAT(EXP_FEAT_ISO_SOCKET, &iso_socket_uuid, iso_socket_func),
-	EXP_FEAT(EXP_FEAT_POLL_ERRQUEUE, &poll_errqueue_uuid,
-							poll_errqueue_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
@@ -10123,6 +10076,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 	size_t feature_count = 0;
 	size_t i = 0;
 
+	DBG("index %u status 0x%02x", adapter->dev_id, status);
+
 	if (status != MGMT_STATUS_SUCCESS) {
 		btd_error(adapter->dev_id,
 				"Failed to read exp features info: %s (0x%02x)",
@@ -10174,31 +10129,10 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 	}
 }
 
-static void read_exp_features_adapter_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	struct exp_pending *pending = user_data;
-	struct btd_adapter *adapter = pending->adapter;
-
-	DBG("index %u status 0x%02x", adapter->dev_id, status);
-	return read_exp_features_complete(status, length, param, user_data);
-}
-
-static void read_exp_features_none_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	DBG("index NONE status 0x%02x", status);
-	return read_exp_features_complete(status, length, param, user_data);
-}
-
 static void read_exp_features(struct btd_adapter *adapter)
 {
 	if (exp_mgmt_send(adapter, MGMT_OP_READ_EXP_FEATURES_INFO,
-			adapter->dev_id, 0, NULL,
-			read_exp_features_adapter_complete) &&
-	    exp_mgmt_send(adapter, MGMT_OP_READ_EXP_FEATURES_INFO,
-			MGMT_INDEX_NONE, 0, NULL,
-			read_exp_features_none_complete))
+			adapter->dev_id, 0, NULL, read_exp_features_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to read exp features info");
diff --git a/src/adapter.h b/src/adapter.h
index 3534986f5a72..e3695b21b7c9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -268,7 +268,6 @@ enum experimental_features {
 	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
 	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
 	EXP_FEAT_ISO_SOCKET		= 1 << 5,
-	EXP_FEAT_POLL_ERRQUEUE		= 1 << 6,
 };
 
 bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature);
diff --git a/src/main.c b/src/main.c
index ac840d684f6d..62453bffaf57 100644
--- a/src/main.c
+++ b/src/main.c
@@ -712,7 +712,6 @@ static const char *valid_uuids[] = {
 	"330859bc-7506-492d-9370-9a6f0614037f",
 	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
 	"6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
-	"69518c4c-b69f-4679-8bc1-c021b47b5733",
 	"*"
 };
 
diff --git a/src/main.conf b/src/main.conf
index bea94640e627..82040b3fa33f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -140,7 +140,6 @@
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
-# 69518c4c-b69f-4679-8bc1-c021b47b5733 (BlueZ Experimental Poll Errqueue)
 # Defaults to false.
 #KernelExperimental = false
 
-- 
2.45.1

