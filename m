Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B231E871
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614613; cv=none; b=pn6HTAdyTBh0uuJc7Ibg9Vb3kAImf6pjBjgeY6RguE/21I9rzx45JSRLFV5duHamt6GazCYDusCe2ST/sAwz1sp+0+vQgvj0oU61tkha88BkBo4rHrUPnqRiAqFUp6acALdF7JykXBvPGLz8nOTvVDANE8Nb2f0ZSn8NJzsOGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614613; c=relaxed/simple;
	bh=wOJt7BsIInf81sHOpJriDhBinELtxiJ+orKYomu64Vk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W5Lsb7DHqUulTSERR33537+WcAzhN25xcu7y3TTQHc+bKKL3CcZ2dUTmC0VaV33uTCiHnFUE+D5xzP/2PZqJ1cDHXdCSbpbYtP4EuSd5img3pvr2dxA2RzvKQYW0d4vhW4bpxmhyabK2DyUpN4LoEuO6UVFy5Xi9pyp6tlgGWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev; spf=pass smtp.mailfrom=sandhuservices.dev; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandhuservices.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandhuservices.dev
Date: Wed, 10 Jul 2024 12:30:00 +0000
To: linux-bluetooth@vger.kernel.org
From: Rahul Sandhu <rahul@sandhuservices.dev>
Cc: Rahul Sandhu <rahul@sandhuservices.dev>
Subject: [PATCH] tools/hex2hcd: fix musl compatibility
Message-ID: <20240710123002.5639-1-rahul@sandhuservices.dev>
Feedback-ID: 82291650:user:proton
X-Pm-Message-ID: 40db816fc8017c6b18c4d5eacd1836234e6f7d89
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
 tools/hex2hcd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index e6dca5a81..42c95b759 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -285,6 +285,11 @@ static void ver_parse_file(const char *pathname)
 =09prev->next =3D ver;
 }
=20
+static const char *helper_basename(const char *path) {
+  const char *base =3D strrchr(path, '/');
+  return base ? base + 1 : path;
+}
+
 static void ver_parse_entry(const char *pathname)
 {
 =09struct stat st;
@@ -302,7 +307,7 @@ static void ver_parse_entry(const char *pathname)
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


