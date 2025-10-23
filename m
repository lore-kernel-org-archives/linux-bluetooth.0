Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152E25C81E
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195969; cv=none; b=pPgwwBq36JG9Gc0D/zphPFJ7eSf20M/UbH0l5POyzjkyLNAXHVMRElxKrVOErfG47S7JF+d7St9UZin4lg0/ocVMG5eGUbrMmqVrg3kl+c5/Nyu9Q8w1h0Ho1eTS/3ovKSTu+qYScdJC1CPMDiYPztpw1U7ENHIffIZVGtYuTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195969; c=relaxed/simple;
	bh=8aZCnJC79Zbs0wRxCpBxJi79bsY+c/pYDPxBwc65XN0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/W7d0O4cEDLckXo9Dh+eNDhMN7gzdRRpZN53IKOCL6vQYSaqwS7W10q2Y/WQ4RO4j9cv4qQV9lcPW9aGRabzLl+6TOLAMAL4tTfX8ItTIh7Vr6xWEhGJTcc2Ccph5YaoDrcCLipPX6d/8ho+KRDT+kBwBQ9NcTn1I7nI9ksedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=yfv/Gcjz; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yfv/Gcjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761195954; x=1761455154;
	bh=T3a9c6889dd6UtobQkkwgBijuv0S2o1ZhAywF8CR/y4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=yfv/GcjzQwCjAyPlZXK45km+JRLC6IFOMv4wP/pkMZZPHLgcPn+seOgA2a3mSeVJo
	 Xyg7buZeiR+KjjuA+Qh9luMQ9Yx9PUzfnq57yXmFTRLOK2Vz6XKRoT6sgS3bDILO9n
	 0uLe98IvwgyGw1kmc/2kDrWStWaIdQtg3IyB369MPtxc45B3Dy/rEQbRAFzhYYZc20
	 uuTRrNS1TLKUrKCxFL5+1SBOiQZ3IoZfioFmKi8vCSA77JsdfZF0N11QBAogqm3JmF
	 0KQ5jRmRZ8/3AJyXQXD8KHwozOQIjEdv8b8EJlNlnIkOoYUi3Bnp+7xYiWt5cyevlh
	 H/6CWZu/Xh7CA==
Date: Thu, 23 Oct 2025 05:05:51 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alfred Wingate <parona@protonmail.com>
Subject: [PATCH BlueZ 1/3] build: Support setting the cups_serverbin directory
Message-ID: <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
In-Reply-To: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
References: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: ea890d9ba75a4322ed5523d5fdda9b0e86b602c1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This will be needed in the follow up change that tries to fix distcheck
properly.

Signed-off-by: Alfred Wingate <parona@protonmail.com>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ebb01c4ae..adb089e91 100644
--- a/configure.ac
+++ b/configure.ac
@@ -264,7 +264,9 @@ AC_SUBST(UDEV_DIR, [${path_udevdir}])
 AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=3D${enableva=
l}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" !=3D "no")
-if (test "${enable_cups}" !=3D "no"); then
+AC_ARG_WITH([cups_serverbin], AS_HELP_STRING([--with-cups_serverbin=3DDIR]=
,
+=09=09=09[path to cups server binary directory]), [cups_serverbin=3D${with=
val}])
+if (test "${enable_cups}" !=3D "no" && test -z "${cups_serverbin}"); then
 =09AC_MSG_CHECKING([cups directory])
 =09cups_serverbin=3D`$PKG_CONFIG cups --variable=3Dcups_serverbin`
 =09AC_MSG_RESULT([${cups_serverbin}])
--=20
2.51.1

