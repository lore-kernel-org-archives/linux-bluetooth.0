Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB53DB31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600157; cv=none; b=AvXUAHZkEc67KDV55ZG6P/PvlgjIZsNy51t0nr8GXYouVIQwMSDwIgVXYBjiWPDYi/FJX00lXlHfJWIuCEJiYMwMCxTgtZbXuESZyG6d8YmqgfHiKDeSr/jxY27FGTmJM8q6jmqdvfZh6mORQAhsTA0cfKt0QOyWJLhVX1tC7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600157; c=relaxed/simple;
	bh=Lt1p+42O441eB1yNr6iTbXY/sQ8jWKO+7aT3dNYRtuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h5vu1FBk4wLC/msTgpvmGHOYOSQvi6dxLEUi6XOmOrJEm8jwZQH9SSQutjJc3xqRnSqz//oQZt3NpU1syKuONKh9LI3p+Sb8QLIQY7AoVBInqL/ZrKWZ1pEEPfwSpOwoUlsP2hLaVorU8hFu2hwhHVAybaV6RPcrEPhJfpJkDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18A563E97E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 08:55:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] hci-tester: Work-around possible string overflow
Date: Tue, 16 Jun 2026 10:55:34 +0200
Message-ID: <20260616085538.3568474-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
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
X-GND-Cause: dmFkZTEzW8IrtgwVahcT0rEP5GBKJqjLSe4eyG/2sHOP6bZMdRuMhXEU7FBjGEBa4/pAzHYF6Pu9mBeB0iVPn30phwMymttVmhnshc9h6ToPKlf/WfidvuIVOPMy3dWGWfvLd3yN5ApOiBBbn/+LHHr5i2W993CQd+C0KP83JsnHrfYJb5X0JHgJqCXnCXC3V2TEWmoPBmnzB/QdWewGGi1cNDkw8uaYCfSCmngBCvXlt34cfbtZpLXDugyO5XYE60UH1d54eor9tsQIveA4Cr74sT0ui1T9/L8K6r7DxHm5caDRJjaQhg+xcMwiwypyZoMJOimwpl20mw8zoM51DRaF34hnf24HZiee82AEFPL+eOjAbj8zGFY21WZ0//Bx1O8+F0rsLGX95QJ2j6KciTL5VXJkSq4jE3o6AaBcxCMS+uS0sGDt9TekqmojQQ5taLc9+GpBxdhUPv56HaVaghaZPV5kxsboJ6rIO9Nz6tS0Fd8MpV7hutHFxYS2A+capOimAd3FbqpVHeZG95nu+ZMG12Ao0ws6h0IXYHE7TfFxGtCBnM5vuzCBwxDLGB3BebIZxsacB1kxkE4/+ePVK+IeD/L7lENSffqnMQPu5FKRNtVXQDdutCVp3HsiBFuB2o1IX/WNX/nfA57NIaBteN0e9RCtG9AtsklOEmRL9u6pLVpvsw

Quiet overflow warning by checking for a non-NULL destination.

In function 'memcpy',
    inlined from 'test_pre_setup_lt_address' at tools/hci-tester.c:67:2:
/usr/include/bits/string_fortified.h:29:10: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   29 |   return __builtin___memcpy_chk (__dest, __src, __len,
      |          ^
---
 tools/hci-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index b8446ee83ccf..c9e7c58d2e95 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -12,6 +12,7 @@
 #include <config.h>
 #endif
 
+#include <assert.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -57,6 +58,7 @@ static void test_pre_setup_lt_address(const void *data, uint8_t size,
 	struct user_data *user = tester_get_data();
 	const struct bt_hci_rsp_read_bd_addr *rsp = data;
 
+	assert(user);
 	if (rsp->status) {
 		tester_warn("Read lower tester address failed (0x%02x)",
 								rsp->status);
-- 
2.54.0

