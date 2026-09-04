Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D701517BD7;
	Fri,  4 Sep 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560667; cv=none; b=u1fMUNwbl3kl1cRxc29OtM5kEZCRSlvpyIKz6dqOfeW/0B+kvZx8nlab6yAXlvXj+kkKcgdjgxn6ODf373k+/KVVlf6hogWABas2hFB7X7wWoHIBWqthA4z9YqT8XSDXd3Bcc7XapDpzL0cOlHkDqR0Hx/cWSWGEDSvITAeCmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560667; c=relaxed/simple;
	bh=PrXupIGMK36s5D6PfG/qC2pq3ZiMWYmQ2f6ItmTVBLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IM4PD+KXoHYXHFdnBMRCZd8O1uaf7RenIjnnIudUtErHr479xHF02Mde+DSzxL5C1ixSR7Uz6gbHWKPk20iFxUJzOBXWbKi4vcq/3wA/lhHMYVPLlqduJbb48LKwSS74QDDqN+TneqOGv4oMVkrI2u51MruqNdiz6Sywy/Xwda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siWQlGe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siWQlGe2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E454CC2BCC7;
	Fri,  4 Sep 2026 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788560666;
	bh=PrXupIGMK36s5D6PfG/qC2pq3ZiMWYmQ2f6ItmTVBLs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=siWQlGe2kpxsavF2YDYo/YUwVsJUsKh1Yiey+HhJm/ZjsNY3USKNSmAPlg5rH460V
	 9gzwQNsqKnQ6ZUjmKoktEnGWTwkqREPXPtszX1HYr51Q1zd1xWzOjhO/HLhy6HwR2M
	 TV0WIZmoBV9OWVbAEZG6ea0qqrIjQLo5YV8215TDmesy1CX/ZZS0Ush6nizoK+nUdW
	 Dm8nWQ5MoiLc2obFmmu0bf8Ksv6WUcRqHmasWta0Tw4dtZPeZAgBYfvzEq54ayUJzV
	 2QxCR/v60HUIxE+OOuBEcERls06OTVN+Klat/sFteDCNlOHXUwagWzfc7uzOAjsFSB
	 2WINuZGRdnDvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FAC624D3;
	Fri,  4 Sep 2026 22:24:26 +0000 (UTC)
From: Johann Fischer via B4 Relay <devnull+johann.fischer.nordicsemi.no@kernel.org>
Date: Sat, 05 Sep 2026 00:24:08 +0200
Subject: [PATCH] Bluetooth: btusb: do not probe non-HCI interfaces
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-btusb-skip-non-hci-ifaces-v1-1-32dda494122f@nordicsemi.no>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB1Igz+1VxEXmXSsUyFKRkUQ7
 25sl9/ivQOUo7DCKzsg8iYqU0h45Bn4wYUPo7yTwRpbmcYUSMuqhDrKjGEKOHhB6Z1nRSotO9s
 8q7omSP0cuZf99267v3WlL/vlHsJ5XnnktPR9AAAA
X-Change-ID: 20260904-btusb-skip-non-hci-ifaces-b52ea298677b
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johann Fischer <johann.fischer@nordicsemi.no>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=johann.fischer@nordicsemi.no; h=from:subject:message-id;
 bh=N9bMTaAocKK1v8xDH8TgTymZY5ojzij51J8enWGWLwY=;
 b=owEBbQKS/ZANAwAKAYSE5whenKmxAcsmYgBqm0UZ9dRRF5Qie8QtQ3kv0opJyLtOVGhp78COk
 rMYHFv7SfyJAjMEAAEKAB0WIQRX82HLlVW1Jm9YMr+EhOcIXpypsQUCaptFGQAKCRCEhOcIXpyp
 seC/EACvELEj4cxv8kO2tR9jfXdVyszVPCZ8e+4YQdBtTrUcroSwb8Wp9J9JmrdkIQsTrs93Uyp
 P4QG64asNL+z1uuAwdi1HwQBGVlNUFzTmTVRLhC2U1GQYoapmtWDI7L3xbhvW1jhynxbZFPHIqO
 KnV0xYoGj4oOSDHWmMyY/HESTqKQHY9m4thSDjze6eg0xK/CjHMZep6Z8azi84oXhcAm2Ums8Fc
 +VeAU81ERiprydS0gEanuzXrGaznZC7Ygmn1/LfJkAbOA+ZZh3G0SaYugNuuGf4EyriAnIT4V/a
 uohIlY3w1q5wAZ5jM9g85G5KiI3VtWejxaNj4LXebwOCM4XpkA1eWN2+r9iwfDFadx6fkHUrXSV
 r7/9yNcIR8WH19pSoDFNuhuxg9cn3R4bt9XaUbE55jdQ8wCKChslEFoNa64ZOM43WItuWc2gqCc
 /pYrb2QTa+WtYwokE65bs05EuoiGZeHqcDFjtpgIGBXPiMdzP0gKqafCSuxZd0IK0pj0L8cq68x
 eDHXVpqU4yMKC5oR22sF4URK5gcUxuc77509y7MLqqjRNUi9ZSXFk0yILSKSVpykWPouASy7kIK
 aJJEWyovgqKZtq/bLtVgPHYoi1tNS1PRfUFCRQFvJbrc1V0geNs65754B101kzfNHj57LSxQwBp
 PmMZaJMpL9RUdkQ==
X-Developer-Key: i=johann.fischer@nordicsemi.no; a=openpgp;
 fpr=57F361CB9555B5266F5832BF8484E7085E9CA9B1
X-Endpoint-Received: by B4 Relay for johann.fischer@nordicsemi.no/default
 with auth_id=1003
X-Original-From: Johann Fischer <johann.fischer@nordicsemi.no>
Reply-To: johann.fischer@nordicsemi.no

From: Johann Fischer <johann.fischer@nordicsemi.no>

If the driver selects BTUSB_PROTO_H4, the second interface (voice
channels) remains unclaimed. Then, the btusb_probe() is called for the
second interface. It misidentifies the interface as one that supports
legacy mode and fails with "failed to enumerate endpoints".

Signed-off-by: Johann Fischer <johann.fischer@nordicsemi.no>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dfefb43fb792..44f0db347643 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4293,6 +4293,11 @@ static int btusb_probe(struct usb_interface *intf,
 			return -ENODEV;
 	}
 
+	/*  Skip interfaces that do not implement the HCI transport */
+	if (usb_find_common_endpoints(intf->cur_altsetting,
+				      &bulk_rx_ep, &bulk_tx_ep, &intr_ep, NULL))
+		return -ENODEV;
+
 	data = kzalloc_obj(*data);
 	if (!data)
 		return -ENOMEM;

---
base-commit: 88a8184cb44c8952e6a6fd21e250445300d1c7aa
change-id: 20260904-btusb-skip-non-hci-ifaces-b52ea298677b

Best regards,
--  
Johann


