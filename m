Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B19F137
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876697; cv=none; b=HlAfWYa4pVYeUihl/Uif9XSyl9j6QBQdS6NusCS1QJLk5y7UxHY66VO/D2GUrJgWEEf3C9uvU4j7tArFyAkcCVlXB9FYGuw+ynZeOUbrDVQzbIlMsB/IZzpK2IZ1aZj9e12fOFc9Y75KK+VKM13JJTb7U2+nlwUwGY4IxcWR69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876697; c=relaxed/simple;
	bh=j6R1n0Jqh5LLtJk7I1b+jusxRXkvl0Koih/b1M3y6Cw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzSQKH2rjZ+oVlcQqPyW1xJpywvv+EI6j/MGYP8+l87RKEUXzWuQxqHsYykTwGj6MIjmYXDfD9hq+RzlXRGeNthkDsrnaGdGk4rMOqC4IIPkEpicVh/kvnmvKOG/4Kb/9mANRCDgnUx++iEOVWYnb5cIl4KicekhLtvf104Zo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ov8J332t; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ov8J332t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762876688; x=1763135888;
	bh=j6R1n0Jqh5LLtJk7I1b+jusxRXkvl0Koih/b1M3y6Cw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ov8J332tGuCwKpAQCImn81nbLzN/AGOIi/kGoNq2vMXBFM9i+peWUZu++OoL0m3OG
	 XPViua1n3Ly68Y991BZmr4YAzV2cRSX+Peiva/6E9JC2NcLy4xMNHcfHvW2J7QrPQ3
	 y3GvHxdoOGbDAq9/vsnzebUuDRskTsXZniPaTv/YECUa8+boCWdAcQydDRIX7PSLyu
	 khnRZIiK516QlsGMMHj6g/dBr3M4IwnEiLQAFY9hrlJGOJ/UGe0OMbRaxTV2qFaiQS
	 FXLEBRKRzDNKRnbNokcVzeY5mkOhOYf3lmeh+Qf/1QOA4OdcD55ECZpnWXCATiIAz5
	 15zAI3LbBEiVg==
Date: Tue, 11 Nov 2025 15:58:03 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Alfred Wingate <parona@protonmail.com>
Cc: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH v2 BlueZ 2/3] build: Fix distcheck by hardcoding non absolute paths
Message-ID: <20251111155644.11675-3-parona@protonmail.com>
In-Reply-To: <20251111155644.11675-1-parona@protonmail.com>
References: <20251111155644.11675-1-parona@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 4fef8dff03f99b61514c110aac35a6d93d3df42d
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alfred Wingate <parona@protonmail.com>

Pkg-config gives out absolute paths that don't fare well with distcheck
that needs to install files into its own prefix.

Disable cups for distcheck as well so that only dbus needs this
handling.

You can learn more about this type of issue here.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1123963

See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>
---
 Makefile.am | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 708e2ff14..e8b31a564 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -744,6 +744,7 @@ endif
 EXTRA_DIST +=3D $(manual_pages) $(patsubst %.1,%.rst, \
 =09=09=09=09$(patsubst %.8,%.rst,$(manual_pages)))
=20
+# pkg-config gives absolute paths that do not work with distcheck that wan=
ts to use its own $(prefix)
 AM_DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles --enable-library \
 =09=09=09=09=09=09--enable-health \
 =09=09=09=09=09=09--enable-midi \
@@ -751,7 +752,13 @@ AM_DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles -=
-enable-library \
 =09=09=09=09=09=09--enable-mesh \
 =09=09=09=09=09=09--enable-btpclient \
 =09=09=09=09=09=09--disable-systemd \
-=09=09=09=09=09=09--disable-udev
+=09=09=09=09=09=09--disable-udev \
+=09=09=09=09=09=09--disable-cups \
+=09=09=09=09=09=09--with-dbusconfdir=3D$${dc_install_base}/$(DBUS_CONFDIR)=
 \
+=09=09=09=09=09=09--with-dbussystembusdir=3D$${dc_install_base}/$(DBUS_SYS=
TEMBUSDIR) \
+=09=09=09=09=09=09--with-dbussessionbusdir=3D$${dc_install_base}/$(DBUS_SE=
SSIONBUSDIR)
+
+
=20
 DISTCLEANFILES =3D $(pkgconfig_DATA) $(unit_tests) $(manual_pages)
=20
--=20
2.51.2


