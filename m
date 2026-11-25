Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641134;
	b=uv6wPzA6FXAyQ1vKLLbuFGTUqU6PIVGOkpqW9FVdkGhVPtJXWfM+mL+Ae4VM6Ldh8M6n
	 QVyPqoiXwzYpODZ1W/hJ420SGAk3A1ilwAK0igxvlKCYIERbCT/z6idxocv3aPJORtsEl
	 ymWINM96xXNpUP7hM98oU7fHPFX3lM54JFP86lbC74FuCJepLioev2/mVuh+SZMugagHx
	 Jq1UsJ85sav2lfl4MV72tK9EgNpQWABCEHxoaDPg6zXnDJ0GbuT4l4/s/ueEK15bnbz2o
	 nAWQuWVoL3IhC0VgcOTBy5ScfFecskwaZ/N5t45YMN56HAhpThanOPBWIGuwkdXuW9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HFT2GrIUj2PVu8/dnyxLeG0EZJb2m2iVRvdl+sDB3Ko=;
	b=YsLP8u2MtKqw2SGq/NIjEzsqt+NBV9kMXPsOnuk43psj1K9leQpKXpX46p0iznWt4XvZ
	 NBfMLbya28pXw1mL2LUf3E4fA/mJu2g5iqXO8QNSJvp3dRcKl4zPVQjvoruq5s7rvb183
	 s3kCrJSqfMhjtH8kE+vL7QDE/G7Kj0dSdol2j9YOW+uBAvatv+5EaUboVcoF+U7xem+Sc
	 +sAq4gdJ9qlI798ZNNreuPCVKu08lkz1TdzbbhYSk3oA6OVHcxH1CURLF5Vle1xjv37ia
	 Md7Ju47XeI360DZ2O73JqM6hsS4QwCzTgkJnx0ZxujkFLJiSbTyUFelXfimWoYsoSFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G284N+MA;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AB606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789AB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G284N+MA
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eae1276409so2282635e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641133; x=1796245933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HFT2GrIUj2PVu8/dnyxLeG0EZJb2m2iVRvdl+sDB3Ko=;
        b=G284N+MATbpU27h/ziIfIVIx+Q/VrxmjZ7mp7Kto8Mq76WJahxDWSgcTCnPLkiqqdh
         btRG/1T1BEprKgFmmYaj2RnbanQKgr3ioxbSPwwu6dtGz8wuTA2z0mj1o9ja40Ojfj7T
         4EwaTmkIutpDO9T3jS2BXS3zGtQyByMj4o6NOgGG3L/Ml2sQmVQ9t6DbVjKwOQWcfeaB
         XQTt3CChx/+IsGjhMjcMRI8g1bf9snHidCRnNpEPz8QuZoDcY6qQFxWZv7aMoGBl2Tzp
         +BqA1s3ZmqeiaSnNdkG0NxbUJ5zwIhJCDprGuo2bKpn6dGWuriboVJiELEwysdyyHc4h
         6Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641133; x=1796245933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HFT2GrIUj2PVu8/dnyxLeG0EZJb2m2iVRvdl+sDB3Ko=;
        b=Uv9rSll6tGHpiPls/GGEw4+mMUCWZdKIxLrB18sHChnxriOdMtqepw68f7pZsmLqft
         izMrL9MSn6nRwZLpexoP5i400RCStcEmXjumcJZILP815WIYSUQHln+mNqhKaeI+eAFr
         Qb1EsDR1DZgFgJNouY2iEEnS1QFz6BtOdJG7HHGVRt+pzPVYcfJwz+Mz9wEu5W1Yjnhi
         rJQd2uSjpR/+D7b/IJL/6cfKsYC+yWYfpWnwwa/qyd/fef228MkzCoBqEm8f9kN7yIrq
         Aa3NYtwNAuqsJ3F2utyaBPjn9MTN/KjUfsuZtTupRkHFvVd1OiE/gaSDefxnwwkGURUm
         Hj7w==
X-Gm-Message-State: APuU4Z88JO3Kx5Pbwuw18LBcv+FS9N1xaRasDtLHCu8lTMXQGTtyCWpP
	FYlmxEZ1yoakQuEhRs7C6TodFGSULzCQq7cMryVJGQqHEXCpNoCxR3hGNg0Idg==
X-Gm-Gg: AZFdTZfFLW4xjqDbW3bB2lHbJLW2tluXnFESQjVc/PG2gL7SAMU73at3PSc5SIK7Lpe
	QjGTxw79c1a9WgRfrlq7JW5QA8YG7MIVYp/MXVzxLUFSsbHepaNIlYCIRByhFMXqeJH2eNpeBFk
	ZvjfU53pv09G23w5K+5Xb8f/tlmxXJSkHy+jFZY9oxqwvURwQt7beP52EbARiFaY1oE7cMVlyp/
	Sf7uTLhT1UAJUmcmLXFuwID5uCLvJjGda71FffrO4OHydURf1k0j8UIYF9+RD3UxsFofJ5KOHRH
	HTadLKMGhiq2tj1di28wuD/8i93JPSohG2GmYE3GyrnkIr/JZOnl+uBfItWIF5IFr9dc1lJidw6
	m/ep3437AOH3GN9bqsa+vtdA4hCZCQzGct7y0Ww35205ohUlrZQdwKyotoXEIxGg3S/xuGVWhLO
	nRqwufp+jw4Kn2i9GWWM73JsgPGIHSwz9xmnuNedmbp1ty2h1OckAUoKzqFU/eb8sBb3fMOQVuO
	iDB0SDSUgiA9JABxsVZ6ca7jZlZWJ5Q+508B1AoIJ3WPcFtJZMYjiWpsM4ikGGiKQIc+oOkhUyg
	yDCAEBC8WiLuLmkdUBITzPsBdoB/jmByyPU2j5mdHY9PMJZoweSc1Edld/CrTfaDzRJiMNyP3mA
	RoRxbCbPvz6HkMZJLdIMxVGGExOTXO0rT9bX8hrhUGCP+Q3GPNe5SoRIsWjZ5Gz1vAHXwO2Ikwk
	6LZCw=
