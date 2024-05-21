Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208F12FF8F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301474; cv=none; b=fhmfFHrE6u8hGm1QYfJDbRUQmWPknoz6h+QPpuAh5ykplVvlhidsKItq17pLMd7P8b7WZfHcXA4UEV+0sixZC/W/B/UBv8XRq8zFxXlH3nABJdMFnT5ejI6NKTv534TaFiKL/FT3Y4+e0CHdvXUgRqLZo1u5JTF18/1eFE8pDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301474; c=relaxed/simple;
	bh=dUin6YS5IiH3aJ4DieH367+JG5gWSMWwzGigk6xOrv4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ci55nVKrhOn22f4W08xQVCiWmCotZSTznLu5ctUYxi+EMcZuFL7a5exWJ9pIGZtxuXP6mqi3C0g+0Y2YBRrONXSztMYwDAonEfg5FLonbdekOgaMC/jshnFWUT/2JeTxEHSFpk2eYZogei5wyGDLv7KyVlxPsIyy6d4mL9udDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWaDLRuL; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWaDLRuL"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47ef5a51829so1168093137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716301471; x=1716906271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+dDlQEM5zkJlOihLGtcBsuJEL9SRpaokILu3HX4UcY=;
        b=FWaDLRuLOBb5TsD45PyKkd70VszMMegkm6pK85D/HT7ARFsggl/Ct8iNzBOUuTH3KC
         60yMUN9LtY2NDVgEcLsgJrOfVNUI2WLJoFU2KlrZvgkBzLXQZsL4KiKeGA6QyNmvj0gZ
         0uBitkmmJJVTGSAg59l5TfzyigwdmhhqkGtYO/fu5r0ruLgAUac15OKLJaI2CMB6ywZo
         wbg3uirWwBz255Yqq1/HinifiPls3qKLLn+b0uCWP9clZQfPrSeaGfZ9+m50+m2hxOoV
         BrRtbQsBaygHqdi5o5SUmrBuIHR5oDcBVqgCTfqHJ1603xyEJJPaVjVIxE9SXjC7f+Zi
         lo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716301471; x=1716906271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+dDlQEM5zkJlOihLGtcBsuJEL9SRpaokILu3HX4UcY=;
        b=VV3ybNT5/ufrPodXAjH2UEbmsCPFxNutVftIv2vxAmQVyemm2hyiSVtpvKQKtTR8Wj
         Hw7N+ygDBdMFeLJJollmd1jRQYqQzkq5G97S6jwXNRpgLVmdAvuFDalWiz21xlhqnnrp
         i/M/aAbGsH03htxHLwO52YcZzlMVoqgmxQQSewLZaSi4Q7d76lMd6nSaihwxWd2Rvd5u
         5H53WHpexenzWb+puqm67dpVFYizYvTGiBURz7ygwzY1kHp0lDMEhxVRXAV5ehxr8lKx
         5ZShhuXmVMauJ1QkwqDF86gDt6u66BgAJT1VzqShfujnSEvC1S9hHtNWkcX4u9Xb5gGC
         ffpA==
X-Gm-Message-State: AOJu0YyD6gXELmN0vPVFc4NVi+GdYO/F03s34hLAzMqXuUZkCUG3LApD
	G/Ggel3wkCBc/Cm1xgUQnKuekoAJZ3X2czGbpA6quQgjJICZIzGv7/G44Q==
X-Google-Smtp-Source: AGHT+IHJTAN51qBKIYqx3k6jemI8hv9arz9A1yjSd8MCMHT9Tsy/eszJ01OQejsrkBubQp8WVIenlQ==
X-Received: by 2002:a05:6102:f0b:b0:47b:d49b:c57 with SMTP id ada2fe7eead31-48077e1576emr30732097137.18.1716301470936;
        Tue, 21 May 2024 07:24:30 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cc1f740sm3634050137.30.2024.05.21.07.24.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:24:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
Date: Tue, 21 May 2024 10:24:29 -0400
Message-ID: <20240521142429.1562347-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5b509b767557..c8a34283f1d8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4647,17 +4647,13 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 
 	memset(&rsp, 0, sizeof(rsp));
 
-	if (max > hcon->le_conn_max_interval) {
-		BT_DBG("requested connection interval exceeds current bounds.");
-		err = -EINVAL;
-	} else {
-		err = hci_check_conn_params(min, max, latency, to_multiplier);
-	}
-
-	if (err)
+	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (err) {
+		BT_WARN("hci_check_conn_params failed err: %d", err);
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
-	else
+	} else {
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
+	}
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
 		       sizeof(rsp), &rsp);
-- 
2.45.1

