Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A843F54DB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921835; cv=none; b=S3qjRw79nyJxWTBu9rXll3BN2brM++Uu6uyH4vt0eUXDrJuYvDFNkFR9BA4GuKpnVHpSjo9o98GkQdDdtAwcjfFBrreND7qkGV3a4vb0FwFa7ilRAe3KaGS2pSi1/YF6i432Awpx5cHQqOdGEx72Ct5NX5+QcRUwPJIJ2rnpAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921835; c=relaxed/simple;
	bh=o8nU7hkaGKvsVT2u8xw/6fsy6H4KW4U0FVuzV4vAzHY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=WBPBJRHKnbOPSS5nHOXVM1TtMs9LPaV0kY+/2Uu4X0Oa5t+mD8R/67xRPmgPaNM7TBAjLJ/wUANjC6/gY3EI6EfYWNio6ENSeZYd7+l2/dJFAOEYQ//GnOk+FqnAu27KGLq+y3NW5DGWX/yepfDQlzl1klYN1TJlL2jtqudTxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=GF09RoLe; arc=none smtp.client-ip=79.135.106.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="GF09RoLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777921827; x=1778181027;
	bh=o8nU7hkaGKvsVT2u8xw/6fsy6H4KW4U0FVuzV4vAzHY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GF09RoLe63N9lsKeK3VDEP5lmVEVSH4T4UO5apNpaA4f00NQiW5dYHiEPS60IDQ3/
	 Th6ced9jBGQWZz1lkkgB10n7yjQwz/ikiv6mBRgigkH+f4TZW7lZSJSTfTP2QXoP2b
	 9aInucCs3lSlhvPJDKfVxYoTKf/HekDMzdHao7aK7o1zmTeEUTgWsAAllkekV3eTEX
	 9LyqITLE1JXUa4u0mWjwU724Fa5NVlZybGTJzcnK6FUobwghUj/Yq0wfS7m7DHlby2
	 8g/FAGpyrhjU+/Ns4zzJKQKw0/dteMsm5zbInQqF+Hfh0+/poClBRnEh/mDzO5LP/A
	 QGCt0TsB8Lb4g==
Date: Mon, 04 May 2026 19:10:18 +0000
To: linux-bluetooth@vger.kernel.org
From: Martin Brodeur <admin@fluentlogic.org>
Subject: [PATCH v3] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <6vsGD_2xyWDIrUZkN1idLdLKf9ChYJJOMyOm2FglmFna_5KyDCgLG6PIsHrMSN5YJv0hAN0APdkK0kZq_5k_qKP_wqILFVxMpmkhb58GyVU=@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: d25a0842ece8d54830f3b3c1706e9d4be2ebbe55
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>From 9eef1ada8e0ce68413c17223c673034365c641bd Mon Sep 17 00:00:00 2001
From: Martin Brodeur <admin@fluentlogic.org>
Date: Mon, 4 May 2026 13:34:09 -0400
Subject: [PATCH] sdp: fix overflow in sdp_extract_seqtype()

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1498f4 ("monitor: Add decoding support
for HIDS 1.1 flags and attributes").

Reported-by: Martin Brodeur <admin@fluentlogic.org>
---
 lib/bluetooth/sdp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0..3295fc0 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufs=
ize, uint8_t *dtdp, int *siz
 =09=09=09SDPERR("Unexpected end of packet");
 =09=09=09return 0;
 =09=09}
-=09=09*size =3D bt_get_be32(buf);
+=09=09{
+=09=09=09uint32_t val32 =3D bt_get_be32(buf);
+
+=09=09=09if (val32 > INT_MAX) {
+=09=09=09=09SDPERR("Sequence length overflow");
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09*size =3D (int) val32;
+=09=09}
 =09=09scanned +=3D sizeof(uint32_t);
 =09=09break;
 =09default:
--=20
2.39.5 (Apple Git-154)


