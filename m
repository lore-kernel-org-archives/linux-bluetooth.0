Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A22D4F6
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920113; cv=none; b=Dvghv1x6r4dRqVDOslC6LKNmumxuP78exoVH/Hh9GSCoIQ4UQa9Ybwe9xVg+ynC54kEGavWNSZ9ZcZVIG+w+U/ohu+Fx7v6Ajh4U6unFtQJoK627QwAoPdfALL5SNXwt5PMwAvkYgHQha5GTHM2dQucePqoIzf1Z8St1ILhYRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920113; c=relaxed/simple;
	bh=AX+ACQCCZBrBmQhvFvUdzncelacVxWgniZ3vnMtpV5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuBUx4249XC1/atLudSNQLfscKeyNUrxWRcz4WpiU/lqboXO4ONNWXeQA1/iDEV431pxjMPYhyvJPEajm2j2+Mu6VFkuyo9Q1w4IhqOXEig8o8NFcZpZQ4L9O5QVUrzUR4wln7CD6+gdEv+oK/nuAWwnjM6XBANyNZrE6NuucE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7F4543B28
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 10/10] build: Add License field to pkg-config file
Date: Wed,  8 Oct 2025 12:40:25 +0200
Message-ID: <20251008104132.2206963-11-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008104132.2206963-1-hadess@hadess.net>
References: <20251008104132.2206963-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

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
index c429864b9c8b..05efc4141d97 100644
--- a/meson.build
+++ b/meson.build
@@ -3,7 +3,7 @@ project(
   'bluez', 'c',
   version: '5.83',
   license: 'LGPL-2.1-or-later AND GPL-2.0-or-later',
-  meson_version: '>= 1.3.0'
+  meson_version: '>= 1.9.0'
 )
 
 datadir = get_option('datadir')
-- 
2.51.0

