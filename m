Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E43DC4D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696558; cv=none; b=Bj38+1lOJjPZ3QUDGlr9OeIDTAERCApSTS+cr+mLllu9Cv/JrHLvspqbo0Iv1t+M301hu8bn8wuIe5MmrbK7JFLX+xXjQNQ3Y9Dx7NdKmK2k91N0/OU7fdToOqgUG/8Q9KypGnTFTi+Q22nec8kCLopB3aPkEd8o/1p5hxKTA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696558; c=relaxed/simple;
	bh=+VxFY7zsEvUuBflQhBlC5VAdTMtrSa8xzyhtAb44BU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj4Z8w2lvfaPFR8PnTySD5LDNHRB845F0xHfXZ0nxIY74CIDpuBVIx4/w0TUYNL5kCBWCts4qsyidjIa+4iKbeBLMldjsjVyBu8Y/hmdY9PUkEKEKhiE/8b4MwmGYiGCmuMq7GooSqIYLHyUIVUfsJKQmQL0a2YgxOuD/l53mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=wUT82xcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4vZB3yL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="wUT82xcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4vZB3yL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32942140055B;
	Tue, 29 Sep 2026 11:42:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 11:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790696555; x=1790782955; bh=uujL3305SFGF2QBMhu1S5
	KMeTIqR1AbsmSd5Dyz6Suw=; b=wUT82xcMETI55OwRKwInB1ZpOO7dwDJmAAfiN
	X35RyeFcuN1zvUmRP69DggMikbRCig+Vh6ZaTzNE7GvasM9J30owEy+lCAnpwEZU
	PuduShoAhHaKQDFoTFyFnEe1sEbM7EAljg7qkTHpaF/Vk4vD75gedvjmNMraTite
	tmLxYlJVgFyQ8g0nWZtGfLCO/1C7tZ8hj0WALLPBt2Vgp7uKeRSN5pm6zBpkFWdO
	uYqAkvgu8KlgvfobmgA6+z+U09j4VrG3ptyh2K839DkYw4y+WbxQzA522i5TnU9i
	060pri2Zgwz5QBOKH1rXlE1WrghMM11K2lNs0DEJ8D+XElMXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790696555; x=1790782955; bh=uujL3305SFGF2QBMhu1S5KMeTIqR1AbsmSd
	5Dyz6Suw=; b=o4vZB3yLjfWgjCftvPuVqPhglUTgwQmfYOCZ6i10CbRocnQKT09
	ChQqQ/tlME9YCAiEq5XFJfCNSkvldd77aML4HJmaJhE9nKbzXzPmPTYqssDj1Dsd
	Iz8VzHNW1qUePTtnt9FEnx/vohqt+AX3iy+aX4rsPX2omp6fbOsn7lUxie3NNwPA
	DDUjiMD423BJoADW7Uq/4q/QZzCpSDCl8zHuhZMpHsm4Ygcb7VfYsT8ya49RzrLH
	UEFx7TUFu2LaouD1n/QrusVkychdXVQlhBynJ92wqiJgs33sQFUsWIpxo5aZ+peD
	tvJPq5vbe9RJajZP5aGkiSNkcf98kdD3Plw==
X-ME-Sender: <xms:a9y7ave_P9q_l5KQBBnNQg5RrdnfA1Y0oBEKDYF9FgEqEhZ4hzMH9w>
    <xme:a9y7asqdIg_30q1VaQvDwJ3BWA7qalBqTCuzwFHMb2mrHRrin4hCUzNwFNn5ejOtI
    h7ZEKZg4Gy6E-jbPy-LF2hyC5T8BBHI-380pxwlqN8tUCZyyruLxt7Xzg>
