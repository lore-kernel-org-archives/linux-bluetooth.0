Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7453804
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828794; cv=none; b=k9uetvjnoRI+bViIagbEweFQSMUGdB9ZtNoTS50RhjHoRPsFux3DzNdMXqScfQVRn9teCJIqgCYx1tfUnj14ulGsbgNrOmvtq0+LtwCRnrsW2U7Ui7UZ8dChhOdVfzLLux3lCL8cCLusGYd/X6yWVvTKOMNeRSKaEBzGlYp2Te4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828794; c=relaxed/simple;
	bh=uNLzsexTJm/MoZWC6C5jzfb5ZJHputH5kGryC5awGWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S4WU4Bgi2zEgYNWD/AIdf2iamcwWG3jgc7KJrJAKOYPk4nWniacIt1so9vrJiN4NN0NotvDxsat3cT3sj2cYzkufqt9wK3jyd1NRxC04rURtL3XT/BgVVYI2oTqZIUO6rT+ATPB24VbiE969+43FB1U/Y42L2L9L0XnRy0N9bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp88t1719828779t1yrvfhh
X-QQ-Originating-IP: fV8ZjqP6d96dQzAmUOc9L47707taGAT35fCzC0va6eQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jul 2024 18:12:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9667334448423119969
From: Chengyi Zhao <zhaochengyi@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: Chengyi Zhao <zhaochengyi@uniontech.com>
Subject: [PATCH] adapter: Add retry when bonding device returns connection failure
Date: Mon,  1 Jul 2024 18:12:43 +0800
Message-Id: <20240701101243.2902-1-zhaochengyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0

When a user initiates pairing with a BLE Bluetooth mouse,
MGMT_STATUS_CONNECT_FAILED(0x04) is returned with a low
probability, resulting in pairing failure. To improve
user experience, retry bonding is performed when
MGMT_STATUS_CONNECT_FAILED is returned.

Just retry once when MGMT_STATUS_CONNECT_FAILED occurs
because this status may be continuously returned.

Debug log:
bluetoothd[1539]: src/adapter.c:pair_device_complete() Connect Failed
(0x04)
bluetoothd[1539]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
DD:EC:0F:57:A9:2E type 2 status 0x4
bluetoothd[1539]: src/device.c:device_bonding_complete() bonding
0x5591f87230 status 0x04
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
 src/adapter.c |  4 ++++
 src/device.c  | 24 ++++++++++++++++++++++++
 src/device.h  |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bb49a1eca..574fa7665 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8371,6 +8371,10 @@ static void bonding_attempt_complete(struct btd_adapter *adapter,
 		}
 	}
 
+	/* Retry once when status is MGMT_STATUS_CONNECT_FAILED */
+	if (device && device_bonding_check_connection(device, status))
+		return;
+
 	/* Ignore disconnects during retry. */
 	if (status == MGMT_STATUS_DISCONNECTED &&
 					device && device_is_retrying(device))
diff --git a/src/device.c b/src/device.c
index 097b1fbba..12fabbff1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -290,6 +290,8 @@ struct btd_device {
 	time_t		name_resolve_failed_time;
 
 	int8_t		volume;
+
+	uint8_t bonding_status;
 };
 
 static const uint16_t uuid_list[] = {
@@ -6559,6 +6561,28 @@ bool device_remove_svc_complete_callback(struct btd_device *dev,
 	return false;
 }
 
+gboolean device_bonding_check_connection(struct btd_device *device,
+								uint8_t status)
+{
+	if (status == MGMT_STATUS_CONNECT_FAILED) {
+
+		if (device->bonding_status != MGMT_STATUS_CONNECT_FAILED) {
+			device->bonding_status = MGMT_STATUS_CONNECT_FAILED;
+
+			DBG("status is 0x%x, retry once.", status);
+
+			if (device_bonding_attempt_retry(device) == 0)
+				return TRUE;
+		}
+	} else {
+		device->bonding_status = status;
+
+		DBG("device->bonding_status is 0x%x.", device->bonding_status);
+	}
+
+	return FALSE;
+}
+
 gboolean device_is_bonding(struct btd_device *device, const char *sender)
 {
 	struct bonding_req *bonding = device->bonding;
diff --git a/src/device.h b/src/device.h
index 0794f92d0..7c269cc4d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -111,6 +111,8 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 							uint8_t status);
+gboolean device_bonding_check_connection(struct btd_device *device,
+							uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_bonding_attempt_failed(struct btd_device *device, uint8_t status);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
-- 
2.20.1

