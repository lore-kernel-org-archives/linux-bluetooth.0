Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB03C1FCA
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929647; cv=none; b=t8jtS4IDExfnhlNcmDGUJhmHwcTuz4SYUP3c7h3AI34RYHOUbsG5Wu40Y/xAoDdzk0AYdgmf+TJOpBPa6gVKg+25/+e/I9xyYo+67YKW8LOuhkU7+i5z/iITw5ANsiOvJxIEP1bOyLJ1j9mZ3cHiojGl6aQjpvQ5cMm2/oL9Tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929647; c=relaxed/simple;
	bh=yeVegc93DWAhv3e9oz0QVH3WOQ2UJHUUF6TETtDtOp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbrrGwt+uNEGSvNU/Kq0GI665rzw8UKOd5tepJsjyOfq8ft/9exuWDGezYsWmiVM5lx+WOTZuSu4bjZId3AugFlbVEr/u8iecqA63qY9BEm13ow5p6hWSYP2tuOIzKJWT3Z7jUiXQkJJdaRKvW/D/jL4VAwea2R3sRjsp5xoIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD82244380
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:20:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 3/7] doc: Port security-bugs.txt to RST
Date: Tue, 20 Jan 2026 18:18:48 +0100
Message-ID: <20260120172034.3463151-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120172034.3463151-1-hadess@hadess.net>
References: <20260120172034.3463151-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffffekvddvgeegfeektddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

---
 doc/{security-bugs.txt => security-bugs.rst} | 1 +
 1 file changed, 1 insertion(+)
 rename doc/{security-bugs.txt => security-bugs.rst} (99%)

diff --git a/doc/security-bugs.txt b/doc/security-bugs.rst
similarity index 99%
rename from doc/security-bugs.txt
rename to doc/security-bugs.rst
index bd4b0d68f309..0dcacfbd9eac 100644
--- a/doc/security-bugs.txt
+++ b/doc/security-bugs.rst
@@ -1,3 +1,4 @@
+=============
 Security bugs
 =============
 
-- 
2.52.0

