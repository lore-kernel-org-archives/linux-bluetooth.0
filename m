Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD37344D8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638559; cv=none; b=LWQQGQNIVCxfjpvbZHd7RU5H8+H+FiYIrpEKohby+nXfjL+y5u1bq249ySzRmF2gaCp1hOGw33O47hVL3Wek2Nu/i5q+/QDb30SjO2rtSjkIx4ZSm5N1Q93jIXxInqULeMWB2CrBZDcI3nd72p6Unb3L5EQpRHNhXhNgcGzr67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638559; c=relaxed/simple;
	bh=/RdqJn208wyrK9zcH/5kdhZ8GKzz1WS+3EBBibI/IgQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5h8YJTV1Og6nKrkIG8RRd2kLaCIX8sthuEyoEFEMtV4TPG2wAUSJZ5TxpapeeIZhu+g81sbdsNAnDYt9pwmXImJ5Iz71yNIlkNIwp9ZCBGpTU9adyXW2FwzC944FSPY1HsNucOcU5KqQ4sdiBRiKpU8s7ySBjyAsL6BFj/7ltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B34354440A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:47 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 12/16] build: Only build gdbus library if there is a user
Date: Wed, 28 Jan 2026 23:12:02 +0100
Message-ID: <20260128221536.2319084-13-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128221536.2319084-1-hadess@hadess.net>
References: <20260128221536.2319084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeufeegfeehgeeggedttedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ab21fd80e76e..6d95cee1cd3c 100644
--- a/meson.build
+++ b/meson.build
@@ -247,7 +247,9 @@ configure_file(
 )
 
 subdir('lib')
-subdir('gdbus')
+if not get_option('tools').disabled() or get_option('client').enabled() or get_option('obex').enabled() or not get_option('tests').disabled() or not get_option('daemon').disabled()
+  subdir('gdbus')
+endif
 subdir('attrib')
 subdir('btio')
 subdir('plugins')
-- 
2.52.0

