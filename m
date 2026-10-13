Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD16418A46
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862302; cv=none; b=UVBULoHZ4LgjAS0TEd4d32UmTE52XDgCoK1ZojcSwDcT60LxGfIg8RKkJX+cXgWyOuLU10WFmUn70suZkGXDYuMcyj8OIJBXtoE7BljTew3RVNauiKvC6dxn495LGemIidVoovLvX0svQMBAAHbWz4KU3LE3Mtwt1LD2oFLBMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862302; c=relaxed/simple;
	bh=V9rJqv7hUU1JgZ/pRuiuMmTNntLvY7jN6ZhKiY35cX8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Wigxcf65OIAHRundZ4WagiJxTVPXA/p5yJbbulbB1O95PNRKedRotcWSWpQ39SnXitwLbsWcS9vRr/HoHNTq9igIgWY4qbdxxca179bn067gpggVb32PdosciIv/V03Fq10IuvDY5qlhvpTHZKbMdvRXGNLTN5ZqBA0/sTmI/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dVVY3dkm; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dVVY3dkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791862298; x=1792121498;
	bh=V9rJqv7hUU1JgZ/pRuiuMmTNntLvY7jN6ZhKiY35cX8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dVVY3dkmGMLfOU1dFTYWTso0b7bC2dQa4+1GRWS7YclaP0Zl9FzT5Wz+pVFE8Wci6
	 VMaxdUMkt1prpilsaNZARhYgtCdC1fzfddGyexn/q1oYpWwiKAgMhTp5NOuieLhC0e
	 ZvQ3Bp06xG/IGyNx0c12Ta8bzVvzlYySAoxDRmCXhr597w4u6ZLFNwz/H8jqiAS30n
	 nZ2hgCtlY1HrL9nihQA8yqrSso659w1mwnKYW7BB4oZ23N9T0YCnTV2XuJVkx0+D/5
	 XhM6K7DYbD7wb8knUwLyJ6TZlkZ1AMhm9B1ICb+79hI/2/nyjsWAczhMLHdlIa2qJq
	 6ysWLFy4y/ZMg==
Date: Tue, 13 Oct 2026 03:31:34 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Bluetooth: l2cap: honor local LE connection interval range
Message-ID: <20261013033118.501182-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: e63ffc2cffa8789562b0c5bc2d9b42c897eea017
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Intersect a valid peer request with the locally configured interval
range. Reject disjoint ranges and preserve validation of the original
request before applying local policy.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Submission review notes (not part of the commit message):
October 12 no-intersection trial accepts [16,24] and completes 30 ms
with STATUS 03 02 18 and normal host TX; the user hears silence. Volume
and multi-day acoustic comparison controls are incomplete. The working
intersection yields 20 ms. Maximum-only rejection failed in kernel 5
and is not this proposal. Generic minimum/range policy and LL-path
consistency remain RFC questions, not established by one renderer.

 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804..49e201d3e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4968,6 +4968,13 @@ static inline int l2cap_conn_param_update_req(struct=
 l2cap_conn *conn,
 =09memset(&rsp, 0, sizeof(rsp));
=20
 =09err =3D hci_check_conn_params(min, max, latency, to_multiplier);
+=09if (!err) {
+=09=09/* Apply local policy only after validating the peer's request. */
+=09=09min =3D max_t(u16, min, hcon->le_conn_min_interval);
+=09=09max =3D min_t(u16, max, hcon->le_conn_max_interval);
+=09=09err =3D hci_check_conn_params(min, max, latency, to_multiplier);
+=09}
+
 =09if (err)
 =09=09rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 =09else

base-commit: 964430c038967fd06643e866f68115664e1a1bd1

