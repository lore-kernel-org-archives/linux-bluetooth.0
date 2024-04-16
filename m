Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3168468
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245202; cv=none; b=d9m1m+CMf9utI1F5f0OJV1sy+15j9L98E6uUCVaBiXBTim478Uk4vg2FxXvrj10K9f1RbPvXHmjWY+3fI7tPvsgCNNowkRx69CK2dO2JGFOYjeRv3bPXoW2jQytyIHwP4vVvNJvpkw/RTpy48ae6w8kVcR4zG+wn1iSxvBNaT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245202; c=relaxed/simple;
	bh=NirOeKcMxQYuVwaG52VBorQgFOfeVW0zEq5cnf7Noew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqExXcTexNgkAd92+Oe9TbbUo9U2RzRUfKTKxV3Zr1Ht8OmsAaqbe7q8a3PCDcqSzqhnQjuvgTT90uanUZxbHaHN6Y8lDx4vxrc+bzBUg6noM0leufZ9jDs/wMvNS5zCk+AewFRK6mVyIkAhZIpyHzueK3KqMCeEF8v62b5YQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b=GU+hdbqH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=polynomial-c@gmx.de header.b="GU+hdbqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713245197; x=1713849997; i=polynomial-c@gmx.de;
	bh=TMcvITuF6Zs2czMxlMG13D25IKIKexFFMX2+F/jyMHE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GU+hdbqHMOCgNpM7F8TXeZ6Huh3q+RixCZQwxXbpNzDbooU95vx2hbJZMRQ2/AxX
	 0/Co6ShikKN7HasJP29RMU1bNwH0oA3EOqiv2iKavpv4XeIf9xGb4CIKyZDdIFdxO
	 4JEY4HUzCtFLCoXUBoX5tCTtT5UhqQMh52z5YiKvq7fBTsJtHt1t50h/X/FgIsqLq
	 jkOkfl10Wc6lZqiQMhaHmnB3Rh7yOCve/Yp9IAjSIQFDE7cU20JtBKWLZAhh8/rpd
	 ay5Sbvqu0ffTeKp2BuJdfaYfFKQDJxBkxCZFS2CYtX6TqHOv9Rap4PtuRuwMYv6pH
	 cQN6i5B42DGw2LhN0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([84.169.215.76]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1sQRyr2niu-00eqlG; Tue, 16
 Apr 2024 07:26:37 +0200
From: Lars Wendler <polynomial-c@gmx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Lars Wendler <polynomial-c@gmx.de>
Subject: [bluez/bluez] configure.ac: Fix --disable-cups
Date: Tue, 16 Apr 2024 07:26:04 +0200
Message-ID: <20240416052603.4373-2-polynomial-c@gmx.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzaG+8YY6BYzebUG0ZpTJJEsRrAg9lYTrQ870n5Nf25A78+PGxo
 wZ5Btb+O8pqcyESUtgcuck3yNJ2w5JzTMyH/V2WqbMKU6/wdmCaSw30W9pHyPEBgccvZdTO
 1t4SEHT5oyMamExtP69xhCBREfc7jbOkFtAYoikC+Fp5dqMDU1lsvAbdI+Ktnk0TDNk27k+
 XzULHgVtt7vk6YIW22x/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GeLWMCc3Dlw=;jsRzDT6O/rFK7BYfscLMm6q9DMM
 iIBQyVhfSQdgT+2MixTU784FeQsnSoKKGQvRc/NC1/TICG4eF0pIX3U6neVy+abHhkx7Rl1T8
 pygnyttc1sOg1i4su0VboXx/6mC7Ektyu0fSr15rzMfe400c+VpSr2M/xILtaZ3gc9Er1FNIx
 pArDv7WMAz5Cl/wGTqEM69tqZo6m8XhcIYMn/0IRCgr24u/mIbEX5k7Isk8sjM/N/arufoFWh
 DNCz5I7Uld4gi+NABuShi6jdRDU3KDVqLdD8W8B8XzibeJlO8y0wOUvXBlzc6HtCGWLyq0vcf
 iA0qocCxi05t8kIhOyHvi2BlBCW3kr5k5UbJKWR8w3H4xiIGtVz6w7OQnZSkT25P17o1c2e2+
 tZGvy9ba5NNKLwbLuZqBblzb1e5C93nGpS5TekIPbep99nLS0qsoaujOTi8IVHJOReVuDKEih
 ORSvhwzSbfmwk35UbGeldYPcqFBGDiZt/cpkgzOklWYKZXQ7J5rqb+e6MRVycGsoBTy5Pp6pT
 tDHAv8cLOhtdIRHaAL2wI+e7ntG5rAxtOM/y9lhuzpjM+VVpqZqwNTR4zqvw/hXhrCO8Vac9p
 J0YkrXGsBOaSMgpf6tSHNnUxhsaRTRx0xGngpm4niIXRxIhRbjaDVzAX10XZkPdkg9HS9V7ov
 bplAMhg6QGVh8CQDGiFdcmlDNizrJUUSN3mPmB51niQg+AFGLHZMVzKysbL3THNMhADZV9TEZ
 TOAcTveErpxZ+0uk5V4r0DOxJUrmqRqNbtFUiy/UQ0R1dgavvHnsCJkFgyZF4yLwDSkqNaamD
 TFbmsY10hngZ2zXydE33pW9nXrOHunRbEWR7vyTdFyuDw=

or else we get:
  configure: error: conditional "CUPS_SERVERBIN" was never defined.
  Usually this means the macro was only invoked conditionally.

Fixes: https://github.com/bluez/bluez/issues/773
=2D--
 configure.ac | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9ebc250cf..047ec1a7f 100644
=2D-- a/configure.ac
+++ b/configure.ac
@@ -249,12 +249,12 @@ AM_CONDITIONAL(CUPS, test "${enable_cups}" !=3D "no"=
)
 if (test "${enable_cups}" !=3D "no"); then
 	AC_MSG_CHECKING([cups directory])
 	cups_serverbin=3D`$PKG_CONFIG cups --variable=3Dcups_serverbin`
-	AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" !=3D "")
-	if (test "${cups_serverbin}" !=3D ""); then
-		AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
-	fi
 	AC_MSG_RESULT([${cups_serverbin}])
 fi
+AM_CONDITIONAL(CUPS_SERVERBIN, test "${cups_serverbin}" !=3D "")
+AS_IF([test "${cups_serverbin}" !=3D ""],[
+	AC_SUBST(CUPS_SERVERBIN, ${cups_serverbin})
+])

 AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=3D${enableval}])
=2D-
2.44.0

