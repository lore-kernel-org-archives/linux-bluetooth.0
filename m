Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348553ED01
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905878; cv=none; b=Vkx//gZvWtkF7mHLFJx7KIrlIr1mTM+CJLyq2MOspKVLgEvOcGWTV+SfDvUmhUbZ/K18Qc0/Xl2aTGApdtbpxPubDyTpJsyAuc7vX8u6n45WQm/oLIg8hUcB4tqK7BzY+MFPp6hGU6v2IZIUa42tnTme5VrvlfWNy5nk6nSDBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905878; c=relaxed/simple;
	bh=0b6CR/9pP2JgFTG5+DpFLx3A79cuvHQK2zjgLUYo+RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPCDggJ9M/utbTYcp536BoV3eQWb46R2H+WDXuZrvs09HaLlc8NounftfdUGj+v/udWtojZL4+2EAtyIjQhDQsH3rdBoWlm3eVRcNMAVt8dad9sdTfTvRnWZ//2RYlb7SXIIP9FHelcusKej+GtowFWym9bLSY7lvP2wy+gxufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=aXLJ0fub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5heqRNP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="aXLJ0fub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5heqRNP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85D427A00DF
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 11:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791905876; x=
	1791992276; bh=2b3Qs35nZ7OXi1LB8Tk6ZOLs/9eQpCuwRKwmmKONLEk=; b=a
	XLJ0fub0l0TvW/O36nZNyy0POzDvkYJ1xV6lYSsy3o8d2NTimIgixDsx6dRTlMLg
	tN0vt7+XHaQXy22IafENWXZjI54CbNuBKSAELpImXmz8xNzEDB6H5htpdUVSU21J
	EW9KKm3pKOhJrDHPI+YdtJfVuc14pnM5OQtZ/gU9XbNOPa/LD9HeT3fq7BDubvLf
	3Hcn+FY54NYtUZPb/D2FvNVveThOdLAfK9TLsieNl+1n/9B1Rx4wN00UBVHh9/2+
	9h+4GOv2JIWjiXW4w0yAHA1xdbC2uxT8AB2pBfXq7Z6RbCKeJ3fPS+XRWR+5Y1Xv
	QEqpkG2+dr/+i68WCVkng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791905876; x=1791992276; bh=2
	b3Qs35nZ7OXi1LB8Tk6ZOLs/9eQpCuwRKwmmKONLEk=; b=F5heqRNPo1yt9PbNo
	iOzh+dx9fRgrHOQ2Q+iVvrl0gOoz/OgJylnLbs9IzdBpxTx/6oGEVlplSreNm+QF
	VdHATwVcgQr1EstQPHt1wYZX++Rw5EprIubJGJoIqx0pimAEKY0dOB5mXKMORORm
	38ji9TPdNrK1t+KcL8GBBkgRy+YAYb7U6toLyTEsRDhBW04M6LOqkbY048yK46MY
	MV2up8H71Pzsx5qv0f6oAg9dSlKA9UTLaP3/kiqOgFNslTliUpQAMu471Ra5R30v
	cW+g5+Bk3XEAoeOH2JY277n3krY/pc0UgcTIa1NdH3G9nJ8VVn/3x4w1qmQ/++A7
	XDdPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905876; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:bk5E8emdEHu4xyRHpEZOC5SbJybp1RRJEB0Io41B/XAGZo2
	vpp2I4y4Mx/re39hwHSHQgfs3i9q8/uCKCtXgqqjCyoVrAeucoVSWOsX5TIEQBPq
	ZzQjiuG8+ch3AqQ5DGWCLwx5zUFHWXweBuViCs9OUwWEsJJ80RPJ9wOZdE6WSG/V
	G6dOX/Pdbdi+YwPqZMt3u8KggAzgYt6SGlcS8j7vslbHK7z+WLJ4jM1UF9tyIKfv
	ohvZSSRT3pGX86cOfA8krv+40oJmx73vev7gpzMobTWnmjr+gy1wQ5mDxz6mGnHL
	WM3ewTRRy/SwCVwIG0pyCdUfdJuJKyGqiQ2Y3/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ti32GFm72A2NGudSTamYSg/MkMkQcanq3GsXfachYWc=:0b6CR/9pP2JgFTG5+DpFLx3A79cuvHQK2zjgLUYo+RM=;
X-ME-Sender: <xms:VFDOavAoldrdEyJRg4uEmjm3JfztIVwkpCWkEUPql4l76benI--Udw>
    <xme:VFDOas8FXKOE8RiHbKnEpqI9iTfWmDojqPOxj_fHvFFOvy0z6VWzEUQGgxxbryA9e
    I-7S6oKpdUSp5HprSkhJpAwz9v5TgMfnl9fUGr68_xzeOTeEFELWc7L>
