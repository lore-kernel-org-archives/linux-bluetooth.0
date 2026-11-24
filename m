Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491541;
	b=eNj9e1fig22R4Gs3zz3kVvA7nPEvOTaorqYbsf94arH1jLQnNEpMWRuST1ph+ISYifY8
	 z9bnqNxeWHLEBQ7QYg8GnSpSqQ6+kWNY+rAl2sLyDs4T0hA1JB6ZJpfqsgKU0PY2Gb8qU
	 OXi5H+A8DwWSKjwru44yiRxG+vpsdzlOSGT31HBNVOPVWCQ+u6YUkZuNN/Ms1xPiHTQ1r
	 zeRrEDvlvUM/58rlmuYv5IMh3AUgJdeVwmrupnhmURFyobHORRsWUUFv9a8yc2donBccf
	 D4uP9QHNucrv/0VOK9FOgvItk8YnTWhX0i52KbWd2mp6vx/8nUFYaZp5S7qnTTPVPGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491541;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FT+bgA0s9JXqV/Fmn2mv7D9VqUUuax75pskvJfWb8aE=;
	b=ZxV+LBVnwAmmNvM5F4Fzp8F9ok4pm0S/3WQqEJWWp7GA1dgYCX3NcwD44JcyRCHwPbk/
	 8NOTF0/ClDgpmVAOtI/EG44Dz93Q2qrgCl8ignec6myGGtYkQaAIdZRZrWVTf9FTWPOuX
	 TvI3oXj2w3uwXpXiVli2ncWAoByXFBB3uzMpVlf9G9nYOZigArP8itAfZzH9NwJFG51Sk
	 +EiZhoZISYR73rJWJ3ydapJIa9oLsNvCEJma3NAQEppvx0UatixuWR79sMRL1Qjh3eN8o
	 lhXrVQOFHGF6+W4/gKVg/K7+iiK/7gfCP7mPSN0ethWoZutJ5a4aAHSqldTQuwpOpDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=jo7nnkym2vfppa5i43knfwhk2a.protonmail2 header.b="N/4OqT4b";
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400A606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0400A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=jo7nnkym2vfppa5i43knfwhk2a.protonmail2 header.b=N/4OqT4b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jo7nnkym2vfppa5i43knfwhk2a.protonmail2; t=1795491538;
	x=1795750738; bh=FT+bgA0s9JXqV/Fmn2mv7D9VqUUuax75pskvJfWb8aE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N/4OqT4b4GirJBOIFugeXVVLdvshHWa+oIPqq52wdVUkuGGoOQBkgz4vL5ywRQznh
	 +NDsWNpovxepgNK23PMCBABdSDauV/hE8QWbzlfMoizD5KbbziXx6rceQuIigWdOkr
	 vy9WQZC/vpO0Y1Q85R3DnttUqjLgCuy5hzgmGtBeQBrScURuvux3jx18Rol6Al6ywm
	 g3zMLE587zvm6VqqaO5U8maascRHskTh5ObuDkdCE8p1tkgKgdRMNKJwhJqT7n7ZYs
	 9SHYHuYar0svDy8CPEhWxEwnboajIiKdOSx+EZ+cTjqgawLgrFmLNTzys7qj9VvFKY
	 ugOwOz5b00gsA==
Date: Tue, 24 Nov 2026 03:38:55 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Subject: [RFC PATCH BlueZ v4 1/4] shared/asha: Unregister set members by object
Message-ID: <378719dfbe498086a4af54cca7b8808e09b5132f.1795489294.git.cochcoder@proton.me>
In-Reply-To: <cover.1795489294.git.cochcoder@proton.me>
References: <20261029002158.1036153-1-cochcoder@proton.me> <20261106235122.719665-1-cochcoder@proton.me> <cover.1795489294.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 7d9ea410fe74671faea7dcdce0cd10128ba40218
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