X-ME-Received: <xmr:a9y7al6zNmKIjGYV19Dc-IkIT6GUPQ44U8iO3olPWfYKR6f8hgUKyDZg_XOgPLMBIA-y6-U>
X-ME-Proxy-Cause: dmFkZTEcqx1FRZQXC9xJ4NwtCsFSR2BPHudlvOl+vUhA1UxbgTzVih7p/1IrChwWHadGK3
    x/NQPvDXr+DoEoBnIA+V+5SREHhjvLn+mtkTklWUf0416nJ6iHuLfO1oDOAO2Td0lKigAE
    ffoRdkCWP6xKejQBv7IJEFmco84lGvjtUMAiMFf7ewjpV7zSwJaBiqA3WALFU2gzpdklyY
    jzJhSfTrism04xw5InZWfVFvtTpcScAG8MSUr7t0+a+dqh4VaZzyneyw7kdpYGKqthO78y
    SDWgzxsrsB6rZ7VMor0Ogp3QbuZkx5RcbwdwkNe9phiMCsjyvpQgw2YXQDG3nTcpvNBBY7
    PXxEyWADOoIrQ+jqvrbvtHCXf/xyheQXk2Zhj7y8IAvcB7Ej1WGQmh3YwjKiysBAyLw29U
    2FisbbYdED5Lnm88JhEOdljb+abB3WzpQOcEOXjc6C9A1u03LjVXN44HYOkrHo3iXDgdgi
    tJ46l2Jg3//6gHdS5gDL3Jb/tFcobM+WxcW7LJUmKwpSHNKrsnSNa2TtxA8h10vNYQYnKl
    e7//6dQKI6T2YTWYfhQdulFfz3RmgABKGI0GKaCN9ZqMhgITc/OQUVKXBh+5t2VmoBu8Cu
    7XF1Ih4ope15OVLDuKuCVIiP6l+kIYNjEzYf5pJ1ycXGyzjYwB/vuqwrRFbA
X-ME-Proxy: <xmx:a9y7aqpW470pYSWDQQXJ-BFirFQW1bUXN2mhZHoOWRcIgX9-qkmkZQ>
    <xmx:a9y7avgdwtS5E-qZduB-mnp2IASsGPIOBplIsg0x6INLRwYvT3zBwQ>
    <xmx:a9y7asITxbiLXrW4ZuKXoGb_8EIPBLbAOJw5sVo41ecK7PwqvaPt4A>
    <xmx:a9y7anC_VJwXlKLewzGaFG6EQrUQAG4H4aDj2lxNZ5Apqj4rAizUSg>
    <xmx:a9y7aoqoiZsYcxQuevgChuVPNZAAM04AmuGtmpPiNk34QH8neA8k3Zlr>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 11:42:34 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v2] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Tue, 29 Sep 2026 11:42:09 -0400
Message-ID: <20260929154219.2366060-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A peer can send configuration messages while an
incoming channel is in BT_CONNECT2, before the
security or deferred accept gate has completed. A
configuration response can then promote the channel
to BT_CONNECTED. Configuration responses can also
act on channels that are closing, and a late connection
response can move a disconnecting channel back to
BT_CONFIG.

Accept connection responses only while waiting in
BT_CONNECT. Answer configuration requests in
BT_CONNECT2, but defer our own request until
BT_CONFIG so configuration cannot complete before
the gate. Ignore configuration responses outside
BT_CONFIG and BT_CONNECTED, and only complete
configuration in BT_CONFIG.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
v2:
	- resolve the patch conflict
v1: https://lore.kernel.org/linux-bluetooth/20260928173324.1837653-1-oss@fourdim.xyz/T/#t

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804908..cb4ec42f99e3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4438,6 +4438,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4467,6 +4471,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4604,7 +4609,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
+	/* A channel in BT_CONNECT2 has not passed security or userspace
+	 * accept yet. Answer the peer's request, but hold our own until
+	 * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites send
+	 * it. Connected channels may also need to reconfigure.
+	 */
+	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
+	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
@@ -4657,6 +4668,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4724,6 +4739,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
-- 
2.55.0

