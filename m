Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE792DC794
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006176; cv=none; b=iIN9LwsaGt8Ygx/bsmSabo83FT+7o3rs/uJpUdfFKn7F0vEwJVHkTIES2HFjK7itg1Zel8SS5jVBQMg7sBhU5YdF57nEnZCfr/tHoXF4yD5wfA/Tprf/D4hbgwy/Ym2qbilUHK7VUucfdtVnk1vISzSUSx/ilcEYMyDk3QvTERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006176; c=relaxed/simple;
	bh=NI0/wdkSoCr214x3B6s9vzTmgcxzWxZLETrgjl6/G/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvF3wvCE0NIRxjz5gOaJfWUthK+HiTo6Vg5X/flWlCgKO4bCI7wdldY0NIp7J2Ei2NOE1Ev4ZIVUhxhCGqAuXYiAsbtjM9xwOqZIKShcrGP4rTE+DBnjRWhK2R1y46okmScQS4cNhnrQa5tfyzMb+Mx7tcmf50/B7sc/ooIauSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC46C434EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:06 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 10/10] build: Add License field to pkg-config file
Date: Thu,  9 Oct 2025 12:33:33 +0200
Message-ID: <20251009103554.2417973-11-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009103554.2417973-1-hadess@hadess.net>
References: <20251009103554.2417973-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And require a much newer version of meson.
---
 lib/meson.build | 1 +
 meson.build     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/meson.build b/lib/meson.build
index aac809ab1c70..a0bc18bc0654 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -39,6 +39,7 @@ if get_option('library').enabled()
     description: 'Bluetooth protocol stack for Linux',
     version: meson.project_version(),
     libraries: lib_bluetooth,
+    license: 'GPL-2.0-or-later'
   )
 endif
 
diff --git a/meson.build b/meson.build
index b5f9be1532fa..a4826dba28fb 100644
--- a/meson.build
+++ b/meson.build
@@ -3,7 +3,7 @@ project(
   'bluez', 'c',
   version: '5.84',
   license: 'LGPL-2.1-or-later AND GPL-2.0-or-later',
-  meson_version: '>= 1.3.0'
+  meson_version: '>= 1.9.0'
 )
 
 datadir = get_option('datadir')
-- 
2.51.0

