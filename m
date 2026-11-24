Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531612;
	b=5klLjCSfxy3o32CUCV4ttF95cHDDzj2hNxlsOIYDw4lcYxYfw5n1QTBDCo2/WTJcndmw
	 HoDToB/A66ZuTKtNPj1li7wF75ojHeutYkOIAWR/luOwoicWev3rRAD0fXsXEROH0ZVh4
	 +tD9o86hwiYD6sZB1Tn/TdbVslQPijhYlTNVUUHhuQ8d/a+sk7qs7Tq39mbgKTQgra8zS
	 avpW9ArDEBEXwJd7kxvZKOOJ+svfr6AmNBegJcd+ZwBDv6+yncabZajY80I6fMiG5GhNg
	 vc0TXy4VlwOMAwkQssHFmBCPxq9BZPdLUoCiY4DNOELdlqbNVVASj3jRg2UKaNCidcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
	b=2gVspE0cUVNKWcs5JLiQzoNdl6aIXmryQ3Xl19gVRdND7aFRqtc/ymwl5Y5lgSsR0qUl
	 bG1hrggyhYKTUNPPSgjnd3RBRwHap1C2Ac86QYhDKLoVJdSJzQjs+B/m70zGAWVUj4e1+
	 sMHtrTw8MbGS5meKnlsMjfRV3ouUwHYVaLOBZvNNYLym+FsQ2kAy7sUoucmSmjjQ1mRPQ
	 8V20v4ySOU6Lm2+GE9Cjp2gAFuS7s3mfgNfv5N/LuwB7v2cH74OJesw4X+aCNWAOd73fB
	 HPpakG67B0zywEPgzMlsTvFDUNeAGmsIQFlVSJcgSx2+IE5Da84FMmrrnOhImZhLnUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hOdbxj1a;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B349606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B349606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=hOdbxj1a
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso45558925e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531611; x=1796136411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
        b=hOdbxj1at5vT6Vl659CC940z41TVg/YF1qnIORku3R7bXTsovC6z4NT7atz/w7jpHI
         chJL8osRWxLoHGsZATx9D2413C0RIDvYjKDB4PqYCfg/H8fDljcOmUOca8hfQG2nl2XF
         b2Ia/6wcrrnCikZ4Lrgz+tci83T71+S0oKSd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531611; x=1796136411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
        b=u8WYVj8cxC6Q1D/5JVvurC+Zogo/t2wglsC4TMU5c7TpUUSQNY5/6ExJlgPla5a+Tx
         IrwIAGsfR4y9Gxh2t8X/dfdw8XdTrrZaSOYM53QKBeonBu2TneqmDMUbqHB0biAwze+q
         5DD8VsuryOtk357Oy5M2iOwS6MEBCfTWfiTL1Q8+kQVTELnCTPCWGkCi3IvEK6rEcLXO
         hsIijjTMaN3l5Iepg+Uayb3Wn+Br1qYKuXP28+5YDRjIQiX+aFyxIAYzDVjbtdx4ajte
         jPMVxl8Xqdy3f5+pqZ+GkJqSSgwQZaKxOqBYQ1MOpzuOP7N8HApkCUJEcEIsKmBEJO+j
         LaUA==
X-Gm-Message-State: APuU4Z9PpduSPupcu12xuMabZTtzEr5VYKe6x7Z/waD6Nh4QxNaom6ML
	qIxPoZmcz33rDJUYKt7TrZN1gOG2uc53Ar3G8mky9vYoS6R1cGRYMA8uhTxW+t1a4EGXb0/xTBl
	nm8l1
X-Gm-Gg: AZFdTZf7mho6c16A358Az/PYuUoxLCl+bEbGEFOt/xCPFvSCuNPzF54ls2caLHHBlm4
	UAOVzucOWksN3Cl2DWYQQv0EVzTM6hMg4E70orTnrhCjWeGLR1oTu+lU0eLI28MvpR+dCfyFWRM
	GpgxOCP2HOf8L3CrWbWjTOXLKjs6qdBzoGGmoSs2DsVify+Cni1Dz2zS6hcG1P9+f04owRczHqY
	5H3o57JcUibi3vQomvuHzu/d6WyAfv1Kkh7sIqrdGCKG1Sf3/WjfIwUYv/RayP0tilF+j3Yvgc5
	robtv9qe0x2IA7esIDQisd3aj4apgawkt+iTzCz3jjg00cxIh2Bzq70GacurIx9INTxNtHDS6nZ
	uvVEqCHmX33/r8PoAOv3CxGV3/S9/YeCukXe9f46aOmCg3YQsYjdcwUSKvYk/Kqu60S/EI1o6XF
	GFslrGMnnCqjggvhizq8gP/eRnJ7PmFCUNU0gnmnN2SPM16iekljhQBFQBrb9Iyj/1pT5wxQnFZ
	arQmnq8m4vHzrS97UVVSW+EUjCFY0PwEcUR5EOpMCbnoXjw3IiRfkL/X3nYtxBfSw7/ZriO0dEx
	okiTEhQam4LxeiAlnOWX/B8NUHOSJO9KxShce0i6yKQfEbVjzg==
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb8880aba2mr295386365e9.8.1795531610810;
        Tue, 24 Nov 2026 06:46:50 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:50 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/8] shared/att: Use the smaller L2CAP MTU as ATT MTU
