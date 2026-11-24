Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538405;
	b=Oi3FH5LskpVqhdjsO1Xpjvcnfo73pOQkTdeeFXja3C8BfcWivuKadJPE3TAIZisFWyvB
	 uwH1iXDKxQk5iwCN5NAntZMUcFv6HU7gNYqYalJ5bDS/8g68UMK1+AR/uZHi8QNREjAXj
	 sp/rWh5wj8hTptJ0b6MJqGhFkuIKVPRNi0UCXQ8VMhIUYTx7RyK6Y6vCReFCBmYKCX+kG
	 kuW7O8dvjqWEUCXapspgjmTIRTzO1HH2YQItGpyS39Q+eU9DjnWrQAlDSKTG2nRVKRFke
	 MYU1YYYyopb2LAMzs9NlosZXwn2HhrUfKFnwMt9nB3KdVae7QWOnxcsZZUSmnjofj7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538405;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FT+bgA0s9JXqV/Fmn2mv7D9VqUUuax75pskvJfWb8aE=;
	b=wBYCIHa3yvlXpGGhN3fXmPhXgfVEJuv1+wA8TqxpDM6rOSWM4JGytpWzmLtj9R/21WV2
	 0GyzpDnwsZUy7Fl6USUWAa7m51iapZ6xYqOs/to2zhhu1lZq0+FaaKG2tckEkNT+dHV8s
	 yhGbuXmMJf3nKCD3KPyEjbtKufsq/guVyTuq1RKP3+7NJyyK6rIjdQexELNqkdAEJ3ilY
	 mGQ9j6AkkPZbk44y8S/7LYYQ8s3g6LEec5gOFRBJtHX+dfb6bDuG8D8ZwZ+KRBiB9CHR4
	 XANf0gA4+SQcXAUeWQ1g4Q53feef2mQaLG8Dal9gxQcoSbTnTa4tNbXwa4SPLx3UscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=LQuI3qK3;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E400606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E400606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=LQuI3qK3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795538402; x=1795797602;
	bh=FT+bgA0s9JXqV/Fmn2mv7D9VqUUuax75pskvJfWb8aE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LQuI3qK3ZlLNjAidnbGirn9ZflGlwuPMyWZpkcfQpW+Mtha5/jg4O/iXCEFBqBxf2
	 SqrrR0bFk88FKCwPm3qXi+ZIWQxG614IBp0EaYFAU9d0PDKr/dNXcvzkS/8p+/91fy
	 HDW6FO435nIxuzH6F9vx2Di7zSNHHcUvNgF1ynOGHWatp5IkU/xf3zj90NDEG8tTiM
	 PoeNnUhKzuN5QE76TZhdSX8wHaF9ZMghedQCXzexGLKdy9nIiTVicvies2XnU6HYHs
	 Vnaq4/4B4smmJvL14N/N6+LkQVT4+b1siljdaG+57YPLYte3T3kGe/9w8w7fP8VDuL
	 QUeUJK7VCfqFA==
Date: Tue, 24 Nov 2026 16:39:58 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v5 1/4] shared/asha: Unregister set members by object
Message-ID: <e565cbbeebf165ab5e6efc3c3f2764bc88da929b.1795535897.git.cochcoder@proton.me>
In-Reply-To: <cover.1795535897.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: e50573f4ca4634983aabfad83ec5c38ef99c5552
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

bt_asha_reset() clears the HiSyncId before calling update_asha_set(),
whose removal path finds the set by HiSyncId. The lookup then fails and
the set keeps pointing at the reset object. bt_asha_free() cannot
unregister it either, since the HiSyncId is still clear, so once the
object is freed the other side of the pair follows a dangling pointer,
for example in asha_set_send_status() when it is stopped.

Find the set that holds the object by pointer and clear only the slot it
owns. A reset or freed object that never joined a set, or was already
removed, is now a quiet no-op instead of a "Missing ASHA set" error. An
object that was replaced by a newer one for the same side also no longer
removes its successor when it is released.

Fixes: 1b137c4bad24 ("profiles/audio: asha: Only expose device after we hav=
e attributes")

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 src/shared/asha.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 2ce61fd..b8e9d3f 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -51,6 +51,13 @@ static bool match_hisyncid(const void *data, const void =
*user_data)
 =09return (memcmp(set->hisyncid, asha->hisyncid, 8) =3D=3D 0);
 }
=20
+static bool match_set_member(const void *data, const void *user_data)
+{
+=09const struct bt_asha_set *set =3D data;
+
+=09return set->left =3D=3D user_data || set->right =3D=3D user_data;
+}
+
 static struct bt_asha_set *find_asha_set(struct bt_asha *asha)
 {
 =09return queue_find(asha_devices, match_hisyncid, asha);
@@ -83,9 +90,9 @@ static void update_asha_set(struct bt_asha *asha, bool co=
nnected)
 {
 =09struct bt_asha_set *set;
=20
-=09set =3D queue_find(asha_devices, match_hisyncid, asha);
-
 =09if (connected) {
+=09=09set =3D queue_find(asha_devices, match_hisyncid, asha);
+
 =09=09if (!set) {
 =09=09=09set =3D new0(struct bt_asha_set, 1);
 =09=09=09memcpy(set->hisyncid, asha->hisyncid, 8);
@@ -101,15 +108,24 @@ static void update_asha_set(struct bt_asha *asha, boo=
l connected)
 =09=09=09DBG("Left side registered for ASHA set");
 =09=09}
 =09} else {
+=09=09/*
+=09=09 * Find the set by object: the HiSyncId is cleared on reset and
+=09=09 * a replacement for the same side shares it, so it cannot say
+=09=09 * which slot, if any, still belongs to this object.
+=09=09 */
+=09=09set =3D queue_find(asha_devices, match_set_member, asha);
+
 =09=09if (!set) {
-=09=09=09error("Missing ASHA set");
+=09=09=09DBG("ASHA object not registered in a set");
 =09=09=09return;
 =09=09}
=20
-=09=09if (asha->right_side && set->right) {
+=09=09if (set->right =3D=3D asha) {
 =09=09=09set->right =3D NULL;
 =09=09=09DBG("Right side unregistered for ASHA set");
-=09=09} else if (!asha->right_side && set->left) {
+=09=09}
+
+=09=09if (set->left =3D=3D asha) {
 =09=09=09set->left =3D NULL;
 =09=09=09DBG("Left side unregistered for ASHA set");
 =09=09}
--=20
2.56.1


