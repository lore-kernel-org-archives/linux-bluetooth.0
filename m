Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA8262D23
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547436; cv=none; b=R/kzmqVQHquO/wO0zt12fngq2sPvsWvIn431mDi5l2RxrqpzTQDO9mn1T58HJR0oZQmoSG+VokrcZWjSw4WUJb4sPlHRAMekwT8P5QEUaS92/ZyO8u+KSxleKT4NN4UIKJMt2SwMHFJUsLqf/YJ4RbEiWks2wmCD0kjOgl5vv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547436; c=relaxed/simple;
	bh=4RmDz3wSasR0Pk7Bcth12mFSgJ2i74CYhMLDba1BZ9E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HOO9f9C233TScHmm3dSwVeBjTaiVUksuOikHU1J9tCD82MhkUE8bdhiOy5NiSX1qD5VxYn0d96wlhrtLdCx0sgkWgURDXxAHI4LivdYbaFuro0Ga4GxGb3E9rH5YdR1GDLNRAcEYMibbPR6d7ttGrGI/UxnaDNmdY/OOXAUnLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wad5Qxnr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wad5Qxnr"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6efe4e3d698so19801127b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739547433; x=1740152233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqOnkwuVXbWTnTVnSaM7BUOC8gd1jHXfIHeDOgFektQ=;
        b=Wad5QxnrTSjqPatL6+gOtQR4Qf6TxJLLAAn/MKm6j2l9cj+GtVxmdFNOnoUaU/FH9r
         QIY4Q5ORrloUJDw89UqMbws+Ijsfa8cvkDULnvijCFbGAI7lx6cl07YREtjjsP2p+AXz
         1rjSKi7OY3qDdoGsFn5/3haMNZUpo3Uiuw1p4oubA/sKJilFdVnNkI4q0blyJbxRCwnn
         R+cT8N1O9+VryP7+jp9WpXUxcw6MXrOLUh+4pM2YdsUUj1apgGEVfU8B+C820Wa4+ZQg
         b1XAvniwyI5xk7vnSP+3yxElhdLSaR8ge6OJeLMIliDFUTKYPdw2o6z0sVB09m1p9iLJ
         J/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547433; x=1740152233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqOnkwuVXbWTnTVnSaM7BUOC8gd1jHXfIHeDOgFektQ=;
        b=XuIKqCtpE7JMIW2kmWXYu68jmsD+h0EJfWsBUOJZBhPAEQzszakjunyc7YxUQEZL7p
         QC9ZMVMbxLVe2gvNHKksNZbvoyUosDothhIz8110DXXVBpeCnxWDGrMpVu5vWuSxMIEL
         VG4wtAVt/9DSGEVYx4/YnNghQU8GSqlX2HdTVMn/qF36GtZyCuZd/A9T0sp/381JkjmB
         9ztSUdZAuinXv6lZvhgCVgRVG6fp/OFaVyco1cBymqTpdHICcTtjXQpecfNCYEEPxYgu
         LDpcuPazNvorf6edr7zKZ5Rb8p3/oX+4kmtodZDRhBAkA/enPlU0BJU3syyTRWppryrn
         4ulQ==
X-Gm-Message-State: AOJu0YxCWQFVCTiIhV4KYTvr6/bXw3gKzeiT4xqdRrwwm3QQB6ojX408
	+DERR2RQPJ3J98Oo3SKvCbFrpzUpbc3i6+lIaM2kVmI6JrOqVEeQ837nJFzD
X-Gm-Gg: ASbGncvWhyJgkhMH1vAFeg79Z45a3rgRyvzGICR1Q2/hx1ytKv/Hk2v6GVa6g5FmCl6
	HyYzpdBVfhoORD+3XJxkitE6cd+szYcPRFKJ753tKKTSPT5pCoTEdEYgNfnn8X3HXvzSv5389xI
	nooxwr0gNcsMIJculDV+Ee3OgaBTCepT9A9bAiYodhm9/zUKhI36YAGzmH1aWLGGewzz4r+sQxT
	IXkrysgcXR1SK443gljgQ9ISCTziAAGGkgtLNiR0nUroHB6xixML+4RJq2TGNHn0DedUm85vTaQ
	klOZ77QN1ARtQNWYBFQUyX4AxHTcSZVtnL7yj6sRWuIFyXffP73+bfbhdc0NHpE=
X-Google-Smtp-Source: AGHT+IF5myI0rDgiFCUslkr0P6q6ljT6SzMeGGyMqZxFoWqmpzjRzqTMGIZF1VZvCqsbJW75BL6TWQ==
X-Received: by 2002:a05:690c:9c0e:b0:6f9:41e3:ea4b with SMTP id 00721157ae682-6fb1f199da3mr113766647b3.9.1739547433601;
        Fri, 14 Feb 2025 07:37:13 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3607751fsm7970487b3.42.2025.02.14.07.37.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:37:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
Date: Fri, 14 Feb 2025 10:37:11 -0500
Message-ID: <20250214153711.887794-1-luiz.dentz@gmail.com>
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

Closes: https://github.com/bluez/bluez/issues/1094
Fixes: 9aa9d9473f15 ("Bluetooth: L2CAP: Fix responding with wrong PDU type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fec11e576f31..2ffb8c35dbe2 100644
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
-- 
2.48.1

