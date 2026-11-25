Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649276;
	b=y3rrW2EnVBK3gWkIpCVuwa/W730cYHf1/AUonQw6ihgv0kIGY/5AGwhi+uB3dA6XKNVl
	 52QiOJD9LDIZ5ecyEvsAaGCiDOJZNTZUgrFEXoexGg+jxChcHxoexlSgfmguUlEvaQHPN
	 XKnCSUHx62VxVHXT50xgSEABZwllzKtsh3cSCcJTVtenGIu18ffyNdvgucoor/uOuuj1z
	 B8JU8dwtbnFL0x41uKMzYM9w4ePlsMdUxArZlUPrqfPOzdV50jDO0voVbjHrGR6+ZTz3A
	 V/pBkxGGCz0v11QMwVAptvFhUvCKTVrK7ankJZsumucCMoe8QaMrf5wxT//7WbqfdtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649276;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Wu7e98kB1kmUDz/+g7/Epixio77x0w+jAEKSfYfciMw=;
	b=BQkdjh/hmylONc9Tg/btyn+PUsjLfqvhiX6k9scsVJGEtw4aul18LoO0YESY3vUlALKd
	 cmKG0DIeveg5ARwrhmpswKoo2ZLvrcI6JVPYVUTxCIfSDSeeaowUKiuDsY6bHbOm48oMs
	 Ihw+F+SnAODzecFNZOneevBOJkOvN6y9Rh/IzC5Ymqa66fvIUCkPKKCQC+mJPx0DcjTX6
	 TT+wqxKRPYi/DlegNnsbWnvUYZGETcgJlJU49YxpTHLIbqcxATDfR/3IRFSQ7tqj6N7yV
	 HTT/++lZ1gsz5XXROYkIDoppIubqsP2RLQMQeY5Ej/FM5oaeC1sVHLmMvtgQBwb31lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=bxz5dslk75g25ndfe7pno7phxq.protonmail2 header.b=IHfKcvVi;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3F606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=bxz5dslk75g25ndfe7pno7phxq.protonmail2 header.b=IHfKcvVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bxz5dslk75g25ndfe7pno7phxq.protonmail2; t=1795649273;
	x=1795908473; bh=Wu7e98kB1kmUDz/+g7/Epixio77x0w+jAEKSfYfciMw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IHfKcvViVghehBo2KEvUfEEsMEgHaifvB4H6jTZUj2z5BbBj1lbxiCFnbUAZq9Opq
	 Q0yRgDe7Ej/VIs1ooZjHq0CSK3xnWKruJEz8Q87XLq13XOwPUQocd0kl4J2zdxMiLH
	 9jRj8PNckQmkc+e0QJOIdNOZQThBkw2s1VN+fHEsLmdss5TqnoHT1cSVf5LF+0Cu9T
	 XlRnqbIZUyEgo0E/Ne6xy6WhnSoW8AdHx38pTkuip6UeQi/zurTLBZch0uYPB/pW85
	 HycbV7o7Qqo8s/En3UvtxUn163CA4n0KZZZwqLcBjLMTnUwkNbCKjQMTrTMPFHRL0M
	 ae2mOVTfsRbwg==
Date: Wed, 25 Nov 2026 23:27:49 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v6 2/4] asha: Add connection interval STATUS helper
Message-ID: <dbb0806e7425e651c1394f98e4c8dcaa7383e535.1795648818.git.cochcoder@proton.me>
In-Reply-To: <cover.1795648818.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me> <cover.1795648818.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 035d51eb4259d2e12a5109a1b7636108020ac551
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
index ddd14547b..0582f8814 100644
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
@@ -182,6 +211,8 @@ struct bt_asha *bt_asha_new(void)
=20
 void bt_asha_reset(struct bt_asha *asha)
 {
+=09remove_attached(asha);
+
 =09if (asha->status_notify_id) {
 =09=09bt_gatt_client_unregister_notify(asha->client,
 =09=09=09=09=09=09asha->status_notify_id);
@@ -214,6 +245,7 @@ void bt_asha_state_reset(struct bt_asha *asha)
=20
 void bt_asha_free(struct bt_asha *asha)
 {
+=09remove_attached(asha);
 =09update_asha_set(asha, false);
 =09gatt_db_unref(asha->db);
 =09bt_gatt_client_unref(asha->client);
@@ -263,6 +295,39 @@ static int asha_send_acp_without_response(struct bt_as=
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
@@ -373,6 +438,13 @@ static void check_probe_done(struct bt_asha *asha)
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
index 9e62fcde8..e6b2e7a0d 100644
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


