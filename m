Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9049641
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470671; cv=none; b=BzX0/T0h0b6ShnNM/qEbU4fqDqo5hMHeiQ+YRNpjBeBAVrW9nV6muVV6h7Shz7Ai2ODkZFlLHp1CZpGm7dFmOHXV2WgFz5bKXbpSY00mo2cQDbzGta4QzdkiH5+QEf2eVZEIHMX25Cf8S20AV/jdoHuuzbe+5QBvjuCrKMJSBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470671; c=relaxed/simple;
	bh=BNkubpVSm10suv+o6ql/8MFhA4pk6I5o78eI9o+qmUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4kzqKdqbyF4nNIJZv8DnYndV5JD468PY29yhyfsCNeaMyAyU3tI+YY0UW5Cnidpkr8MML9MsETWTeFOPpte4v6rBjHrGPtPAy5apvxnSpubg903vrC5RMfC89VOn8sdTb5BQ/75/qYZsP2R4+XsaIr1yAMYdFLALVDS4k0I8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=ssSfVEHW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="ssSfVEHW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-540215984f0so6143970e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470667; x=1738075467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erG11dIqQwlizbPs8opfHOp1y57ZM2gmol7QUTaAt48=;
        b=ssSfVEHW1gYWoDIbPKzW4qz54BkejDr5TUaDk3qnGFqXH6sFmZQd9EO8QVzQPcy31n
         R8fa9tAJGg+/6GHoQmxSO/TpwH9eQWlhUeGi29ynnCeNI9LVqhPb4eYVqGc4lEVYs++R
         q7tQl7Ea9KkMVSIljQcoTPM0oZMAmlJ74XV4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470667; x=1738075467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erG11dIqQwlizbPs8opfHOp1y57ZM2gmol7QUTaAt48=;
        b=AImdvCZez/rFrsU0vn5eEOAhpqdTOmepm27jTrn3O8TPg3bwXjsX+nJDnIQHCCRB37
         pCGUW0QmW2EBh64hpfmkdUV+nErgUrZi0q+DhhiiMAy/CPEvD6adynltcV1vyPpdHZst
         H7hkzz+mDmAE1XbOPLgL0Yf7/RT4txVGCCuttUgs6BqvIjuIEZrbbDf4rrPqOHoNGQWp
         DM+imYuLFFaQ7yRIYYkpyg3d0kqALPkzKIviz0bhiWRiwE1B/9FuRMPnOxb+waW3CszM
         gaA+sOWbFkIo5vtA7e9EES5aAVeJFz+rfja+KvkTUMCKzQgLfYzXaxm3/bHnO4pJYXj8
         EopA==
X-Gm-Message-State: AOJu0YxgkAPhCBE4OJwEV9l9swMrsjRq6VQKmnFPJ7Xiv02YO4QYlsYB
	6esreL1uXPa/5QThPul0xPSvLyyJwrdoII+egCnIM5d8uRSlgfRFxJ5FxvZckrI6VXqjt/xy3LQ
	=
X-Gm-Gg: ASbGncu6a0dmfYmNWXl3weMbOyft0RSW6YAbyUwlvWY+FOQwGZqzWMJb9Q6+C4B20zS
	qXH4uAyzORsnRLQE9W/2k65J2Ioy92Mi0KsKKkYncccdigOdyH+nAWpso0rDFDBR+6MTMQBM2nv
	6wcoAgRj0Lz4K9oIe9gWY4qeYks9kgz74XyLvd9c7Wyz8i0evJYZFShK8Fr6uxYU4scsqGXkdS3
	2XStUUTczm71guTfP8CLeMT3a2XWKhOAG/XqTQ/2if4XRRmFPSyEvkKdx62mgiF0Fo26MrlllLJ
	bU0PhgRBeZXMSLPlxZRD1WVy7YDclq61FH1Y8D5DJZzg
X-Google-Smtp-Source: AGHT+IFhtpSAfIXZ+g6gdTp+54oM4L8oJbLAtE62uv//FT0/X757UXG7mu92gnTdRzBtvMWAI/3PGw==
X-Received: by 2002:a05:6512:32ca:b0:540:2d64:4ef4 with SMTP id 2adb3069b0e04-5439c1c8879mr7487795e87.0.1737470666786;
        Tue, 21 Jan 2025 06:44:26 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:26 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 4/5] audio: fix VCP connection management
Date: Tue, 21 Jan 2025 15:44:03 +0100
Message-Id: <20250121144404.4087658-5-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
References: <20250121144404.4087658-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those changes are mandatory to be able to connect to the same VCP
renderer more than once without need to restart bluez.
- use vcp_disconnect() to close client connection and reset vcs members
- call bt_vcp_detach() the same way as bt_vcp_attach - from btd_profile
  callback
---
 profiles/audio/vcp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index cc6f352c1..d3723515a 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -72,7 +72,16 @@ static void vcp_debug(const char *str, void *user_data)
 
 static int vcp_disconnect(struct btd_service *service)
 {
+	struct vcp_data *data = btd_service_get_user_data(service);
 	DBG("");
+
+	if (!data) {
+		error("VCP service not handled by profile");
+		return -EINVAL;
+	}
+	bt_vcp_detach(data->vcp);
+
+	btd_service_disconnecting_complete(service, 0);
 	return 0;
 }
 
@@ -188,7 +197,7 @@ bool bt_audio_vcp_set_volume(struct btd_device *device, int8_t volume)
 	return FALSE;
 }
 
-static void vcp_detached(struct bt_vcp *vcp, void *user_data)
+static void vcp_remote_client_detached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
 
@@ -203,7 +212,7 @@ static void vcp_detached(struct bt_vcp *vcp, void *user_data)
 	vcp_data_remove(data);
 }
 
-static void vcp_attached(struct bt_vcp *vcp, void *user_data)
+static void vcp_remote_client_attached(struct bt_vcp *vcp, void *user_data)
 {
 	struct vcp_data *data;
 	struct bt_att *att;
@@ -354,7 +363,8 @@ static int vcp_init(void)
 	if (err)
 		return err;
 
-	vcp_id = bt_vcp_register(vcp_attached, vcp_detached, NULL);
+	vcp_id = bt_vcp_register(vcp_remote_client_attached,
+					    vcp_remote_client_detached, NULL);
 
 	return 0;
 }
-- 
2.34.1

