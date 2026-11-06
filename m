Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985907;
	b=2HZA0YspvjWxVm85QYTQcKXw85dGqBTDjwv0IOY4ph+e3YmkAMmwVrvO+AtjPAXxQvnE
	 REWvjos62CuMDVJh2dZADP/SfozEwATrhKJKkelAvlYDsM7P2IKCYm3wHXErE6GOzp1tC
	 rUci4YXEZALcMIzgi3tsfF0g1Fnjp7+9emnFAP9Y6RUT7308F0aTBSYt8rj6smJcoak1F
	 5UpRTYM/SxcETF+Xqtii0tGnyEPR93cvg13M2lCtlMANt0yaSNbkjWEKuY8/xMJtbJKMJ
	 4d6jqMFlRdt4NpI+j6MGp+jAHlJ/+0Qbh7BgFNHoMVkotOVvOkqGw+Si9U63TrjZnUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985907;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1s82DtUi5BpnupL9XEScyO90k0wwALTTjnLeoQTQWmA=;
	b=06Smv61rTVWv/5O4rw791qrNSYNmBzive1e/1I/aykPTA8ylhJOrmI9WfKY2aF2kyX46
	 JKfQNOeA2/EsgdAiVgmEpy35bJjNbl3JaPD36lqK3sNlqbvSDjEme4nyIbqzwyl7KD58W
	 NlxyP6zBEXT6zaLVJmpO6bO3zfrqYE316jASsRqvybmCLa8NbgFVXFCoDb3jiYl0BICaQ
	 cTRJtVnXja8I3fa+RpPw64z3c8gYsjk3/YjoQSAhahOFfJqJ5S7rqKLyt3q6xceF8OOme
	 UlklLaKRhIBShH9I2+7JOQ6MD9gQEVvYOiHhdHHgyrRZOKXY3Vp0ygYp7aFCrVxnBWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=2tx7rvy4v5byzgket2avvb3ji4.protonmail2 header.b=PUWmLWPH;
	arc=none smtp.remote-ip=79.135.106.118
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A5606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 17:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=2tx7rvy4v5byzgket2avvb3ji4.protonmail2 header.b=PUWmLWPH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2tx7rvy4v5byzgket2avvb3ji4.protonmail2; t=1793985902;
	x=1794245102; bh=1s82DtUi5BpnupL9XEScyO90k0wwALTTjnLeoQTQWmA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PUWmLWPHstra1DDT7CZfmHHO7jEmOsJqmycWQTIKDwIyr2CL5YR/KOfg0vOnOj5gi
	 +2vLv5sptKsQZ118rP3K8MkRX522as4f9sc45+gjBn/d8Lp/jQbXlRZ8VB/2XJhIWF
	 b+bwE0TjOW3QFpQ4r+yRhbmOe42WFGXiP6ELn2TXf9ky/D4AuQdaI5G7sP4w4s0sfe
	 TRtTbZtN9tM1pNyS3mKc9TYFanijVfqR9Fo+ZY7ndOcSyMvpYAXlPuOhnq/WY5bdpy
	 GAVUbnuwJvgi3yujkH96h8rCOfNpl6oMxxvy8cMirG4/z7yaexzSRaZt1htnl8Y5x7
	 afrZ2mbFNN6Sg==
Date: Fri, 06 Nov 2026 17:24:57 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH v2 1/1] Bluetooth: reject invalid LE supervision timeout relationships
Message-ID: <20261106172404.591900-1-cochcoder@proton.me>
In-Reply-To: <20261106021809.631456-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me> <20261106021809.631456-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: be8047b76153ca8b8f8570c3c30b43523a775b8e
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

The LE parameter validator calculates an unsigned maximum latency by
subtracting one from a truncated quotient. If the quotient is zero,
this wraps and accepts invalid parameters. Exact quotient boundaries
also accept equality where the supervision timeout must be greater.

Compare the products directly after checking the field bounds. The
validated interval and latency limits keep the products within int.
This enforces the strict timeout relationship without division or
unsigned subtraction.

Sashiko identified the underflow while reviewing the soft interval
preference RFC. The bug is already present in its unpatched base; keep
this common-validator fix independent of that preference policy.

Fixes: 8757825b128e ("Bluetooth: hci_check_conn_params() check proper range=
")
Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Fix the pre-existing validator bug found during interval RFC review.
AI review: https://sashiko.dev/#/patchset/20261015181041.42873-1-cochcoder%=
40proton.me

v2:
- Add the introducing commit in Fixes, as requested by Luiz.
- Remove the blank line between attribution and human sign-off trailers.
- No source changes.

 include/net/bluetooth/hci_core.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index e33b15808..97ba716c0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2371,8 +2371,6 @@ static inline struct smp_irk *hci_get_irk(struct hci_=
dev *hdev,
 static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 =09=09=09=09=09u16 to_multiplier)
 {
-=09u16 max_latency;
-
 =09if (min > max) {
 =09=09BT_WARN("min %d > max %d", min, max);
 =09=09return -EINVAL;
@@ -2398,19 +2396,14 @@ static inline int hci_check_conn_params(u16 min, u1=
6 max, u16 latency,
 =09=09return -EINVAL;
 =09}
=20
-=09if (max >=3D to_multiplier * 8) {
-=09=09BT_WARN("max %d >=3D to_multiplier %d * 8", max, to_multiplier);
-=09=09return -EINVAL;
-=09}
-
-=09max_latency =3D (to_multiplier * 4 / max) - 1;
 =09if (latency > 499) {
 =09=09BT_WARN("latency %d > 499", latency);
 =09=09return -EINVAL;
 =09}
=20
-=09if (latency > max_latency) {
-=09=09BT_WARN("latency %d > max_latency %d", latency, max_latency);
+=09if ((latency + 1) * max >=3D to_multiplier * 4) {
+=09=09BT_WARN("latency %d, max %d and timeout %d are incompatible",
+=09=09=09latency, max, to_multiplier);
 =09=09return -EINVAL;
 =09}
=20

base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881