X-ME-Received: <xmr:VFDOan97uEz5ykgeKZrHq1M_G4J8D2o7g-HvNTtyRDDeNngoW4SqtekltuKDMsO6_C2SKew>
X-ME-Proxy-Cause: dmFkZTFAzw03AYneNMhCB5vi4aEzVLTyAS7nwuX9DSJclN4i9HCKSgJppltekwFHgknlKN
    ixwLVIDHqDDMx1dDgjCBjVoEofRI9lytPXMGhNgMsQeO/NUBohO5B9gP9PCtFm9Zo/5tO5
    zpN40JaIE1krMEGAqbWMoyd8NsEUcWQ1AHvUAf8A3BM/1CSqoMKMbYmDuFxIeR4cKX9wFb
    NGkiPG8BLLLZst14Jt3MQ+DWoBKNr9jUSZ994rr3Cscgm0XuPwIMXvaaARWlhSfrXNX8Sq
    Olm2XLJH++XK2fv27idsC8EpchRtcTdmol3irKFrbJvBgOMnJ622lN6d3Ohd+HA00mO5I7
    C3Jo5ma+yRPsii5UUhDgGimWge71bOt2itjwIVTDDUVilx1B0IcvV9grPrw82tBVNFIifz
    WNvjU+2fGpm9qYL2nj/FQ3mk+oRb+87lb/Ai9ImCm1jbgHCOHr8WZxVXWQVHV2L9Km0OAa
    UPUUSmNE/+x/VAOkuEh+7F9rEpMbLA7bPQtqD5Z/UDr28llmmnxZxsxQuqesYTc+MmgeMr
    tFYLcWUyrgl5s8DwkPEEeQ2AWF9fcbMcQ6hfr8SQeMCG42ZKQ4+JWFkSIIiJmtuSUIFMHI
    nbT0XJD+//eGaPVrmZ7Hm0mhBKMQeUrvHr85pBHGObj6vojgWSKms2hTw6Xg
X-ME-Proxy: <xmx:VFDOarcyX00S-TvbuR2ovXN_hWmoAwTQHxmdj-O9yA8hxFG5BFy_dQ>
    <xmx:VFDOaoF9LlYQ9Qv_fIrj4g4Rtt1ki8W2S1i2rHMrByZ8oPJuAB6jlQ>
    <xmx:VFDOahfXChLi5kXsNPsk6SS_Sziztmcmgqw7M6qNgY7R6fpkC8H2bQ>
    <xmx:VFDOaqFI4xRw31AC0CExezYIDriPaXS3l_f0U2mpSzpJ5aoor8Sv8A>
    <xmx:VFDOas9obtlnEQ54L9DztR-4cjnJL1uXAI3xHCrJlHafu87EvLfLR13q>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:55 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 6/6] Bluetooth: L2CAP: Remove dead configuration state code
Date: Tue, 13 Oct 2026 11:36:38 -0400
Message-ID: <20261013153720.2635387-6-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013153720.2635387-1-oss@fourdim.xyz>
References: <20261013153720.2635387-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONF_EWS_RECV has not been set since commit
e7b02296fb40 ("Bluetooth: Remove BT_HS"), which
made configuration requests with an EWS option
be refused. Remove the flag and the branch in
l2cap_parse_conf_req() that tests it.

A pending connection response no longer needs to
set CONF_CONNECT_PEND, as connection responses are
only accepted while it is already set.

No functional change.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/l2cap.h | 1 -
 net/bluetooth/l2cap_core.c    | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index efb9b7f422d1..54eddcdd341f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -725,7 +725,6 @@ enum {
 	CONF_CONNECT_PEND,
 	CONF_RECV_NO_FCS,
 	CONF_STATE2_DEVICE,
-	CONF_EWS_RECV,
 	CONF_LOC_CONF_PEND,
 	CONF_REM_CONF_PEND,
 	CONF_NOT_COMPLETE,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 210d1507af7e..4dd56e0074fd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3769,11 +3769,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 				rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
 				remote_efs = 0;
 			} else {
-				if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
-					chan->remote_tx_win = rfc.txwin_size;
-				else
-					rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
-
+				chan->remote_tx_win = rfc.txwin_size;
 				chan->remote_max_tx = rfc.max_transmit;
 				chan->remote_mps = size;
 			}
@@ -4512,7 +4508,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CR_PEND:
-		set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+		/* Our request is still outstanding */
 		break;
 
 	default:
-- 
2.55.0

