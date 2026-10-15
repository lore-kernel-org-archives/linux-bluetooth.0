Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC6556BA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087899; cv=none; b=ktyjfJ6P939H2HYcLJL/jJXuPDcIXIj2KaKLpv7XBImZCXYEOoBRI97UHG0F1y7d4ov0xruVu+znHVsOvQGIwLHnMOQgN0x4vJ1aHP+1FR1thL/VnTmQ+82pH40G17rwAI0Kfc4wwEBjCT0XGegpDJW42OnjuTvP3bv9Pxzb8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087899; c=relaxed/simple;
	bh=iF9KNRVVfl9yefyuDdsMHvmsXVUEtUTTt3+AdgKf5As=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XW1+vJXpRCbTJRJ/KWG9Tz19Dm/Dy+YCiK1RkPs6rQKTnQHidOH4y8vuweJdvAgADhGjJDtY/2ProNIzipVOAKcJ+xK4LaPT69uZ8SdXLoCtX+SH7o/XUqxD8I01rsmpiR7xhGhgq+NrUhhpZO1W4xxvqGx/HBCn9x8nQlbE/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=d/2NaoVK; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="d/2NaoVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792087880; x=1792347080;
	bh=2msydkpPHwsYTtGjMai0sSWWVLFUdd2yy6ntZs9GgAw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d/2NaoVKhbX7fByWOYUZE6MgnqIi5RGzYUmT1Jmc++fehe0cNCfbRTanFe9kmzs9e
	 kL5r6H5GQ7t81xvbDnuvhRABY5Igg46VlvDHQLTxzCS5Hj4b4ss36T/xj26wFcc0qE
	 V3T5E5Zirp+HCdrHTeZVwRsm5GDA8xHo1KS3hEzEZcq6WHvvawUB0O00BWQLyM0uGe
	 1HBWoR0iRWc8o+kn1uzpZRtvAqFN9ffJ7ryLEiULOEwtWnkeQEIBUq3K8n055Ut7WE
	 1r8Moxz3JuD1Q0vfqEhaqEc5XBe4iFaR4XodXIq6kMOzqOEWmeGCXym4j8/iZrfclA
	 GonKPP6BH/42w==
Date: Thu, 15 Oct 2026 18:11:14 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3] Bluetooth: l2cap: prefer compatible local LE intervals
Message-ID: <20261015181041.42873-1-cochcoder@proton.me>
In-Reply-To: <20261015043336.47734-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 32ae447af949694aa43417245bc5b45cd106647e
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Use a valid intersection of a peer interval range and local preferences
when they overlap. Otherwise retain the peer request instead of treating
an initial preference as a hard supported bound.

Validate the original wire request first. Only narrow its interval range;
leave latency, timeout and disjoint-range acceptance unchanged.

Assisted-by: OpenCode:gpt-6.1-sol
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes since v2:
- Wrap test notes to avoid the GitLint B1 failure in series 1186108.
- Refresh onto bluetooth-next ff8b09806b7b; no source delta from v2.

Changes from v1 retained:
- Treat local ranges as preferences, not supported bounds.
- Prefer a valid intersection; otherwise keep the valid peer request.
- Never repair an invalid original request by clipping.
- Preserve latency, supervision timeout and disjoint-range acceptance.

Prior native controls check the accepted L2CAP response and HCI range:
overlap, fast HID fallback, slow idle fallback and exact match. Baseline
passes 3/4; strict bounds pass 2/4 (reject HID/idle); v2 passes 4/4.
The prior reference-guest full L2CAP suite passes 115/115, without skips
or captured KASAN/lockdep alerts. These are prior runs, not fresh v3 VMs.

The independent BlueZ test companion was sent as:
https://lore.kernel.org/r/20261015044221.55631-1-cochcoder@proton.me
Its overlap case intentionally fails without this kernel change.
Completed-interval startup/stream gating remains separate profile work.

The saved v2 CI report lists all jobs except GitLint passing, including
the native L2CAP tester. This is not a remote CI result for v3.
The combined Arch trial is reported working on hardware, not isolated
testing of bluetooth-next or exhaustive device/negative-path coverage.

 net/bluetooth/l2cap_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4dd56e007..afde04a19 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5031,6 +5031,19 @@ static inline int l2cap_conn_param_update_req(struct=
 l2cap_conn *conn,
 =09memset(&rsp, 0, sizeof(rsp));
=20
 =09err =3D hci_check_conn_params(min, max, latency, to_multiplier);
+=09if (!err) {
+=09=09u16 pref_min =3D max_t(u16, min, hcon->le_conn_min_interval);
+=09=09u16 pref_max =3D min_t(u16, max, hcon->le_conn_max_interval);
+
+=09=09/* Local preferences must not reject a valid peer request. */
+=09=09if (pref_min <=3D pref_max &&
+=09=09    !hci_check_conn_params(pref_min, pref_max, latency,
+=09=09=09=09=09  to_multiplier)) {
+=09=09=09min =3D pref_min;
+=09=09=09max =3D pref_max;
+=09=09}
+=09}
+
 =09if (err)
 =09=09rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 =09else

base-commit: ff8b09806b7b18884ad8d3a2b3d702da534a4e21

