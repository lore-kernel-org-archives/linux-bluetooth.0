Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78B41D135
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954819; cv=none; b=H9xrX53GKofe39V9j3i4xtYE6I4mIEFDcUHlw2eRIgVhHYwgNJxt0n7qaDHhuKbFdPvlRDlUP03dFgSlNH6BCcTKXEyAwWw25WaNWSQ99EbXxfy3k3En1MNpCUdkPqXHPhMbAiiXmzqNMw+LAcZfmoYtF3zgKb4XugwEWV9j5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954819; c=relaxed/simple;
	bh=MQqoQaB1FyoyMJ+K6yDem6WMrchPow1EhO4d1DLyKj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN7jDoFH/rBacFxxKN5tHKqgubTWZXtlpEd32PT20rAU3Y7Im2vPXUKdCyxsGHbteMJzsgBdnlyvjDFRmbHMWhyCCb2uXvJD71WdWz8RTNJnhqjLstCOMsYbVAbMmrdPxZgJkaeT4VodByZny0Ppt0suzXdcTVlSod8EqSzC9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aznMqGAa; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aznMqGAa"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so4166956eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954816; x=1792559616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDi1ZUpchAKrAeynCZ008rcYzeK/yq/xfHew59IB4Z8=;
        b=aznMqGAabPfsZK8qdbwxW614EkmctvdX4zNWe1xKXsU5mpn8aBpnNi3k2ggtJ2w36U
         OV9fkrbXv1E2ltrpbJlmHJ6lPX09Y5c2mIMFn56NVEIGKDaOeo3BbSs5ipkeXSkyFxm1
         10djiTOzIVJiFBJp6FYrBTJC2zCJ1I+C/aNnzIpPmriDXyZe2QjTEx/T2fXu3VV904e0
         R4HAyy3FE76AVNY/EAzVWck3ft8emOxtHR3HTesH/mdLVRAvnzK6qpk//GD+3jemT0VN
         P06b8ogTrBJQWwIcG4f1iYegL0w7zi3NaEyfWYR/ZrrzntZl6XUTDTrnSuQtf0mRXNQH
         vrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954816; x=1792559616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDi1ZUpchAKrAeynCZ008rcYzeK/yq/xfHew59IB4Z8=;
        b=myzOhB0ZMI7q1+K9nBWuoYLwpJ4NMfEb7nMA7JaqypOpT3sXbPf40SNCqLwynCN13X
         R/9BUjxXdIJQ5SveNVaVowGbtNIKDkNsVUp4Osz4h8JslhIHGY8lAuYGLp8JwZp3nOoE
         iHCXPOlR77hJJ48CnR/PZToOlZUgs4oVe9n6IvR8TLD/nMXSk1LwYjMJMZa1s2qotPju
         OaNbCqralPf5f4duw9yvMFmaf0mt0R9ChD3KmyBDKSD0i2b029qGaDa/hL7dB2XzfoTP
         oQYx8z+2Qf9reAD8o0iFQMXmGaV21AaclAJvgDAqM3OMURjLIXfZo9HUXrvhBthuU/hu
         Sgwg==
X-Forwarded-Encrypted: i=1; AKwUvByJknu9dvOd6uBisdioFJBCEpr4v5dN3kxahW2dFLFA97s2ahFV6G7o4Rxrx5Pq2OMUzvhgRHC7fzqtgvWFg0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSOilJw2Eb1WzLFS/Im22C7zumunjQl3lXIKSVzTL7b4XbpnJf
	OlKJHlSRDIfulaTFqsNS2UhxPbfWjpTTO3qJDW+aSl3LZUylib+/yodO
