Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C419CD06
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765297858; cv=pass; b=hDxBh53rpB3JV4x+DXS0yS8Nhbqh3xWRUhIDp84m3yH50gINfjbqYG3eRCc+yFx9FY2F1xG3KR5hoF+u1aw2hGtETskgYfpq9B1onqKpjWeFtW4Gg/21tASjCbMgRUHFhOR4Wy79ckjmk11P88TrExHoGeFYc4NJKwnKX9/eP2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765297858; c=relaxed/simple;
	bh=JFvDr3Ew6b6bUtja/p6jTxDDClA90f++F3NPsn+N2Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaOQefviGidKK4qb70GA4YTU0vovl5g/Ku1vD2DbjK10H4tXUhPHbnqOu3oX3QPgBhtrM5ruFMfg91YBR9ufvcd5CNh4Sd0IKwZ+diSqOm0ulLbFlD13aHLc7DOV3V/sJZkneDfikKquF6T9TUbfeh0ik3PZey1XZhS7e4rkaxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HW3a1L1n; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HW3a1L1n"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQkqb4l2CzyRd;
	Tue,  9 Dec 2025 18:30:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765297852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anb1S9Vd5g6ujNgDCgRuwHk22HiJGfbuoBBDijDlBBU=;
	b=HW3a1L1nCRobKb4QMu1wgtXwZlu+9WQCd6Hm3fs+b5Iah0jRoe2H1HJ9WJBKSCRDFlbJyG
	DGqRUzEXRGAMapHeX9rNSj0jj0fI6k+aUbheg7HoDB6+HvSvno5uNPFrA1mT2c1Wk4NcfD
	BtvuFGIO0LdyGcw7El0ZPOkl0ZC5zN0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765297852;
	b=wbTWof9tAHrt2pQRpC/ZigmgQ9kqpfIuRSzakkWWiO5bGf0c5Lnryidx2kERQbv8o0ZOxg
	V/A+ObuYZEgSQKUgEUIY6pCz7A/1CYAVE9wUYRs/zZAY4PEKppZZw7BCRrhG9r3fUt4/t6
	cBaT1ghEDAcNP2jea4jG8ZWvVstjl08=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765297852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=anb1S9Vd5g6ujNgDCgRuwHk22HiJGfbuoBBDijDlBBU=;
	b=AB9m+W1NuYmGIxA+NJweiOMOSxOcMKxcWjstKGBfGBgtAASODol7rvO7E3dFYXY1FYAm0S
	8AE8VOqJeWLd9zZ8urLGKqAKTSGPwRcgH/mIwDETMa+xGJ+zt0sYjaSkfjxA+615GMcLtf
	iQrQLAh49RugGmnXdiOUT0el/qQ4qPE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH v2 1/2] Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
Date: Tue,  9 Dec 2025 18:30:34 +0200
Message-ID: <118c61c95ad4deab0e08d3a3c8b92910bc271281.1765297112.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When protocol sets HCI_PROTO_DEFER, hci_conn_request_evt() calls
hci_connect_cfm(conn) without hdev->lock.  Only SCO and ISO set
HCI_PROTO_DEFER (for listening socket with defer setup).

Nothing guarantees conn remains alive after unlock.  In all other code
paths (also listening socket without defer setup), hci_connect_cfm(conn)
is called with hdev->lock held.

Fix by holding the lock.

Fixes: 70c464256310 ("Bluetooth: Refactor connection request handling")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    These two patches are pending some further testing in practice, but
    lockdep is now happy about how this works.

 net/bluetooth/hci_event.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9868f17ef40..a3bd7dcee1bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3306,8 +3306,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	memcpy(conn->dev_class, ev->dev_class, 3);
 
-	hci_dev_unlock(hdev);
-
 	if (ev->link_type == ACL_LINK ||
 	    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
 		struct hci_cp_accept_conn_req cp;
@@ -3341,7 +3339,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		hci_connect_cfm(conn, 0);
 	}
 
-	return;
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
2.51.1

