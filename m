Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FE1DC04A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737752227; cv=none; b=F6b/QCHCNV3kh1uWCFB3QQELKrRUXYfDT37KORoQl1lHT95jvAZ/RE93TzyrsJwJeNEFkWQnA/kF475m7ZDd6jJ7q960vA5c/rjtD8T4urqDb0xRAOHVekDGTdBXzd6pm8tGN1+3Q0SDFIaj3FQnzWllS85CY8j+oeGKG835wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737752227; c=relaxed/simple;
	bh=In+dG3k+ZSqAGF5gMXwx0VrTsam9aE6QEuReBL3wJH8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l/DvrQ96852y+55AI2cTg3cBmuq22HY4XXfV58FWDJsOOBcR8KSaNUdB5KWV+vMfUvvtq2GeP1Jr6DxqaHrNypgSIclSrVkG/EiEcjCCOvbS/MUo5SdISRVdUJXMjgwSJQRQzvczYkkT5OuSagNZvOwfDnD4huiSuvCIml+1GQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZSPQoOO; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZSPQoOO"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afe2f6cecdso1714322137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737752224; x=1738357024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZiHdQ9avJIcbpVWAj9KtipKt/pwvvp9K5NEXMhHh0=;
        b=VZSPQoOOYKZ31SUF7c9xR8nxrO1PBTyrFtIK/Xr7bIY/Y33Ak/Zm9Vi2F1OJQQMxal
         C5MVdrz0SE+EAfBRFuI0TfqLgreeBGCROfnZH4DoVTwvcNeU3YM7t/56OysWnzdoLgNH
         rmDTDWsuj4Z+T2txj5UR6Eig4XvJBEUgERRpzTwIVrtkThWsh836AdF/KeCSVwHiv/mV
         jLt91B+rypCP4pp6MG5RwN9eUeyQqpk1DYYmHvsszAJEh9Xod/4h0KNcDk9+lkUhxyi4
         +lqfrtDjmISwayC87QSyVX0ODl9Yvi46KepjVDOtYll4P31cM0jDC3ahL1mGgSgNRFm8
         jnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737752224; x=1738357024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZiHdQ9avJIcbpVWAj9KtipKt/pwvvp9K5NEXMhHh0=;
        b=DTs8SDGXFwAsxLWkpyu1PLB4Galxi2x35BUcY6LK6tbI2a8ero52ePmZtSGHUAO4yd
         wprCGZST8SAwReiueObG5w2N/MckcpcyDeJFPAVxqIieMKepoXCYPbynEeDCr4bt54zN
         fuO00MWWlJ0yxwUGDFuGeMoCH4zJvuFIiqy13xjYcEEgOA4tsnBEQkmOPvtrv5JH3ffo
         /0ZStMOyBZkm8/f/dmsLynZzHirxWL8+lCYNUHwEOmv3T6AOBgWgjMhxfgTGCaSyOSGi
         jMlzvoncFCwpH/uhJ4elFvS6DA0kIbRBWxDP5dVmd5pyrCaDb/mubPfUxk59bPfobv3r
         xQiA==
X-Gm-Message-State: AOJu0YzLN0NHGX5J6trVL8nKZnwjDMJemVVjZ03a4bvCg5Ng2l+afhqk
	m/6wW7cE+3UBCe0vAahEQNl+aXJBw/38WxnS3oYy5BAH+GKD37pyxH5byQ==
X-Gm-Gg: ASbGncsT4tw0AWU307V8I7I66ICMTM7nFQBc774u9uVmW3CmuiovRkYlfYXYqlNA8YW
	IAn9V2G5HaLHc0H74r9xBa+3T6wlf2P8MTwHrVxR/3XZysCo2+TvGolH3uaXlZhxJ43R2EZJMsT
	2ZKbOJBxb0xre0F+qs0dKPjcyMjK93n3ZkDpieifo4orO66fm5r2l7Mzs6n+Uc8dLFZilS7bsv0
	+QtrcKyvVFf65z96rC06pXw3Ldt6QlFOPw1xZPJabU3yxuZG1fjWh+3tnfsnrpEiNjOhx2Zwd2h
	Yaq1jxdDjQJHUm6IUZR/beBr6rMmVz0B9E2vY9nXsj/cbCljOID6
X-Google-Smtp-Source: AGHT+IHNQQFXOnCgw02M1hte1IhNnxkSiwPU41/3X9BZ2k8FnjedpNzx1wpzLgqrCofnHIkWRGB7yw==
X-Received: by 2002:a05:6102:5043:b0:4b6:377e:5653 with SMTP id ada2fe7eead31-4b6f79f15e7mr8048646137.2.1737752223823;
        Fri, 24 Jan 2025 12:57:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b7097ab10csm652477137.7.2025.01.24.12.57.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 12:57:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] gatt-client: Fix warnings when reconnecting
Date: Fri, 24 Jan 2025 15:57:00 -0500
Message-ID: <20250124205700.511446-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When reconnecting warnings could be seen due to services already
existing which is a new behavior introduced by dbd6591bd1d0
("main.conf: Add GATT.ExportClaimedServices").
---
 src/gatt-client.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 6f22bbb490a7..da7c16fc14af 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1968,12 +1968,33 @@ static void service_free(void *data)
 	free(service);
 }
 
+static bool match_service_handle(const void *a, const void *b)
+{
+	const struct service *service = a;
+	uint16_t start_handle = PTR_TO_UINT(b);
+
+	return service->start_handle == start_handle;
+}
+
 static struct service *service_create(struct gatt_db_attribute *attr,
 						struct btd_gatt_client *client)
 {
 	struct service *service;
 	const char *device_path = device_get_path(client->device);
 	bt_uuid_t uuid;
+	uint16_t start_handle, end_handle;
+	bool primary;
+
+	gatt_db_attribute_get_service_data(attr, &start_handle,
+							&end_handle,
+							&primary,
+							&uuid);
+
+	/* Check if service is already on list then return NULL to skip it */
+	service = queue_find(client->services, match_service_handle,
+						UINT_TO_PTR(start_handle));
+	if (service)
+		return NULL;
 
 	service = new0(struct service, 1);
 	service->chrcs = queue_new();
@@ -2146,14 +2167,6 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 	queue_push_tail(client->services, service);
 }
 
-static bool match_service_handle(const void *a, const void *b)
-{
-	const struct service *service = a;
-	uint16_t start_handle = PTR_TO_UINT(b);
-
-	return service->start_handle == start_handle;
-}
-
 struct update_incl_data {
 	struct service *service;
 	bool changed;
-- 
2.48.1

