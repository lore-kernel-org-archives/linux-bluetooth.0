Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CD4156FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488285; cv=none; b=dfz4Pc3l4wR6xuCTZhPXUVsuN0i9BpXMT3fujin3hg778jTArQCmk4ZtBTAf8FNJ5BRMKVB2Rey1WiwdERi1bxhvcEk1O3aXUpX+U5yLy62LFu5aVe01eR9XIh+CbNBs4CVjxSIDA6jYXGl1p84L0IY4xS6XY8qSPmNA+Kvro1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488285; c=relaxed/simple;
	bh=5FB8PC6/Q62nOVg0eoQJd+DOERl2l6vI8fv1xL9ikDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIN/u9TOiMWnKmKvp0eWazei+LfCHI4acLwBLd06EV2qf4QZggzJdaAzfMObrSoRv1+U1YJWvtCO4TOSg3PFT09RHEYUS7OHbHztcoaPmZnMwITHm9HDEXWzIxhqJuZfVpxVALWF60kxWsxmqYOYWZ3Ux420HruyiGxWefmbmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqBkoN+p; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqBkoN+p"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78569cf871bso2454829137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488282; x=1790093082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObKLsTHjJOHf93xH+uaMgs5fVVY03SLwwchPdEnva94=;
        b=BqBkoN+pCVsO3HvBEmiwuOdYD1STk4ALeVhnG9vvFLIMiisb0gZMW2oFCbl/Nlw0r1
         PZDaK1vDqvUf1sUQ0YzUC1y9WD0Tq7+lCacehwDIXdgoe6nqIMAjqFrIHVOtwPha0kKV
         eSmt+km9g5DudDspkzwIQDbPVyX7ZNizMxIxIRnIM0MG80+Jm5VZ0xiVppvpOKzvn7wz
         03HgSKDOhXG/ZYDsf1doSRkKhwDBNHL9OJChGCLRDv9j5pngqcwUmanYa6r71pcNMbvX
         +PJF1nanxnK3WDVwW2mPRlDPQ1PV2ux/8iVvgtDHhoQOcyISaRBeGwGcNpgf7jsBCybE
         5d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488282; x=1790093082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObKLsTHjJOHf93xH+uaMgs5fVVY03SLwwchPdEnva94=;
        b=lfH/MS4vleBTjUJHmw9eN+KR+F06Das2Cz+wXoJOSha/d5X9zAbLdPNTTTXtTpjtU2
         sbsTDf6ssykXBAZXLoLwRgNW4ugI7r1dH5lAEOQJx2pTCKK6G4v8+/qIxw1cdcsHeGAB
         oTWjYNXAyNwO/ZJpJ/uFYCjYlZZGpRKbRW6tbLrguysRwohJ7jMwxp7kQdorwz0jfitG
         ZfyakMk+LykjHesafQHtfHVEAp7/KxUVhsX3fKBxzPCsgUhRzetyqb4mLsvEFL3L/u4E
         nnGXv5yULuAzx8hYVsaQdD+JZ/iDEjMbqfb0GFk/rr1eY+dhoBeluS8Mns46gJWptgyg
         mZkw==
X-Gm-Message-State: AFuF++k43gjJiiYxfBlLalHLG4Pw+ASBdeAPq5+vrgwDtcnmySzCpMly
	w/G/UTh7Ax0DBJyU4j2ldZ/nHVpx9RijVcyuMPXispbKmyI91ExSeQl8
X-Gm-Gg: AYBFou3KXV0fFwGQhlYDSauaOsueB2x2fjEuj4PM4aeToEUmT6NwMB9SBEC/ndhM8eS
	wPIBz+HxuOxZqfNDqRa1Bb8KO9kkGlAQesEroD739EkeCL2xkQ99mRLqozlg+lWd2QW4b6hGf5I
	DcmHbjVOXmjNM1LuKTSQnjhku4WegBQQWBWI9lrvbIoQ3V4IY8dpgI/tCDrocfc3sisG4jr2KvU
	tj05Fu4TtLq2jeCJe/3MbLl6cATQcIVwqczPHhM16nfhFFBrqAg4XbsExXh5Dr70dg6FfIXqXIB
	LuIP0Egnwba71SXZQ70PJU+Cyrc2OVdd1Spp8KMBg/dbRWe8zvqoI0QqUYg4XdIU8Eo+26/OAZH
	6amZ9uoU9FuSioAS/bLnRIW0rJ40bEs9E39KeK6ZSyUvGP7PpO+s+Ln6RSSVcr89A99yw8HQAGD
	/ocs/iFYz0RMPqLTi5s25MJ5p9QAvjtmxhxKVYyhC/Cc62f2tV0dxc6teF+vLEiE/K
X-Received: by 2002:a05:6102:f83:b0:79e:3401:4036 with SMTP id ada2fe7eead31-79e34014397mr1706268137.9.1789488282158;
        Tue, 15 Sep 2026 09:04:42 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79facab39basm124128137.2.2026.09.15.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:04:41 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH 1/2] Bluetooth: hci_conn: fix CIS hold ownership on reuse
Date: Tue, 15 Sep 2026 13:04:29 -0300
Message-ID: <20260915160430.3108071-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 69997d50ec57 ("Bluetooth: ISO: handle bound CIS cleanup via
hci_conn") made hci_bind_cis() and hci_connect_cis() return a
connection with one hold for the ISO layer.  hci_bind_cis() currently
takes that hold only after configuring a CIS, so its BT_CONNECTED and
matching BT_BOUND paths return a bare lookup result.  Its configuration
failure path can likewise call hci_conn_drop() before taking a hold.

Take the hold before any state-dependent return or configuration error
so every successful return follows the documented ownership contract
and every error drop is balanced.

hci_connect_cis() also assumes hci_conn_link() always takes a new CIS
hold before dropping the one returned by hci_bind_cis().  However, the
helper returns an existing link without taking another hold.  In that
case, preserve the CIS hold for the caller and drop the redundant LE
hold because the existing link already owns its parent hold.  Returning
early also avoids changing an existing CIS back to BT_CONNECT.

Fixes: 69997d50ec57 ("Bluetooth: ISO: handle bound CIS cleanup via hci_conn")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/hci_conn.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4a..827694c3d6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2047,6 +2047,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		cis->conn_timeout = timeout;
 	}
 
+	hci_conn_hold(cis);
+
 	if (cis->state == BT_CONNECTED)
 		return cis;
 
@@ -2088,7 +2090,6 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EINVAL);
 	}
 
-	hci_conn_hold(cis);
 	cis->state = BT_BOUND;
 
 	return cis;
@@ -2465,6 +2466,12 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return cis;
 	}
 
+	/* The existing link already owns the hold on its parent. */
+	if (cis->link) {
+		hci_conn_drop(le);
+		return cis;
+	}
+
 	link = hci_conn_link(le, cis);
 	hci_conn_drop(cis);
 	if (!link) {
-- 
2.43.0