X-Gm-Gg: AYBFou0TRjB/s1yulECSwYEnCHiHyVvIKK9uZovxJz362I9gl7fp5qaHVFNPFIDjd3E
	fGK4n/t1PNkho1elc2WyKykxUFj4lCsfTAib64vGVhUfk0AWnHrtb5sxLcm+MpU5InUDx37gkhj
	NHQVshHIEi7PZP40oIlBJ5K8Jk1d9yIOXWx8Oy/N/GgXS0NROZAQWJdYDYPgsITrUFfgFif5xiT
	0VjvhGl0Gzm1cvTkz2VA1Kcj0R2O65ZyztHvklmtw6efUTG2pbifrhQFgvbzYusqX3JmB6A33Db
	mW7GOZ2jKNIfkw5wonqhZla3I2QSDBsY0UNtP249y2Zau+djD/scN33+3h6XJyJgj/UKXWwm4Xv
	wVtzVtgge4t9flEoDj0VReLO5M2PW6X4WiPqKaVrDhHE56t8avIdm+ZsxVkJyo7mXPRfk6Oc4pR
	8KOxsr5YIZYUsfAHWwgMrYzwyV0Csgq0Tc2Fhn9VPqqZJq15b7oaSnMZLuy5Odb0bBYfUSkV759
	2mQ6tQ+DcbqFlXcxXObAOP/Wr3XuZXisWBJEgW+gdPMhL8E6LbMlFY5PXzKyCE=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr27762456eec.0.1791954816356;
        Tue, 13 Oct 2026 22:13:36 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:35 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] HID: Use hidraw_instance() in drivers
Date: Tue, 13 Oct 2026 22:13:23 -0700
Message-ID: <20261014051326.3784498-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of directly dereferencing struct hidraw to inspect minor device
numbers, use hidraw_instance(). This removes the dependency of these
drivers on the internal struct hidraw layout.

For hid-cp2112, fall back to dev_name() when hidraw is not available.
For hid-led and hid-u2fzero, require CONFIG_HIDRAW and propagate errors
if hidraw is unavailable.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/Kconfig       |  3 +++
 drivers/hid/hid-cp2112.c  | 13 ++++++++-----
 drivers/hid/hid-led.c     |  8 ++++++--
 drivers/hid/hid-u2fzero.c |  8 ++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..1d2657edab27 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -587,6 +587,7 @@ config HID_LCPOWER
 
 config HID_LED
 	tristate "Simple RGB LED support"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	help
 	Support for simple RGB LED devices. Currently supported are:
@@ -1252,6 +1253,7 @@ config HID_TOPRE
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	select HID_LED
 	help
@@ -1285,6 +1287,7 @@ config HID_UDRAW_PS3
 config HID_U2FZERO
 	tristate "U2F Zero LED and RNG support"
 	depends on USB_HID
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	depends on HW_RANDOM
 	help
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..148946b04bff 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1225,7 +1225,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct gpio_irq_chip *girq;
 	struct i2c_timings timings;
 	u32 addr;
-	int ret;
+	int ret, instance;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -1330,9 +1330,13 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.algo		= &smbus_algorithm;
 	dev->adap.algo_data	= dev;
 	dev->adap.dev.parent	= &hdev->dev;
-	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "CP2112 SMBus Bridge on hidraw%d",
-		 ((struct hidraw *)hdev->hidraw)->minor);
+	instance = hidraw_instance(hdev);
+	if (instance >= 0)
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on hidraw%d", instance);
+	else
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on %s", dev_name(&hdev->dev));
 	dev->hwversion = buf[2];
 	init_waitqueue_head(&dev->wait);
 
@@ -1494,4 +1498,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 7d82f8d426bb..63fd723d9e69 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -448,7 +448,7 @@ static int hidled_init_rgb(struct hidled_rgb *rgb, unsigned int minor)
 static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidled_device *ldev;
-	unsigned int minor;
+	int minor;
 	int ret, i;
 
 	ldev = devm_kzalloc(&hdev->dev, sizeof(*ldev), GFP_KERNEL);
@@ -488,7 +488,11 @@ static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		return ret;
 
-	minor = ((struct hidraw *) hdev->hidraw)->minor;
+	minor = hidraw_instance(hdev);
+	if (minor < 0) {
+		hid_hw_stop(hdev);
+		return minor;
+	}
 
 	for (i = 0; i < ldev->config->num_leds; i++) {
 		ldev->rgb[i].ldev = ldev;
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 82404b6e2d25..83e223c12cd6 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -307,7 +307,7 @@ static int u2fzero_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
 	struct u2fzero_device *dev;
-	unsigned int minor;
+	int minor;
 	int ret;
 
 	if (!hid_is_usb(hdev))
@@ -347,7 +347,11 @@ static int u2fzero_probe(struct hid_device *hdev,
 
 	dev->present = true;
 
-	minor = ((struct hidraw *) hdev->hidraw)->minor;
+	minor = hidraw_instance(hdev);
+	if (minor < 0) {
+		ret = minor;
+		goto err_free_urb;
+	}
 
 	ret = u2fzero_init_led(dev, minor);
 	if (ret)
-- 
2.56.0.385.gd3acb90ef8-goog
