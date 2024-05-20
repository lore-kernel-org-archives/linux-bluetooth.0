Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47481CD39
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235830; cv=none; b=gfEfaCQqVC8Uop79xcjd1CaNvjw6vmqjOXWU3pstpyC8K1BLOPwRRfvf0uoF7KIPUGnXDFXuyi/xwRYlKnkRtJQiurQQjdg6jOKIaaLIs16Eauc4GYTODzNDyOC303NkyEL+63SJRkW6NjHtzjY/AcMjAGpnhH014MmuOX3RBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235830; c=relaxed/simple;
	bh=TWC+ZOOXvAWWR3XzoQ3Ky5DBWJ85eGrZORcCRwzE5DU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A74WEtL1HX6zaqbCIq2zMN2lJttjHfV31/glzcwcjtOuoCLOE72TzzgVvWqIEqFDEQAFtzx1EgrXz6zstYwkz+NmAIY/aTXE/21mjSlQasiqmOn5P1l0w1/yLunetJOec3wI4WYH+kIkR45I9CePPMpcutKVT42qtqdVpZVIJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGv7zmwX; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGv7zmwX"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f919bc2e1cso1785409241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716235827; x=1716840627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR3clpzcV/wPbdIQW/CsMCbzfmYu7wisd9LZ8FAEN0=;
        b=YGv7zmwXLG37a62neXuJfA5i84w40fNOvykGt7NC+zNsrP9C/1ja26WrqWUtmgHpfr
         7dy0cGT0edbBIalqMnBgUe99MvjhEAy6ju/zAuNCtWPGpcyc2NW+5NZgTeOTzmA8+F0a
         Wr/mWC7BMeHCROeoXoU+5LawcKzzcH2ppEPQNzrziYN3nLGcK4Nc/TNRqdUjHON1TYcy
         EVaH/Hr71NzNeltZXzTMduVh6W2RRFrOdgHhlPpXGPbcz7KbSL7MPPthtAokx6RwG+1Y
         3BrnAHGlSwVAQjlXv++N4NZNpkqHRGd3vQkxfyyyinxCFg9GaiZEm43AZQoNEU4gMWVN
         c+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716235827; x=1716840627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR3clpzcV/wPbdIQW/CsMCbzfmYu7wisd9LZ8FAEN0=;
        b=wN7G/OfJoRCGVAiCn//U8EB+kQ8MVXwjQsO2UugZx+JX4aooKMbY/dee3bXhV8x5jO
         QNnwAls+DJPHbBC3yDjItnEeWff8LOcYmX3fRgcwKL+B5UkpdoS4qgCv8t0fzxT6iaVS
         Z5ZbS05fOY1pCxOi4Vj+QJs4mCdLgwuDD8QSeiJFsj6y/0MoVhI0Io+UwiErQ2vYzemd
         s8BNkj4TRw3x1O4nvWhKucCguoDFW5C91O6Jd9/JGm7NqXfcqURJKGCGrHIx1K6lz80f
         FYCfV0Wij/K7Ndfm4h53ceqGsogQTcmJTel3+hgPrqm0RktxAeGWljYa7ITazYLhiF0Z
         cFeA==
X-Gm-Message-State: AOJu0Yzxhj6Nzaui7U8Grc1EakdzD8pCS3jLRTGKhMZhdlFsCfHsuudk
	ctyqNSRTALLZR0Vd9rYkp0znpuM1xnoP2s/L0llmLbUCGpm6WbVCTdl7BQ==
X-Google-Smtp-Source: AGHT+IGwWV7lOTmcEeF07lIUt+JoEha1Na3zPiJz1yeXaG6b9NHZT8TgLZHa4w2935eMNwN8fBgQ4w==
X-Received: by 2002:a05:6102:548d:b0:47c:362f:4c47 with SMTP id ada2fe7eead31-48851e85101mr6372752137.14.1716235825392;
        Mon, 20 May 2024 13:10:25 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f8ff9eaf93sm3396680241.2.2024.05.20.13.10.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:10:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
Date: Mon, 20 May 2024 16:10:23 -0400
Message-ID: <20240520201023.1437548-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

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

