Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699523182D
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910494; cv=none; b=HcKlgY2oVQQ0RHgCFlhu2OrmGxnTRd2q1WFXAgJJTdxzE98asLC0p20b4nRcgeEzFawIW2uSfZxGrX8myitltg8GeFXVwQXYahtlBHu2fVHNn+fAVBwCBi5eGgJFG+9R1y2z0Xq+a4N18/mMcIZaDLjhTKep+vRPOP0kx8NfIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910494; c=relaxed/simple;
	bh=Y2/lrXxffcc3aGO8vvw8p2nizD/0viouWIGtW6A3/Jc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pA6BiiJ9uxMQN8/FSDUEq7p8U8OkNnKwRQD1ukRMMwzR/NsNhuHtuVe+jYVLaNVgg0rL/F1zqkeaWBQ79bO1xtr4ySOKnXpBpqTmuZjFJOjXYSv9moie1VRGmUt0JldjFAHbH2+OADie2VLNRe7sCpDLnmDOVPkH6RapZNelZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=k/uu12B5; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="k/uu12B5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777910489; x=1778169689;
	bh=Y2/lrXxffcc3aGO8vvw8p2nizD/0viouWIGtW6A3/Jc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=k/uu12B5a4Dm8wYwsppiPXZfYtaUmf7Ouc2ASFiijSrOIQ+WwGEeBf38k+cqBcFv+
	 rV3bgzshDb+PaUA/DQvRpad20kDO2P1F30eiil2J+zdMr5R16k4ycjhXXyygC7FBoz
	 Nk3PNnc7cuLhWpXDzldfDlFmNom4DVSzXQh4r5kMrFZLhy/V9TLOn56ISqo5rRu15r
	 0CRCI7NNzLcwokvpFAMwH0WGr0k+TC1gVpm39vq8+PgVCMwg2wLJIZIWWlga7cY6wk
	 /zUIqt13uZEkNnf7qC2NvF7saObpRfhY+r2Og960Hy5PCZ4KcFypWXD1r2M01mDACB
	 /m8FQ55cutFbw==
Date: Mon, 04 May 2026 16:01:24 +0000
To: linux-bluetooth@vger.kernel.org
From: Martin Brodeur <admin@fluentlogic.org>
Cc: Martin Brodeur <admin@fluentlogic.org>
Subject: [PATCH BlueZ] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <20260504160118.26675-1-admin@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 9e00920323429b5c9759fce5f7eab372fa1d02f2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1.

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


