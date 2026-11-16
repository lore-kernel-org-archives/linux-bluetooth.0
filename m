Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816362;
	b=Kfw8G2GqJunWgjiCnPAKAnTZqQgW93tBOtfRZUWrvj5nQpLKXvDCEP3GVfu7Ggr3VNXk
	 1CRW6chfzLkmip2yXkKbETNgfMxqEW+0BMvciRSDGmJerkjqyo4YJ+9tQcdcytaxmprpW
	 4CJVWh1fZ5OoIdaDlHbRaWJMWxGwB0rbsWU5J22/0ZeXB8v9lm/khxwYSqHSjWAI+CtQF
	 rlMleBgY4+63+rq3vTpOSSvScHp+w5QVum9NnJBKZGOgPqAABB7Js9wCvtJv+HfeE8mox
	 WtqUdAR+N90pTMv+Lz20Ezr+1x+lZU5dMVQiHqH9tVaTzzRjpYqo0kold2jQmyjqbgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D3L9I6nVkWNX8DoxsebmsKpsQfDRL9KhwjDhBEHBohQ=;
	b=Du1AJzamm20LJ5VTz3dBzJpDv8wDLfEGUTWuW+qxex6PZeSMNb7MhEn0pdTCuEM27Au0
	 jsdL2XQEHkLpxz2fSukLqdGQR4WPnpbM+tak6zsM+53MiUmvXIsZJBV++85nE8edqMixd
	 JLxScL2ZPU3j4SP2NJflBcrXQqujNPkyBElZ4Z63VBL6X8PV2U2M2OW6b8LNz8HnPlaEG
	 mUkzJuIJ7Flh64aIJ3fiuor/LGXbIx+Kq2mBvzNxzuxeYQo5UOO1cFSVRWd7Ij8L/7UIp
	 7dh/fFKlw5u0Vhrjf6MMfdxTJrvudygKrre7AwkikIabKYiYuCzQSXuZhyaV998VYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ygc/pnFP";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802B606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 08:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C802B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ygc/pnFP
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so2785755a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 00:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816361; x=1795421161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3L9I6nVkWNX8DoxsebmsKpsQfDRL9KhwjDhBEHBohQ=;
        b=Ygc/pnFPOt8zvc+W+L790+lPPI92JkPu1Uet0MizR+wPU4/4AVPIO33xQIQQXWqjwl
         3IsZczk6UpPFMxES408lo6l40XuzSn6/U1NdX8Hulaf4qhY0S6hHaZMoIfvObWIYZBzU
         R7MW3wm/wkILcpsvHyc+Zfv1G4KYDaDGKYTAizSo2YHL4mcOEUgh0hQVBF5HhFKZ85Qo
         PnNiRUh1eZLLQEDnb+1yegApZbv97tfxhdh/aUJQeLdYJCo3jPsGg0NhoIZ4HaddwmFZ
         /jlcSvhnu1UNfNdcNObY98A1srXDzubomlcD0Xsg52xBamATrnZWHwq/S1R40Kd2fsRE
         xPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816361; x=1795421161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3L9I6nVkWNX8DoxsebmsKpsQfDRL9KhwjDhBEHBohQ=;
        b=Tj9iLe0ZWBr2GmlONF+f0ymMoZeAAOHGQGyqBMhmIfjxZpsO3J7VFd+u126yvXIQk7
         7yKhOZBAIKraYQciphaeIDEZfS03+WyYfLM1hboeIIC4kjrkCK7ZopI+HHq9De363NGS
         b84oM9YscbmMmGWBYtTktEoWVj8YFItnivij5eHYO7IPt+y4pMbehKWkNQ6i8jSnJYVl
         ZWbPn9wmBCzPGvfW2fpMQhUAG48ajvPh5Mzphy8Xwt7OieJeDOyKwClnMqMQh4wIpiT+
         MDTTzixCnbK3qgVHcGrc05jTtQTYzNEWmpdQGwPiZ/LY0N3MmC8Pyu34tixgVrol+Y0s
         88+A==
X-Forwarded-Encrypted: i=1; AL+hErFu2XUuHn7pUF1n9kzfJbTravNFz59DTWFhfQMwQFopTTEOUexb98Qk/IaHLcM66eFIubAjcw9umjvw0zpkgn8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PWhk08Fz8btC8EzFrMcvD1xlOdPBC4K9z5cVqpgHMSB39QSuZ
	ouVIYLU8WlwbdK2lTRKPx7lQkspI2T2AMoH62ZWGbGOZgIOGi/bRPpS8
