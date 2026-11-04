Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805376;
	b=DsvrQSbXAnOvycgicpiqQ0mtCgDK5YTATddkTwYqGDIaScU4tK/2TtlJ6Sr5EuZiLZsq
	 tfyVGQdaISFIQzWpLNtEiqKAGj5z0if+xoE5Y1QrCJ/0LK4FO0MDRUZlIrUe62E8330vC
	 slaaErqYBYFunm85og4TsVoybp/AyTKzv8eCEysaRIuRr0xC3pdcWBVxGMtckXi0P8Zym
	 +N6OYyJSrw3Qpqe9f3BOuszxnVieUvhaUbxW/wg+7MXCDuKCCfcNOieC4JMGElB3/M5CC
	 PbrA2Vy4eu+2KAVXApv8RJo6POp5wfDS9Cmv/rpIjFFvyAq3unyRmTDS4A+mhUL/Ldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805376;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AiY2yui9DQjU6dkBTFrcvq3Sdje7Pd4O5PPdTtK3bDs=;
	b=cs7VAmxRXnKmf07wFVFVBLOITstydJx2PQ2HFt8NNoskSt4EHRsSGWF8NAMazdlnlQiS
	 Lz0H4LPCg3YNiQKwYsYMzKEwiu0PfpNOOOeh+r8fYPKrtz/SQ5YxULFo79bQyc3PovT1D
	 Hwea7x4YJhF57BEQBOd/kpReQzKXe398Dl96K+FYbgL5f++/Saqz4XCrivymdegfpWRPt
	 cPmJsaFwXUkqWnEpb8+9JnrbhTDvgP9FlgkbTpjPcsDbtSc7ggSYHnC7cUrhoau9c2+zj
	 vrjMVcGKmZ4NDqPtsKOJnauxNRMcT8FxsZjNMnAkQeVmzVFU/P4fpNQ11PdeSJMeKNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b="Na/adWXn";
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA1608362C;
	Wed,  4 Nov 2026 15:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BA1608362C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=Na/adWXn
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793805373;
	bh=gJ97BxnBMFL4vlZaqEERaFBjAerkYWWjMKMV9bTKY+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Na/adWXnVWlf3d1npu9w6rvFzPG8JEFeEbHlld7ytt6E0TqwnABqWqGVAhWvDbMqY
	 so8EvrcKJi62VsMXLJ4KZJ2d2qT57RxQfmz8bF3IdaL2wOoCnH7zCaQeJv3HtbSfYW
	 QMqt7bb3hk/Pd2fi3XrnXI7zdViQ94Lua0Bk80L1CaTE1ZU33AoGa+Kks01uQCQ3mW
	 TucYRdQJnpLjuvSZWy6gWG75e8XMoJU8QW6IRgIpy4+JG6Yb/okzp8layqXvo9AC++
	 2DCC0tbAwFaqGUj5PdHx5m+qNf6dqLnzGdGZUiGGUbziYp/ZbfoH+ZSnQoV3IVwl5t
	 onZGb8qEcIHhw==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	66ton99@gmail.com,
	josemiguelo.ochoa@gmail.com,
	aditya.garg@linux.dev,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>
Subject: [PATCH 3/4] Revert "Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type"
Date: Wed,  4 Nov 2026 16:16:00 +0100
Message-ID: <20261104151601.70493-4-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104151601.70493-1-dev@deq.rocks>
References: <20261104151601.70493-1-dev@deq.rocks>
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

This reverts commit 88397423671f2b54119a6162a1834d207dcf1a81.

The commit clears the upper bits of the legacy LE Advertising Report
event type for every controller with manufacturer 15, Broadcom. The
reports of these bits, in its own commit message and here, all come
from the Broadcom controllers of the Apple T2 Macs.

The previous patch clears the bits in hci_bcm on Apple machines and in
hci_bcm4377, the drivers of these controllers, before the event reaches
the core. That makes the check in hci_le_adv_report_evt() redundant
for them.

Tested-by: Yossef Osman <Yossef.Osman@proton.me>
Tested-by: Aditya Garg <aditya.garg@linux.dev>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 net/bluetooth/hci_event.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 736dd2f741e..0675c224f6c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6683,17 +6683,6 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 
 		hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
 
-		/* Broadcom ROM firmware (BCM4364B3 on Apple T2 Macs, no
-		 * patchram) sets vendor bits in the legacy Event_Type.
-		 */
-		if (hdev->manufacturer == 15 && info->type > LE_ADV_SCAN_RSP) {
-			/* 0x0f masks out upper vendor bits (0x10, 0x20, 0x80),
-			 * extracting the standard legacy advertising type
-			 * (0x00-0x04) stored in the low nibble (bits 0-3).
-			 */
-			info->type &= 0x0f;
-		}
-
 		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
