Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2917736;
	Wed, 15 Apr 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214071; cv=none; b=ZHGcgccF46exGXWUUVvRTQUSs603MPb2yoPc6/Lo29yzdyfaThz5X0aM+oJ3uCZQ0er9iOJaoM0wZznzVXIOdsvlWknnSawaO1SXAI3jNNvrj925AdXqXlbgpZf792Sd4s6YAXEUO3bLXvv95S2mcj3BHtibqp0LajuQDdD69Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214071; c=relaxed/simple;
	bh=yyclKNbVOUPNTd6o9wWkFsmB/JRShMYhZntOJE06ubM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=av3nHOFFDD3Q1/WHeXO1F19nswyEu5AdljQQwWp+1ej0GRyIAixaR5m5DvquZAEsXWP2BlJPd47xtpw9RfUBtSHQKzxLOXx7KlW6cNsH5lZ+Wa/T+/LxOkcXlbBSQwxg3khwqZ2loaZM7wWQ7igKqNa+TSNswj6Bc7Y3bw7slFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai; spf=pass smtp.mailfrom=innora.ai; dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b=H+oV4Ml0; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b="H+oV4Ml0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail2; t=1776214060; x=1776473260;
	bh=yyclKNbVOUPNTd6o9wWkFsmB/JRShMYhZntOJE06ubM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H+oV4Ml0O/VA/dkrxZ/Q3TL4T5ccTdiAxL6QNdYo8I3gcCgloDUppKbn0ebHyfNx+
	 gdD82U7KnyC4UP0f1GB6n5RBbX3U7C9EkYWUELfWGqYq1CjJcxD/hUN0zElfS3+Sgu
	 r6V0NnXZqjeKZdH0vNnm4bDREp1XW/gzBaFBZdbIq59zBIlnIheR+5gkh6R/qjtN1z
	 E9AOk7SZQtWiE2XhL/rwpd6jSW+DfwHkLgX7pcqQwfSCK1z2NfXFJHt+isRJSJvaDK
	 XPuUnnDIHFLcQ413vQLkXq2O3PQq/S6WakwDV4dVmEuyl72wgHyu8SeVm6/rYDPUoX
	 jEHnXjXm3BW2g==
Date: Wed, 15 Apr 2026 00:47:33 +0000
To: linux-bluetooth@vger.kernel.org
From: Feng Ning <feng@innora.ai>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, feng <feng@innora.ai>, stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix ECRED reconf rsp channel teardown race
Message-ID: <20260415004725.39215-1-feng@innora.ai>
In-Reply-To: <20260413044730.86315-1-feng@innora.ai>
References: <20260413044730.86315-1-feng@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: f8ce39647baa47fc3c1ee1a8d660d76e47216d13
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: feng <feng@innora.ai>

The ECRED reconfiguration response tears down all channels that were part
of a failed procedure. The handler iterates over conn->chan_l while
holding conn->lock but it called l2cap_chan_del() without taking an extra
reference and without the per-channel lock. Other paths (socket close,
timer expiry, etc.) may drop the final reference outside conn->lock,
causing a use-after-free when the response is handled.

Take a temporary reference with l2cap_chan_hold_unless_zero(), perform
the deletion under the channel lock, and drop the reference afterwards.
Add lockdep_assert_held(&conn->lock) to document the calling requirements.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credi=
t Based Mode")
Cc: stable@vger.kernel.org # v5.7+
Signed-off-by: Feng Ning <feng@innora.ai>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece..08d2045ab 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5466,6 +5466,8 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap=
_conn *conn,
=20
 =09BT_DBG("result 0x%4.4x", result);
=20
+=09lockdep_assert_held(&conn->lock);
+
 =09if (!result)
 =09=09return 0;
=20
@@ -5473,7 +5475,13 @@ static inline int l2cap_ecred_reconf_rsp(struct l2ca=
p_conn *conn,
 =09=09if (chan->ident !=3D cmd->ident)
 =09=09=09continue;
=20
+=09=09if (!l2cap_chan_hold_unless_zero(chan))
+=09=09=09continue;
+
+=09=09l2cap_chan_lock(chan);
 =09=09l2cap_chan_del(chan, ECONNRESET);
+=09=09l2cap_chan_unlock(chan);
+=09=09l2cap_chan_put(chan);
 =09}
=20
 =09return 0;
--=20
2.49.0