X-Received: by 2002:a05:6122:9003:b0:5ee:b4a:681f with SMTP id 71dfb90a1353d-5ee8af6c710mr10479399e0c.20.1795641133440;
        Wed, 25 Nov 2026 13:12:13 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm18316369e0c.4.2026.11.25.13.12.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 1/4] Bluetooth: L2CAP: Fix rejecting all Enhanced Credit channels if one is refused
Date: Wed, 25 Nov 2026 16:12:07 -0500
Message-ID: <20261125211210.1955598-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211210.1955598-1-luiz.dentz@gmail.com>
References: <20261125211210.1955598-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_ecred_rsp_defer() responds to a request that has some of its
channels refused with a rejection for all of them, deleting the channels
that userspace has already accepted as well, e.g. when the listener
limits the number of channels, like bluetoothd does for EATT.

A L2CAP_CREDIT_BASED_CONNECTION_RSP can accept only some of the
channels of the request: the destination CID of the ones refused is set
to 0x0000 and the result tells that only some of the connections were
refused.

Fix this by responding with L2CAP_CR_LE_NO_MEM if only some of the
channels were refused, with the destination CID of the ones accepted and
none for the refused ones, and by deleting only the refused ones. If all
of them are refused the response is unchanged.

Fixes: 9aa9d9473f15 ("Bluetooth: L2CAP: Fix responding with wrong PDU type")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 67 +++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86740..a15ffcdd1330 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4065,6 +4065,34 @@ static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
 	}
 }
 
+struct l2cap_ecred_defer_count {
+	int pending;
+	int accepted;
+	int refused;
+};
+
+static void l2cap_ecred_list_count(struct l2cap_chan *chan, void *data)
+{
+	struct l2cap_ecred_defer_count *count = data;
+
+	if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	switch (chan->state) {
+	case BT_CONNECT2:
+		/* Still pending accept */
+		count->pending++;
+		return;
+	case BT_CONNECTED:
+		count->accepted++;
+		return;
+	default:
+		/* If not connected or pending accept it has been refused */
+		count->refused++;
+		return;
+	}
+}
+
 struct l2cap_ecred_rsp_data {
 	struct l2cap_chan *locked_chan;
 	struct {
@@ -4072,6 +4100,7 @@ struct l2cap_ecred_rsp_data {
 		__le16 scid[L2CAP_ECRED_MAX_CID];
 	} __packed pdu;
 	int count;
+	bool partial;
 };
 
 /* Lock @chan if it is not @locked_chan, and has same or lower nesting level.
@@ -4141,14 +4170,23 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	chan->ident = 0;
 
 	/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest */
-	if (WARN_ON_ONCE(rsp->count >= ARRAY_SIZE(rsp->pdu.scid)))
+	if (WARN_ON_ONCE(rsp->count >= ARRAY_SIZE(rsp->pdu.scid))) {
 		rsp->pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_NO_MEM);
+		l2cap_chan_del(chan, ECONNRESET);
+		goto done;
+	}
 
-	/* Include all channels pending with the same ident */
-	if (!rsp->pdu.rsp.result)
+	/* Include all channels pending with the same ident, the ones refused
+	 * have no destination CID if only some of them were.
+	 */
+	if (chan->state == BT_CONNECTED) {
 		rsp_flex->dcid[rsp->count++] = cpu_to_le16(chan->scid);
-	else
+	} else {
+		if (rsp->partial)
+			rsp_flex->dcid[rsp->count++] = 0;
+
 		l2cap_chan_del(chan, ECONNRESET);
+	}
 
 done:
 	if (locked)
@@ -4161,8 +4199,8 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_ecred_rsp_data data;
+	struct l2cap_ecred_defer_count count = {};
 	u16 id = chan->ident;
-	int result = 0;
 
 	if (!id)
 		return;
@@ -4181,13 +4219,24 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 	data.pdu.rsp.result  = cpu_to_le16(L2CAP_CR_LE_SUCCESS);
 
 	/* Verify that all channels are ready */
-	__l2cap_chan_list_id(conn, id, l2cap_ecred_list_defer, &result);
+	__l2cap_chan_list_id(conn, id, l2cap_ecred_list_count, &count);
 
-	if (result > 0)
+	if (count.pending)
 		return;
 
-	if (result < 0)
-		data.pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION);
+	/* Only some of the channels may have been refused, e.g. if the
+	 * listener limits the number of channels, in which case the others
+	 * are accepted.
+	 */
+	if (count.refused) {
+		if (count.accepted) {
+			data.pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_NO_MEM);
+			data.partial = true;
+		} else {
+			data.pdu.rsp.result =
+				cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION);
+		}
+	}
 
 	/* Build response */
 	__l2cap_chan_list_id(conn, id, l2cap_ecred_rsp_defer, &data);
-- 
2.56.0

