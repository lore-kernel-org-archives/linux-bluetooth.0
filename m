Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055B58AA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636226; cv=none; b=GlA7o9LxP0GcmLk15/6hBqiWVhFdhbpObT/nDTzgdO4MPtx4vpdkbUI7zeA2sc+8O9siiPK1S0t+hkiJZlfQ30u+lmu53c/pI3EyKDW3a/g4npF64joGNM2SwStSDXGqZDn1uT4kQxmKkahVlBHEUGpun7Q3lpyM5jyWLxXpmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636226; c=relaxed/simple;
	bh=yD3tuob/aEPKOz3BDQYxitIG8AOd0L+GpLFuISCabNk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OTKX41ygDEB6ELld2oXT0W0mzKjslh37TgCLUPW+SJGNT9mu/IVBvoebpWy7Pe45EArsInNX9WXjD8fG2Er2LJF87PUIY3ScnbeGFeOi1NJX4JMRqHlgHSXtc8F7miABB1jDdOzbM1MsRHRFbMEE5pFDn8ajT2N9rZ3j1Srwplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev; spf=pass smtp.mailfrom=sandhuservices.dev; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandhuservices.dev
Date: Wed, 10 Jul 2024 18:30:08 +0000
To: linux-bluetooth@vger.kernel.org
From: Rahul Sandhu <rahul@sandhuservices.dev>
Cc: Rahul Sandhu <rahul@sandhuservices.dev>
Subject: [PATCH BlueZ v3] tools/hex2hcd: fix musl compatibility
Message-ID: <20240710183006.26549-1-rahul@sandhuservices.dev>
Feedback-ID: 82291650:user:proton
X-Pm-Message-ID: e1aa7773384caacebf2311d6b3accb442381f513
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
 tools/hex2hcd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index e6dca5a81..28f0e8be2 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -285,6 +285,13 @@ static void ver_parse_file(const char *pathname)
 =09prev->next =3D ver;
 }
=20
+static const char *helper_basename(const char *path)
+{
+=09const char *base =3D strrchr(path, '/');
+
+=09return base ? base + 1 : path;
+}
+
 static void ver_parse_entry(const char *pathname)
 {
 =09struct stat st;
@@ -302,7 +309,7 @@ static void ver_parse_entry(const char *pathname)
 =09}
=20
 =09if (S_ISREG(st.st_mode)) {
-=09=09ver_parse_file(basename(pathname));
+=09=09ver_parse_file(helper_basename(pathname));
 =09=09goto done;
 =09}
=20
--=20
2.45.2


