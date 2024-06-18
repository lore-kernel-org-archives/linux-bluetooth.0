Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CA16DC13
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740759; cv=none; b=BrH+w0Z1vQW7Mwkp/hyaqgRWnCXDZXLvuLOUuVHbDvNAIgy7Jpd+I3st0YGivSCHooXdRwNVMpwh1BjRAlEKvBmyL8c+8mWx/cuqwgqHyqMNQ7lk6R93ScUe+zoUZFLzBv5j4XshgArC3TKaJwucb9CoVoyx4TeKSqE68vW/S80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740759; c=relaxed/simple;
	bh=KPRO9K8znTLH4N++Pw9KtOdVsqL9gLZ4JCCu8wTDLnc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eLSIpm9pQH86BWgi3DWrw2fwjzH3OoiO+JZgb3KDogMPfBubKDTl3eoSatJ6lAroGIYCQbiya6Ry99ZmXzWWjtHGg6TvgNWGOfYHnFeef4gH5prO6xbRNL1LaHQRmdEtK2NoKaJsMsMw7IMyq7vwMYj0wGO1vaWXNpTtsUmcTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THNwagTb; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THNwagTb"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80d6c63af28so2221554241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 12:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740756; x=1719345556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUChMKBl7Uk/LYywKjq7tFinr/EaniquZ+qsBJhKnyU=;
        b=THNwagTb//KmviyDZY+bbMAb8ngwyq/jz4+B4Mxg6JlaxKuW3JTov6+j6EN0yRx6Br
         Om+IieMwwcrOwkpvqkQWe6bxwczXWKqI6CsqGatZFw/pBBggTzCMWBJozfaEzQq0WPLy
         9f0bRVrsWkGSc61AlXZp8SlpGoiGXNMv76lF9cU7YBVT8pF4c2azvxDqi/R9U8Z1/3Ih
         gh4c5PVTKfq8grECAnzsW3bJv4TSnMW2VzIeljNM4tYOqvR0jawbMksOS7HmjvGAGAke
         ZPZ+ciF5Gcbs8glYQ3ZiW67kdlWXW1h+JMMZf/8hLYOjPEDQ2ReHe2zMx1oU8fgjvvXI
         CTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740756; x=1719345556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUChMKBl7Uk/LYywKjq7tFinr/EaniquZ+qsBJhKnyU=;
        b=veEdhdRf4OVH4dwKGYMv40h6PMkPlTf+ETAc/s1yup2/QqKtv58aoICspU8/F2zx30
         scorH2TGAQ2O/UUyyIoxsDEYrQS5bf1iq3thif1RkQP2qjd5evDGSedcjFL+07uVkMjj
         DM+hSyuTbeHvtLD2NPohanVfmhLarnhFdNBXrMgNAdGnGvC0KLBIjxIW/HyGJ7jnNDv8
         2QKsIlw8jtD/Otxl1Ckl/Qgs98N13gX2PvP4MEWA6cA66QuexEvXhxhKnJ66FYd80sl0
         T5Aj8QrNnnLXh5Z01OhMrwzRh/dhR9PbpVBNvqAOwau3NPQ/QqiFNTIbSTD5QdT+CC3j
         GdRA==
X-Gm-Message-State: AOJu0YxnKfMfAI4GwuCHoewy/9UvkQ4Z5QLsFQ0ApvMov2m/OFEfD7s0
	FF8B3A5tIGMlpAtL/ZyUA48WwzuXy5MfTQIhtkT2B6fD2MOlPHS+NqGFMw==
X-Google-Smtp-Source: AGHT+IHXpQY+8GrkkKWafrl9+C/SSccwNGxMQItaRRcWHC1G+/BdfaGttJLimx8ya1Xw+ojlwMx3XA==
X-Received: by 2002:a05:6122:4121:b0:4de:847a:3647 with SMTP id 71dfb90a1353d-4ef277801a6mr1018480e0c.11.1718740756394;
        Tue, 18 Jun 2024 12:59:16 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4ed3fcb1a3bsm1770092e0c.24.2024.06.18.12.59.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:59:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] gas: Fix reading attributes on every connection
Date: Tue, 18 Jun 2024 15:59:14 -0400
Message-ID: <20240618195914.2470373-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Attributes only need to be read once after that they will be persisted
by the core so there is no need to keep reading them on every
reconnection.
---
 profiles/gap/gas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index dbe5f003bfba..08aaf19cb332 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -342,6 +342,10 @@ static int gap_accept(struct btd_service *service)
 		goto _finish;
 	}
 
+	/* Check if attribute already has been discovered */
+	if (gas->attr)
+		goto _finish;
+
 	gas->db = gatt_db_ref(db);
 	gas->client = bt_gatt_client_clone(client);
 
@@ -364,10 +368,6 @@ _finish:
 
 static int gap_disconnect(struct btd_service *service)
 {
-	struct gas *gas = btd_service_get_user_data(service);
-
-	gas_reset(gas);
-
 	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
-- 
2.45.2

