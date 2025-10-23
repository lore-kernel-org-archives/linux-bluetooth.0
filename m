Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F60258EE1
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196003; cv=none; b=tNEThPUSETj+5g2a187Sb0zMs6pCPKFOd5bk2LWS+ToveYI0FOxMsNGR3rdhQBCNU9AC5VZ2bPhkIzeg2WbM9LHckhSgzH+pD9hlxIfA6zo0pCMDkZ55Ht9KarNa/3MC0xYLvQRJTcmGKWBxnhB0jtBOeJeDfehMj+ubE8ytpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196003; c=relaxed/simple;
	bh=XV/RJsuOcbh54As04dUPu7Q/y3cxqU1DcOfjNfX/I7k=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggqJLmgh/6K6BgwQQUcW5lCVs6WoWk+A2iB2B0zhBSQppr7vvaBFTI2Y8ch/LxH4thfI8zSTNl4U2P9JUYKvuyuY81dhkDeX26C4Yct9RZojg0gR0r31ZBUvpG4ubebnpEUTxZjcfH5o+BgzeBkR1tq7N73ZBZLkA2XNGwXTMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FBBjqTF8; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FBBjqTF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761195993; x=1761455193;
	bh=a51Z4JH4NrdNbn3ItSyUilY9UJoWbLBXEAiFTLmiepU=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FBBjqTF808KWLt3uEKWhG/FD0cA3d4twLC4KGLfxn23ArirQLHL3bUdpmJh3bzZo4
	 bhePkRUBhS1GxwyDFjAL8g/UcsmrUysH8oMkDYF1VcKspR5wG1fCR1BzwcNUXdBx0R
	 HJfLYKeY1yr6Byuv/RTrHl7xkhVtrqMWDKPVlq5c+rt2dHK9ujurKDb2M+NkxhC1+e
	 BwHDBGL0ML8m/mmmwKjh7fkB+juDdgLndcsWwFIf23r3GHOWrXRORuHy0VOgo4VihE
	 2aL6tJAhDz6AmoyUGb6GMiT/oAl9LF6/7cIvz8LzKJ/UwJwwoOWO5HhzP4TV+L2tYM
	 DnMaKTyKoEQdA==
Date: Thu, 23 Oct 2025 05:06:28 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH BlueZ 2/3] build: Fix distcheck by hardcoding non absolute paths
Message-ID: <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com>
In-Reply-To: <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
References: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com> <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 1480d21882a927cf780ce1b7b1158756cfed50c0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To make sure it doesn't fail lets hardcode every path that could come
from pkg-config.
(I managed to hit issues from dbus **and** cups as I have them installed)

You can learn more about this type of issue here.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1123963

See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>
---
 Makefile.am | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 94f625db4..3e25c01dc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,6 +2,14 @@
 AM_MAKEFLAGS =3D --no-print-directory
 AM_CPPFLAGS =3D
=20
+# pkg-config gives absolute paths that do not work with distcheck that wan=
ts to use its own $(prefix)
+AM_DISTCHECK_CONFIGURE_FLAGS =3D --with-dbusconfdir=3D$${dc_install_base}/=
usr/share \
+=09=09=09       --with-dbussystembusdir=3D$${dc_install_base}/usr/share/db=
us-1/system-services \
+=09=09=09       --with-dbussessionbusdir=3D$${dc_install_base}/usr/share/d=
bus-1/services \
+=09=09=09       --with-systemdsystemunitdir=3D$${dc_install_base}/usr/lib/=
systemd/system \
+=09=09=09       --with-systemduserunitdir=3D$${dc_install_base}/usr/lib/sy=
stemd/user \
+=09=09=09       --with-cups_serverbin=3D$${dc_install_base}/usr/libexec/cu=
ps
+
 lib_LTLIBRARIES =3D
=20
 noinst_LIBRARIES =3D
--=20
2.51.1

