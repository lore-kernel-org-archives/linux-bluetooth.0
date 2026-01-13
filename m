Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B83806DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294901; cv=none; b=p1QQhjLvSQE07IiCKVJPZBLuXGst/JMyJKEv6uyj7ucrjUjY92La9dhfLDgCtwcgKWBVXX8++jw33GcDwiIqahGbNLnDDEG8LcpmsKqhnZHbfHOIjgbRwmEAmrGd/ACRzJ4ogi26kd+lZ8lKgzSRwdpJscPlFPfCGOXR0CNToKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294901; c=relaxed/simple;
	bh=qjMnlfhq0oTiCuqXubHqHG6/xVy9BYXTo/jajCWcJpM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Gg5JPJgDqm+Ynz0PMS1v9kCMN8zW4pg/j6N7tMlL4BryxKKr1TLQ2jWKc2VhbWXB60WAH8FPj/6ugXAT4Ei05VmYi12KIJjsuXeFp19BHiMkO9BHuzhA5KFnk+gQpgu3pzrN0Fbw5bArdUcp7nN9ZGYBAAgqlvyctOSNunXqSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9FCE443E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:01:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Tue, 13 Jan 2026 10:01:12 +0100
Message-ID: <20260113090128.244709-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupefflefhvefggeegfefggedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
Changes since v1:
- Fixed build

 drivers/bluetooth/btusb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded09e94d296..67ee2b869852 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4462,7 +4462,6 @@ static void btusb_disconnect(struct usb_interface *intf)
 	kfree(data);
 }
 
-#ifdef CONFIG_PM
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
@@ -4616,7 +4615,6 @@ static int btusb_resume(struct usb_interface *intf)
 
 	return err;
 }
-#endif
 
 #ifdef CONFIG_DEV_COREDUMP
 static void btusb_coredump(struct device *dev)
@@ -4633,10 +4631,8 @@ static struct usb_driver btusb_driver = {
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

