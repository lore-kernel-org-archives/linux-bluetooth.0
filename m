Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444144AB6B
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762995; cv=none; b=GOqCv9GQ5489EisjrhEKLtV9SKE2hlq1136BOaZ6RVGa1lhHgr3Jsdy6tFDaTbyAu9yMXP2ucoH8v0u5l9rtZF9i2qtWhfSaKgU+QriCZWYpkBPRy3REK7RKHgAHx9MnvtrdpBfN2O8UMYoEShFmXRbNx6+ijinCswItddoHCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762995; c=relaxed/simple;
	bh=iW36Lz1m7JhGxd50TOlPXz36kiQO/hb4Gka7rJWhLH0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZYVxIdg8LieNImQIslcEVkxfwHxVg+K46s2BUz/3/ZALew827tW4Hpp1wfrmrOTJzrCn0mt9UEqr6Lxjr/XWVd4Evc0JcIovkrZlExI3RBb77flCeGePUSYjl7CkL4T0tzTCL3edRgccOUdf0h15fCZshsNnmI/82GEyg0jbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LEnuiowm; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LEnuiowm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rknkw4o7yvaklfjnoh5dzfnozq.protonmail; t=1789762982; x=1790022182;
	bh=iW36Lz1m7JhGxd50TOlPXz36kiQO/hb4Gka7rJWhLH0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LEnuiowmUzIb1JdB+sppvzuIZ+zLonlADXlxrSErtLJ46IgZ/HXJg/yBoVk7BzSIn
	 1Y7v6Bc+bPHWm+8CsQk76toKCrkQldr+0Pmwyh09U9KLTyMMH5Wg+sz80kez6UT8HC
	 m6fK1bQZ8Mc2wb1t6LmQbcDLyBFfzs1JCBLvVo05a3vqffFlRm1AgFFg0aqSt25OiP
	 IbTNRb9vCwRwnQQtC8PRJFEqVA7Z5lGYXlziTowckOh1zGB57puUf/9oBUGShbP0Ox
	 tzIbf7YLOsJVuK9mFIX0jKDtU0l+DH9I2xmBVdFiPfp1P2T+pQz9ibEPMaxhpcch/L
	 ijYusajRqylmQ==
Date: Fri, 18 Sep 2026 20:22:57 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 2/3] bap: Recreate stream IO after an early Enable
Message-ID: <ZKE2YTCY4vSeMRG22gAE_m0EaMZ-c9O3kDGGU2YzPPFnkcZFexHMBMWbshUyc5nSPg6bgtyhVB4JwKOoeAGRRCgWWcfSzi0LvsND9Qxe6xY=@proton.me>
In-Reply-To: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
References: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: e376ec8077009877b7b4f7f01aa56224fb2ad5a1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

When reacquiring a transport, the stream can reach Enabling before its
previous CIS finishes disconnecting. Once teardown completes, IO
recreation accepts only QoS, while CIS enabling requires existing IO.
The pending Acquire consequently stalls.

Allow deferred IO recreation in Enabling too. Keep the existing CIG-busy
checks and recreate all IO before enabling CISes.
---
Additional local A/B: hold the userspace disconnect callback for one
active CIS for 500 ms, then reacquire about 118 ms after Release replies.
With patch 1 in both builds, the old predicate leaves both Acquires
unanswered until the client's 26-second timeout; this patch completes
both in about 374 ms, after deferred cleanup.

The delay fixture is not included here. It delays userspace cleanup,
not the HCI event; the regular regression does not force this ordering.

 profiles/audio/bap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5771c9ae0..308e0fd05 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2576,12 +2576,17 @@ static void update_cig_setup_io(void *data, void *m=
atch_data)
 =09struct update_cig_data *info =3D match_data;
 =09struct bt_bap_stream *stream =3D setup->stream;
 =09struct bt_bap_qos *qos =3D bt_bap_stream_get_qos(stream);
+=09uint8_t state;
=20
 =09if (qos && qos->ucast.cig_id !=3D info->cig)
 =09=09return;
 =09if (!setup->want_io || !stream || setup->io || setup->closing)
 =09=09return;
-=09if (bt_bap_stream_get_state(stream) !=3D BT_BAP_STREAM_STATE_QOS)
+
+=09/* Enable may complete while the previous IO is still disconnecting. */
+=09state =3D bt_bap_stream_get_state(stream);
+=09if (state !=3D BT_BAP_STREAM_STATE_QOS &&
+=09=09=09=09=09state !=3D BT_BAP_STREAM_STATE_ENABLING)
 =09=09return;
=20
 =09DBG("%p", setup);

