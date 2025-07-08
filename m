Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C201C6FEC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970271; cv=none; b=RgVukksfpcT7WmDO+YLW64XOs8ppmtbA73SLV0YjmV/TKhO9MO9hcoZcwm3pbsZHeCnUT3v9JjpNDFICIytwKmtmtRA0a8D83SOMx59wCZpxzjXTEh/a9Ea9jcyS0Dq7vvQ8xz52rm95pSaNOWUn6URMVQsWgUl28xSDLXq8150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970271; c=relaxed/simple;
	bh=RI+eMTklTt67rNKD7pimOPp+LPpegLecpooGmdextrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cTp9AM0TLDbL99Pcn1hRG687A4q1vE1oTGTkdPkpziM0NEVWYu2hOKewa8FemQeF8O/cItYOSHI8WULlWaSvOI9TFZEWFHTvaB35ky0bH4z9VYHaukDqdxin5wE3q5/wXD3bZt/GVe5kKq34vg7BpVJw3RBaK5LReomK+2HDcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CD1543228
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:24:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] build: Remove deleted configure option
Date: Tue,  8 Jul 2025 12:24:08 +0200
Message-ID: <20250708102418.1863891-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffelueffjedvueefffdvjeejvdehkefgledtjefhiedtteetgfejvdeuvdfhjeeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

Remove this option now that that the supporting code has been
removed, fixes a configure warning:
configure: WARNING: unrecognized options: --enable-android

Fixes: f0512114aacf ("Remove android support")
---
 bootstrap-configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 1c26909b9212..f89759bd2a78 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -20,7 +20,6 @@ fi
 		--enable-nfc \
 		--enable-sap \
 		--enable-health \
-		--enable-android \
 		--enable-sixaxis \
 		--enable-hid2hci \
 		--enable-midi \
-- 
2.50.0

