Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491556;
	b=qmGaB+iOt2bN0t5Jd7aOlizx5w2N7nQ9g2IwDYaPqwKxql+zXVN0cOvDBQrQ5NDpgXLl
	 qyZVyOjMaGDc4PIMh3WPuThnQw8c9AQCB7QuK+9tKF+53kNNnHHg15JcvYDkKYhc4/1EZ
	 ZlBAGLEvSkmnjae0UfiBHUJJTnemdGjueclgpYCWHC+DOe/gE473rUygP2V8EXyOKMiq3
	 UPH5tG7tL7a7jxMRgLmbZYab33LUZfoJa5jBetuJIxxrS7D5StKxnK5sQZsEb8QMKgFBU
	 mXbQLa+0THfvrsGUO1ySB1m5WSJ9XRSo7UaJ+INYNGp7BDkuDe9w2PVQpEahsAbRBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491556;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=fbIdkZ6yYSD2/2vsHu+ZzN4N/nInFByxeQsga5sSZjQ=;
	b=q9Qc9uffm0IHkX9NhKMcbVjFV6nLze/QxCWsb9LCLLzjkhizku7NDqNOJm27XLyWNK9+
	 NbKxeTuXD7UKIglAM2cIAz7oab2kSeqyQoWYGGSTffai0EF5fp6tdctDq4dfs/e1lvwVO
	 IttNYIwxFP8lccooc1/JtSdYhQI3yb2WGp5W9owqotboTNNa1Ht9L8Qf3BI5WzBUwHXwC
	 lio3aGqysZZ4yOblm8Uyopxw15aGxAI248vsF2eRK00vxPbsSNwgcgfuclGTFxNxelEe/
	 BEIZavoC/yCZqt8lumMK0XyE29DePwL61ZfJaUp/WM4TNyETe/LpyFdJ9bMLTcMKrDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="a/NY/75R";
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C0606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732C0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=a/NY/75R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795491553; x=1795750753;
	bh=fbIdkZ6yYSD2/2vsHu+ZzN4N/nInFByxeQsga5sSZjQ=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a/NY/75RCOkcOWCzg3auaAQjY+2/9UbeJ0n4uDLg9fcfXtOeB5PtwwuWxPNSCQ+qM
	 JoICeaaCejA2Vf8D5ybcKv7A3pqro3i7WwKcohfFRU270wqDDPlQxkQ0uMqm5fcPPp
	 Rur5987+oDd6DPfxWOrONv1QYc1mn09kZkqgTSIosc+dQElnqNEPyaRyR+PV/63/xZ
	 fIkuymoId2hsYxKqIl9QImHEj53d0j3Stxy1bp19MyJQZyNMvqGeN83swDKXleBjoH
	 EdBYLY9nN9adppO/nmuGT1TRpwC5RCNsQVd2JG2XPMvLKefhcBvt/tcW59rdJuUFgl
	 5ofh6m1ETzUIA==
Date: Tue, 24 Nov 2026 03:39:07 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v4 2/4] asha: Add connection interval STATUS helper
Message-ID: <2d1043401d8290bdb12ac1c15cdff6338f8788d6.1795489294.git.cochcoder@proton.me>
In-Reply-To: <cover.1795489294.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: be62daf4b35da5762ee77149808d12ca863570b8
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Send the observed interval to both attached hearing aids, including a
peer that has not started streaming. The format follows Android's
hearing aid stack, which sends STATUS with a connection update type and
the new interval in 1.25 ms units to this side and the other side.
Reject intervals that cannot be encoded in the one-byte parameter
instead of truncating them.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 src/shared/asha.c | 37 +++++++++++++++++++++++++++++++++++++
 src/shared/asha.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index b8e9d3f..e85c5c1 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -260,6 +260,43 @@ static int asha_send_acp_without_response(struct bt_as=
ha *asha,
 =09return 0;
 }
=20
+bool bt_asha_set_connection_interval(struct bt_asha *asha, uint16_t interv=
al)
+{
+=09struct bt_asha_set *set;
+=09struct bt_asha *other =3D NULL;
+=09uint8_t cmd[] =3D {
+=09=090x03,=09=09/* STATUS */
+=09=090x02,=09=09/* LE connection parameter update */
+=09=090x00,=09=09/* Interval, in 1.25 ms units */
+=09};
+=09bool success;
+
+=09/*
+=09 * Android's ASHA document lists only the update type for this STATUS,
+=09 * but its hearing aid stack appends the new interval as one more
+=09 * byte and sends it to both sides. Reject a value that does not fit
+=09 * in that byte instead of truncating it.
+=09 */
+=09if (!asha || !asha->client || !asha->acp_handle ||
+=09=09=09=09interval < 0x0006 || interval > UINT8_MAX)
+=09=09return false;
+
+=09cmd[2] =3D interval;
+=09success =3D asha_send_acp_without_response(asha, cmd, sizeof(cmd)) =3D=
=3D 0;
+=09set =3D find_asha_set(asha);
+
+=09if (set)
+=09=09other =3D asha->right_side ? set->left : set->right;
+
+=09/* Notify an attached peer even if it has not started streaming yet. */
+=09if (other && other !=3D asha && other->client && other->acp_handle) {
+=09=09if (asha_send_acp_without_response(other, cmd, sizeof(cmd)) < 0)
+=09=09=09success =3D false;
+=09}
+
+=09return success;
+}
+
 unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 =09=09=09=09=09=09=09=09void *user_data)
 {
diff --git a/src/shared/asha.h b/src/shared/asha.h
index 9e62fcd..e6b2e7a 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -66,6 +66,7 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_=
cb_t cb,
 unsigned int bt_asha_stop(struct bt_asha *asha);
=20
 bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
+bool bt_asha_set_connection_interval(struct bt_asha *asha, uint16_t interv=
al);
=20
 bool bt_asha_attach(struct bt_asha *asha, struct gatt_db *db,
 =09=09struct bt_gatt_client *client, bt_asha_attach_cb_t probe_cb,
--=20
2.56.1


