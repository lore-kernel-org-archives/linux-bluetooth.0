Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817141F7D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954820; cv=none; b=GvyzrbPU+X4SXa1NVbZYLdciAIKJhB871HSbLDZJkXhvGiEExxK9qsxUwVg9BS47KcaHv1DPbF0jTLteyulJydIc7l23OnJumIYuacY1xsjv+1bBhYRY5bpR0TbcvbZwyr3gSTRt5Odn9BuMwOc0KgnPpc+50O5Za2fhSqHLju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954820; c=relaxed/simple;
	bh=PCxxcn6JaCpLIK8BQyFUvhMSkm+HMXkbPHY3uUK4fNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/wWyyuSh43zzXvco3RFrinkEt0f3nyjuYun8uOa2IrK+7qpBgYw2ggHmld9USxzfR+Ryu8pXtL/gVZ/ZSFB2na5x8Zbgez7+bbgMdKvzLfRumPyGgO4W9v1qoJY3CvF68w2PPKMSrUapFITw9rbR6Q1YfMvJsyfLuh3SlWpTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1qh8KF2; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1qh8KF2"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so4120768eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954818; x=1792559618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrXU4zkPCMdeqO1j0v9Z1k0Agb/FJlpriDsHwaYaty0=;
        b=C1qh8KF2bfAD6f17ndVdVD/s7SaWiTNybP+P7lzTrUMfJzt+H1oeG4j+AHn5GNKBZF
         s0dkc3HLRCQoNvzezPdLeR2idU0ovM0zwaMNPq8JJrCP9MyFe8zo33JDxaxUhWF4wN7g
         EeDSnkAtoZ4a8hIndVXXEoFJ9lgIeUs93i2F4qmSYovHxZQVITK67WbW3MpVN1PMSxNa
         OTOAl/LYYIPixWbrzMBJq8ORuESRimPrrxl5tZQjG/ty2U6twRnY05uVv/ar8XMtdU7x
         aK0jXDM+eo9mc/G/f1BckNGNKrOTjPBI8xLYVlGw1u6kIQGVh0ZL1MqMHAVWuJUk05Rh
         93Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954818; x=1792559618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrXU4zkPCMdeqO1j0v9Z1k0Agb/FJlpriDsHwaYaty0=;
        b=GPfPUVfaezkAMfQmIShyU3mUrzzWYmfyKCDBI+fGQYIA+I0xoGDoJFT2xpjoVcvFeY
         tyGCw5iWde3SlBF/CFo2GUxCTmLaAdq2TUU2N8sQgDio5uJbHg8YLMooBLsqSzI9SmBv
         DRNhPv85qvnpY5JDmuYIzxawij/+GFwXJ9JuX2g74j0GyyJBUNdOlWC3QBIcJ0iBg1uk
         2JPu6Oa68ngUHvAFBy0QMS2a20X/xC4nO/fpzYmlsX4XGBc3jU+VuKep8IQ+p//NmbVn
         awAeDUwiMNieJpYujjF1qH0xlKtU5AxV6BMlV25ydwoIhMLhERG25WxfPAtwgTFz9+4S
         Gpfg==
X-Forwarded-Encrypted: i=1; AKwUvBySUtP3tWXRednzBN5hO2dOjSfu0NC6VFhDNyq8xLeCLwGAZuB1j9qXBQ+J3r3m2tKBpd3L5SRh3ZhPSZ2qqbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkvSt7PUnC0yAPb+b6CLPgA1nyjVB2K4AZXI5fiIFes0Q9f3mr
	ykt+cxLcxqbGFe4YnSAG3ge3iGHdw6mHksIrAe1JokczdqjwkNAShNwO
X-Gm-Gg: AYBFou0X712wytaVAMm4Q6R+v1UFT1vbOkiCQns3bQJP9R07+GdTWpZlIfmF88jvNjY
	uygruhKaUKkuZ2WWVZBxhrmOheZmjFgUov+DbGSMIjocneW4Xn1MjMO1MTov1Ug1N1ftjpIBg39
	jyTMf0ubrx+5eyrOO1Hdjp4UvrDulCENOo447U8vXZap0Zd60cwAf1OAS2OZdW8Y3qqG6fp3TzS
	cHM8KYg0iEiTT4hHafll0shV0mop2JVGDoV5wdWfVCMeqoODF67dGJaoDUw6hR9Uw0ro3P+oGTb
	zNDf4yJRr5a4FuTDoFwyZ1cJQKlUvwKBSbYBrqfQQImgKiFIpjOt0RM7AE5PvGlILR6+5VWWefY
	VlcarLNZLNTepJMt2sSf6qTgjlsCTTXCp1rNWZ4XhGZqUPVmsqbxwG2DbiJcaMl07h15QGosDo8
	nK60KmLcqok5Tz8UFpSevNMEIO259wtUhWe0dQOaJPvKhC1Xmm4Q72brqFoq64YHUaCUaW/ca8u
	3M9hbJx5+6sWKME52Otciqg5LRtT4lQyJTYyliVfe6ZAgXQ6Q2lf401qr6eL6OCtVGC59v0BQ==
X-Received: by 2002:a05:7300:6822:b0:35b:bb89:231e with SMTP id 5a478bee46e88-35bbb892336mr8115364eec.29.1791954817958;
        Tue, 13 Oct 2026 22:13:37 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:37 -0700 (PDT)
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
Subject: [PATCH 4/5] HID: Drop unused linux/hidraw.h includes
Date: Tue, 13 Oct 2026 22:13:24 -0700
Message-ID: <20261014051326.3784498-5-dmitry.torokhov@gmail.com>
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

Several HID transport and sub-drivers include linux/hidraw.h without
referencing any definitions from it. Drop these unnecessary includes.

In hid-ft260, replace the hidraw.h include with linux/hid.h directly to
preserve the declarations it previously relied on indirectly.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-ft260.c       | 2 +-
 drivers/hid/hid-mcp2200.c     | 1 -
 drivers/hid/hid-mcp2221.c     | 1 -
 drivers/hid/hid-winwing.c     | 1 -
 drivers/hid/usbhid/hid-core.c | 1 -
 net/bluetooth/hidp/core.c     | 1 -
 6 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 70e2eedb465a..c4d13a6a575d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -9,7 +9,7 @@
  */
 
 #include "hid-ids.h"
-#include <linux/hidraw.h>
+#include <linux/hid.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/usb.h>
diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a079..9c82de069b8b 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include "hid-ids.h"
diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..bd6b92b5a09d 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -14,7 +14,6 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/gpio/driver.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 9cd25a77999e..5223baf2d020 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -8,7 +8,6 @@
 
 #include <linux/device.h>
 #include <linux/hid.h>
-#include <linux/hidraw.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf819..e398afce73fc 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -34,7 +34,6 @@
 #include <linux/hid.h>
 #include <linux/hiddev.h>
 #include <linux/hid-debug.h>
-#include <linux/hidraw.h>
 #include "usbhid.h"
 #include "hid-pidff.h"
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0e24c5e2955e..bb408599a28b 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/file.h>
 #include <linux/kthread.h>
-#include <linux/hidraw.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
-- 
2.56.0.385.gd3acb90ef8-goog
