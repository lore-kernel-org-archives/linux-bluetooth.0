Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36966261B9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196027; cv=none; b=XofMFQ0QrWW4lY09lxjJxfQfFmgIq0Qxk/PdtYPBr2X7sMVsQmS0bAI/IzHxIPzDmXd4ewGTgByAXCjUmLIBPo3y4RE3Nlmd1YkTgNhhZMccdPMG+FGBqZ3GdaMq/sIwWeGB/dB83RYm4OkYYbLZSevCQsz2Z26S6oYt6vWrkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196027; c=relaxed/simple;
	bh=7Ha4RsKCzic/0CVHIXdI3T6AXn+YwJjbegOcXiS3jcY=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/xFFOvQz0KmEVXEDxFrVQxoN8+kugapSoEgTbIfOhIfa18WtbN2fVF99ANHT1NxG16QPQKkGhLoWJqLe9W8PmcJ0NbYa0bl1hukyNUAuRxRvHJtUuBkyZYlgpc2paSGpXsyCsbJwM3/34URsvH7iuEsikPWHYRQpWFIQ7LFkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=EwhmWiAM; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EwhmWiAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761196023; x=1761455223;
	bh=7Ha4RsKCzic/0CVHIXdI3T6AXn+YwJjbegOcXiS3jcY=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EwhmWiAMN6fWHE6axYDrj/M7COu0llbXglEZHe1TUGfiXh+rNW6P3gYx9yviYYYjp
	 uJt/cUH02ifd1J6fcYGPzK7fkbhnf2hNF5jUy0T5eq4zkiTKD67yB6+/8697N78r+K
	 9k2qeN9D4BJ+9JDloQRrmu09NHF4YIPqpDqY61pCJ3DjPP5gGEUv6NaO1T1stV1X3Z
	 yNttM6PkcJC7oDx02KXhpNWxHVcQTBkRG1vzHxu5RPbIERaZth4koPUNCU2v6iRHCV
	 LQjmYfzHtALYlUnu1kvdyrufaai4IuMYKarXLLbPchnXVy4OyiEWW0MevrMmzHU7D/
	 P0xkVA+y7IULQ==
Date: Thu, 23 Oct 2025 05:06:58 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH BlueZ 3/3] build: obexd: Revert "Fix make distcheck"
Message-ID: <VTzPwTDkDfGbR57wsxEbuiXQ6FOs2G1Zs7h3sRt1rF8ndowLCRamofHVH4BLu5aBj_K_WeM8mYV8SA4rbeX7_FuXcvTw8nTko9mdtIDjvf0=@protonmail.com>
In-Reply-To: <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com>
References: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com> <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com> <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 960817c61050169f8db0c643fe13f92a9ae69560
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bug: https://github.com/bluez/bluez/issues/806
Reverts: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>
---
 Makefile.obexd | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index b59cfaf8f..7ad74e128 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -4,9 +4,6 @@ if OBEX
 if SYSTEMD
 systemduserunit_DATA +=3D obexd/src/obex.service
=20
-dbussessionbusdir =3D $(DBUS_SESSIONBUSDIR)
-dbussessionbus_DATA =3D obexd/src/org.bluez.obex.service
-
 obexd-add-service-symlink:
 =09$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez=
.obex.service
=20
@@ -17,6 +14,10 @@ obexd-add-service-symlink:
 obexd-remove-service-symlink:
 endif
=20
+dbussessionbusdir =3D $(DBUS_SESSIONBUSDIR)
+dbussessionbus_DATA =3D obexd/src/org.bluez.obex.service
+
+
 obex_plugindir =3D $(libdir)/obex/plugins
=20
 obexd_builtin_modules =3D
--=20
2.51.1

