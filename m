Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB350286
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715430991; cv=none; b=gQ9KlC5IWKEzQiIeOPUweWZg4BKKChlbddbu1f171Kx9GSPPvO4yXpH482bR7MPmNWHud028qPjsk/NXfU8Y+Zmj+UXR7NadUFc2JXKLj39efMJX9BIkJ6Hd2FaoiDUXxCTWsYtebn+RO5eI+wovIJwF6HQwpvYnL7IcMJrve4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715430991; c=relaxed/simple;
	bh=tdF40W5/p7BNpqk7dLQhpUrEV33iYOSR9aYMnXyOXoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWn5T5xKOL3ErihRDXBgmvWBmKHa8Zcy/jt5bd4cKgBe69HP3b5slvXe36tfN2u7GJYGDomiX0r5lA64JvKYumu8Hg3ZwGLySAfxvakD3sEt6ORZUowFw2MDIrCJLQtNZ1vRbi5iMn2BlqlgtgiBc/LQg5delboh6csiJEo7tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtMisOm7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtMisOm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715430988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLhuT+oWLYe8VAd+4kBJ2yh31MpICmbd3ylxkbHpSO0=;
	b=OtMisOm7F11ukdOBpNBZhBItMrTlL8wO/JBuapilYNVbdNkiDcB17iiLo/FAnVP6ViMfWB
	2ZGAizsYmImlra/yirkvkdshHF+HJ/8us5JSXgryRrHOThmZ8wbqJFgQUrtzLu8n7P3gm1
	dkzD7TgHV6gD8fvbcibJG0BuFAmVIss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-cJlqn6TuOrqo0Sepr6n1eg-1; Sat, 11 May 2024 08:35:12 -0400
X-MC-Unique: cJlqn6TuOrqo0Sepr6n1eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04A4F80027F;
	Sat, 11 May 2024 12:35:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB02C2087D71;
	Sat, 11 May 2024 12:35:10 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use led_set_brightness() in LED trigger activate() callback
Date: Sat, 11 May 2024 14:35:10 +0200
Message-ID: <20240511123510.22303-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

A LED trigger's activate() callback gets called when the LED trigger
gets activated for a specific LED, so that the trigger code can ensure
the LED state matches the current state of the trigger condition
(LED_FULL when HCI_UP is set in this case).

led_trigger_event() is intended for trigger condition state changes and
iterates over _all_ LEDs which are controlled by this trigger changing
the brightness of each of them.

In the activate() case only the brightness of the LED which is being
activated needs to change and that LED is passed as an argument to
activate(), switch to led_set_brightness() to only change the brightness
of the LED being activated.

Note this is compile tested only.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 net/bluetooth/leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/leds.c b/net/bluetooth/leds.c
index f46847632ffa..6e349704efe4 100644
--- a/net/bluetooth/leds.c
+++ b/net/bluetooth/leds.c
@@ -48,7 +48,7 @@ static int power_activate(struct led_classdev *led_cdev)
 	htrig = to_hci_basic_led_trigger(led_cdev->trigger);
 	powered = test_bit(HCI_UP, &htrig->hdev->flags);
 
-	led_trigger_event(led_cdev->trigger, powered ? LED_FULL : LED_OFF);
+	led_set_brightness(led_cdev, powered ? LED_FULL : LED_OFF);
 
 	return 0;
 }
-- 
2.44.0

