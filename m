Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588537D111
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224518; cv=none; b=Hh7rlXVMUs490o4JF+1KXY34MRnA30IgCNoiLLuq87hHeLsu2zwV4ijhdSgPZAiolXRev3YhuxODE1v7wen4pVgfoe1UtwltCVa9BbKoZhL2uh2gocwOGPvISEYUYbtSV0n0MfqKcCpyFM7gcmorUvN36tqEPmhCnUh7XpXkasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224518; c=relaxed/simple;
	bh=YrbU1TaeI4Ab75wlNgL39OLwMFM8wwN0ymv4Zj+bzVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KgIsWoMF7zXobGwSiC+jTdM3ZIN/QRuXn802i/Q+XcW6ySjonVDLMxDsx/ISo7xaXEh18662BYtxpq+P70jvRHDLGCrYU3+mlTGt8Rg4waKQgiezNZD/n9JZ8z9ojkgGHHrCkm/XtV+sWF05MSaG0J+Xh50tbjSt+BWI4PIv9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFA6CH7T; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFA6CH7T"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5688c221fd3so1075991e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 12:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772224516; x=1772829316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMv+TlxQ51tSE0FjyQUwa4MlvX2MTQAyEbckffVJ6dM=;
        b=NFA6CH7TCyQWno7LXb40x3TJaKIs3xkpH7bzBtW4muCvNJnS896PMtd/KOMKJZ3T9f
         lRgcXa1cfbgnnotOzohkkWcLW7IOyNZj7Xsi1XQH5VSw0yul014TZl8Atwpxbww+zQ0O
         WKAk6dK9Ms/qPTLxfhMXutuOEArz35dFYpeq6BiD9ME2eu+KE9r88I34WgfV6oFUULON
         UQqqojAGznBUYh6Red+/Dt/pxY4nXdsWeDOEvZ8f3kZuuIazSw/rqSQmds81NpOYNIqp
         tSi4D5KYTQ8G747B0hrxk3m8wgYuAf36Cs6PXvuQkhvrGuuuivRWplHFTsaPnO6GvzzS
         Bx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224516; x=1772829316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMv+TlxQ51tSE0FjyQUwa4MlvX2MTQAyEbckffVJ6dM=;
        b=mLsdIB3IbNcR3DSyELLjU6nrivOgTJhW40JM+BRr4d7sxvQMtLAgDvzBFvAd09CEew
         UQ6qErC1BMT6eb3uCvww+FhmWwVtSY92X6/cmctiBDBg8oroSLcBNvvYLJ2phQZnC2GR
         HfPjmLrpOCYr1sTHOzQszNa7SVyn44zL/u46dsmHYZ/lT5r1HkEe4cdpQAzUPhpSSgHA
         RWRXxNKhFTdPtcZtT23Zy9bkKVASnhJu+iYgDKgSNv9AUhCfFONSoyfA3nqEDGs/SAMv
         8cRsQ4kesWe7c5V9OLGx/AGKvr+R+gdKXm49Kb1bpBtW03Vin2RCzDd/5NV91d4kX+NM
         5ZLQ==
X-Gm-Message-State: AOJu0YygSaCqZPBsVEFEqW3ICZ9mjM6Fwe8w3wXuOzKMkcaOPXeGZLJM
	mJI1ZalbuFUFpZBBnpzSADlx1bLVs6zbI0lnvcq7XCPld5O36uGZbOJ8StrjJg==
X-Gm-Gg: ATEYQzzU76Rp2sxQ7BY5XV1XX92m3sAJY/Skti0tofEj24RlTwb9EeYOiGcUnzFWQxi
	Fp9yXkSF+CTw6j+/an4AJPZKSD17xBV4vCvz9q+akTS5U2rUbFD3xnbxXpml5xvuNTr2TG02CRv
	TqBLTyZWNEPl3jdws18ouV8Rdu77G3DF19DYkeBjXS/UmqIZuRJ7W4Jpm83D4wKdADtsphXfs1x
	Uo557undUTqgNRuvga3ZMOM8uOq8rSKKkZXciikJQfTB1Z2GJpeg6UApj8xzAK0SbZeD6ozaemZ
	umU9+BC0HMe1VtbD4Nyg4S4JM07QudEjpvewNwlVOxeax+gRXOH5Qva7MrnIvk9KcHYKRBVMJh5
	jvGM0PXeXv6V9ZlWwxHH0oNfcIDg/oPMdWgkdHbJJ+rEGsE9N+R0Vwr/YErBiHlcTjIUC3bxVJO
	XMIMAFAWKCPXg651Z8/01e1TBrbYedNLl+cdH26V3GeUfoauk0k2MSh5EeXspZSDXZV4fEGstsT
	Dy96IsvIXX2s5LAfQ==
X-Received: by 2002:a05:6122:a26:b0:566:398d:96b9 with SMTP id 71dfb90a1353d-56aa09a9a82mr2087841e0c.1.1772224516467;
        Fri, 27 Feb 2026 12:35:16 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a92274b1bsm7338348e0c.17.2026.02.27.12.35.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:35:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Fix defer tests being unstable
Date: Fri, 27 Feb 2026 15:35:06 -0500
Message-ID: <20260227203506.573494-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iso-tester defer tests seem to fail with hci_conn_hash_lookup_cig
being unable to resolve a cig in set_cig_params_sync due a race
where it is run immediatelly before hci_bind_cis is able to set
the QoS settings into the hci_conn object.

So this moves the assigning of the QoS settings to be done directly
by hci_le_set_cig_params to prevent that from happening again.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0795818963a5..a47f5daffdbf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1944,6 +1944,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 		return false;
 
 done:
+	conn->iso_qos = *qos;
+
 	if (hci_cmd_sync_queue(hdev, set_cig_params_sync,
 			       UINT_PTR(qos->ucast.cig), NULL) < 0)
 		return false;
@@ -2013,8 +2015,6 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	hci_conn_hold(cis);
-
-	cis->iso_qos = *qos;
 	cis->state = BT_BOUND;
 
 	return cis;
-- 
2.52.0

