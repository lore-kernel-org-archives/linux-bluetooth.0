Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6973328FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469059; cv=none; b=mgcFERa5dcYhzoaZ77gXCtpuTz14yI7U76JBWDqniJRZVbmadTmVBcM8dzYSNgwBRBTCmJZ+QryMLevuj0BtiluJvvKChTPTVQP0JGiJ8TTeudowyCdJb5vhZQZUhlmCzV0EqGpuT/t8capFNyfg/72dml3ydsJ2kTjRI4NrZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469059; c=relaxed/simple;
	bh=rz+W2qWJAfAIWcKPZy9Q9ZEQ6tfB1EPzY+y2C9ewF4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKlp9c6Ma4yVEhx2C1KIh8nzdaXlTP4KocSDJ5OkXk0fLwPnCFFEqBccRNvgvVMjW5WqJkRQ6agaofU5egBqkehvog/z7XYdK6yZR6E+m7veI18wwSTusKll8hzqsHoRcPqJT21Vy3TaP89bOuNJlRkwXPnUmPi5151C4OunT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=ky/w3nNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOCbkAfE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="ky/w3nNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOCbkAfE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 33BDB1D000B5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 10:17:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 08 Oct 2026 10:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791469056; x=1791555456; bh=7s1NMy4MN7MdTqNfUXuv5
	JXwf/6IrBCQeGvi8CTDpDU=; b=ky/w3nNyf2DZwRKKyTI6pg+z5jTRgqlnwq76H
	G3nU7xYcMsVhdj343wUEC3shzmqZ8t+PFhRuPS+nuiMuNvHu08gfuVYGokirh3wg
	PlbS/geStXzIyEPSDVKVz7MW8gT85/VTv8aHwheQDK+I/LXZHY2UoD1FGJFC4oIf
	LHf+SIvEqj0hRL9zuOPfDITFMNYFx+kTksx4jT3M7Sg6L7+S9ooKBngaMTKroXbW
	vEBvBqY9vN9dz90eAdbXaK/1BGkjiWnDbBkXLGKrTPO8gtsV0TZCOwMmTmpCB8YV
	pLAQVwGvr9Khn+5nDU0r/AZkPBzO3EjNN/FZ+yN7xxHMP61fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791469056; x=1791555456; bh=7s1NMy4MN7MdTqNfUXuv5JXwf/6IrBCQeGv
	i8CTDpDU=; b=sOCbkAfEeCGVAPh1Adaqu4y6cDI+UTFnUfI+xSZ53O6Td2YzyIV
	K60CURHnBefPrmnxr8vAtbu4My7XxLMDG5o06n/Sj+vcFzw1cycYq193TFep/gUX
	SIbxBov7n6VNv3CI14s/DvIHmU9K9t5Y7j7M3ZCaUuyIw9lyhW9Ya/r/TBZCjye/
	SajMrEv8fc0cjSG8iWX7LNwTWvUgcnOpnOIV2QWaX+qd/lcLMuSrT4AwJX5dvn/a
	5BtF9dZpVLxjy7BvP6f779qVhoSNYgObSpujeCAnRMCL/8U6V1O2AMsv8pXvNnBx
	x7dtAjY+H7a4n2b5vXYh0J+TjBR1og0L2Nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791469056; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AzyZhlQ+w9+IxK5btFpDL76y2GFpnpgDBuRfSjxTbGlqnm5
	g7ub6FM++/B7kOpYCBlPNzvHYgiiCpCLNuzpxoxFM0X5O+y8Xc7/Ml9wbDAlvJ6B
	6aTe/ACLdif6nuMGznVvZiz3XKv/Kj0tbXyVFp5DsmVmg3RNyIGvFY/92zQARxms
	1THWd6eeWAtupupUqLP4dGXIB/qDRES1GhtAeMtRuTfYTrOT2+6Term8u+u2wtxp
	0IsEafQgjBJHNpYFhes++jc1MTmeO217/A2phDOVTL8h68diz53pbXsS8GSppaN0
	aOfkuNhXrkLCM0CX/lYAtHkUXpLDAlD7Nz6Ep2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:vZV6um0VQKQLLkrE8TNHJVAVk3eu71N5tgQtw9PsAjM=:rz+W2qWJAfAIWcKPZy9Q9ZEQ6tfB1EPzY+y2C9ewF4E=;
