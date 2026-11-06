Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931518;
	b=r/1EZXC/Lz+4NgpOccd+3lfRDiDtHih8vw/mdAy2vuCjXalZfTSEM1iiOu4NHYxGiU2M
	 7FKsjt3f4Ltr6hHogSmlRCymdw2JVbJDvkq1pDuhcPQE1RLfK3MWbw9mKLfbptzfcsqpF
	 BXYYf8S9FWb/fXh6ajwtHlAT9Om0JfwA7k5hcVj484SkTvIZq99PTM5EzyqwJYw4lw3TC
	 z/KagvsMIh+bBzUKmh9EqJpoPiCgwItF2avG0FJvf+2F5FS+WMu8wwP5y6foVdVnttGu2
	 PGS3Ab7yv6cTAU1z1f6hXEYuKQ3Von091b3YexgY5v57NY1IlKZYuzk8vf6oVQH2YKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931518;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=s9mYTm91eGDfuuManX45DwLeoHxJ64BDjGSH6sXiwKw=;
	b=HxJHeL6PNdzI5Ji+1iRNpj+weqzlEQQFVvToQTsKSdTQUuo4NARKyyrZOF5vuFLypCH+
	 NiWkkkKFOoi5RM9dtT2q5Hq45LlW9kPo5+YM4v4FSk0AOGxLNI+2iS7w0AYN0UdgRk7I9
	 XPMJ+xphGTDFY8IwIKE8FaQnwn/tEsjuA5pCNB4s3Zy20w0NGjkfytZRWgUcCqmUS5AWX
	 TM/NIjMm7ctlCG3E8ndD/6oBJp5oNcCB5Z3UaoWHG4A6rPKx9zYAw+IxMR/vsWEXdHP2P
	 L2U4kweameLafkWf36iObtEjLDxbjcdRgkEGo322ayD6Pl4i+F4BgF7crzmuYqL6L4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rd3WIGcX;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F702606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 02:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F702606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=rd3WIGcX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793931516; x=1794190716;
	bh=s9mYTm91eGDfuuManX45DwLeoHxJ64BDjGSH6sXiwKw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rd3WIGcXC0SaSuNDqT62+jQSP8A2cdZpkdmwv1+GMnUYDvfVKNvgfJAbKXc2keVds
	 GVksIpwq6Kvfw14TPx9C8a8G+yTWj9aayqa5WmgOW1GoNto3MypHjxr71xKh3XpktI
	 zcSQjZ9LoGBmAeu7REdZ5o6fh8FqbY6QQ7rzpKQtm/RfwZ6ImqsbHMwX/XiS9lxLDE
	 Ajyoo1CH6qtAFFbA/VRRODCavqvpe9Vy+/DzXDLewde1ZEIKa/SDv8zA0MzrOSv1Ss
	 fgcSf3Rjd0M6dSYLCymlbwmq6pa6jEO63ScUNjwt5kcAQjtWGPVXO6S+58HTHdUFZ0
	 jauwPwB8gVJaA==
Date: Fri, 06 Nov 2026 02:18:33 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH 1/1] Bluetooth: reject invalid LE supervision timeout relationships
Message-ID: <20261106021809.631456-1-cochcoder@proton.me>
In-Reply-To: <20261015181041.42873-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: cccb7fd61247527647f938117c1d4ec569f97d51
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

Assisted-by: LLM

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Fix the pre-existing validator bug found during interval RFC review.
AI review: https://sashiko.dev/#/patchset/20261015181041.42873-1-cochcoder%=
40proton.me

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

