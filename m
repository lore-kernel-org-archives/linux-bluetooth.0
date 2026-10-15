Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D93655D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792038863; cv=none; b=StFUNaQLVG0ZQ2jtlWMCHAhQnzSQWaqo7XhBqFLnE/wXILnWy3twIt1i/l8/PjnGCSwSGzzGgp+ZU9IXOMOechWZkihtF0zpdN+0zLpWtCY1kG2BeXeynTvM5Re/Qc3hnXl9iYOO4LUOp0+Xszkhov9UZMAuofv5B0dV7SRUlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792038863; c=relaxed/simple;
	bh=GecPh04JnjxnNtmO5vyhs4mACH8DimY590D2Cb0p/7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aiqb8aJ84nyji5hFxXHAf88YMHL4hRENENQJOBJxyP1mKhe+HpRE4GLLaWyCrWooEYw9Kb1fICmUz6Smi4+sPUARt0ZG0DzS45P8k2vZFCFeXCyI32R87foaM/EUY07bTMNyyqfUml3UAbtdpylhzMEqRKzR/t44fe2hi5tZYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EEAtDpVs; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EEAtDpVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792038849; x=1792298049;
	bh=AF9QRn/bgmloh9rsY59JJs7E43ildWYjRulk23LNwyY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EEAtDpVsFYllg34jrnF4MNy0eTkAOmBW8ee+AHdM+ve3dqTzoQuQwVxbEfEkQmt9+
	 tvfMyD0wfDRvggY69SDzAnGJ0HnhAXfRAPs/MJvZf5D1F/jUFqs8Fcj00YRqTZmG4e
	 ZuXiAuQHyzOxL0GwUnoCYHzlvmmI099+fZAStFVk5pIclYMHrP5BU3Mw4Coi194YLM
	 9oj+4EQdTSI4D+s7935C9EykxI08TvAQKP1JjH7QTG+hOoyka40AHcnypbTZbXpyJI
	 KpUuXoKg1IBzDMXQgKYRWCgh8JFJPAJMa9VD2rZmqwWZO7dKhJbLKhUWW3NkvCEi4y
	 NM9GWlwFBsZ2g==
Date: Thu, 15 Oct 2026 04:34:04 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] Bluetooth: l2cap: prefer compatible local LE intervals
Message-ID: <20261015043336.47734-1-cochcoder@proton.me>
In-Reply-To: <20261013033118.501182-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: e60af580416c48dd048560653073643c9e5b3f5b
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
Changes from v1:
- Treat local ranges as preferences, not supported bounds.
- Prefer a valid intersection; otherwise keep the original valid peer reque=
st.
- Never repair an invalid original request by clipping.
- Preserve latency, supervision timeout and disjoint-range acceptance.

Four native controls check both the accepted L2CAP response and resulting H=
CI
update range: overlap, fast HID fallback, slow idle fallback and exact matc=
h.
Baseline passes 3/4 (no narrower overlap); the strict-bound negative contro=
l
passes 2/4 (rejects HID/idle); this revision passes 4/4. Its full reference=
-guest
L2CAP suite passes 115/115 without skips or captured KASAN/lockdep alerts.
The source-extracted sanitizer fixture passes 397,723 parameter cases plus =
two
framing/role cases. These are finite tests, not proof for every controller.

The independent BlueZ interval-test companion is not yet sent. Its overlap =
test
intentionally fails without this Linux change. ASHA completed-interval star=
tup
and stream gating are separate profile work, not a new kernel ABI or hard b=
ound.

A combined Arch 7.2.9 trial with this change and revised BlueZ was built in=
 a
clean chroot. I report that stack working on hardware; the running test ker=
nel
and BlueZ package versions were verified. This is combined-stack evidence,
not isolated attribution or complete N7/paired-device/negative-path coverag=
e.
It is not hardware testing of the bluetooth-next kernel itself. Remote CI f=
or
this revision has not run. Target master still matches the tested source ba=
se.

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

base-commit: 397464709a204da9b8dc3b01d6ea42539d951cd2

