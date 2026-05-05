Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35D3D6695
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971481; cv=none; b=NZ5hIF24ZLCS9z96zfodFZrEcCOA7toJ+kZpl2L2D9cE/pGkg8dOfiemYIUsE1223LBUGULtx3ccz7eBSLVuxzGqQGKlP0sgxmJWf8ObrdR+SEJl3pxK9dZnDS2PjmyQHKyqU//dCTemhF4hAU5XvI6M2pdB4n6r9tdJqQCJ2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971481; c=relaxed/simple;
	bh=SWP8MNCwwfT5kWuCHx7j60zFOIhCXyw7WNlU6hOod68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeG/S6XtkpLww5eB/f4SrIl/PP83CD/+eV21Ik5vAZ43w0NnpRZoeik02ttYWdazysRTHB5JbRZjghMq3/S3IlwY1fdSFgc3ay1xKYotI5qepYhsUKpbOI4tXs145CYyR6oyyvVuKrEhMGXNb8R5xS34g4hNWzh7IqJ0LVITbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 547953EBD5
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 11/16] build: Only build profiles if the daemon is built
Date: Tue,  5 May 2026 10:45:17 +0200
Message-ID: <20260505085741.2497401-12-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqtVbT0wpNaWEQh2iQMp4gPH9wZex4ya2OtxeG0hDMnVWlJUUb+45phVPIH7LvhdrbTLJJsnRP/xO9B3RkPCqahVRLMAy24KOMxeuNAiwP11KcZHnlh4JKnwBJlH7TKtG5BZtkP+73jEjpTHnTSg8yVMr/v6kDdEx6l3Pbi6lN/A91o1bgJW2lNfKQMl8DF39WtzHXy1rrgWAAtDsCdg2z2yLghhsQvErb7njikFAwnRpCBeoMAd2x/tkJCgJPe0dhtLy0GH5Ya/yzgTenUnkc/ngWvefggMGOjPKUx0+dOTfCi5/Z64c0MGLazxFjHJnijVHLS4ErXFVsAWQg8EBWQA

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 391cba6962bb..d67abfe32430 100644
--- a/meson.build
+++ b/meson.build
@@ -269,7 +269,9 @@ subdir('gdbus')
 subdir('attrib')
 subdir('btio')
 subdir('plugins')
-subdir('profiles')
+if get_option('daemon').enabled()
+  subdir('profiles')
+endif
 subdir('src')
 subdir('client')
 if get_option('monitor').allowed()
-- 
2.54.0

