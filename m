Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AE4A13A0
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023873; cv=none; b=J7SxuY1e98Jsl03UNgs2DVStiboXIgZV3x5030f2fWjN+FGm4svwUb96uEItGME4vGqWyjFY/BKrWX13mqcpfI/igdWsAPJHbi8TyD29soLEAMTO3sKgul74tizcoC8ZDyJE5vvqKCDN5KY/n25HNSK6wlaDUJZmVyl1B/t54rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023873; c=relaxed/simple;
	bh=5H90uErCQoFzqb+SX5tpWYwsvN0rC7GfKcHVNr+6OaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwAt5SMkfa0NFKtFWoGKsuYauTFUHfs/MKOISpgg8CEh4AVf9YdoTXWT9EEWYW7FAu9W9EZOmO8peISWDm/xCbwFXW4iuszwyC49CmtbMov3pK9CDrC+JgxBOro7Lf5/Oj+aVuNUn9MCo9dJEw/TDQLAH1h8HSYs/BDW9fZMBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGjO+kHu; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGjO+kHu"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59e2b96e3d3so3740284e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023871; x=1781628671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dw/lLEgxLiB6yzGtsh6BeeJEhrA5RZsFPTMQOmyqxjg=;
        b=WGjO+kHuDkTbPtIk+4C/pwVDGrfjxIJ6XIW/+lOI1fUYMaJhpKMh1iOamv9ZYiQDgt
         ia3rr3pj8f/QHpjPwvxrjKQoEtefiTuI2U3Jw+ClpQ5r2fAavUaWsNqI9VMQuT+n8C6W
         L9PUiZcjWOXyqWogUwapli/rlCRpObin/tYgWkSmQCP4hiv8npz5/bFcg0eZaqf4FpSA
         CAMl4bg2FIwJbWs6FoUVnbG5gAZlH/Z9L/xv8ee+LBvitEJ1hg+Au24HzcEjsr4Xn5X9
         Qmgkbhf6sRZJS9do2c+ST83J4bAQFlGIp0+m4xd9bc7eSswAdvJroDe07KgmLfmXRjir
         T7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023871; x=1781628671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dw/lLEgxLiB6yzGtsh6BeeJEhrA5RZsFPTMQOmyqxjg=;
        b=O9Zms2xV0gRVd3AGIOKMutz+KpPbdw/sGslpMwMEJ+7zrat4LSuVsrWDyC6h/1lx+F
         NH3PxvZuoNFEWadSn6wlqlCcI23/4pWNWaW1orL6NvF+FhXzw10ZOM/zpGRyiQJ297Tz
         S3Q28WIQHsSi7mJxxG+zL4MISqC/gn+g/8bmX+icBrlgvLRJSHheCg493wSET89Ge0Jo
         MmilxtEditRTT1/PFkhamh8z+wLVdlFnp9wm2ecID8mNyIzZAj9BZMjJ9n8F2CGNFWlz
         js2Dp8lobiFEGbLfCuZ1ld94mhey+nsZLPul5p4AVPwSpVlsVaXxZvm9JpVbsQIhWs13
         srOw==
X-Gm-Message-State: AOJu0YwnM1wKn2yFle7BEQ7437IDU+AlfwsUsc0pPTbMmKEzGQgpONFQ
	zwFkC/WKbqEqKDwsh5lFVIVOS7DeD+hKIPkOUCBez0RjofVgQK4wAiY+wVEYRQ==
X-Gm-Gg: Acq92OHl04RgNkfgXQyTR8C9V4p/wvWabZdgm4vdt3MRAyJ6gjrz8b3vA16eIunIRw+
	4wQlx1n7Lx++FeprocKgtIDRmL2m4SIQLIJq49w6wpOS1e4BY9HEQ/eBDni+9QK4b5da3x0mzNP
	/7G5m1GjvPBorSN6/iyyjSYQmchyhFCBQt1O1nqbZ+KK6PEAD5OIx1zLdIvj0pYrnlydnlj/4xm
	hleKomYquJHj1lnxVC6qyOF+8PVGfluSNKDsN7zq+eGMe/FdYnerN+PbDPFzSmIwU5FsYpVObZk
	VvJop5sOzr9ERGDFHfD/jlhpWXkENtWBvdQjJmGL4No6jMMBCY+xJGwVDxwdZ71rWQGtv5Iqeu7
	PffbIm5tHkFBosWSc4YXJkPDubpuDg/lfSwwjKv4z+4QzHo5z3sVg4rpqX/zrB76viO0Fv8W3eu
	xh7NTunp3lRgTxnzfXH+wbmeAWh3Jcp7yc+B5c4KL5LAM2hbBBoLxEzZrrUVMRwjsVAq66SkqSo
	8SdkmLGs7SzlSda/WvWpLwbGWiel0O1M9OaLQM=
X-Received: by 2002:a05:6122:45a8:b0:5a4:3c79:f5a8 with SMTP id 71dfb90a1353d-5ac477d7f60mr11556835e0c.0.1781023871136;
        Tue, 09 Jun 2026 09:51:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm18333721e0c.5.2026.06.09.09.51.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:51:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] bearer: Check btd_opts.mode on btd_bearer_new
Date: Tue,  9 Jun 2026 12:50:57 -0400
Message-ID: <20260609165057.90837-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609165057.90837-1-luiz.dentz@gmail.com>
References: <20260609165057.90837-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only create the bearer interface if the corresponding transport is
enabled. Return NULL if BREDR bearer is requested in LE-only mode or
LE bearer in BREDR-only mode, so the D-Bus interface is never
registered for unsupported bearers.
---
 src/bearer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index 02267c711431..299eba6e8ab8 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -34,6 +34,7 @@
 
 #include "log.h"
 #include "error.h"
+#include "btd.h"
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
@@ -278,6 +279,10 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 {
 	struct btd_bearer *bearer;
 
+	if ((type == BDADDR_BREDR && btd_opts.mode == BT_MODE_LE) ||
+			(type != BDADDR_BREDR && btd_opts.mode == BT_MODE_BREDR))
+		return NULL;
+
 	bearer = new0(struct btd_bearer, 1);
 	bearer->device = device;
 	bearer->type = type;
-- 
2.54.0

