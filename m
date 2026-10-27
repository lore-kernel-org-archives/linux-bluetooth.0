Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119818;
	b=auCmtYw/IvlE08rhwh9Cs4n7Of+7t1jrRAtONFtt6JVUmGPQavQqYOeBTsVGjFlcAJAx
	 AzDw0NJN38dcjtqeXidT25UvoGi81uom4UZv/wQeR8rMv6NGdY8G4QE7tal6agVWW1U/l
	 1RRagBmwYi4mdNDb25SCVbiwU6huwSCSCB0He3lXIlExqGMhugCiyCLWxzQARVt2S3fLa
	 z01CPMeL1LfszaQb5/iQMvyeyOkvrk3r9HKh1/vkcWn0MJLaOCDOGZMEIWCoHbZZ2vkjc
	 rf/OVV7rUwhkdZfqLKQ0AyNvxyjo47QGgo0q/C2rB2lb8uDFexo//2c/ErsHsPCn/fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
	b=a5DcwCtBkz4pwVI2BxWIqlKYYTBt4ao2/JcRjjgnIzDYnOlhPjr9ZLnuhHV64c4bEG79
	 cON99XX6ItEigZOw+S18sZrPgkT15FxH/7VS2YEMaHnEx/iemheft7qHRsAU0fuGfCc9h
	 W4L3KPbgJSXWIrPBP30udJw3TSOjjOvsCPej5Mn65uUrWYFtbHvsi7Rp+6i71H/hBBiqX
	 h6vQ+kS6pXr4e0jagxfHWGxRh9fzFozQo0m+iI+pDusp8qPY0YuqwC58HPMAQtmprZoJ2
	 u3lNYasCb9AuBG9V5Z8tCpnCJ7bQ/VAqZzQDX8bToMboXaDWZYfjiVaNsjcEaCQfcQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la4w1539;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A66606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A66606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la4w1539
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8437d47592bso2571a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119817; x=1793724617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
        b=la4w1539TI11yfEnrvxu16oZX8aY02atnOMFhFecsCbLPlsc+qWmlalnnmLTLrhRB0
         cXIvBvW6AdVlwli/OTujmmOHe++pNxCW+WoLLWx97k4l2AjqirquI4ZzwUcfXoZ9YQtu
         8bCmVM99moCXyTyw2yydQxBqmWSc2UtzeLgDHnQiZRuzGBw7VSnVJWqhOrzvakukfkfL
         CAWtO5k2Rd3mKS36H7GyqDwB0iV6vkqIUBIa2xrUmc06KhKMrQheAPGT5HL9u/fnmgQA
         Ch6NpKShcV1J44hvq99uS6ZwrdIJ81bgxOvNUdBy98opNB8hXms2gGveQqZt8KWmzNBG
         +Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119817; x=1793724617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4uABW8OiY3rHeYMO8zDAabmlkfTd/SaGhS/z4feweo=;
        b=MocBVf92xR/IgDAuVNHTwVvrENcA11xh3uaQmfSPbFdOj1vV4tL7Vm11aFJo4ViDJd
         BeLd/tVNzmU2Xt7AyqnxnP0kl497sL4aZgpxZPdHh2GpU808uNDyUl4ed39wX54Sadh3
         1V6yBfG1RsgRyrAx2xLgVm3M1OtAAHfy/KvC3exRrZ9U3jVZRzpeJ4iyAukOpfIKaTs0
         BLQTi1SOHvEFrU1zPAlyiwsKNBiSwWr3Fqb37cXr6XL/Wf756S2Nv2Z6LNiOaHlsQb3X
         lJPec963PN9tg0asYZ2biDDSYTyo4xk/ndFtUcLgtn+3GBHLS51YZuNyTTpx3frucfS6
         ImIg==
X-Gm-Message-State: AFq9FYIdawYB9RKnGpPHWhb6mcaDElE59Mbw/45fKDGnNtvzaefNOh2j
	4xmGTlfWt2zaA/H0sUcV/QIqmmJ8PdyhooRyemEYoMVkUjzEv69IpongY6Y/YdN378c9jw==