X-Gm-Gg: AZFdTZdGYUvqFsD/3ELDR26I8IcLNWiuY2yGtmQUK2XepSHATbibyR+90+IDZ8YoOIl
	XVaX2/JVfEZgbqMcBaO6sWbd46/HxhUJMFHOKhnQWgp1vVvAf5UlqKPxWLPKHZSaep7q30oLkza
	AoaQLAbuPdH0TRcbomBg7yhonwzLuzt3aIHkuYZBw62pMsluUVbjCJcC29+V06XAfepmHvA7Sl4
	UWG28VKGXXVkO4n3WJeWX9xJl1qJ9nur/zjNz4FU6vr/brG+kQNbKBhRadY3wISS/wkmkLoVy/3
	LFNNl2ob08q5wB7yAyaHWBLtSJm2W52nEH0wWLrs4mg/ZBfaDOFGTA8Pr/ayB7O6RpZaPJKRlnh
	RM+q+9CG7esWfy5osL196YmV7IW/98Y1OzQTLXOPhGpjvPB8QRPp2ivHCWjm20/nVhR5oxRt8Bo
	4g1nKDq5dCmSsmmthsmHAa0flgii5/ZZs8gNz9HEDRZ0wE6p02uT/jZ2z4lHEKhcvK2uOFdhu/K
	CxIH6H+DDLbIbefDearblvFCyRwBuhY7Pi6MifW4iZsCV5kbJA5W4K3YABM454a9456kQw68Ahu
	y+xaDTiOXpJYEk9gebtSqadTCp5Uu1ohD6EQaB52/moprEZ9CBeIC23EO9G8
X-Received: by 2002:a17:90b:2f0c:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3b1b0ba0acfmr9088807a91.26.1794816360741;
        Mon, 16 Nov 2026 00:06:00 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:d1be:2710:af83:9beb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm20924303a91.14.2026.11.16.00.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:06:00 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Michael McAllister <me@michaelmcallister.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_serdev: serialize flush with transmit work
Date: Mon, 16 Nov 2026 16:05:38 +0800
Message-ID: <20261116080538.66575-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_uart_flush() runs on HCI close and reset and frees hu->tx_skb while
write_work may still be sending the same partial frame. The worker can
then resume with a freed skb, or both paths can free the frame.

The tty flush has stopped write_work before freeing the partial frame
since commit 1b0d946d6f08 ("Bluetooth: hci_uart: clear HCI_UART_SENDING
when write_work is canceled"). Do the same in the serdev flush: disable
and drain write_work before releasing the frame, and hold
HCI_UART_SENDING meanwhile so that hci_uart_tx_wakeup() only records
HCI_UART_TX_WAKEUP. Then re-enable the work, release SENDING and replay
a wakeup that arrived in between.

AI assistance was used.

Fixes: 82f5169bf3d3 ("Bluetooth: hci_uart: add serdev driver support library")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.4
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Michael McAllister's v2 series changes the same function; its
HCI_UNREGISTER check goes above the new lines:
https://lore.kernel.org/r/179468159400.2456.12381703314197227930.wcn3950-poweroff-v2-2@michaelmcallister.org

Tested in arm64 QEMU under KASAN with a hook that keeps a partial frame
in hu->tx_skb across an HCI close: without this patch write_work reads
the freed frame and the close path frees it twice; with it the run is
clean, the close returns 0 and the device transmits after reopening.
The same holds with the v2 series applied. No new W=1, sparse or smatch
warnings.

 drivers/bluetooth/hci_serdev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index d2c48df34199..194f11251cc5 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -97,17 +97,26 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p serdev %p", hdev, hu->serdev);
 
+	/* Stop write_work and hold SENDING so wakeups only set TX_WAKEUP. */
+	disable_work_sync(&hu->write_work);
+	set_bit(HCI_UART_SENDING, &hu->tx_state);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
 
-	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
-		return 0;
+	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		/* Flush any pending characters in the driver and discipline. */
+		serdev_device_write_flush(hu->serdev);
 
-	/* Flush any pending characters in the driver and discipline. */
-	serdev_device_write_flush(hu->serdev);
+		hu->proto->flush(hu);
+	}
 
-	hu->proto->flush(hu);
+	/* Resume TX and replay a wakeup recorded while it was stopped. */
+	enable_work(&hu->write_work);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
 
 	return 0;
 }

base-commit: da3cc02587c629420603df4395179ec82955c941
-- 
2.56.1

