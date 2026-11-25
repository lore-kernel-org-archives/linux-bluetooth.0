Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649254;
	b=nL20dxKK+Ot1vOYXIfCTbfBpwQSnpOBEoXJsywACZP1RLyYF3OaTLk/k5Y0mYWVGE6eb
	 AK9uw9YOMdkG7NUbzJdMLF/USxMmzQnaXV8Dv5sbEbvcKfZR2w11enT1FAKBtWV+M+3On
	 Ig4zDfsPS+0nhzDDrouGTBwNTmGXCpm0AptsEKpFpCMcBDjCtx2GrAVh0OlGS2rskfdFw
	 k4x0UjxYV4m3PnOlj8dI6HkfVd/3GT/ZehNRW5gKSPJqsIi9Fn+A8nv+QtVG449acrGwV
	 Zq0zquFYjwbL44M+/Jv5z6qxpfyzyG60io5Cdq+yTu9Aib3+jJUCkvcablrQXiB6Ctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649254;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=WMZEUiHcmZNRrzAeOC/L0+Y/IHNJTKTJC6QeHwB83pU=;
	b=bIyI2wqwsVPwX/0ueS04/kqOMUhCDoK2y/Lq+p5TQ8MaPAxpSMfIKvlE0KJcrJ2BmPHc
	 Ss96sbr5iT8XrTahmfCz6GaRRphq8GeYIQX1NsijcnO4LQUVwwIe9X6FjEJffWEqGiyIe
	 YOyxpTBiMd4PPTlK+58sxSlbZ4tOVajXWFHTIGiheMl00P9FcXqlvdxjeia68Z/v7V6UL
	 lCVI8XRB8gB7TFeGlLRLtKDnJ5NLxF0ip4oXVd8+iErivNTIVkHn+G6KYor5FomTR8BCt
	 jI6EpT2RGwBUCARALkQr+z2Ah/fOxcmUdVp+5hVZcme4XITSokb2w1jKFiQ1vwmW3mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ffcgnu4gardsrlkkwb4zbirjrm.protonmail2 header.b=vBh3Dv0Y;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A50606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A50606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=ffcgnu4gardsrlkkwb4zbirjrm.protonmail2 header.b=vBh3Dv0Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ffcgnu4gardsrlkkwb4zbirjrm.protonmail2; t=1795649251;
	x=1795908451; bh=WMZEUiHcmZNRrzAeOC/L0+Y/IHNJTKTJC6QeHwB83pU=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vBh3Dv0YQWrppTm0HPi27UWwvGqUhe1L1NtD6AxgKoMN1XxUfqsupI/u25omwlcnV
	 bHoQYPuOJJcBAVXy9NHDB0HqBXWb9iUqKocROcQNkdYhZHYxlSsUSgVxlr1i2BVBCY
	 /uuUx/C/d1FFFxs+8Jx4MPc1Qhk17r53xhz3K+Qm6z29rySkLWY7NCqaH3D5c24qVd
	 8ruj0o1KaYEpIjtsAMHkx3ZBAHG72MvPm17XfOXdughLog0esXAgDduq/mKkdxBFrF
	 WKBPQP/xjniBw46xSicdRNdZqwPQWEe9AbBwcuwDzF0cya6t0wDadEtg5D+m6UrJ/m
	 SXZeZE6AylW9A==
Date: Wed, 25 Nov 2026 23:27:26 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v6 1/4] shared/asha: Unregister set members by object
Message-ID: <feae2742434bfca2ba04cc882c84bad4cc823c5d.1795648818.git.cochcoder@proton.me>
In-Reply-To: <cover.1795648818.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me> <cover.1795535897.git.cochcoder@proton.me> <cover.1795648818.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 18e04312dc5ab06b693701471b661d211c4d4621
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

Recreate the set queue when an attached aid starts after the last
registered aid leaves, so registration does not lose the new set.

Fixes: 1b137c4bad24 ("profiles/audio: asha: Only expose device after we hav=
e attributes")

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
 src/shared/asha.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 2ce61fd13..ddd14547b 100644
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
@@ -83,9 +90,12 @@ static void update_asha_set(struct bt_asha *asha, bool c=
onnected)
 {
 =09struct bt_asha_set *set;
=20
-=09set =3D queue_find(asha_devices, match_hisyncid, asha);
-
 =09if (connected) {
+=09=09if (!asha_devices)
+=09=09=09asha_devices =3D queue_new();
+
+=09=09set =3D queue_find(asha_devices, match_hisyncid, asha);
+
 =09=09if (!set) {
 =09=09=09set =3D new0(struct bt_asha_set, 1);
 =09=09=09memcpy(set->hisyncid, asha->hisyncid, 8);
@@ -101,15 +111,24 @@ static void update_asha_set(struct bt_asha *asha, boo=
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


