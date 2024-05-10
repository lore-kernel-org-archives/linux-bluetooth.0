Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDC17108A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353785; cv=none; b=XEuOulRu10FHg+Oapn5Of5rWsQIhMh2fnPUplRWEuSueo9D+zcsHZuPJCTbARUF7EsZrnz0bWkz0QLUcv/T/xjL5eV8rUu+VmrtzluOyeL5LxX3Z9LDtzeSfE7ypQ758/lblCTQeUwflE1NWdaiw2+baFBTALm2ws8ke/rPUHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353785; c=relaxed/simple;
	bh=rlrNutOX/JtzQ2vvYouzl+ju8rzQd9ExsU6WNCQAOKQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QipZMLZ+GlzDJV+owmUoyk0Cm4cc3vThm7FjSs77ecyDu7X1JpJND4/tn6IokPKr/5EbNS1hhqU8XUm9Iezkgon/VSCfw1ZhgBiYbtibpInCEyHsCcYqtIsCKibNHnFiGthsIQ0fFonm+Q3YBweGfaU6KLwozehZACPu/7R6GQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COloPPDO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COloPPDO"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2339356276.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715353782; x=1715958582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NYPamNuvUWNaKXtsTZIVx1vuT1dcpKc6L70cng3uqM=;
        b=COloPPDOFfzze7ik19N28aVRjxl5Mnlp16V80gVpf6OW9JPqJdCp0mNMlnzQEhtQCW
         vtegHRwiCd2E9s3Hfsp8/96HyM0BeKIzYQn2YQ7x3iY9H6XtHogk0FdiWTI214bw9cQ9
         IP9NZlX3P3L2yPyc9hIDCPWb7pF+Dni0R5k7mrdh1OS92aT7aPLUz6XI/pK5fs6RFImT
         PnV5kazNdAglBW5AipNq6AfVz6EorKrwMSR6/Y0KEeKv+EOLXil5ClQvK6e0i7oAaEQB
         zhH7f8V5h/GxcAiGBFm6PbsxObCzzrNBIavufP/1TPeaXXe0WkwIABO87oGJIgaI4OBe
         Hfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353782; x=1715958582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NYPamNuvUWNaKXtsTZIVx1vuT1dcpKc6L70cng3uqM=;
        b=JDQlTz7Sx1rNnHEEZFZASjgB6dSjXZFddV6xs4esfXFFSCMZz/MgXB4X6Tc1CNhr02
         d2uMjjBwNYEOI3HwDkIS/tGldQdNTwwdPOG5Q0p+wZTqehcLf+UTOinwodf7C7JR+60Y
         30k7toRfeE2peRlaZSAl+cL/rLOkfXdEjaIubz6geofSgzbiRq+M619ZSeWCx0PdFFQi
         I4dAvrJCrlyTzgg/cQU/eTGy1dy8klBvd4vdVaeDuY7VlcPVCapWR0ATbW7t4Ajf928h
         nHv6xPugrBh/DUgM5kKjN9wJbxXZ1lOzn1osGrm54NyNQ2SoUZxG+1kFtnudWFdeJ0Zx
         8XQw==
X-Gm-Message-State: AOJu0YyWKO/OV2Tz7gC3dqcGOdXesPavAPqEufsoWmPZ5wQDAvfexCXU
	KgVC+ND5pjJxy16P+8FvYPXQUc+8+a6XoI4OVRtiMVcUgv8kksIqa99yqg==
X-Google-Smtp-Source: AGHT+IF4o0wpXSuGWG8Y59SAyEPgZD2rs8AZ79lpjOK39mjjUACda6H5Uw0s67r4FCvVL5lLdb6rdw==
X-Received: by 2002:a25:b985:0:b0:de6:168f:f2d7 with SMTP id 3f1490d57ef6-dee4f4ee845mr3064185276.55.1715353781886;
        Fri, 10 May 2024 08:09:41 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm510050137.2.2024.05.10.08.09.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:09:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] src/adapter: Added connection parameter load/store functions
Date: Fri, 10 May 2024 11:09:36 -0400
Message-ID: <20240510150938.1492169-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510150938.1492169-1-luiz.dentz@gmail.com>
References: <20240510150938.1492169-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Felipe F. Tonello" <eu@felipetonello.com>

It is interesting to let other parts of bluetoothd to access these
functions since there are few different use-cases where this updating
and loading connection parameters can happen.
---
 src/adapter.c | 34 +++++++++++++++++++++++++++++-----
 src/adapter.h | 10 ++++++++++
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5505edbb29c1..4943e5e88e70 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4635,6 +4635,30 @@ static void load_conn_params(struct btd_adapter *adapter, GSList *params)
 		btd_error(adapter->dev_id, "Load connection parameters failed");
 }
 
+void btd_adapter_load_conn_param(struct btd_adapter *adapter,
+				const bdaddr_t *peer, uint8_t bdaddr_type,
+				uint16_t min_interval, uint16_t max_interval,
+				uint16_t latency, uint16_t timeout)
+{
+	GSList *params = NULL;
+	struct conn_param param;
+
+	/* Only versions >= 1.23 support updating connection parameters */
+	if (MGMT_VERSION(mgmt_version, mgmt_revision) >= MGMT_VERSION(1, 23))
+		return;
+
+	bacpy(&param.bdaddr, peer);
+	param.bdaddr_type = bdaddr_type;
+	param.max_interval = max_interval;
+	param.min_interval = min_interval;
+	param.latency = latency;
+	param.timeout = timeout;
+
+	params = g_slist_append(params, &param);
+	load_conn_params(adapter, params);
+	g_slist_free(params);
+}
+
 static uint8_t get_addr_type(GKeyFile *keyfile)
 {
 	uint8_t addr_type;
@@ -8919,10 +8943,10 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	btd_device_set_temporary(device, false);
 }
 
-static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
-				uint8_t bdaddr_type, uint16_t min_interval,
-				uint16_t max_interval, uint16_t latency,
-				uint16_t timeout)
+void btd_adapter_store_conn_param(struct btd_adapter *adapter,
+				const bdaddr_t *peer, uint8_t bdaddr_type,
+				uint16_t min_interval, uint16_t max_interval,
+				uint16_t latency, uint16_t timeout)
 {
 	char device_addr[18];
 	char filename[PATH_MAX];
@@ -9002,7 +9026,7 @@ static void new_conn_param(uint16_t index, uint16_t length,
 	if (!ev->store_hint)
 		return;
 
-	store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
+	btd_adapter_store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->min_interval, ev->max_interval,
 					ev->latency, ev->timeout);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 2ca045539ec0..3534986f5a72 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -289,3 +289,13 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+
+void btd_adapter_load_conn_param(struct btd_adapter *adapter,
+				const bdaddr_t *peer, uint8_t bdaddr_type,
+				uint16_t min_interval, uint16_t max_interval,
+				uint16_t latency, uint16_t timeout);
+
+void btd_adapter_store_conn_param(struct btd_adapter *adapter,
+				const bdaddr_t *peer, uint8_t bdaddr_type,
+				uint16_t min_interval, uint16_t max_interval,
+				uint16_t latency, uint16_t timeout);
-- 
2.44.0

