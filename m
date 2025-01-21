Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A96D1F2376
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463664; cv=none; b=GqGdcJDIlDsIW/zuwED0bkT3fwGoMPMlZddu/tZCtmkSyJ38vbywSfZVZKnJNvjZjsly2RueR/apB184/K5apy0C7Eep3OEbxG/fZI4kAGenHWfLRNW3NKmMiLBqs2oIMUaeM/FyMXAzEwicw5UHRUvBESl9viFNq7i6BSf4lzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463664; c=relaxed/simple;
	bh=TqiJSHNq+e3qqPdiBb4X9IRUX8pgul3fXpmo5HKqD8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BL2pK6xa4Ng1J6xwEekczcInGbo7AnSaq3pYuBLSpj2Ua1D72Psrmb7SopHluLn4e6kz3umuP8b2MqPR+j7LNmIyr/ZQ0No9AcJm013K6hY3fE6T8dT9vtAAcfJiSpL6GeVlir/9dbvmax9rGQ/41QjnePbRvBYtuQ+NsICZ5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=t56KfbwX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="t56KfbwX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5da12190e75so11436478a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737463659; x=1738068459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I3MtPMq1q/q7OhoezyHC+aX2aZ5CTAnHXUsCORbDLU=;
        b=t56KfbwXMXXFE5nDrqW/mbq/sXmUuoxKJFjY11qQmYKs3B8h+f0tb8wWgpvSjgDh6c
         S7i8cwNVY9ePDqkhhguzPQdYld5muccqGHGBCJdVhl6pvsAkLZS1bi55WXVNtBCMlsso
         N2EoBWHRMI+RnNgBuIHlrJRUom5HdNiv8CAbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463659; x=1738068459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I3MtPMq1q/q7OhoezyHC+aX2aZ5CTAnHXUsCORbDLU=;
        b=UG+CsocMgbrhcTvAvAr17BXSzZRSwyxJosmkIfzl8RTei5wh0vk7z+EHnOnvUuYbiz
         bkCCCLJ/Ax1IcrLUgOr3zKb1n6NwWBtuCXoTMYHCOzbGxSWUsmoWtQHiQkVpsFCO6wy7
         5aJ7OYio4y7c68GGZpsDgtFz96TyodWIN0hWgrrGVkOcS6D1/Vap3ddqNlX0OY+XGls/
         7JRJ3XiRnyn898tYdxJahKQSYejkDy+i91DjZdZ8Y5ipq1yZyddHL3jdV4MGTU4MCQS/
         f+AVfn0fn+8Ll/csmZKhxSKG0yz/NqHr76K+LhuSsd6+ur9sUVRR71qGHsd/iUWpJCMl
         OaSA==
X-Gm-Message-State: AOJu0YySWidAAMFqi10fvQ2x/w3RW6P676wjsjvQ/tAgyvKQ15nLaIfL
	2C4ACH2WHwUUHdRKQyfvBjDlx3T5uwbKUucc+vG3EShBiqVUITXRzuXDuaXxQa83beGQ1JC0/4c
	=
X-Gm-Gg: ASbGnct58nB0eNvDSCguYFJBSquHKGHK4fE5ZuKcMVhHo6J6Fl05KNaNjacq3isSorV
	mez+2BsmggTOpnNE5aNxUo5Hqrw0Hs2O+3jpjEvmT3rD0TJJUPxFqPKJLAQRtLVQ9XVEwY2O4uv
	hVsqQn6BA+hzgm/2QAj8bQfQLcrIxtR0nnOzmuSOoAfj8t8FdSlErxOIoRMcNxs2q6tfZg85pM4
	ZE7UiJqbV/fS5KhN/s2876DabNDHkGVAsCJ5m6Yd/iT1ZEvsPPnFd7R4vnZCDvNfOlKprhjgvDG
	ODfS6x6Y228Dyuv1K8bU4tgPMT1+R6NS8diO2AgpLuTJ
X-Google-Smtp-Source: AGHT+IGOmbDMgp0gM4hHjjXFBth+m2UszKCk8BkNW1F1J3nwmIB9n3MIuWtvtcF7WB9eQa/KdTKGxQ==
X-Received: by 2002:a05:6402:3510:b0:5d9:84ee:fef1 with SMTP id 4fb4d7f45d1cf-5db7d2e7efemr13730993a12.4.1737463659267;
        Tue, 21 Jan 2025 04:47:39 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm7153591a12.19.2025.01.21.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:47:39 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/5] shared/vcp: fix memory & connection management
Date: Tue, 21 Jan 2025 13:47:16 +0100
Message-Id: <20250121124718.3995904-4-michal.dzik@streamunlimited.com>
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
renderer more than once without need to restart bluez
- don't call vcp_detached on all cbs, as it would clean up too many
  (all) device-related objects
- vcs members can be already set when connecting for the second time
---
 src/shared/vcp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index abc5a35a3..683650f31 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -392,10 +392,10 @@ void bt_vcp_detach(struct bt_vcp *vcp)
 	if (!queue_remove(sessions, vcp))
 		return;
 
-	bt_gatt_client_unref(vcp->client);
-	vcp->client = NULL;
-
-	queue_foreach(vcp_cbs, vcp_detached, vcp);
+	if (vcp->client) {
+		bt_gatt_client_unref(vcp->client);
+		vcp->client = NULL;
+	}
 }
 
 static void vcp_db_free(void *data)
@@ -489,6 +489,7 @@ static void vcp_debug(struct bt_vcp *vcp, const char *format, ...)
 
 static void vcp_disconnected(int err, void *user_data)
 {
+	/* called only when this device is acting a a server */
 	struct bt_vcp *vcp = user_data;
 
 	DBG(vcp, "vcp %p disconnected err %d", vcp, err);
@@ -508,12 +509,15 @@ static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db *db)
 			return vcp;
 	}
 
+	/* called only when this device is acting a a server */
 	vcp = bt_vcp_new(db, NULL);
 	vcp->att = att;
 
 	bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
 
-	bt_vcp_attach(vcp, NULL);
+	if (!sessions)
+		sessions = queue_new();
+	queue_push_tail(sessions, vcp);
 
 	return vcp;
 
@@ -2344,7 +2348,7 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(vcp, "VCS Vol state found: handle 0x%04x", value_handle);
 
 		vcs = vcp_get_vcs(vcp);
-		if (!vcs || vcs->vs)
+		if (!vcs)
 			return;
 
 		vcs->vs = attr;
@@ -2361,7 +2365,7 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(vcp, "VCS Volume CP found: handle 0x%04x", value_handle);
 
 		vcs = vcp_get_vcs(vcp);
-		if (!vcs || vcs->vol_cp)
+		if (!vcs)
 			return;
 
 		vcs->vol_cp = attr;
@@ -2373,7 +2377,7 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(vcp, "VCS Vol Flag found: handle 0x%04x", value_handle);
 
 		vcs = vcp_get_vcs(vcp);
-		if (!vcs || vcs->vf)
+		if (!vcs)
 			return;
 
 		vcs->vf = attr;
-- 
2.34.1

