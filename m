Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538419;
	b=v+2xBuKVwQiuTITxV9uN1ODvZPCVGtpRmPFq5DypPjOb5BrFqyYyKyhL40BS4R/yQA4Y
	 tqlvcEWznM8L/iQOYgmgITT6bt31+iY2ZgpJ0Ilmc2jQGjS6h1RXWTVkkT0auQ+08wBjP
	 l1kKfbRtrFOBBmYLR2biJtbFJWF6b1dr3ax8DVUrIl8sA+tJR1JrelJeE1x4zerRBzyO0
	 0EOp9L73yfCm57bKXK5zypMniF+TgCWfwrijhK+weetQwDT/atA++uA8Sh8fQ/Sv/+B3W
	 48jx5EhVbReTrXKQIUl2cDa1ujA/EUsevdatKgehwRiEmyZyJnREnGHIRZMwhoj7WLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538419;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nMTAjdXVSrHM1aJN3eOqd0HD+98MDYmo05fZglbwoI8=;
	b=SI4q74oBLtEPeoKEKExotHZNlPOCU2Xbe+HB53aOOf+U8mDgAktV88c2pKDtKy7hRZXV
	 QEXjHO/BNQR7RNGz9E6Oye0Y+niFb8teLD4Jkcd/0bkPs1PC2lxGSYaZAuRlERmNTLpn/
	 kr/S4AtfTUs8zIqjwOagMh8H8tlsaFXDo2d3tX4Mr2m586J14A+OAAlh3+7LGbQ7G2gs/
	 hL6U1iREolGNw3TYvttxGJhlgHL8jfKub0FowE6V8Q/MntHIHsgsup+2tt4ggyTBxo1y2
	 b2FM/tL7or9XvTGIM9vq3WYND6lrfCswwmGcFgttSFBbz5JOGRrCb4QT5JWGuNDI0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZVQM3nPz;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B33C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ZVQM3nPz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795538416; x=1795797616;
	bh=nMTAjdXVSrHM1aJN3eOqd0HD+98MDYmo05fZglbwoI8=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZVQM3nPzdZ/KPouIDw1eP+zQCbEcVBpgZ4xeUNRNvkG/NJshaIfK3Vd7FDQMX4/qM
	 7axHSxbd0p27/dXn/hw0hd+ApQzQu7R4Y53Q5YnYb0lMO4EvDD904J0NIbat2h74ip
	 jXn6z9qij3qlK31Vs+bwu6YGL4EWnVgynZ+cLzh0AOhzusJhaW8OR7iO229WPrzMQc
	 Spu1zBfkl5a1qQS7KFgRBFKwF6F9RX8bDussVug9zvxDYmgakt7+XrK4EmHEICQxgE
	 TnWb0kMmyv+ygqcf9GSQqIYzCiM4+CLp/tgJ9uoLcUJagR8s9xTfpFxyg1hOWVcdBj
	 tQEJQe1re68wQ==
Date: Tue, 24 Nov 2026 16:40:09 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v5 2/4] asha: Add connection interval STATUS helper
Message-ID: <20a79dbc6f7d52c13822d270cee17c4c6e8f74ff.1795535897.git.cochcoder@proton.me>
In-Reply-To: <cover.1795535897.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: d5dbd11e3c6008f3078d9acf4305df2ee5738cbd
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
peer that has not started streaming. Match the encoding used by
Android's hearing aid stack and reject intervals that do not fit in its
byte field.

Track attachment after ROP and PSM discovery separately from the set of
previously started aids. Remove that membership on reset or free and
keep a replacement when an older object for the same side is released.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 src/shared/asha.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/asha.h |  1 +
 2 files changed, 73 insertions(+)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index b8e9d3f..68a49e7 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -40,6 +40,7 @@
 #define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
=20
 static struct queue *asha_devices;
+static struct queue *asha_attached;
=20
 static unsigned int bt_asha_status(struct bt_asha *asha, bool connected);
=20
@@ -58,6 +59,34 @@ static bool match_set_member(const void *data, const voi=
d *user_data)
 =09return set->left =3D=3D user_data || set->right =3D=3D user_data;
 }
=20
+static bool match_attached_side(const void *data, const void *user_data)
+{
+=09const struct bt_asha *other =3D data;
+=09const struct bt_asha *asha =3D user_data;
+
+=09return other->right_side =3D=3D asha->right_side &&
+=09=09=09!memcmp(other->hisyncid, asha->hisyncid, 8);
+}
+
+static bool match_attached_peer(const void *data, const void *user_data)
+{
+=09const struct bt_asha *other =3D data;
+=09const struct bt_asha *asha =3D user_data;
+
+=09return other->right_side !=3D asha->right_side &&
+=09=09=09!memcmp(other->hisyncid, asha->hisyncid, 8);
+}
+
+static void remove_attached(struct bt_asha *asha)
+{
+=09queue_remove(asha_attached, asha);
+
+=09if (queue_isempty(asha_attached)) {
+=09=09queue_destroy(asha_attached, NULL);
+=09=09asha_attached =3D NULL;
+=09}
+}
+
 static struct bt_asha_set *find_asha_set(struct bt_asha *asha)
 {
 =09return queue_find(asha_devices, match_hisyncid, asha);
@@ -179,6 +208,8 @@ struct bt_asha *bt_asha_new(void)
=20
 void bt_asha_reset(struct bt_asha *asha)
 {
+=09remove_attached(asha);
+
 =09if (asha->status_notify_id) {
 =09=09bt_gatt_client_unregister_notify(asha->client,
 =09=09=09=09=09=09asha->status_notify_id);
@@ -211,6 +242,7 @@ void bt_asha_state_reset(struct bt_asha *asha)
=20
 void bt_asha_free(struct bt_asha *asha)
 {
+=09remove_attached(asha);
 =09update_asha_set(asha, false);
 =09gatt_db_unref(asha->db);
 =09bt_gatt_client_unref(asha->client);
@@ -260,6 +292,39 @@ static int asha_send_acp_without_response(struct bt_as=
ha *asha,
 =09return 0;
 }
=20
+bool bt_asha_set_connection_interval(struct bt_asha *asha, uint16_t interv=
al)
+{
+=09struct bt_asha *other;
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
+=09other =3D queue_find(asha_attached, match_attached_peer, asha);
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
@@ -370,6 +435,13 @@ static void check_probe_done(struct bt_asha *asha)
 =09=09=09=09=09sizeof(zeroes)) =3D=3D 0)
 =09=09return;
=20
+=09if (!asha_attached)
+=09=09asha_attached =3D queue_new();
+
+=09/* Keep attachment separate from the set of previously started aids. */
+=09queue_remove_if(asha_attached, match_attached_side, asha);
+=09queue_push_tail(asha_attached, asha);
+
 =09if (asha->attach_cb) {
 =09=09asha->attach_cb(asha->attach_cb_data);
 =09=09asha->attach_cb =3D NULL;
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


