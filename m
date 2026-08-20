Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A438D3FC
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250668; cv=none; b=MBo8hVG3SBCu1sm7Np1sIRf2eLJ7OPr+wzdVWz+Fyr850gmJMJx2p/4Y+ValL3YJY+xhhdVEtbMj8v01K3yTSz3J0+912XM1VuE8k8oc/dtKenWnwi65x3gmROn9mqXt2l/ZWi0NYZ0snc6+OMLv7klYtzDfMkEBZHzc9eswDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250668; c=relaxed/simple;
	bh=GS8iWW3KOYyueC9Xc0634j24G6thBfU/TCzgmHWE6Wo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uj0EyEaojf0XSHh/BugMgtYGcj14yZmxYHRNcL/V6xHELXS0DsieDUEtiG78G4TifBwV7R2QiwZwsAuTD6PVpQNro8R/wK5IaqT9siJC+Lb5LgUUgHPMrv17QdlobWFCVAJZP0GbD2HPgPtBwhOjP5lcc4DpdLYh8bvEZNkPEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7bkV+aI; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7bkV+aI"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c2dbaf828eso143907e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250662; x=1787855462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hShyAifQW1rgKFq0/zPmgbqhpK87cC6GpMRd+F7QsSM=;
        b=s7bkV+aIZe1b91ekqrjnAKHKQ4uibstSlRTxFGL1egkgqHm4AV3tLyAtFDELb7W1R7
         LmRw/uIb26jdP3//nQ0euXXx4f0cVvgOjJYBIp484rREZY/Xompx+1Dhjm0Ujn9Ms7oy
         rUxW9xtnLg72G9VRLzGR/b+Ml+ecTNB05q0eiNkHlBT+Pm6dGmSFTX98ddBzyNBX7sec
         AK1MAw/OFd5360eFG+guoF2JkUwaC9I4QJMQ8YjnPsuNDc6ojKrOs0JSuJY5U9ija19o
         0YA5kZ6+U5ez2wV8HcB6hTxSvpcKSKyKk4EbjOiIKor9XLlsjSgIUz3K5/vPfDTIWhWF
         YFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250662; x=1787855462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hShyAifQW1rgKFq0/zPmgbqhpK87cC6GpMRd+F7QsSM=;
        b=I4YG4bS3fJDe19B3qJagQqP4tAIjAcbDIJTYBlihU9D3WI03ZtfoEYvEt8qkjS64aS
         jQPRDVMqRzpwFSCkw5z7wLDGKHRHtVWeU2S9iMT1hXTJZC0evEKPZbFqQbCUbiCBjs5f
         uHPjgviJ/wFlQu/WcWF8tPHVTq0uK6unpq/vST9xtlSFf9fqJqXAbAAdUNHDU4r+fl9T
         DVuQBWQJrBcUmstFXBkoY9dSgXlseqX6lNhJCl/AI7NkDuZ1UmoZu1Hfo7U5mPzqrHvd
         GHbi3S7ZyReHhPiQcv2nS7QAUwpQRq62tPhuY4/CALhNGXMAu8nWFRoifnR0943cA12e
         DQQw==
X-Gm-Message-State: AFuF++lFpvEheTGyijp7u4+o9QQ8tW2hH5rYGZW047ZyvOtdngonCbMP
	M3CUBSbqMcr8iJeckTridHJGm1tZXZOb+hSc4cDDURhZmErXc7+Plw9qMdpPj1UZ
X-Gm-Gg: AR+sD13J9OwzMrZCEmTAGhGQUSnGRsQTeTJdi+nbVVAirw/hAag5FuSXBoEREj4OyzO
	FVTaHKbi9v0fWK3oW2WB0OMfxAnnJdIs5Ja9il/ZeRObx+5UP16Dm0iuDCWpBIiWGD26PzkuALg
	OZ2tEeLj3LJ0kAhFHNFyXGxrklurFP3UDvvj2LNR5A9cGdJwT4n5eQp6M46TT18sXYUY2yvdsYU
	iqWbpH4gKZJUA9JJmYCt35WUoIoXFjhCBlV+4aqerFlgYzdIbSS1w+s66ODlIEGLug3gl1BKqiO
	DZnJ0p2g7f8ZtXnAHlqubhAv3XGH8Cw3ZUtV2er5oRzCumqj70s87vCwHPTJfw+fvpnO+5vUOCc
	nb8DTx2pU1flkxMOdZ+Lo+xBlFoM27ETw/OJV5bPizTcpneKe9T5BJxV6MWFfeDI2W2Fl85sDwf
	JRomHEvFFfTfJoWXvGDj3CbN1HpTEPZQl7B8zGVwxfsawMyFmvqrJ/Y0N2rlzFxWoYEGDVwKFxx
	8opaKdMrlpgrJ8yKVgswMaxi1HWlbGugoHdY28dN6t8Nr4UAjz2Dwg=
