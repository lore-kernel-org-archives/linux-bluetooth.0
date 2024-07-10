Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260ABE4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630514; cv=none; b=IhDbCmyVDfWnQpxDzbGfhpzxtdP+d1QlvhqW2v3pKtNb/e7h09u4xrFxaQ1fbNvVaaFjrB6VnOQrxhrh0pTuzeHBfkgOYrwvBOlmOqJUg4yDScS6zjmXT7JzQLiBoEHq4uzRJlMEBu+IbDf0RP2Y3pputUnVGWoUKAebCkGiZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630514; c=relaxed/simple;
	bh=cr52yorIwSl4o/IMzFiGu3l079UKMSR7eso8mCaCC2A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jKOuk1oD2oU73CPzKXensV1Txfsz9QQjbTSxJs9rgzTbiNHhMnTlVjkZGdjVxt3GzdUUoO/IkL1WJJInfE8ATZcfKPRVPGCwjNs8f8jwu6w4xXW4XEPEvzD8jcCRyfPXD48cXV7ir3n2i/P5tWhY0aSwYdaS41jcEl7F2Ma9DXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev; spf=pass smtp.mailfrom=sandhuservices.dev; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandhuservices.dev
Date: Wed, 10 Jul 2024 16:54:56 +0000
To: linux-bluetooth@vger.kernel.org
From: Rahul Sandhu <rahul@sandhuservices.dev>
Cc: Rahul Sandhu <rahul@sandhuservices.dev>
Subject: [PATCH BlueZ] tools/hex2hcd: fix musl compatibility
Message-ID: <20240710165459.26813-1-rahul@sandhuservices.dev>
Feedback-ID: 82291650:user:proton
X-Pm-Message-ID: 31d4736737632338e7809a09f47cb93356ad84d9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The call to basename() relies on a GNU extension
to take a const char * vs a char *. Let's define
a trivial helper function to ensure compatibility
with musl.

Downstream gentoo bug: https://bugs.gentoo.org/926344
Fixes: #843
---
 tools/hex2hcd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index 42c95b759..28f0e8be2 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -285,9 +285,11 @@ static void ver_parse_file(const char *pathname)
 =09prev->next =3D ver;
 }
=20
-static const char *helper_basename(const char *path) {
-  const char *base =3D strrchr(path, '/');
-  return base ? base + 1 : path;
+static const char *helper_basename(const char *path)
+{
+=09const char *base =3D strrchr(path, '/');
+
+=09return base ? base + 1 : path;
 }
=20
 static void ver_parse_entry(const char *pathname)
--=20
2.45.2