X-ME-Sender: <xms:AKbHane0ohyec5HkSPFN6_gY_O8CSEnWMEocHrY6M7EPy_xxb2VKDA>
    <xme:AKbHakq476BZbyxxob3m30r4X913DsPoj0tLX9Uc40YfYOusENtaqq3ze1tqXYcOV
    I0vxwl5OKiI0vZJt1JcqBwJyLzthadhCghYXI5MyK4-9rUcjqbkL4Fz>
X-ME-Received: <xmr:AKbHat77WSpni8A6dDzcaU_ghpMGu4iHYROB6jXhjiD_IiPmxhffXiKRpO4iRWe2Yu4uOho>
X-ME-Proxy-Cause: dmFkZTGZ5nuwXcoaGxNAKXkzKvd/xk+Kv7JedPGk1syAZV7xXzfE+gElmkPQhfPOj8ZrSS
    WTnFuJ9w+tGOtAGhTYq44u/q5/qp9NFEbpyrgoObaQEDZCDJR5WL7+e8B7ukWryL88aWIH
    gZy7J3ExN8gntngyyxTzR4QaRdIq20Yb2FEgtjxUnJjzVmd76ylY0MNfKIP53jj4MYVrXF
    y/iDZVsKIRfzcsnSG0ovr/zB2Smud25Tcbh7w2pJJ2jfPuc1mdMArX2aQ7zVPWesoBhAwi
    cRHqbT3mXCioRVS9lsFSNV/iTgjWyxNHOtiJDJTKgMFKkIkcEBq5KGqowpJ/M91yOx1rUP
    UJly8SbWE+L1k4jRIwK0TYs/SEMslkXuxpJyPm8mAg0YIVlyOHs8q5fDpeNbcK0AMoYiKU
    qLnYQVhq/vqsQ/IwNF0ET9DteanUdB3Bw9JZRdeaTYPVocJ8NRi/lsJpfgLkpMidb9d6xf
    DHWbJBonqR+MW9B0Y8qD43CddRZjMOejOfN5AL8Qp4F8sFmFKEpZWaLmW9dR4h0fSn9uQv
    /Wk4WT2s9UK7iFkOpY95duydWndXh0xuJ+boSJ0bzCX3EXoD9FV+ZPzw11NwRrwchOiapf
    x0TeQE6dctzrl3NC13qQSj/VJGwPNizxOKm+piTzyjpvswRNjIZqbXS/C9cw
X-ME-Proxy: <xmx:AKbHaio1DH4gwnK90TOPo2nunX03egyDI5MnwD1M5oiJ1ft99ab5xA>
    <xmx:AKbHanjaD3y1ESiQog2cfn9-2VlAL4dmR0CIccmlqV3iWfzGrbdVoQ>
    <xmx:AKbHakJWOZJjOqTB9-ENZhba0I5Ot7d4NExhj8xhlSrYOJ3NK33M5A>
    <xmx:AKbHavAPlPRKrQcmHENufhUEyOZYpJKIiJankuqdaF1eGXVbjsLMQQ>
    <xmx:AKbHagrjUNzBwwmp8KQANx3Py7msYQmmj1RL1MobBKGI3qCs3rw2Wle9>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 10:17:36 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v1] Bluetooth: L2CAP: Reject mode changes on connected channels
Date: Thu,  8 Oct 2026 10:17:07 -0400
Message-ID: <20261008141714.95709-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing mode changes on already-connected channel will
skip necessary initialization on the new mode, resulting
NULL ptr dereference.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20261007144717.3832330-1-oss%40fourdim.xyz
Fixes: f2fcfcd67025 ("Bluetooth: Add configuration support for ERTM and Streaming mode")
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
Please apply https://lore.kernel.org/linux-bluetooth/20261007144717.3832330-1-oss@fourdim.xyz/
as well, thank you.

 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cb4ec42f99e3..2cb3f59112f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3876,7 +3876,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 		}
 	}
 
-	if (chan->mode == L2CAP_MODE_BASIC && chan->mode != rfc.mode)
+	if ((chan->mode == L2CAP_MODE_BASIC || chan->state == BT_CONNECTED) &&
+	    chan->mode != rfc.mode)
 		return -ECONNREFUSED;
 
 	chan->mode = rfc.mode;
-- 
2.55.0

