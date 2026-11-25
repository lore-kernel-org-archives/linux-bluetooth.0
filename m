Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625951;
	b=pNf1bxDPzyVTJEMVRj2Jvx1KNqS3TH9jSn1lXkCxyE2T0m9Qg8ox/nETg5YVOE3mBaJL
	 0KYoizM2nBBskQ2dbfcIMhsjLpS3IS/R77dpb/6RoAvPStmCg3KbLcrkVpfEoC2siCkGT
	 Jy7tG/bKyjeCdgtqpWPAG8FNvU2rnMvA1fs/Gn7TeytV+3kvIwMhO0m4NP6xzdN33ykfW
	 KDfTXtzmjL1qWap0DVCkdqbNkiGfaIWe7Z18Wbr5gKQ1dMZPBuEuiQXb3kJqW48bCmafl
	 C2DCkcTRkMOpMQL2MV6e7djQ96/3AQpHojx/Msk3OQftWsNAsKKYKBL68roMZRHxjaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
	b=1h13BV9qtVCtmq/TkOiOqSjcikLw5gIajHROc23gJHSgOrB1CsoFzUFq7YRenGIW3JJf
	 VeDsKyE+9usoaBbsqYhrqw8M4z1PB+vRo9fwJIW6bSGTYFuuq7idOCFxv7s/Jb0ZhnVSu
	 iArgdsBkaLc5rkczDOGyn2NkAujFojirQJJruuFD1f5zbuJ4u3IpET2LVWQPSjlFQ9D8z
	 vzhluZpJFpCISpNKTXvLC+SVwokF9m10GS/WKt8+ErJ77L331UpEz7LaOWiSDs7prVamw
	 Q0KSxlBwttcS8kBeonC761vDVwXDLgGalRbmeFqRwWbPs7YITWFry1x7hFJBOwKnfLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dWP3egYI;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A28606A336
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A28606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=dWP3egYI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so59984715e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625949; x=1796230749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
        b=dWP3egYIgL1QXXr1K8Bvt4cDWI9NZCsa5Q+lYvP87NDD/6qM3z8KfBzhi6WrrB/mGS
         dAOejNCLQSYFIgZInCaS44AfuLz9dlE0M43Ex6spVIr7hvyKTDGRiE9dgGb1vHkWzMCm
         68/xRID5JmJwIwrRGHmDJFO5EYEXRF88GP4qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625949; x=1796230749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqgK6rZAwmHcuP0t36aSEI/mX270D8emMW7RBE++eSg=;
        b=YXAVy1dm+7K23dlnG33Cj2wlCs8wlCWLu5PmZoNpJQbfbQRnsPU8m++imukWrAeu6M
         MtyTxYXKDgO0oxWTfXsRjIlH1t3qeqPnyUc3ttvhzt3XXkojA+knyGuiBPAYqkY3qX0X
         2p6P8fyqu4GO9wiQiBhLSi6Pm/NMmUEOOJuPpR6UcGYLQjRW0e/jGUm0eNpK/3fjxRJ2
         YUU8Uv8cvJ6xKukSxXpCFUZjj8uCFO+W8tqw67UBdQIAT+SwzPw/76A4suzCkfeoaNxI
         tJVUapEHftwWgaUtupRoP2KozRxkAgzSk5cyKr/3fZ4SLIXRTp0/Lswmq9GpK53uLxB1
         9eNA==
X-Gm-Message-State: APuU4Z+w5j/yBHfQaSZ7w9+pGGdYZjNbWHph23QWZdIb6sxDuEmvTXvD
	leH7ihvS39hK89mFdf0ClqoGKjv5rE9qvPFISEmE+7uO2exDGnVCrIRpLcchgiyOuulZQ5s7t4j
	2v+bS
X-Gm-Gg: AZFdTZeU8/QKXwPTeaH25hLVIEMt5pBPvurKwOeQtHw16LdTsMjiIZ5NAeYkqIyILAf
	o6OjIL9dSJejIRnnSZy8d2nh9U9hiILiUnZ11fk2Ci7rEVKh3QRGjyZAdbMRxjJJrIX74tIagq0
	N8CsXPjNLVNwckwRcYvIXqPDlm0L/LHB/60G9HhdikAoXiDLH7a8NK9HGEwM5Ttaf+2gRwBmmt2
	rYRIxYfBCETNdfifbYfed9Nmc22GTBTCrz6zLfjHGAcCS9aKKb8MLlpzgtH5mWpKfSwCqhzgCos
	Kg0ujH/SZmYF3gYgT49u0IqOqYuqlEqhkNjxr17ZcfHMbeslqj62WI2d0MHvXBPfHMgiajinYD7
	TnpLtAHrBVohjUwq+pkmNfENBBv10D7+k88gk3dvitrxRUiVdCe+1lTPVdv13fGV7SqskrxL57Z
	xR62eOwBJw5cZJyyyMUeZ5dH4Oh9tG4Qf1roxkEs91XV7G/4PjwIAzWw5AHBSJM5gYG/nQzMG7d
	ZBjHZ+cxYtF0rDCmSPCgek8Lt8b6nrPNIZgRa2BiAPoB5xjjHsPOlHSAw2upXsDhruVclYOuEtq
	4B8waaqP14NI/WbCkMMC8urnSuYI7AF/iZzW5updnyifBaxW1Zcl4D7140hduRpP8DnBQVQ=
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id 5b1f17b1804b1-4bb88810991mr400065685e9.21.1795625949175;
        Wed, 25 Nov 2026 08:59:09 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/8] shared/att: Use the smaller L2CAP MTU as ATT MTU
Date: Wed, 25 Nov 2026 17:59:00 +0100
Message-ID: <20261125165906.1645581-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

