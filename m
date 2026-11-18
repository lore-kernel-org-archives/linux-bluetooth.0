Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006125;
	b=peTdhfsbOq2I5wGQ6ItRrW281nqlX0JQjVy4MAvp53tUfo4zrgo1203RCt29saBzU9bB
	 n8k6y1EfNrhHKihMzt7wztNlHUVxEFZRkRSXp/pv8IIRp1J9J7fni+KV6CASxzqKL0CpL
	 +rxinyU+6eTTaJUYflwXDLg1N0AYz0j8h6/2UO/+ebEIjkJDna0Mq1SdNCoG2/4Wql2Ns
	 Rnl8Jwrz9vrOGFJya+AQydIo7vAvNE/VWu28MFja7ivIi0dv5N1XcxlDUgaWZ2FUD5qHY
	 Kc6VBgpSUiGhwKj9EBoieHFUg1VZBVESfSH06l76aVCJLu7LwTCjxOuOHN1vzxB6ZZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
	b=ZspQZ7XiTjq7Xqzy3nR4bKieg+gz3pcRmPhkzUCB0yVJz7x5aUdnWTsbhsOBIEHzR19l
	 XNsdXEcDY5K0eL6mMjfhSoPf1FTKcSjafCuqClCESVaezSdiWKzpVr/ZAvq0fulUmvQ3L
	 w3ScYhSLdXKmMURTv9Ms6/APAu2TdHhIFkelM9ryPVTfqD3N9Wkqpa3MuRNHVkXSMgvSK
	 k7eF+UgUWuC52CN2IujG+HHISt/SRBlrJSZ2SHSKN3qXdODxrlHivPVNtbhcxCP85BpGY
	 K7/vxYNYw7M3xOhUv0iDqsUgF2tuUSnj7D0FmgQHkcNPkrt8Qtv+EuhlIqmVwf7JFhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyDNa6qH;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF97606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 12:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF97606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyDNa6qH
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-89d6bd67045so508377b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006123; x=1795610923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
        b=ZyDNa6qHMqN8bT/9UckflEmKPPuhmBWElmSUA594C94jxxTf54Z5EYatCyvYVFjoYX
         hwApiSeGORrZ1+GW+mydas/M4G/Xcymm84AoP7egbmUiPf4ukExDdmUsLWbiom+x12hk
         gd6TMTpDHzVbTRqqfYHJ6pW4kNCvPBri0YZip51lYeFqyMOm9j4TOrR46nZfMp2Tn8Kd
         TtBvLOrwAUhemLdjYFrr2KC2Pw9LqiZm2tox/2fTYSofHoIeARlmHQbM/FftxS2rr28z
         tbwLJSJ5taOaNc4B803dtcycGfxzxZe/wP8S60zRqcBrMG9WjDVE5jzm4zXzXnFjTC+0
         eqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006123; x=1795610923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
        b=powxcPquDNxKQ5FpmtiiuK/365dVlPUaGCZ/ClITAn1T8cQlaQqgmlgJQ1hbAGibt6
         woYIpWvsKMWHvMCuGwIlmjkR79jXAn78707Xj8VlmHte2FuHIxXFDSiusw0ikNCBIUL3
         lSILQBRf85WpVHSnumLMYBWe4t7PVIqceYaLrLsQUKVBC2A/NcaygOCWsx1Lo+vBLZ59
         vNG73vOOXVOWx8FS/8EIhgeqgrQEkRyWO0jnPb5+Um3majIWQOWyeDVM9kg6zsskloH1
         VVBux5AqIQ7RUNRONt2kJtkDbWNp3pfmCfJB30lTfXbOaMvVaTTONCgdslBD7B7Y+EFS
         whHw==
X-Forwarded-Encrypted: i=1; AL+hErFXPKMeJk9jQzkJk0SzE3x39MCpfx4gy+WPbmevQFGXGafpgxHI6OXIOc9Gjdnmv/RqMDKhQPKIzKx3AjGzNYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cfMVkqnSgB1S5BCcDBSfVOfU/2ruzDkT4EtshhCjollenEQJp
	hJYpePkzomMpUitm2MXyVgpsa5cgn+uBe/UWA9UJZA2ravOT/14vt/8jbtKjf6At6/M=
X-Gm-Gg: AYBFou0Eunwhf0drmDnYC15Wj1us8+3TTFmJJIEAbVjKxCR3I/ikSgpbfAB364ZhqTr
	QiLW9V5KYCBEKQJGzLzc2kwCygcR9h2XbFeti4muN+KeX+NIbHI4PXOLn922ql1ZO+9AfR5Yhnj
	+2Xoks7dbQe1OulexmAmAahJjeC9sPYNf02t6VotEZQs/F8hTcrY0fBD0lqSp/Veq0VYnTn8fzj
	yJYhOeGu8PDYAyzE2r5BjtRt5wpCZCWTeR8KtU8iRWYxjiQVbTaY/qs9NVwTgZpx29/1+yxusvX
	sCbbeocepmxw40JSGo+Y5+T731QgMbTi0FbhOGpzopLiOG5YS7UpPYX7jGJcZ+hBktgTpIfbwG6
	KfSsZBU302SD2fqMfTauSwLFQ/QHS3GptWLHwT/+44qNH1YyyAkRC1MgC05063Beev/CDNpNFcm
	TCGi9RGKfi6sq1uHLm1a9W9k8SHyaC9Bq7spqKi9J0iVSfo7wO/3976O428I2WuzWH/osfYGPxN
	he4hfboAom48S8fjOGycJHRLgXivX4h9XpJA7mlwGkMiucBsqg9Pl1jyqx6bnCc4VK+Y146klFk
	fuu8scvgyiM6pNFmzL2Zcd+rpU5zhE0MFFUDcldPHM5kMAeQpBlc+LPP7v6u1g/QHbo=
X-Received: by 2002:a05:6a00:1acd:b0:8a0:67e7:1004 with SMTP id d2e1a72fcca58-8c455fe5db3mr3817702b3a.11.1795006123031;
        Wed, 18 Nov 2026 04:48:43 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb54e413sm1176077b3a.43.2026.11.18.04.48.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 04:48:42 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Wed, 18 Nov 2026 20:48:21 +0800
Message-ID: <20261118124821.3990-1-enderaoelyther@gmail.com>
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

With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() clears
HCI_UART_PROTO_READY without hu->proto_lock and closes the serdev port
without waiting for write_work. The hci_uart_flush() just before it
re-enables write_work and may replay a recorded wakeup, and
hci_uart_tx_wakeup() queues it from any caller that passed the
HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
write_work can then call ttyport_write_buf() while ttyport_close()
releases the tty, so it writes through a released tty.

A partial frame that write_work leaves in hu->tx_skb also survives into
the next open, which flushes nothing, and would be sent first to the
controller after it is powered on again.

Quiesce the transmit path as hci_uart_unregister_device() does: clear
HCI_UART_PROTO_READY under percpu_down_write() so that no wakeup is in
flight, cancel write_work, free the leftover frame, then close the port.

Found by code review. Compile-tested with W=1.

AI assistance was used.

Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.12
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

 drivers/bluetooth/hci_serdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 194f11251cc5..028f691bd7da 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -164,7 +164,18 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 * open may drain the battery.
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		cancel_work_sync(&hu->write_work);
+
+		/* Do not send a stale partial frame after the next open. */
+		if (hu->tx_skb) {
+			kfree_skb(hu->tx_skb);
+			hu->tx_skb = NULL;
+		}
+
 		serdev_device_close(hu->serdev);
 	}
 

base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.1

