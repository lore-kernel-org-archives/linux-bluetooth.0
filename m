Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC375024E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569662; cv=none; b=drmtfvSSJvhONqotWyYfSIUJtWuM7+gAEbAw4WdLx+QiFrbLTtEAXJOdhF4D1iv/ldtOqXONxWe44uDSIosMZa5L+HpnXUnreqTJxvwYKWIakSkcvcfWhzLlRgK4moVRe70tecMkyNxWRF0fGx6iKRvaqGbl5B05XkPT8nux83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569662; c=relaxed/simple;
	bh=jCffkjUbybQRxJV27LiKk/svy8XGBwo5nd1AR0hlHiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQKUkcTCMn4W3kN/SWKXWvEF8E37s6d8pTWcD4QasjJercRgA0QBDYXMxK/XaryjxZnMt/S1V7RNxo247qwa/RXT0sgN7NqmyJqguPjR8sE4XzmswSp2h97JpL7S/aqFcdLNmSH0pH0zAOQ8Pg6o7TKe42YJE7QAAeoJ8TP0iWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz10t1719569645tl7fin
X-QQ-Originating-IP: Y0ZgNjIZseLHMdQrSLArJlgjhRxDC9EnhZOqAzPAelY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Jun 2024 18:13:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6547517565520991816
From: Chengyi Zhao <zhaochengyi@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chengyi Zhao <zhaochengyi@uniontech.com>
Subject: [PATCH] adapter: Add retry when bonding device returns connection failure
Date: Fri, 28 Jun 2024 18:13:48 +0800
Message-Id: <20240628101348.16820-1-zhaochengyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0

When a user initiates pairing with a BLE Bluetooth mouse,
MGMT_STATUS_CONNECT_FAILED(0x04) is returned with a low
probability, resulting in pairing failure. To improve
user experience, retry bonding is performed when
MGMT_STATUS_CONNECT_FAILED is returned.

log:
bluetoothd[1539]: src/adapter.c:pair_device_complete() Connect Failed (0x04)
bluetoothd[1539]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr DD:EC:0F:57:A9:2E type 2 status 0x4
bluetoothd[1539]: src/device.c:device_bonding_complete() bonding 0x5591f87230 status 0x04
bluetoothd[1539]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[1539]: src/device.c:device_bonding_failed() status 4

HCI package:
Frame 2969: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
Bluetooth
Bluetooth HCI H4
Bluetooth HCI Event - Disconnect Complete
    Event Code: Disconnect Complete (0x05)
    Parameter Total Length: 4
    Status: Success (0x00)
    Connection Handle: 0x0040
    Reason: Connection Failed to be Established (0x3e)
---
 src/adapter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bdc5bf920..ca5eb077c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8367,6 +8367,16 @@ static void bonding_attempt_complete(struct btd_adapter *adapter,
 		}
 	}
 
+	if (status == MGMT_STATUS_CONNECT_FAILED) {
+		if (device != NULL) {
+
+			DBG("status is 0x%x, retry it.", status);
+
+			if (device_bonding_attempt_retry(device) == 0)
+				return;
+		}
+	}
+
 	/* Ignore disconnects during retry. */
 	if (status == MGMT_STATUS_DISCONNECTED &&
 					device && device_is_retrying(device))
-- 
2.20.1

