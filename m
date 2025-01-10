Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B843210F65
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520643; cv=none; b=J7hipBT0k5WTT3kvcBuIC/ev/pz/vaUalFXMoUeHoGdxP/b1/+DpUB1HyBNpxKDCoedCQRn6DhjyQm/jQzZbmm1dS64a7Lr7AxKGBXMRnA1D3NrWc7SUEzQi90apSymUsU2GNTCFbsetr43SA+wo1j3cVTPKvgdU2g1YMjFIAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520643; c=relaxed/simple;
	bh=eKLHUfO43SPVOhmhCvWL7q+n6hzBedv2LyRDg5DL7TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9ZMQ4DycNBvwXTaonj43WHCjradw9xhX9uwa/zALTiIF7/8e8pD3VLVI9i+eRDt/0kMdy4BlA7dPJa+xDa3OqdYCFuixx///On61TTjCzbxIwhQzFwS66jGERmzmY1JxC+uk99os2r8DHqG9xYNhU0dNCO/4IDKlaZtADb7E2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=r5WkxPBt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="r5WkxPBt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so3374528a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1736520638; x=1737125438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og9SUFsPb4dzDEkWY0WllSX42ME4js2AX+dHBXv+ZKw=;
        b=r5WkxPBtHHFB9x6ux3sX3h6CVHzTB9nYDGrFZNg9rkTCur5aOQWKuo+7ZRp3TC6cLU
         GIvm2Ed7DvCLcyFIxbv3wA1/TvbQ7HbwCxGpDmT7tfZRaWOnKgIb8xfIGvwGAltmyeHi
         8/glETkBqCy5OJkOB59xlHVt+9O6ncrcanyCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736520638; x=1737125438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og9SUFsPb4dzDEkWY0WllSX42ME4js2AX+dHBXv+ZKw=;
        b=IBJXdKr7MVbuot9mwec2CQ9OeRdZMX+2Rc1rhKJDuli8mxa16gmnRkfg1Oky4hXM9G
         724VbjIYHSaxZIu7KswJFXNdlN2uofQXJjlr/YXha8ZGPiOz6KEmLg/L2NjZxl+0k/6+
         5nNTee1uMoFo0a4lxLdcfSpTezwQJnsXW9vF6x74NWj1mUE7j2VE0At43Y/Yq5Zlf8Ig
         5MAg/gnvlChflWd23GSC1rTvNv4sdHM+3SjHx61YEOVYh+HSjZtStqFH62YpKV65+IVd
         nrx8YWNL+wvBejTQk5svONKCO/4Eef5ymWrpDVHae96fe/79d92dBINA57gn4Eg8oc2L
         QlgQ==
X-Gm-Message-State: AOJu0Yx+5VJUAkrjqlqxcU1yChvWzXdxRCEJT1tklLaCJa4mByKR01qB
	Y//rytXJ4IgVVx3PuPovXrarpwipQcarMFRzEsfScZgt0Ngi1eiq4TTR+Y8h8RRjm+SdhAwKgcg
	=
X-Gm-Gg: ASbGnctU0VSqD1RL6aa/qxRW5mUovp9zJd/6S96GoMcDVmBb1DMyWOwQhBr/Lgd90Jg
	qrRt5Y8mS35S3J0ruPnRFDliObUanm7/dPhBuVaG70W/AIQ/pjXWQ9/y+2M2Ey5rhW7/iWDwBTn
	ahcXARFIc9kUY/IxSQgVq9khTCUo2iGQ4J9tMBHeic6XlXK5ZKhqHVU0Tz5N/WtHTV2nFR24PRR
	qq6QV7hWjnr2MGtndfN+BsWCxBTfcryVfe0ncGei4/EZaUIMBmUH6bprqBzK0TUaf+RIuwLNu3y
	xL85ASabKzjsLx9r4x27UXrBHn6HNjU=
X-Google-Smtp-Source: AGHT+IF8vVHknGKrgb5+O63lELfiZy4gZsUD4Iatx/0DjGPHP33Rp2dtISTLnN/PL75rrc46W0ev0g==
X-Received: by 2002:a05:6402:5255:b0:5d9:b8b:e347 with SMTP id 4fb4d7f45d1cf-5d972e722e6mr10500795a12.32.1736520638625;
        Fri, 10 Jan 2025 06:50:38 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c3fccsm1679331a12.21.2025.01.10.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:50:38 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 2/3] vcp: fix memory & connection management
Date: Fri, 10 Jan 2025 15:50:18 +0100
Message-Id: <20250110145019.2380299-3-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com>
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
- vcs members are cleared during disconnect, because they are expected
  to be null when connecting
---
 profiles/audio/vcp.c |  9 +++++++++
 src/shared/vcp.c     | 23 +++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 83e568f22..0203673bf 100644
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
 
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 489cd2b97..c92eb00d4 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -389,13 +389,24 @@ static void vcp_detached(void *data, void *user_data)
 
 void bt_vcp_detach(struct bt_vcp *vcp)
 {
+	struct bt_vcs *vcs;
 	if (!queue_remove(sessions, vcp))
 		return;
 
-	bt_gatt_client_unref(vcp->client);
-	vcp->client = NULL;
+	if (vcp->client) {
+		bt_gatt_client_unref(vcp->client);
+		vcp->client = NULL;
+	}
 
-	queue_foreach(vcp_cbs, vcp_detached, vcp);
+	if (vcp->rdb) {
+		vcs = vcp_get_vcs(vcp);
+		vcs->service = NULL;
+		vcs->vs = NULL;
+		vcs->vs_ccc = NULL;
+		vcs->vol_cp = NULL;
+		vcs->vf = NULL;
+		vcs->vf_ccc = NULL;
+	}
 }
 
 static void vcp_db_free(void *data)
@@ -489,6 +500,7 @@ static void vcp_debug(struct bt_vcp *vcp, const char *format, ...)
 
 static void vcp_disconnected(int err, void *user_data)
 {
+	// called only when this device is acting a a server
 	struct bt_vcp *vcp = user_data;
 
 	DBG(vcp, "vcp %p disconnected err %d", vcp, err);
@@ -508,12 +520,15 @@ static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
 			return vcp;
 	}
 
+	// called only when this device is acting a a server
 	vcp = bt_vcp_new(db, NULL);
 	vcp->att = att;
 
 	bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
 
-	bt_vcp_attach(vcp, NULL);
+	if (!sessions)
+		sessions = queue_new();
+	queue_push_tail(sessions, vcp);
 
 	return vcp;
 
-- 
2.34.1

