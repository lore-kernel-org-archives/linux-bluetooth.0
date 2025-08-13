Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F32E9752
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119730; cv=none; b=m+qv3SvYxf6qd6DnXFOXDK25+wU83/z4A3np/Wfp6FpdXlq5REK1zFogRs9MqGRpx52YKF97NHsb9ARuAzRJAoUG0Y8A/v/60z+xX/bRZE9xDo/B/bK9LciqF/A7Y3A+dmmSRGWG74zdgMrCA7MOl6Iid9inp6Uf9Rfj7lNOBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119730; c=relaxed/simple;
	bh=Zr7CSZQ4hDCQ3ZpBn52BZTRHpoFkE8lz//oeNd+qaWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2/p1yv/8BimZevFBsL5KPjEDrUQpXNKKRhShv/vpGu0aNe3OTDbAMThGfNUu2ORC9JiXCxAtMvbsmFWcjfz/b3F2fI3+hMnMY3HTUan5ChPRlN920DEhdUpZlaLAes0woafSjxBMzzYXWgVwyrvUgVVSHEm4YqAufMS3dt9iJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOolVSJw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOolVSJw"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b174fc165so123317e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119727; x=1755724527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0A26OXScjIDPaaoebMA8zVzlukUdZXy/NYrnffRd98=;
        b=XOolVSJwBYMxsXt5JfIO6iFyYDqJMypP+vLUC4xQdPntN+rO5kSPtaStEksey3UWmC
         x2DX3HlRJpaims7UhFTCOgTIaHiIv0gPwvG6DunEvaT/soRgmY8f17GZFX2agWxcRzal
         ZewU2ivx5fxji27EPbK/yb4D94cpwms2uDn5ju8bgploX2ubdLieLqHOyh8Gvfqazv3R
         SSCwnpG2cJ/ZgvlUfVFtaHLC6yVs97/bF88042c4nwzX5mAyAlA9MXXDW/hqhHne0i9/
         Fg58gRC4lm+xnjOeFt3AQcm6s3ZIXqovCu5e8XeWv7sgCF053KOzYwhHM6p5BOvdpcm2
         81hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119727; x=1755724527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0A26OXScjIDPaaoebMA8zVzlukUdZXy/NYrnffRd98=;
        b=VKfU25MlojLCUfP5sqq0aOk1Aq1NtzN+rki0HWP5UAsv1X53bWm2xV9+CH3yUXBBWx
         meWGMtNAAYmEkqCJlnw8nNuHhWh7J9TR8o2bZqODtT6CJIRbONB/e8sS8quaBWxG4G5s
         70v2/nuO+5A68JHFSiyqlQblZiVuig3fnmDOdbeP/zH7wlmtG66j0TOtxLFrsWtt1Cp0
         6CTnLsJtYJsMXUzSu9Gy3zQq08+KJTHiXk0Um4/arkJk0nWF9GEp8fuBnNcbki95O9qG
         8TO52nlbLY36dTiLwj+/+ZHEYr0ew0kRVALaRZSfWGcCy6b0EnGNeDq8zxTG/M2f5J0K
         Wwgw==
X-Gm-Message-State: AOJu0Yxzt8OFeL4+1eN4Mg/TNeng6xHhhlJzaBMU0YRWb7ntg7la1TRG
	Zul6hBXaCcF8AIOrkF+KzM96srvch95JsZzfR2jyRO6mKzoApxAH+uZD60EJrA==
X-Gm-Gg: ASbGnctmm+dnY7NKRsMZC2mjAcLoWU51A9I8G7Cvwg8sq4vtwSseZv4yawlh/NBtnnT
	EO0xkzOcQ6Yt2jqnCq33msgXZjyAOEq9XV2O5jJijLudieBSmgGBY7NhPq+EiJcmt7os4xMMCc4
	r5p5RgdFwhLRBKgl9Lgk3mWNjl2mCwHkJrFpIdUlKZUUsU43+vdLOMPdf0HvL3r+56iv3A/Qi6n
	9QD82W9Vg9A7kIfY/Y9SJ95R8xStu/7l8c2cuJgkTEPFNDT+ZU9ipfFe038ctMQAcJexn6svlma
	Hd6E9u/TJnmXjFhzCPDm1tshRcYz9qSK8XKe/v8qggbvbAL0cfgXLEKL6MEC/ef/M+NRIhNDCmi
	y8IvYHOfM3Z8uGiU2rp+KyBZJgSE8PtHjRNoJp26MsiG81t1fFLR1GHdwB4KmLIJN
X-Google-Smtp-Source: AGHT+IHgQRghceo8bY+077SrpApA3q7RNj/IZ80Jbbt1LIA/vo03xKGMbRTKyZjns0hGJzrmb6Zh3g==
X-Received: by 2002:a05:6102:e0a:b0:4e9:bae0:7f9a with SMTP id ada2fe7eead31-50fdff063a5mr241573137.12.1755119727206;
        Wed, 13 Aug 2025 14:15:27 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507dcae5200sm2458422137.0.2025.08.13.14.15.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:15:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/5] Bluetooth: hci_conn: Make unacked packet handling more robust
Date: Wed, 13 Aug 2025 17:15:09 -0400
Message-ID: <20250813211511.90866-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to make unacked packet handling more robust by detecting
if there are no connections left then restore all buffers of the
respective pool.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d2324eb1211..d2f0c3c0f0ae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1151,22 +1151,44 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	/* Handle unnacked frames */
+	/* Handle unnacked frames:
+	 *
+	 * - In case there are no connection restore all buffers to the pool
+	 * - Otherwise restore just the buffers considered in transit for the
+	 *   hci_conn
+	 */
 	switch (conn->type) {
 	case ACL_LINK:
-		hdev->acl_cnt += conn->sent;
+		if (!hci_conn_num(hdev, ACL_LINK))
+			hdev->acl_cnt = hdev->acl_pkts;
+		else
+			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
-		if (hdev->le_pkts)
-			hdev->le_cnt += conn->sent;
-		else
-			hdev->acl_cnt += conn->sent;
+		if (hdev->le_pkts) {
+			if (!hci_conn_num(hdev, LE_LINK))
+				hdev->le_cnt = hdev->le_pkts;
+			else
+				hdev->le_cnt += conn->sent;
+		} else {
+			if (!hci_conn_num(hdev, LE_LINK) &&
+			    !hci_conn_num(hdev, ACL_LINK))
+				hdev->acl_cnt = hdev->acl_pkts;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
+		if (!hci_conn_num(hdev, CIS_LINK) &&
+		    !hci_conn_num(hdev, BIS_LINK) &&
+		    !hci_conn_num(hdev, PA_LINK))
+			hdev->iso_cnt = hdev->iso_pkts;
+		else
+			hdev->iso_cnt += conn->sent;
 		hdev->iso_cnt += conn->sent;
 		break;
 	}
-- 
2.50.1