Date: Tue, 24 Nov 2026 15:46:36 +0100
Message-ID: <20261124144642.298366-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

On an L2CAP channel with a dynamic CID (BR/EDR, EATT) bt_att uses the
outgoing MTU as ATT_MTU and reads into a buffer of that size. The
ATT_MTU is the smaller of the two MTUs of the channel (Core Vol 3,
Part G, 5.1.1 for BR/EDR and 5.3.1 for EATT), and a PDU the remote
sends up to our incoming MTU is cut short.

Use the smaller MTU as ATT_MTU, and read up to the incoming MTU.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/att.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 366ee83d8..45ae9698e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -53,6 +53,7 @@ struct bt_att_chan {
 	bool in_req;			/* There's a pending incoming request */
 
 	uint8_t *buf;
+	uint16_t buf_len;
 	uint16_t mtu;
 };
 
@@ -1104,7 +1105,7 @@ static bool can_read_data(struct io *io, void *user_data)
 	uint8_t *pdu;
 	ssize_t bytes_read;
 
-	bytes_read = read(chan->fd, chan->buf, chan->mtu);
+	bytes_read = read(chan->fd, chan->buf, chan->buf_len);
 	if (bytes_read < 0)
 		return false;
 
@@ -1237,6 +1238,21 @@ static uint16_t io_get_mtu(int fd)
 	return 0;
 }
 
+static uint16_t io_get_imtu(int fd)
+{
+	socklen_t len;
+	struct l2cap_options l2o;
+
+	len = sizeof(l2o);
+	if (!getsockopt(fd, SOL_L2CAP, L2CAP_OPTIONS, &l2o, &len))
+		return l2o.imtu;
+
+	if (!getsockopt(fd, SOL_BLUETOOTH, BT_RCVMTU, &l2o.imtu, &len))
+		return l2o.imtu;
+
+	return 0;
+}
+
 static uint8_t io_get_type(int fd)
 {
 	struct sockaddr_l2 src;
@@ -1259,6 +1275,7 @@ static uint8_t io_get_type(int fd)
 static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 {
 	struct bt_att_chan *chan;
+	uint16_t imtu;
 
 	if (fd < 0)
 		return NULL;
@@ -1283,15 +1300,24 @@ static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 		/* fall through */
 	case BT_ATT_LE:
 		chan->mtu = BT_ATT_DEFAULT_LE_MTU;
+		chan->buf_len = chan->mtu;
 		break;
 	default:
+		/* The ATT_MTU of an L2CAP channel is the smaller of its two
+		 * MTUs (Core Vol 3, Part G, 5.1.1 and 5.3.1). Read up to the
+		 * incoming one, as L2CAP lets the remote send that much.
+		 */
 		chan->mtu = io_get_mtu(chan->fd);
+		imtu = io_get_imtu(chan->fd);
+		if (imtu)
+			chan->mtu = MIN(chan->mtu, imtu);
+		chan->buf_len = MAX(chan->mtu, imtu);
 	}
 
 	if (chan->mtu < BT_ATT_DEFAULT_LE_MTU)
 		goto fail;
 
-	chan->buf = malloc(chan->mtu);
+	chan->buf = malloc(chan->buf_len);
 	if (!chan->buf)
 		goto fail;
 
@@ -1487,14 +1513,17 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 	if (!chan)
 		return -ENOTCONN;
 
-	buf = malloc(mtu);
-	if (!buf)
-		return false;
+	if (mtu > chan->buf_len) {
+		buf = malloc(mtu);
+		if (!buf)
+			return false;
 
-	free(chan->buf);
+		free(chan->buf);
+		chan->buf = buf;
+		chan->buf_len = mtu;
+	}
 
 	chan->mtu = mtu;
-	chan->buf = buf;
 
 	if (chan->mtu > att->mtu) {
 		att->mtu = chan->mtu;
-- 
2.43.0

