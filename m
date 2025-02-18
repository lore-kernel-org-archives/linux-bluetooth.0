Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406871CAA93
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917687; cv=none; b=Ub++SqejxOLFgy0xJcgOxjg5CT9bh3HPHt/LZ0patQVHALDAUvcO4zweX4J42mAn3MX6lOBNH/TNYFvylVQEVHcXTs4avTN2wKQWmnl079B/WvGzgPjYTE/dCEnWFpCa12ZMQwHQrrk4fXvb62LHPQsdvJlFkSv4JfeT47tr7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917687; c=relaxed/simple;
	bh=/k5wVRaD5LMeCv9cOAd+eHo0wtzpm5v/QC0GEOa7JT8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=md7jtS6DervJexhYbRwB6N9ksQO5CZIBqs7f+Zuhz8QyoUZ7DdQaqAQqMLbmHQqQMSTmwudjgcbp4IHRPBuHjDIekVJid9a+aN99Ku9WJag1GS8LpMHWTu2AmAsO0Sgz2rWaq+hicoPcR58EwzlSueeL8PN6/jtmTYovXertnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj61lIsi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj61lIsi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef7c9e9592so46283497b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 14:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739917683; x=1740522483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y6lQA5k6mf9IWK7DuOh0OZcAjpNHUWXl6bhJSbsFRC4=;
        b=jj61lIsi3W0PJfXxewpewn3/UWUPuBWcYyq4gJP8FBYiFBHRsyiAlpdZpBUVgARNVC
         Tr9QqZl5jXsbjtev2SllDFsX5tGu0A2PKTOT2PdVit1LP/gDxS0SnmYZX9qScCnRQJ8V
         nDQ3i0BVdLmApkprPPj/9tCMalsXz7xiJIOl9dMimPWWp1A6a5Nmnaj4gw0ikM2bKj9W
         eZbi33yiwxjHoj7Jk1QlO2bPydoZxPNadoWNlS6kQmIsZXR1qR60t8MBWrccQ0zlyB6r
         K54PXlbLAqk7xiTk6xgkz/pgcIlywm4RznX3DgXxj2q8V0C2m2o5mb6tNPVltHiwfB39
         yx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739917683; x=1740522483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6lQA5k6mf9IWK7DuOh0OZcAjpNHUWXl6bhJSbsFRC4=;
        b=RRzi32IghPIRC6NyVZIJd5LyBtp7sBFrQGaFyjCawZFsi+PR3r4vm3GGktQJcaiNIN
         OA/9TvoDq1dqZH3LC65jJy0Php+nDhzq1Bl+3KK5ddiuJVaPaZq1uahnz3KeLIQ6cpU+
         XWMIH+gDee9ujylqete0hr19iibTNRas/KFRcpRAXjs2v+P7Qzfhqeh41xsASUL8wcpc
         Ub56VJc9yLEY7jc4sIAMjWureWMqsAatmXMN1H9ZflS5bRDYZDdcZsfEGy9Ta1dnWvMv
         vhvlKzCGB6XtwV8X2WGNQMfXfirgIw7e8D7IVIa2ghSOCWqXcnK/N36rRPFMD53/UDs4
         eGjg==
X-Gm-Message-State: AOJu0Yydxav8y/lq525mhx2Bm9uShHWb8hH52iFmfcvGE0JpY5bDR6rF
	CE4fqKbLVHsK7a3H5vY4/JeseYGMCbg+nsc72uki9KyYTwcBd4Moj9K9oQ==
X-Gm-Gg: ASbGncslqkivGRfxc+mXP+Q3GJH7LTwdB7uSUkRTP6YjAR33e+tczVf+kXzSe4+6BN6
	rJfNNDlATpHoMVDIzrPFmtoXwqxQdFBmrFXJMEoABlaLIXlsJGRh/uMrM8cHTI9KggzGWW10uKZ
	LCBbjoRGyLNQ3kfFBei7pq9i1pFdUcc3v2xtqMONNFMHpWFkWPqhb4CLx050X7n9sKUNIUlHRgh
	bcRKoT2nao2UeAS4BhbwRlppjIp3Q53JVd8Sc7LvYEz7iVih/jduVQM5e1323f2cRcq3dHOIAoU
	+M5w3g3+6bx7yuV+MlyyRu/3onMROpNN0ZnhEMOu8iNldyRxZe30bapj3PDX8UY=
X-Google-Smtp-Source: AGHT+IGUadDEa8vAEZ7ZR3N+5VXHf9J0ZwwB6OruPtM/DX/vfVivoxQOsSQhm1NMqLIOgyoehm8TWA==
X-Received: by 2002:a05:690c:4d89:b0:6f2:9533:8fba with SMTP id 00721157ae682-6fb5827084bmr145829917b3.1.1739917683469;
        Tue, 18 Feb 2025 14:28:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361da1c2sm28360237b3.122.2025.02.18.14.28.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:28:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
Date: Tue, 18 Feb 2025 17:28:01 -0500
Message-ID: <20250218222801.1526620-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2CAP_ECRED_CONN_RSP needs to respond DCID in the same order received as
SCID but the order is reversed due to use of list_add which actually
prepend channels to the list so the response is reversed:

> ACL Data RX: Handle 16 flags 0x02 dlen 26
      LE L2CAP: Enhanced Credit Connection Request (0x17) ident 2 len 18
        PSM: 39 (0x0027)
        MTU: 256
        MPS: 251
        Credits: 65535
        Source CID: 116
        Source CID: 117
        Source CID: 118
        Source CID: 119
        Source CID: 120
< ACL Data TX: Handle 16 flags 0x00 dlen 26
      LE L2CAP: Enhanced Credit Connection Response (0x18) ident 2 len 18
        MTU: 517
        MPS: 247
        Credits: 3
        Result: Connection successful (0x0000)
        Destination CID: 68
        Destination CID: 67
        Destination CID: 66
        Destination CID: 65
        Destination CID: 64

Also make sure the response don't include channels that are not on
BT_CONNECT2 since the chan->ident can be set to the same value as in the
following trace:

< ACL Data TX: Handle 16 flags 0x00 dlen 12
      LE L2CAP: LE Flow Control Credit (0x16) ident 6 len 4
        Source CID: 64
        Credits: 1
...
> ACL Data RX: Handle 16 flags 0x02 dlen 18
      LE L2CAP: Enhanced Credit Connection Request (0x17) ident 6 len 10
        PSM: 39 (0x0027)
        MTU: 517
        MPS: 251
        Credits: 255
        Source CID: 70
< ACL Data TX: Handle 16 flags 0x00 dlen 20
      LE L2CAP: Enhanced Credit Connection Response (0x18) ident 6 len 12
        MTU: 517
        MPS: 247
        Credits: 3
        Result: Connection successful (0x0000)
        Destination CID: 64
        Destination CID: 68

Closes: https://github.com/bluez/bluez/issues/1094
Fixes: 9aa9d9473f15 ("Bluetooth: L2CAP: Fix responding with wrong PDU type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fec11e576f31..b22078b67972 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -632,7 +632,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
 		hci_conn_hold(conn->hcon);
 
-	list_add(&chan->list, &conn->chan_l);
+	/* Append to the list since the order matters for ECRED */
+	list_add_tail(&chan->list, &conn->chan_l);
 }
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -3771,7 +3772,11 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	struct l2cap_ecred_conn_rsp *rsp_flex =
 		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 
-	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+	/* Check if channel for outgoing connection or if it wasn't deferred
+	 * since in those cases it must be skipped.
+	 */
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags) ||
+	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	/* Reset ident so only one response is sent */
-- 
2.48.1

