Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701382BE63D
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271423; cv=none; b=WFCeeq7Sb0AdslbK8e27dIP+rd6d0E6UwWv7glLOR67pqIpAXjhyfwnIP/YZbJdfNe9vbvHoBfQGK7qXEXfG1DCePCsiCLvmWErS39DbWs5TdzEpearn5dTbnJQbACaSSiwwUX9DZvEOn/dcgcFnwXtLSni9aLTIQgBeZSrO58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271423; c=relaxed/simple;
	bh=6cPDwmbXb+blwSJD2ID6J03/nEuAFQ1G4glGjfXZVss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jKZWMtxx5hoVy4cP4BsLOMAdjIZ6CH2ut8W/6VaPSenc22UE/jLwglzZwEtUgicsq2nWl+idiw4uSqlDGxahtytw93G4jKy8AQpUzpCQL8kyY2sq4wJPbahfEdiYZMRZBVl5wgT+i1kJ86hRA120RxW8/XuGnrDqboAE7+2dl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11B4C1FDA2
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:43:32 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc: Fix typo in PreferredBearer property
Date: Fri, 19 Sep 2025 10:43:21 +0200
Message-ID: <20250919084324.2799981-1-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffelueffjedvueefffdvjeejvdehkefgledtjefhiedtteetgfejvdeuvdfhjeeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

---
 doc/org.bluez.Device.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 61c394dd2d0b..593ff06643f3 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -418,7 +418,7 @@ Indicate the preferred bearer when initiating a connection, only available for
 dual-mode devices.
 
 When changing from "bredr" to "le" the device will be removed from the
-'auto-connect' list so it won't automatically be connected when adverting.
+'auto-connect' list so it won't automatically be connected when advertising.
 
 Note: Changes only take effect when the device is disconnected.
 
-- 
2.51.0

