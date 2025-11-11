Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D919F137
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876712; cv=none; b=MSHj0J1YMckgEbEFkgQ8cn06IgVebNB7iFu8FRPFAuAcdUM8vWBjTU1MtpCpoRrDaRdK7IL9RKqQQJdu+i1TGD4K+FXOaPGgzlTFHiiHUIHDL0wUkdRtUgG6aII48OEzbgmKnSF690YH7ZTqiD3HqPAiQn9S0NFe39BoBmAOFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876712; c=relaxed/simple;
	bh=U4mKTwfeePLEN6AzhUBxHh5rQjK1lxVBTI8Cel8JS9I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhkQ5Z6bdhyx+bEBzl2YAT4MM/hTjyyYzEYKwKadLLzDV53vW7fXuNPt0NOIGPAMK5lKWSj499wpoDhUc/EL0Rv5/hvJeLv0KbFBRlr1OniGJqG/8nrHtnlziXQqTdDQJ0MCbZTfPD30WoIqVIOCQ5qYpyTl+hMa50R8Mv5sIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=P9scmfE6; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="P9scmfE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762876703; x=1763135903;
	bh=U4mKTwfeePLEN6AzhUBxHh5rQjK1lxVBTI8Cel8JS9I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P9scmfE6T/aQHZe/OZ7hTHcXyXtcsjlu6vvZ6akaKfo/qz7yLpX6Cfq7jS86uMagx
	 b3aOtQwOAhGEduYka0Qg7SWZTnTFq8O01shyTEaXg4fAtbYBM2t9SKlSbas3v9LilE
	 DVdQLZYsGHbArmCXL9U9tsj5FOlLNfB4PfkzLw/eJ0gJmXMlrw+YjUs6s/MUZidG8v
	 6tOq5m/jHEjiASQW+4cXfNT7xIX+KSa1KaDe8TAKL2PsbmdV5HFeLPQDgFZSKJcgt3
	 Se/6JCeF/iZmPOTBKPk5d0RMjRpw35ZplLu/463y9Fp8nTP5a3rUO/p544A+yfolTA
	 fhghzjfsJ1q1w==
Date: Tue, 11 Nov 2025 15:58:19 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Alfred Wingate <parona@protonmail.com>
Cc: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH v2 BlueZ 3/3] build: obexd: Revert "Fix make distcheck"
Message-ID: <20251111155644.11675-4-parona@protonmail.com>
In-Reply-To: <20251111155644.11675-1-parona@protonmail.com>
References: <20251111155644.11675-1-parona@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 40ea1bdac49398e080b8a0676825769c480344bd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alfred Wingate <parona@protonmail.com>

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
2.51.2


