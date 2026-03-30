Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0E3D7D64
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879480; cv=none; b=pUkq3DGg+Z0I1K0iBzWQWQYMUJceubS9/J6HtZYPBMxrttXuXFIqLzBcCvPTyIjMaY3vU57z5MgUI+71znYBuKPMINqaDcP2SNDV1r8D+aX9S4p2fuUoTkAd7/PewN6hOpXrxt+YE4WVTOde+DsE0vpMUMbpa6nJgQ6JEVouuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879480; c=relaxed/simple;
	bh=1nDy2ly84N0C4bZ42yJfuqtLPQ1cWdmJXjjjheiBk8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goYwa/ZefF9DvxPatPu6U0O3rnCpULGZgCKAXhqXdrJEjNMPRHr/Jn1qXnluO3vlus5MPfl2RpLfWTPdH1AnIAoWeSSrChw5X4PtRKg28Q5ffyDNowmkS789odzSCzf1/zMqVYfw/z8We0G52mga7npwqSTC9LFGNbIQKFdFfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqtJupoK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqtJupoK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b8ebe6bd1so171806f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774879476; x=1775484276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRTKeoDSzLd41wFWg33HtA46fkOlLah9F0f28gcBRzs=;
        b=AqtJupoKJ0IO1OtWCCnerRqLXdGAy7c5hol9R1xPNOH8L1BlcJ2a1xhyRngjmg6WEH
         qK44hPKyo0Z1Tb/66hJ1R7qj9u9RpE7dERpoRP2dQ4O+RPRIY8CYu91XU5zE9cqs9gul
         isrQ1pduqv9h/a+TvMl/r1pHa4NWiyOqj93l3M2ZKDXdhIaEgr2PcKrUXTr7VXvhcizC
         aYeBHDP8L1iMMzZjAeC/+aY5968EDsB2E1Xrw/lybggzMP9Sfn+d4V5/TnEYwCkGGVWH
         4t0ZI1/iyj5sOkC6sj5V2qY0KmiKOyYWm3rdbPcYrRWT//JhhZG2F4LTmC3pMbrIL/VE
         abyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879476; x=1775484276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRTKeoDSzLd41wFWg33HtA46fkOlLah9F0f28gcBRzs=;
        b=gi6gQdw4UPHwPL1lwznf9RDd8Kd2qpg9uWb2/PU9iA+SfaURYMFnJ6qpLHQ2lB2wWi
         rrgq/hjw+xf06eLRnXMu5M3GoJ/dpSaooPg860EnZ16eb9zc7GQQfMhEpSUs1S2pvc4B
         gJ9k22ibJmbB94uX5BMKbQSkS6/jPk4tgdd2PKHYGrRpxI8UMPPxECjnZpmwDA0u+l1W
         bfHHSWixckqDHjPhYe7OTctXh38UX2o0GWlmOzzO+91vBvYl0BCCM2SsiayKDt+r+2vR
         lH0/jlnLVLL2NAZJplfNfKXj1DabDAq4O7PM0rlyC45wd8l8zDKspWt9Dq8LN4eiisvM
         iPVw==
X-Gm-Message-State: AOJu0YxY6Oz75Pc6eKlAHP4GnLotJ8fH/m7t3yWyU0zlo2o2gDK186bq
	liKdaL/H8RpWeTzNdEP9e6i6gS8yCH2F1b9z8V1ubmtz2EQUeT22mGU6q88tbia9y5s=
X-Gm-Gg: ATEYQzz9rwuaQuETRFMY8PtKclUJUUtEy/qzvO8q3eoKp3hBn/8qkn1+RfsUCpt/4Vz
	CF8B4Acn+yfQsLVRvF/VU6+fSXbcCFnLvoMdTn49z8Q6BPd4URJn24XZ87cFcY36n2jzOjah+3M
	sodYeChmL897pcDw/8fxMzuoKGsYHLTwGpfVB87cGPFWUytCz6+rstP6LmENczyGgHEeK/FfBT+
	6cUV0rlWYqc6+/iR3jE2GWSdZk8bRxfhl9FTx1fFfjHHbDVMfiJesD0Th9jjMHg7amGeC8BahCB
	j4I7C2SwE6P9td15KhXaV7kZRm+woCUUCWVeFTYqGeyt4+atzHyNJ9cvKn+qOyfXeT+HOEhtohx
	YP0ENZ7erMMZDccQiHpWcsUsHNZDEt/jykNWtUXviWqszfiPs7ApGGIh/Fz2TKRP3N/EzP4Ohcj
	e9F2BUlYgknlpl5nDPG1nP2U14Hj4JPkog9T4av9JgWMMwMgR/QKz9ktR/lryxBimFuHVCXMgZd
	4durP/VG5yfWkoSmshho1LhiWHR
X-Received: by 2002:a05:600c:154c:b0:486:fdc0:4504 with SMTP id 5b1f17b1804b1-48727eda77bmr112642375e9.4.1774879475969;
        Mon, 30 Mar 2026 07:04:35 -0700 (PDT)
Received: from localhost ([2a01:cb1d:4ec:6700:174f:90cc:2ec3:a84b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873bbcac33sm83719655e9.15.2026.03.30.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:04:35 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
X-Google-Original-From: Aaron Esau <git@aaronesau.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 3/3] Bluetooth: hci_conn: fix UAF in hci_enhanced_setup_sync
Date: Mon, 30 Mar 2026 16:03:48 +0200
Message-ID: <20260330140347.906689-3-git@aaronesau.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330140347.906689-2-git@aaronesau.com>
References: <20260330140347.906689-2-git@aaronesau.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Esau <aaron1esau@gmail.com>

hci_setup_sync queues hci_enhanced_setup_sync with conn_handle as data
without taking a reference on conn. hci_conn_del tries to dequeue with
conn as data, but the pointer comparison fails (data is conn_handle).
The existing hci_conn_valid check has a TOCTOU gap since conn can be
freed after the check passes. conn_handle also leaks on cancellation
because no destroy callback is set.

Take hci_conn_get on conn, add a destroy callback that frees
conn_handle and drops the reference, and move kfree(conn_handle) from
the sync function to the destroy callback.

Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 net/bluetooth/hci_conn.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a7faa4c..6a567d6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -278,6 +278,15 @@ error:
 	return err;
 }
 
+static void hci_enhanced_setup_sync_complete(struct hci_dev *hdev,
+					     void *data, int err)
+{
+	struct conn_handle_t *conn_handle = data;
+
+	hci_conn_put(conn_handle->conn);
+	kfree(conn_handle);
+}
+
 static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 {
 	struct conn_handle_t *conn_handle = data;
@@ -286,8 +295,6 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_enhanced_setup_sync_conn cp;
 	const struct sco_param *param;
 
-	kfree(conn_handle);
-
 	if (!hci_conn_valid(hdev, conn))
 		return -ECANCELED;
 
@@ -467,12 +474,15 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 		if (!conn_handle)
 			return false;
 
-		conn_handle->conn = conn;
+		conn_handle->conn = hci_conn_get(conn);
 		conn_handle->handle = handle;
 		result = hci_cmd_sync_queue(conn->hdev, hci_enhanced_setup_sync,
-					    conn_handle, NULL);
-		if (result < 0)
+					    conn_handle,
+					    hci_enhanced_setup_sync_complete);
+		if (result < 0) {
+			hci_conn_put(conn);
 			kfree(conn_handle);
+		}
 
 		return result == 0;
 	}
-- 
2.52.0

