Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550426A089
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901088; cv=none; b=UpOvL9EWlI/lnrfKbwNyyQKDEb2iqjo2WwuybU0jC/TBUpeKgKAjgotZh/OkxHysm629/9VhKf5mzGKaiOclojlzWusj55kqF97madiesuNqWfLcaRpWhbDUH0XQDv/Am6v+Us4RQm29BLpKrQfPOLND0DTFWBShT3VXM26sZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901088; c=relaxed/simple;
	bh=M9sa0FtaKbsbe/7BMF1PKYFJyfduBgF8d8xytIpW9VU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KkF9G3e2cSOmMvApJ8XJTItKqKr7LKcvZsSi911MF0e/BDtJN+4gFWPlGKJJjC4y80BQBFhJydea4MVVn1H1ALWAM9pRtYxD2IemA7HdbGkoNIto9XN61jly547Wrc1CEtFSFD3+1eo3VhlhysRR6Yfj64yKu4G8WDUP3JGP+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNa2xYTc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNa2xYTc"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f74b78df93so51810897b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739901085; x=1740505885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/ltf5dYFt4hXs8lHoCvJYcEAZxOb3CjNLzyjR1lpW0=;
        b=jNa2xYTcCgZdBlwmdRkKxFXi0EN5S3cW3ZB0A6LlaZ2eUPP3lXuqf49ybB4uAyV8PQ
         IOPRuZVEQDcrhtsgP+RGr51/vHhMAVrMQonOtZ0b21LlQu88MME3tGiWsNO0Fs1RPeGJ
         XyLRWfauSQJydzym9TB2hdWx9VwZuTnoZgjUxvL7MX8KGTAwlfeaxrj13L4/T2YS7pKK
         k08fFzgrbWsGoDI8SgIL+je2nU62GLud4Os3sLvYSnjla6/Av0Ytt4gqg9AgdSI2nw58
         QztbjLxcYF+ahcbEBFGrQFuqmtJTyeZvw2ySRCa1ygpOj55iepZK/6W/bGee7XsvOZNj
         RwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739901085; x=1740505885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/ltf5dYFt4hXs8lHoCvJYcEAZxOb3CjNLzyjR1lpW0=;
        b=LCXmCgCkiPnaEYe8pvpS8hdMowMNmqVqN2Gy8/Mw/81K4jMnkYzBJP3FfOZG9O+uC/
         o/1rcW/+tf2k0EBGvD/wGRWTaci3fvhaqzuPLD0WVAlqxqUYzYXuwt9veZIQndC5YQgN
         Vb1YAVQFlPXRb590wNCeQtdmkYcEbsdVS5HFgWAfgf2PZz2/BoAkGlnWkWSBDsLLOlot
         zpEw18awPvi2kXyOO+zsg7xQ5ncs6h9wq1A+XbLZ8C6xwTqLswvW8etCS5u5Y5q5VDSd
         LLTHiEwV4y4G3L0AFqCUumkqSqlng4kiBIV79ifdCxy3qjr0MBu9osEdS0qSiezPnygH
         6JzA==
X-Gm-Message-State: AOJu0YxvTO/575RmtQaKKtUHLr5wrgfjoE9W9g4zdiiJ/J5hjtnqGAd4
	QSszpa5mWJ/AUBNDUL86gTNXIeppdbSRMIX7R6euuZL+uM4WIlcM1laNeg==
X-Gm-Gg: ASbGnctihmDrGblba/6UVVYgEMcDNvUxTTQDWUJF3fpkjzHlwqkyvF+CyxkLoC4AIYp
	cxCTzFFAMLTQyAC8G7t2pT5U6OGRRDOhMYW/LXBh9Pr0Pg2cLnST68LJ3yxCluEcw7y8AeZ8fwZ
	D+AJlYp9W9g48y3KGwQduvn95DOB+BCUcwaL/NKdEOCmTnVTpkgyfkruIq60PJoo0RsE7ka4bhd
	s40RORxDR4zGT2RKuNmm2nKJI/+xehYoyHfildmatgsOU3YcHVysVId0bh219uDxjjwxKllz/UW
	e1IymGHoPW5bhvHRaVbM4rNqp6dJmCznCVEL3s+ebzEdnjuQk1Y5JuJVkQIRxpg=
X-Google-Smtp-Source: AGHT+IHV11UowrKp+NXjgW9b3CLqgn3HthVb0uxnlS2hmO5BOHyR4X4lkAlmQRG/C4vupC2HDQsZaQ==
X-Received: by 2002:a05:690c:9c09:b0:6ef:4cb2:8b4c with SMTP id 00721157ae682-6fba579e7b8mr7837127b3.23.1739901085272;
        Tue, 18 Feb 2025 09:51:25 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35f66ad9sm27166577b3.34.2025.02.18.09.51.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:51:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
Date: Tue, 18 Feb 2025 12:51:23 -0500
Message-ID: <20250218175123.1479657-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fec11e576f31..e716bfed4159 100644
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
@@ -3771,7 +3772,9 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	struct l2cap_ecred_conn_rsp *rsp_flex =
 		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
 
-	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+	/* Check if channel is pending */
+	if (chan->state != BT_CONNECT2 ||
+	    test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
 	/* Reset ident so only one response is sent */
-- 
2.48.1

