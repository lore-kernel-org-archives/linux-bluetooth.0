Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7C33FE2F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916878; cv=none; b=pLpGJJf1nrDNEjVQzM8w6fpPDr9goOfzcen15Go9LQ3vxH/9hTIvFKA0pHnnwX9wp2FtUUxLHWwtQeFrHWBQuvqqqoBOCUErVjL4u3k1dNufEN45P53fjUE+CGBjXcMvjKNpuR8WAAntCpS41myME0i8fV25idalhC7AARuTo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916878; c=relaxed/simple;
	bh=TGFufk6T4Or/HEAfaSxYl8GzMKnQxPm/+KXgn7XI8hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHPMKUvptfrlcS+LLfYrLsGT4mqutU4li8TYmU3niSHHj93mlSssG3rt3qzzTBabemprxwMdldWtLRxtcMH4oKUE4+2YdjIEF0YLtUMAla0cbsw3LINZE6pu02F5fQxvrmhUs3IDM+FprgNf/oWrIzCyPyW/2hPqb5dDR4Etlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Y5xZyiio; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Y5xZyiio"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso48382875e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916876; x=1781521676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0Anr4DTJQJ+x42zW7Hx8QU2wYjWGcvL8EaaQeWhin0=;
        b=Y5xZyiio7NHO4yjAwJMzIUu+m7R1W9E4G2iTzYgAq+JqET/Q7UxxJZPOVvnKrPocbX
         dgWeoDHoRut1MovZKEBzlfYF122+PPGqB4KZBoXj4dpOkdFwZsV5F5kXRlwI9/L+O9rU
         PfDWESTDlLFYSE1rNqkevIRwjLjAI3QIv4TuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916876; x=1781521676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0Anr4DTJQJ+x42zW7Hx8QU2wYjWGcvL8EaaQeWhin0=;
        b=oxspthg47yvaS5Sqivj4aXYma1DkgrfpDe9T4/kNpRTIiBJPeJXKb9l0ci90oCJLOv
         OMg5ItDzRsvRSxE249BfGtRMk0yoxf8cgPkTPiDSdiLDlD0w2YxyOjHornvRAvLfeU5c
         SRnVB2M9cZkFStAVuvKlRTMxREa7KaICwkPDNybRQ0BRAl17+yBGKNcBDCLmk3TDIgjz
         32J8DL2qV9XkPodHBT+M5VF+MDAZeD9iX+o8BlvQhSMNVGc4OCoxVNMhsWX20YcStR34
         TD90yXFbWamIRf12E+JTSQl7l7EEvEZnQS8Rqi9d16ZIy204Pj+JiV+0PiUJS3Oabp9l
         /nFw==
X-Gm-Message-State: AOJu0Yz4yC2hAshIJxsvpiwyYxtbYkcU+72gEoQc1Nwovhxdc4DThrfn
	KU9FeYAop1nYPK2CKjCfXuBOdBQPiQtL3umelWwKgYmKpypDgupjmaGEHCWFyJ6v1V38WhlJSTq
	C/wUu
X-Gm-Gg: Acq92OFX0U617kKKQrWw+Sro49f1Errlc6jz4vOomrlaj9zJGDJhMil6vcTxH9nDe50
	a8HS8Gicp7/ngI8hpwHPdEXqFkfZnG3c1dQVXibcAdwaQv3fLZki6/G90zW8vlvVG+ZDuOCEE7M
	ckhRQknkKsUCmEGGeNKKoTQ3vSCaRNEMoBb+3FLrWU3PjjxpSrMuZH4KlbeV4y9CwujckNyYB+r
	koPyTrJIBTh9TPha8tNYRkydqdsmh+eBob4YM/zV7WqvWDYc8UTGrSWYGkU3IsvL8MvFCFnfQN0
	u/3gwDGcoTHhvCKzgTRw+BrbOTrfDURG90LWFfKc0cKkgRQDsx4XuaxlQUwG7RvPU/MgGJifz1K
	OGlsMmTTl/4yXlOje5SfPBvy/jQMae8QeKmEmSfpp8xFwm89ug7ySzR3lmFkwAnPszvgPgdwsnS
	5cDy0lgos9jPMcevpTDWmXIWEFIJ0MReIL37ZhKDemDyqoIlSRChYb/w==
X-Received: by 2002:a05:600c:4e13:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-490c25eea3bmr284251495e9.23.1780916875840;
        Mon, 08 Jun 2026 04:07:55 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm326962625e9.1.2026.06.08.04.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:07:55 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 3/3] device: Fix returning discovery error for Device.Pair
Date: Mon,  8 Jun 2026 13:07:43 +0200
Message-ID: <20260608110743.3683728-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
 <20260608110743.3683728-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.
---
 src/device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index b0c1960ff..5f9f7ca99 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7294,6 +7294,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	struct bonding_req *bonding = device->bonding;
 	struct authentication_req *auth = device->authr;
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	int err;
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
@@ -7352,8 +7353,16 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		DBG("Proceeding with service discovery");
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
-		device_discover_services(device, bdaddr_type, bonding->msg);
-
+		err = device_discover_services(device, bdaddr_type, bonding->msg);
+		if (err) {
+			if (device->pending_paired) {
+				g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Paired");
+				device->pending_paired = false;
+			}
+			/* Disregard browse errors in case of Pair */
+			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
+		}
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
 		if (!device->browse && !device->discov_timer &&
-- 
2.43.0

