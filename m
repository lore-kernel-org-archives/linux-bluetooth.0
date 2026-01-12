Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792B34DB50
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215100; cv=none; b=cYnNc3nTRiLZqfnDRnoDF39enqS73wCj76xOp225csZnV3dFQYT5I4rV5fXjRprLq0YigeAdePh4ILIKXFK8Al6dIFTkdiKCYFhjc9j3AkPf+uWGYjqsnzcec7m1+HKQ8W0GoQGRdvUarnUbQG84i355PVeo6gijGjqotQJwxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215100; c=relaxed/simple;
	bh=UnH0e+LMQ0FXWSBKQIbLBDyX/rIhqOW/FDWaItuClac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BtH3BjGWKlnibbvujvaFC/wbDKnBYWvz8Gd4LkGUfo/kdGbyt29ehIBSJ/f0plANTjkwGonm8NsStPKdjaU/obfRPk6xB8b7V6JzP5CkyJbwcHKKs90oClS4iGXj/GkrmC2QmGsarfUIJKkDde+F1JCl5f5MP6FlEDTQmLfNay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82A644329B
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 10:51:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Mon, 12 Jan 2026 11:51:13 +0100
Message-ID: <20260112105127.3664608-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeekvdetieeggeefvdeluedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/btusb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ed3883ab8ee..539e93227b5c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4627,10 +4627,8 @@ static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
 	.disconnect	= btusb_disconnect,
-#ifdef CONFIG_PM
-	.suspend	= btusb_suspend,
-	.resume		= btusb_resume,
-#endif
+	.suspend	= pm_ptr(btusb_suspend),
+	.resume		= pm_ptr(btusb_resume),
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
-- 
2.52.0

