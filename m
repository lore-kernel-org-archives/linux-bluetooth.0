Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCB1F3FC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470670; cv=none; b=uApWD8mP5lBUk8x/PfQUf7mc42P9jUuLWF3+PLYBsBCUV45R8IXjl9OtqGVUJThopJRHD6tY6GSOyAR1qDvGuq+79j+VubJECIQxDAx8DI0LuCSJYfNETlp9F8JxSnR2PU5V5xTPctmsBjdUqZa4XqCpHc9XDrsHvekmofaE1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470670; c=relaxed/simple;
	bh=TqiJSHNq+e3qqPdiBb4X9IRUX8pgul3fXpmo5HKqD8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAeKL+aym6hbBo2QF8gA2WJu5/CBCItwOLg+hMpTDW5g9wWZPRYasEpONafbMqNi5PYIvNYXBKLxW9b/t1zP9Q4hdCRLI9/1zUSmBS9Ztd83DU0sRondLG/u2Q3qThkE02EaDyFCSLcx5OtYT2rL/XRUMDDsG4KssRw+xZSU+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=mBwpX1K9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="mBwpX1K9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so5404925e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 06:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737470666; x=1738075466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I3MtPMq1q/q7OhoezyHC+aX2aZ5CTAnHXUsCORbDLU=;
        b=mBwpX1K98eEQx0RoNDqN3w2hEZQ82T4liHXmPtLBE9mgg+CpAFgD815Ryjfek2tSfd
         ya6Wz7DSeVLy+YQGO3yeWf0JSii9ON4Ee/N5yCH/wip5uUdCA/cjb0nTcKRvucac1d2B
         cub1Cb3wXu8+6LCrw1iGgCIpzJRKkKFIFSDTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470666; x=1738075466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I3MtPMq1q/q7OhoezyHC+aX2aZ5CTAnHXUsCORbDLU=;
        b=CzP/rIO3p66BTDrbZTpLX/k8AZ/5+LkAo+MqCZaFT63XsuqtQtUQsP+umEOT9bdVe5
         bmIwrfH4bulpa4Md0k3bgfwtkD0QVH+svysJKeUCxTWWrnZQB6/9UmwNlmclfpxTme2e
         9cD2RBsNwkJ9y9c7Y6CLsYzf2d4WEAY7WfZnYzvaE9YXZSDnQeITn3a/427duBksaocz
         m0UvIzrgukqrraa+top256IwGYN66gyFkVOYAygpSodkbNIB4a9upBG0oJz8dU2iN6hN
         zs2DjATBaLRW0gNTeFUelG4RX3LGwmSwnQvtUAEryKbtLyyYZf1tD7nQYinSp4RVZFgA
         bv6A==
X-Gm-Message-State: AOJu0YwhVTcQZJAEE/3pU2VRYSy2sWFsDYHWGB7EQG0f1+Wy/9cz5EV5
	nLNk6nUrQdchE4izCEdYByg6TYdgKb3M+/9HWiCVpxp1WLsyPBEkAV8tcjnMcfaF2ghRpW0LMCQ
	=
X-Gm-Gg: ASbGncv5cmQ9Wx5fxUCgYZeNLwdgH08lO3j7mk+5xA981lQqx26CZ0Gkkq+sIHQstmO
	VUDWHN95Av09wmGfyREXkqe3FQOtOaNFRzLtSRIoDjpJS/APdwRRzM81VqVKpOe7uwHjjhTLakc
	qUj8n+igGpaTXXj/PUUgigDMxdGl76giNMZ76WY4ogFQptW/SS8c+k0EYXLcvdKNOMzEEZd4nFG
	M1NUrt/xjmOCn3nIrKTEaO3Eg4r3mwFJj3BiVO8+tPf9AtuMVl+rasi24vsHqUz3VutfhDYDJv4
	wKMRACl20KBOsgCDy7F4kKiaXlT4JwnZ3SCZEFW6QAgj
X-Google-Smtp-Source: AGHT+IEEoEamsXwXiU1DBhONwJqbjiWchhtMEv98s2evJVFatA6OHwuUSdbJ4lCZ8KCIewU3J09h1g==
X-Received: by 2002:a05:6512:2255:b0:542:23a9:bd44 with SMTP id 2adb3069b0e04-5439c24116dmr6311510e87.17.1737470665599;
        Tue, 21 Jan 2025 06:44:25 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af733fdsm1866237e87.174.2025.01.21.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:25 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v3 3/5] shared/vcp: fix memory & connection management
Date: Tue, 21 Jan 2025 15:44:02 +0100
Message-Id: <20250121144404.4087658-4-michal.dzik@streamunlimited.com>
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

