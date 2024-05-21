Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F43770E3
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302127; cv=none; b=WQeNSgmU8TgMS6sNlI5mnhbEi8Rn4VNhOjXs3bdxjgHOgRSsQvUaaYGnxM/5bzEXQG85KDOm5yUdcpTVjy/YVTjmqVI8VEx84homs2fkE0ev2JhIpw0h+9YqGBa67heFi0YvUbKMpSoFONn6JmsmhHVF3h1GHK1G2Tx6Z00Sgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302127; c=relaxed/simple;
	bh=7o9OVhv/mbqnItG0NVM3K15RAEYB5a71poX9koQJOFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q9ZN2htWK04lYXLIBYhjzehyRaQcSCVpIQIWypBsJ0Rsb820sec8kEjbSmWRo2akIM/Wtz5LPl5PPH4+wdt5pdPExBf9AlmslvrFP7XHMbRdfd/XtPXclh/otaKSG/c5kSy/i94n9fi4kfZi8++4ZUJAuiGbjdm5mEzHYzLI5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdfxAXji; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdfxAXji"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-488e8cb86c9so851669137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302124; x=1716906924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRHnF/piT4qYDq6Xj98K3w68/p2Y1UIc0dqz7FopCzg=;
        b=AdfxAXji9LLqMfdzlBDB4JVbFEaCLOXjSrSCBOReaifdKzoWd+KyinElFeR847cpNe
         XiaT6bW0ciF/Vw2vBLvWiCzbIgRWjRlCWUw9FCG2IkpOWHQhazm53swtwtCcKNTJLRiD
         rQOn4XwMqYGUNUHyyYqPe5LhgBZEji1RDLOu5ecURtSJqRb577OvYXpUBj8S93lIniDJ
         ivyN8oW+UMCMD+89YGH9+QW4zw3kilOA97cWwgcMb1Drc6pioJk71YzbkQT6REZFlDZ/
         sm5M0VucFIZycqANl4cOMBBeAi5t857j/HFJkIQAkpesuzPrtJCO5oByQhZmrZr7kIC8
         FrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302124; x=1716906924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRHnF/piT4qYDq6Xj98K3w68/p2Y1UIc0dqz7FopCzg=;
        b=bYIUQNFwY8b4mAdPdFWtyKLXilZI+qn/HmHVZFosmvaMAPf9/jPx1bcXpHVZZQhnK/
         wka63lXnP7N2AZLSoSHhtKUHX3v2L4sW6B2h6xBdOqWi7tQ0o4o6smiUcWKBdltOyTpL
         rZqGKY15Hx7QpnRd6Wn4vQ7HzGjAOoIMEJwRskinfkZi/xQ9KbMydexYCHwwUjx+jwh/
         EGW7wSe9NBWWfCfV19/gWUy5HSILuib2WZnRmvwryZXvkOWUDNwaHkaZ3mNiEPfSxY4w
         cgbjVHlO32djjt2nyuMZlNuh3ujCKh1FcoqZB9qMdAXAm4pz/yaD5utevyO5yWXVJiO5
         YChw==
X-Gm-Message-State: AOJu0YxaofU6ip8vHdGO1HbbUiZhwb/3aDQgAV+xDPR39XI3UznSB6GG
	08hC3lcfYb1lafBzdc+BzgyGTV2DiX2Cn1UOIdKOVhTSd+Bv4pfWdpd49g==
X-Google-Smtp-Source: AGHT+IFDI8/3Ec7pLCWWS7162/269vYo9AnBzUl1mtdkX60kx04KCHgAOojyKdR2dzLur+hXM+ugMw==
X-Received: by 2002:a05:6122:31aa:b0:4df:19c0:86cd with SMTP id 71dfb90a1353d-4df88134fd7mr29514718e0c.0.1716302123459;
        Tue, 21 May 2024 07:35:23 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cbfd194sm3531910137.26.2024.05.21.07.35.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:35:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
Date: Tue, 21 May 2024 10:35:21 -0400
Message-ID: <20240521143521.1568672-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the bogus check for max > hcon->le_conn_max_interval since
the later is just the initial maximum conn interval not the maximum the
stack could support which is really 3200=4000ms.

In order to pass GAP/CONN/CPUP/BV-05-C one shall probably enter values
of the following fields in IXIT that would cause hci_check_conn_params
to fail:

TSPX_conn_update_int_min
TSPX_conn_update_int_max
TSPX_conn_update_peripheral_latency
TSPX_conn_update_supervision_timeout

Link: https://github.com/bluez/bluez/issues/847
Fixes: e4b019515f95 ("Bluetooth: Enforce validation on max value of connection interval")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 36 ++++++++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c       |  8 +------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9231396fe96f..c43716edf205 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2113,18 +2113,46 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 {
 	u16 max_latency;
 
-	if (min > max || min < 6 || max > 3200)
+	if (min > max) {
+		BT_WARN("min %d > max %d", min, max);
 		return -EINVAL;
+	}
 
-	if (to_multiplier < 10 || to_multiplier > 3200)
+	if (min < 6) {
+		BT_WARN("min %d < 6", min);
 		return -EINVAL;
+	}
 
-	if (max >= to_multiplier * 8)
+	if (max > 3200) {
+		BT_WARN("max %d > 3200", max);
 		return -EINVAL;
+	}
+
+	if (to_multiplier < 10) {
+		BT_WARN("to_multiplier %d < 10", to_multiplier);
+		return -EINVAL;
+	}
+
+	if (to_multiplier > 3200) {
+		BT_WARN("to_multiplier %d > 3200", to_multiplier);
+		return -EINVAL;
+	}
+
+	if (max >= to_multiplier * 8) {
+		BT_WARN("max %d >= to_multiplier %d * 8", max, to_multiplier);
+		return -EINVAL;
+	}
 
 	max_latency = (to_multiplier * 4 / max) - 1;
-	if (latency > 499 || latency > max_latency)
+	if (latency > 499) {
+		BT_WARN("latency %d > 499", latency);
 		return -EINVAL;
+	}
+
+	if (latency > max_latency) {
+		BT_WARN("latency %d > max_latency %d", latency, max_latency);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5b509b767557..c49e0d4b3c0d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4647,13 +4647,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.45.1

