Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF92FE28
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119632; cv=none; b=amqpT4abzuZ8DbMtSAfRLo1YqKX7y3cZHDjCawgauAoGaJvsS88EL4p7uSkmzk1zKM57/y41QWNKfhv062w6ehwOig1oLqXsUImRg1exK6FSpgKAHo/LscACQkiHFYCSZzKhtAW5xmfF5l3URD9JlzisgY9y0DJrnws4Zeo3bsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119632; c=relaxed/simple;
	bh=BgGogpAMmcwXEp2jAZ1kV7+3AOfYiVYXX4zj4e6l87k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhm92jRs87QvLpCciTHjhGbMnyjy1nfSoVDPqCpD68AwJrS3wTBv9b2HUOOyAaalZhJonCB80VPHz5v9P5INAY+V8Fm/acwfBftDVOkSlhMNphf0P9Zh1s7F6x2SW98SZSO/SprO2H7B+eOAJPmiJSdv8COLAsJmoco7L7kD7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTn/J2OB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTn/J2OB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708119629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=riMbU5asA6XpF0KUJUQt8608xAirHV8bI9Iz6C44BF8=;
	b=ZTn/J2OBEQfJ5aUYBj2ORqp/Ped4i9qafzRUYVQictuIsQQ/QaCq3P5jLQc5HHf5rmmlN3
	sG2ewi+0zd2QzUvL67LBYsuuuCSoheqX5wYrHg34xhVWKt+iTRu/CPxNet4HOsIYeMBEMy
	euCRSIwGy116OU4iP9l1uxBlLhbGU7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-09MIMy5nNVG8GJMSqKMfkw-1; Fri, 16 Feb 2024 16:40:26 -0500
X-MC-Unique: 09MIMy5nNVG8GJMSqKMfkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F08F3185A780;
	Fri, 16 Feb 2024 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD052022AAC;
	Fri, 16 Feb 2024 21:40:25 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
Date: Fri, 16 Feb 2024 22:40:16 +0100
Message-ID: <20240216214016.251819-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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
2.43.0

