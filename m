Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5913ACC
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Apr 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411608; cv=none; b=pg/Jsg7T73RuUC1eGr6190bRvzAQwKrE1kEuCYtVsj5p0Aey7j7O6+psPBI9htzporIGXvHnnidPpHVLz4D6rQtX7c4sOYkGcwRrD5ZAuMQRfFTx3NQYKAfBrPJzsrZ40oLwvDC71Z0dYenAWd+EZhNisuulcT5KH/Dyre5A3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411608; c=relaxed/simple;
	bh=uuFTbIv6oepg9RSLXpan7yIe7cMQvnD2QDFxRZ4CdKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjw18JkD+mV/8ME0LWgUW5rpgtxKsDHIbo7doi6lxkKuwZw55Vyye/6RHE2Y3TPvnTZRWrTKqlPuZTeg3isebhH58JvtX7VkhT7DuuHgAhzeYyICFxYXwYty7YwhE8YEnz81WNCbebKlASlxTQiZou+WDOsFiXW79P4gBIOeC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGERAViv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGERAViv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712411605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P+xOAM1vynFvRAlHMpeR1e7xSyEQz3R2PI61qJxfT/Q=;
	b=aGERAVivC+PjDcXuUuhnWdeJOtkGWJDikGxHrAh/MnXsKCVEsGwDNMmFnTFVkBJk8TsO+M
	JYG9iGpCR5IgpSYLv1UmOsvMB9MQtynHx1f47dPmMf+0oXA1XPyb0zxR+y7zcQBESuo8Qp
	K/jg/s6vd01MCSQMDVxdoT+t0h7dU2w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-9ex952lBPbGQTuXj0IpCdA-1; Sat,
 06 Apr 2024 09:53:20 -0400
X-MC-Unique: 9ex952lBPbGQTuXj0IpCdA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB3E43803507;
	Sat,  6 Apr 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5E24492BCD;
	Sat,  6 Apr 2024 13:53:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH resend] Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
Date: Sat,  6 Apr 2024 15:51:06 +0200
Message-ID: <20240406135106.16821-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Like the bcm43430a0 the bcm43455 BT does not support the 0xfc45 command
to set the UART clock to 48 MHz and because of this it does not work
at 4000000 baud.

These chips are found on ACPI/x86 devices where the operating baudrate
does not come from the firmware but is hardcoded at 4000000, which does
not work.

Make the driver_data for the "BCM2EA4" ACPI HID which is used for
the bcm43455 BT point to bcm43430_device_data which limits the baudrate
to 2000000.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 874d23089b39..85471be0c71a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1487,7 +1487,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2EA1" },
 	{ "BCM2EA2", (long)&bcm43430_device_data },
 	{ "BCM2EA3", (long)&bcm43430_device_data },
-	{ "BCM2EA4" },
+	{ "BCM2EA4", (long)&bcm43430_device_data }, /* bcm43455 */
 	{ "BCM2EA5" },
 	{ "BCM2EA6" },
 	{ "BCM2EA7" },
-- 
2.44.0

