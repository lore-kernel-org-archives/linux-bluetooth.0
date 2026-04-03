Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1C29D28F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775259776; cv=none; b=Vyb2LiuOLXiHAsuGAJSd3f0SJApuCu6VPEPgWXjbD8Qe8m08v6Rgu780Odx+7TbSTZxVSkZq14dIUCYNuIZYCwV33ulW6yLHHNfhRJiUDERFotS2I4U+3frVufpcAxk4Qln/+bh5TpqINev99qN8G6Fn4EgyrvWQl9/qVNkRReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775259776; c=relaxed/simple;
	bh=3DI5dVx2Naeoi46pTRqVENZG6DfxBnkJ2YVgWtJLZZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrzH41Th4qt1ua3Io2SAi0J3KaPghaJxHonlLQFEMWyP/eDgScpJE12shqUqUhlzgKYg7DliaBIcatxl5JDgiwxQa4Bt96MdMe3d3zj37l5B+U79PmevdN28QUyaZ1mUJmXDxofNSfeCMBpL0S2J6ZLp7IO5uQUjRRdK8A1epFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvNzPIo3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvNzPIo3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1175125b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775259774; x=1775864574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0PYaH3gWpafhqEIhLMK1xU+HnSfUDW12SDpFSDb7Qw=;
        b=gvNzPIo3MSlde/voEZtAgDuNUQiDULcuBFxbUyN48S9ozwnKZ2qfYZFbdjHOhaTHqv
         J01eKVw6ZoOE9ASj4IY04pv/v7Q316jdtInkOucFt5CW8Svg3xSJ/fa3IFdCgfaLE+Cc
         QOzTAQwx7c1tbW0tiBbUHAoymoRbitm+nFh7hQm7q+zhebo2zmzKVH7QTatHisoQ/Y3w
         kKaLwtpEfKbZCHDi7hBRJkmKyoi3Okjt9WjYpZRqt8zxHaoxxJLzx84nxHa4b5JnBRdm
         45r2ClIzKWzVYW6zh7MvFDwnMwaJs+9tflB+FrGA+cXgDENkxAFiceXhkrELv6sfbAOb
         120Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775259774; x=1775864574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0PYaH3gWpafhqEIhLMK1xU+HnSfUDW12SDpFSDb7Qw=;
        b=GmSJOXc2Gj68FKI21m9GIEG8+vuI/8hAEEixQQ0nB/6K939qvUifuBFNNNPCLtmiPL
         BQQdnRgV8Z5Uo7ZMygkNShCXyMOI2FgKyn0Yu6jtyOpSAgFSZrapHNCpGJxVZZTwQaFf
         jFCE8HE4vDy4+NQegSrjSL1HujmbFwX8u5Jp6pd1vzbE8gDO/LMdfi1lyBfq9dbukhvW
         tMq8oQZKqZHE5xURCPS911NHExuK6jdwhhYOJfOzi0MKlgBvY59s4dLPJrQMEUcIlp2G
         2Ly1hDf6rJDPwBDQeE6QlNQDtW50Y8/WT2/ztGUGIvb9R4xG+Bvi1iTYBYdG86oV6HrL
         HwnQ==
X-Gm-Message-State: AOJu0YwyBdzDnh43KGKLfyO40t913mrfHgDtubKFT8N2+2iaYCeTllGr
	LrkpQAUkjQosf9MLNPL10Y3UJXLF+gC/SRRBOBU27Ua6Q6z5ulihVErqdafJbg==
X-Gm-Gg: AeBDieur+DKO4A2K9BbC25/uJrUXiq+7TEl32Kkm5chjRMEiC+t6/Zc31BA1VxtoRzo
	+zEAgLzHox8mH+dwb7LvxPmwVdSdhyqj2fQfxESPNopiwvVznOzZwvIXAGzYnl7SPFQQPPQj7ww
	Lj2eXgc/nWiPFLotMARQzOnvjrOJV6BEReKHy285WvPc4HfUB5p7iSZZFDzksQBAGHd40sPYBbe
	sRdkJ3Mi68UI/wTM4H11mQapUo/+mQgSt/BZ32cE2FLDpnn+iDjx5qStPOl27CHtvW7y06S4ICt
	lzOvnxL8kNUE6MNcOdaoqSjdea0sXXG6L4O38NGTa0KaOGqy67Ode1xXFQ3EZk5yDYxnyNBfDmu
	THBsY4zL8Zp9beZM+gBZyJhj/5rFbJbQSWzTEehI7ePm6qeG9nhecOdzwKjAhTFBsf0kZbiFfF9
	30DkLczNGNXRPowBfWu9fkYiTw/Q==
X-Received: by 2002:a05:6a00:c90:b0:82c:2104:ccb3 with SMTP id d2e1a72fcca58-82d0031f927mr7339162b3a.17.1775259773688;
        Fri, 03 Apr 2026 16:42:53 -0700 (PDT)
Received: from fedora ([2409:4090:a037:7a12:dca6:8cc4:1f19:c506])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b23c6asm9253136b3a.10.2026.04.03.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:42:53 -0700 (PDT)
From: Harsh <harshsahuxlr9@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: lazy-pir8 <harshsahuxlr9@gmail.com>
Subject: [PATCH BlueZ] device: warn on BR/EDR connection key mismatch
Date: Sat,  4 Apr 2026 05:12:46 +0530
Message-ID: <20260403234246.31501-1-harshsahuxlr9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lazy-pir8 <harshsahuxlr9@gmail.com>

Log a clear message when a device fails to connect due to
Bluetooth BR/EDR keys changing (e.g., after pairing from
another system). Advises user to remove and re-pair the device.
---
 src/device.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index cfbde307b..cd62abd73 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2066,10 +2066,23 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		const char *err_str;
 		DBusMessage *reply;
 
-		if (device->bonding_status == MGMT_STATUS_AUTH_FAILED)
-			err_str = ERR_BREDR_CONN_KEY_MISSING;
-		else
-			err_str = ERR_BREDR_CONN_CANCELED;
+	if (device->bonding_status == MGMT_STATUS_AUTH_FAILED) {
+		char name[256] = {0};
+	
+		device_get_name(device, name, sizeof(name));
+	
+		if (name[0] == '\0')
+			snprintf(name, sizeof(name), "unknown");
+	
+		error("DEBUG HIT: Connection failed for %s (key missing case)", name);
+	
+		warn("Connection failed for %s. The device keys may have changed (e.g. pairing from another system). Consider removing and re-pairing.",
+		     name);
+		
+		err_str = ERR_BREDR_CONN_KEY_MISSING;
+	} else {
+		err_str = ERR_BREDR_CONN_CANCELED;
+	}
 		reply = btd_error_failed(device->connect, err_str);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
-- 
2.53.0

