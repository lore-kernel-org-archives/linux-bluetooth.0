Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B31F03C3
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463664; cv=none; b=HULD63adwjd7UVmXTCPo7uuCQTk6Dijm2EFlS3fGFmfykaD5IwPCMyhMlYFbYTkRiEXUyOhaW/tO122klJbvu8zZ4pw3yVKODxgpD9GyJk6ASvcY7pVXqBwP2MEUpVkjqvFXZghuUD+RguuxlqdBuzj4qF6PIYaC6/Ua+M4qDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463664; c=relaxed/simple;
	bh=Ht2bEvcviyDOnuUoUna0SildHQ02MGAV1ztnDIlhDAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abeeR9jDPWnmn5Ix1a61VARsHaYle1DPMIAGKenxnEMi4+7LtVhEpsLWmfUX5X57n17b7tKBI/Wyufa6+XGFPOmSFgh9m1syJ2xujPb9MOW5XdL9M43LqRtoMu9shw3b3DwuzrWD4X7fB6xSC21cpgvlDDl2PC1ai4qYI3rYAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=F7ugaUEU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="F7ugaUEU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso8388277a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737463661; x=1738068461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Rk6pDXs8zGzcrI1wCYal82gpP98EkNSIPLnCPhbco=;
        b=F7ugaUEURh4FjI7aKjhOmggyAf9vM5uEoWurkKdSBX5uCGTO6Le4KwoJcsefyxB3DE
         oTqPttayC3CRbzNyomWIuJ5x85Q/xBU9rYFyl54C02/G9nXii9L7kttFcjDKhcm3McbN
         EAbmL4s9AHqZpr/uJ9dhoYcErYCAbGRzqOEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463661; x=1738068461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/Rk6pDXs8zGzcrI1wCYal82gpP98EkNSIPLnCPhbco=;
        b=Ztg+DNAarmLA/KetQTdHSZh9H9+cNeYRgzUhwR/Q4dG1zg3IPcCM/g4P9oyl7EchnM
         uTxoTS4FsV0+DEJm30OlL0eWujgKceRWEJ4vbCUvq2wB1wczb4iIy0KlR7f5sGCWOYre
         M0sYkGPk66MP+4Oqo2dkxQYuzk079KocMYDNd0N01ce7t+VfbPqSHoBqq89x3Z3rzc6e
         3yZKLmHRS/27RH9eDUmgyFD6LM2SyV5j4+JLJahDPS76oMy2SYm1ay5fn6+H9NthPE7w
         LJE5QEpwm93KEZCfLJ0iJATZPfc9e0ZJndcjcCx+TjC1nneQQr48pDZ5nLLnQROKnFlx
         KgAg==
X-Gm-Message-State: AOJu0YwieTiUCJ17P4oLHZmxS4bfwS2v0Eha8e9HhXM0UJAPeBV9qTPa
	GrmfY7BFGtg4CWTdH7v4tPhPp4TJXnwdWlEbkD/vlYqD0gY5T1M44sg1ysPPWRHimiG+VVWKlVU
	=
X-Gm-Gg: ASbGncuRaDwxdYC2RDbeI7tf/g0j2JiQCGeWpGToIZkaRAj9C9Z3KRx42MHbziyJv+V
	TDZv910x6JoLL63Zexe7cnJsl4CnVhwKQNg68tjwZxV/4IiunK3rpjJU7tV/dnJr0gzoLKR3XhB
	rTRSXvEHwR/hON5I6cux47IJGrRkYaRwJTuFxv6GTNndOQ8TsuFHFxxqqgo+QU6m8WmQk+y+XNY
	E8CDfli6FD1XiQVUiBGPt1Qx3sFShMOHbUEytIY2VOhmcc4FC7U+wZ+r/UnvftG4SpncHllYy50
	gvQSnoIu6Yrgp+mzxzJk4BQk2v3FBe5HZ6mQ+IxAIfxb
X-Google-Smtp-Source: AGHT+IGZ+cPtfWjV65USxxCd36UuFPVAG3i6SE4uH3HWAWL5+SaSrn3T3roxqPMTrm22bc+538QpKQ==
X-Received: by 2002:a05:6402:2791:b0:5d0:abb8:7a3 with SMTP id 4fb4d7f45d1cf-5db7d2dc6bcmr46275959a12.6.1737463660756;
        Tue, 21 Jan 2025 04:47:40 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm7153591a12.19.2025.01.21.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:47:40 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/5] audio: fix VCP connection management
Date: Tue, 21 Jan 2025 13:47:17 +0100
Message-Id: <20250121124718.3995904-5-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121124718.3995904-1-michal.dzik@streamunlimited.com>
References: <20250121124718.3995904-1-michal.dzik@streamunlimited.com>
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
index a0c77d45f..dc21771f1 100644
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