X-Received: by 2002:a05:6122:17a8:b0:5bf:b5e1:f8e5 with SMTP id 71dfb90a1353d-5c5ff7128e6mr300620e0c.5.1787250662167;
        Thu, 20 Aug 2026 11:31:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e276d416sm6840662e0c.12.2026.08.20.11.31.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:31:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/10] device: Rename btd_device_device_set_name to btd_device_set_name
Date: Thu, 20 Aug 2026 14:30:36 -0400
Message-ID: <20260820183037.2713973-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820183037.2713973-1-luiz.dentz@gmail.com>
References: <20260820183037.2713973-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The "device" was in there twice.

Assisted-by: Claude:claude-opus-5
---
 plugins/neard.c    | 2 +-
 plugins/sixaxis.c  | 2 +-
 profiles/gap/gas.c | 2 +-
 src/adapter.c      | 4 ++--
 src/device.c       | 2 +-
 src/device.h       | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index edfc115373ef..1633dd576747 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -629,7 +629,7 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 
 	if (params->name) {
 		device_store_cached_name(device, params->name);
-		btd_device_device_set_name(device, params->name);
+		btd_device_set_name(device, params->name);
 	}
 
 	if (params->services)
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index a04a76d394eb..fc2b2a9d0156 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -362,7 +362,7 @@ static bool setup_device(int fd, const char *sysfs_path,
 
 	info("sixaxis: setting up new device");
 
-	btd_device_device_set_name(device, cp->name);
+	btd_device_set_name(device, cp->name);
 	btd_device_set_pnpid(device, cp->source, cp->vid, cp->pid, cp->version);
 	btd_device_set_temporary(device, true);
 
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 5184d74e8f07..495799e641d9 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -86,7 +86,7 @@ static void read_device_name_cb(bool success, uint8_t att_ecode,
 
 	DBG("GAP Device Name: %s", name);
 
-	btd_device_device_set_name(gas->device, name);
+	btd_device_set_name(gas->device, name);
 
 	free(name);
 }
diff --git a/src/adapter.c b/src/adapter.c
index c21b3e7fbcc2..cf59db4aa5a9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7628,7 +7628,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	name_known = device_name_known(dev);
 
 	if (eir_data.name && (eir_data.name_complete || !name_known))
-		btd_device_device_set_name(dev, eir_data.name);
+		btd_device_set_name(dev, eir_data.name);
 
 	if (eir_data.class != 0)
 		device_set_class(dev, eir_data.class);
@@ -9814,7 +9814,7 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	if (eir_data.name && (eir_data.name_complete || !name_known)) {
 		device_store_cached_name(device, eir_data.name);
-		btd_device_device_set_name(device, eir_data.name);
+		btd_device_set_name(device, eir_data.name);
 	}
 
 	if (eir_data.msd_list)
diff --git a/src/device.c b/src/device.c
index df607f718be1..9609a14f7883 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5101,7 +5101,7 @@ char *btd_device_get_storage_path(struct btd_device *device, const char *name)
 	return strdup(filename);
 }
 
-void btd_device_device_set_name(struct btd_device *device, const char *name)
+void btd_device_set_name(struct btd_device *device, const char *name)
 {
 	size_t len;
 
diff --git a/src/device.h b/src/device.h
index b890f23d4642..7683be82ee3f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -23,7 +23,7 @@ char *btd_device_get_storage_path(struct btd_device *device,
 				const char *filename);
 
 
-void btd_device_device_set_name(struct btd_device *device, const char *name);
+void btd_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
-- 
2.54.0

