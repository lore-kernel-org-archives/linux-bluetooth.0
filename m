Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61563F9ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123749; cv=none; b=sVuEXpLMikthUQpKNcwDO7F0FBaXshfwxov1RV1ikHekqVUYCkJfGN/iN57XqTdPStrZ+JeLXtfZeQW+ixUUQX5JWLpl4DH95pKsYdteku5BDSnw6bXER3RPBmNjoaL9nxwLCiaVmZJw+se87DOrnpUBCvS7V3f/GRifXMaU7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123749; c=relaxed/simple;
	bh=uf0s7q+MYPMznukvUeqWYTroKcUmH7wQrDRIj2FdgFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/Ivgy16NqhrvtBmZwsLZ3avipsch9pyFiel4aFzf1Zwc/z/KD4YWHeTPHjp/h8ZyLHP9L09SwY8H2ttpLs+H8MBqlybej5RoeraPj/0QmNVSia4sopPfQIVnklV/Dx4RCu7XC/fD2dm9pcJSGY+gnGdfJ1Iatj99P/+fWr4aHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcAAMVoI; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcAAMVoI"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80b58104615so346686241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718123746; x=1718728546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBt4++ZzzESRUTI0LotWR/V4cQy8uWVXcpi0BEebXlY=;
        b=IcAAMVoIbUZ3Rt5w1RxYSFVYPLamBMv0Wky4fa6vvSE+RnL4hpxwKkNHV3G0SSRkQr
         bvNBbR9oqgg6ZBCLGQSFbXLihDHsddEMbzaO3IRUy9/8OyDB4o/RK/SE5iOm2JrwQMlb
         CvFUQ+XRzGfOA+PFGVYvuV/lbGS25V+us10Vd8E+Ssz+BVx63ed6zISqaU3NyzpHmFJ6
         Li4bCQ9SG90/+jEaO7IQM0vAdBXAVqHPuudsnMRmCkWQrOBd0Ae5jfyb65BckqIYsc1P
         Lo/h5zKYSCrzFGdxOvfxg/f8ujPlUHpNOP5uUHk5zK1u7XDxWq2U6mwqp1aS5OyC2xw3
         UK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718123746; x=1718728546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBt4++ZzzESRUTI0LotWR/V4cQy8uWVXcpi0BEebXlY=;
        b=AtxD4a6uNHn10QGnuwEbBww1PlKNw7cEH67LI0lXnxtP2m6kznx31R5okZNcwU4EgY
         n8SeKS7tjDJI/pL1CNugTuIm6ILha9uLx7gz86QU+nKT0qTg+IHVGBpBppLYygEy3JsJ
         5+9vPS+ArIhM6yaolie9oxVmT6c+9vtPKvh7ZovaIokPMlAWsgbvJgnWbfndzHSEKGum
         /1H3YPJ9sl+AXFevzrUy3828oGA0wwBWrxjJ/R4FvMCCjpcOYJ2lu5S8lDtIYZvcapTn
         eIYF/Plbzz8Gbs9UoYSrUaTiZk0S3nWWFAX0WFDtWhWIEgc+879QMurPdPY9/3vD5WV/
         wWGQ==
X-Gm-Message-State: AOJu0YxDJI/pjCLih4aj5YVItAQyx7wAEgwXw0/jDkX2fXNVHwHt+XTV
	im7EUqs0JcWLM9JpIQSEq8MwuFcAq9nbBRwZS4nM8+2p38I6qFX65h/Pag==
X-Google-Smtp-Source: AGHT+IE8VIAPDvF92FbFdx5e4rX2cnTYPUNfeqSAVLeuIZq0znyaxr5NWiwddYlqGYEY6Fz8cmBXrw==
X-Received: by 2002:a05:6122:3988:b0:4ec:efaf:a020 with SMTP id 71dfb90a1353d-4ecefafbaa7mr3959011e0c.15.1718123745821;
        Tue, 11 Jun 2024 09:35:45 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4ecf9b30a1bsm132291e0c.32.2024.06.11.09.35.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:35:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] settings: Add more debug logs
Date: Tue, 11 Jun 2024 12:35:42 -0400
Message-ID: <20240611163542.1161789-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611163542.1161789-1-luiz.dentz@gmail.com>
References: <20240611163542.1161789-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds more debug logs to indicate exacly where and what could not
be parsed.
---
 src/settings.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/settings.c b/src/settings.c
index 033e9670ac40..996eaacd36b2 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -58,13 +58,17 @@ static int load_desc(struct gatt_db *db, char *handle, char *value,
 	uint16_t val;
 	bt_uuid_t uuid, ext_uuid;
 
-	if (sscanf(handle, "%04hx", &handle_int) != 1)
+	if (sscanf(handle, "%04hx", &handle_int) != 1) {
+		DBG("Failed to parse handle: %s", handle);
 		return -EIO;
+	}
 
 	/* Check if there is any value stored, otherwise it is just the UUID */
 	if (sscanf(value, "%04hx:%36s", &val, uuid_str) != 2) {
-		if (sscanf(value, "%36s", uuid_str) != 1)
+		if (sscanf(value, "%36s", uuid_str) != 1) {
+			DBG("Failed to parse value: %s", value);
 			return -EIO;
+		}
 		val = 0;
 	}
 
@@ -104,8 +108,10 @@ static int load_chrc(struct gatt_db *db, char *handle, char *value,
 	size_t val_len;
 	bt_uuid_t uuid;
 
-	if (sscanf(handle, "%04hx", &handle_int) != 1)
+	if (sscanf(handle, "%04hx", &handle_int) != 1) {
+		DBG("Failed to parse handle: %s", handle);
 		return -EIO;
+	}
 
 	/* Check if there is any value stored */
 	if (sscanf(value, GATT_CHARAC_UUID_STR ":%04hx:%02hx:%32s:%36s",
@@ -148,12 +154,16 @@ static int load_incl(struct gatt_db *db, char *handle, char *value,
 	struct gatt_db_attribute *att;
 	uint16_t start, end;
 
-	if (sscanf(handle, "%04hx", &start) != 1)
+	if (sscanf(handle, "%04hx", &start) != 1) {
+		DBG("Failed to parse handle: %s", handle);
 		return -EIO;
+	}
 
 	if (sscanf(value, GATT_INCLUDE_UUID_STR ":%04hx:%04hx:%36s", &start,
-							&end, uuid_str) != 3)
+							&end, uuid_str) != 3) {
+		DBG("Failed to parse value: %s", value);
 		return -EIO;
+	}
 
 	/* Log debug message. */
 	DBG("loading included service: 0x%04x, end: 0x%04x, uuid: %s",
@@ -178,11 +188,15 @@ static int load_service(struct gatt_db *db, char *handle, char *value)
 	bt_uuid_t uuid;
 	bool primary;
 
-	if (sscanf(handle, "%04hx", &start) != 1)
+	if (sscanf(handle, "%04hx", &start) != 1) {
+		DBG("Failed to parse handle: %s", handle);
 		return -EIO;
+	}
 
-	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3)
+	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3) {
+		DBG("Failed to parse value: %s", value);
 		return -EIO;
+	}
 
 	if (g_str_equal(type, GATT_PRIM_SVC_UUID_STR))
 		primary = true;
-- 
2.45.2