X-Gm-Gg: AYBFou2eTJgiS+31yC3SGrBpUFrXO5Si0a02BxlF2SkcBJO0fM60QVDqITEl6qmP/OM
	hnkHaktZgbcVMcmn49dUAbel3myiLYcvN/9Xm7hCx/5YYu3gC++XiBOq37kV8xP+/2pg0NB3I2H
	uqOuss5h5z1kzT2hrpibP+5PM1Vk4iUUoZbYd25f7B+slt+v6Lu5l4Qt23qp6ZtcXLddzy+x+IW
	18LG8cMgGMOjEzz8QtNG00Bjr7DFMfkRYtxC9BJC6T5ADyhuKr4DuEn1Q9wsfz01P9yYgi3fW8P
	fg3aVLhDEJ3gqFxi3aDFrBhmY223rRa6PJPhhngQRPCcSUE1RKZrjxnSOz8dGJaXJm3tqgZE+EY
	9aFQqOpf+UQX0lmnrdHJODcQQaB7IH2llB9CD2/y6QMHdU/Tv3pmC8glY3QP1fAEDyXBm2X9/eY
	psjTp0TTaj+cAnN1hj74m+2G2F5v5klIvjg1euJvNvVCuYlDyRf4yzxzL0OPVC+Gb8BXP8A/9h6
	mwWBkqo9kboUhdcDTuvLVXNYT6v7Y9+9LD3mqd0CLjqUucxDtxlKF4FJeUXlMPSupFeiRP7+Ze8
	9LD6Q3mEtE5tSYBsiuciKa1U2hRbtyvb51A=
X-Received: by 2002:a05:6830:a201:10b0:828:f53c:92fa with SMTP id 46e09a7af769-85aba4245c6mr70437a34.0.1793119816992;
        Tue, 27 Oct 2026 09:50:16 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.77])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749dcsm10927058a34.11.2026.10.27.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:50:16 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Hitalo Souza <enghitalo@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_conn: hold a reused SCO connection for its caller
Date: Tue, 27 Oct 2026 17:50:07 +0100
Message-ID: <20261027165009.2401154-2-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
References: <20261027165009.2401154-1-yaroslav.voytovych@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connecting a second SCO socket to a device whose link is already
in use correctly fails with EBUSY, but also disconnects the first
socket's working link.

hci_connect_sco() must return a connection with a hold owned by
its caller. sco_connect() drops that hold when it no longer needs
it, including when sco_chan_add() fails.

For a new link, hci_conn_link() takes the required SCO hold.
Since commit 06149746e720 ("Bluetooth: hci_conn: Add support for
linking multiple hcon"), a connection whose link already exists
is returned without one: hci_connect_sco() hands the reused SCO
connection back without a caller hold, while keeping the extra
ACL hold that hci_connect_acl() took for the link.

Commit 8a5b0135d4a5 ("Bluetooth: SCO: fix race conditions in
sco_sock_connect()") added the drop on sco_chan_add() failure.
When the second socket gets EBUSY, that drop consumes the first
socket's hold. hci_conn_timeout() then finds no holder and
disconnects the link.

When the SCO connection already has a link, take a hold for the
caller and drop the extra ACL hold, which the existing link
already owns. Keep the hci_conn_link() path for connections that
do not yet have a link.

This follows the ownership correction made for CIS by
commit e06d549fcd4a ("Bluetooth: hci_conn: fix CIS hold ownership
on reuse"). The second connect() still fails with EBUSY, but no
longer disconnects the first socket's link.

Fixes: 8a5b0135d4a5 ("Bluetooth: SCO: fix race conditions in sco_sock_connect()")
Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
 net/bluetooth/hci_conn.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b007f623b2ecc..7a55aaf197138 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1911,11 +1911,20 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		}
 	}
 
-	link = hci_conn_link(acl, sco);
-	if (!link) {
+	if (sco->link) {
+		/* The existing link already owns the hold on the ACL, and the
+		 * caller needs its own hold on the SCO connection, which
+		 * hci_conn_link() only takes for a new link.
+		 */
 		hci_conn_drop(acl);
-		hci_conn_drop(sco);
-		return ERR_PTR(-ENOLINK);
+		hci_conn_hold(sco);
+	} else {
+		link = hci_conn_link(acl, sco);
+		if (!link) {
+			hci_conn_drop(acl);
+			hci_conn_drop(sco);
+			return ERR_PTR(-ENOLINK);
+		}
 	}
 
 	sco->setting = setting;
-- 
2.43.0

