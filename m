Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEE38551C;
	Mon, 30 Mar 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863202; cv=none; b=D4p0/gf4ibGi1k4BQv0fBkKLL6e6B9URYt6cyeA5gffWpj75iQ7GLv9mgnppg3jo2IyPd6FOMaJ8M/2L8GiRZJQp6Um+dng7mJhDkP/eNnJV518tffLCIZQMyYi+DlSflvhLxPpL1NLr0M4hlqP+sGLl27Ap2EaelDTvAg8rKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863202; c=relaxed/simple;
	bh=/koXv/gRjWCD4wnT3R4wEMCqKnoLsgkzSsKyyfQH1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOUQyVBHpkHuTjkAEHBqfdyEWylfHMTzzqWHGQfV6WpDV0tMk0b1+i6iAdm3mWSK7kKcLvguRWplqJvzwB33IkQn/AybPaTFuBrB9mBOG+1bKrMoCBkC625Grq4q/enMnjGXFF4OznK26hWiG0vYUmuEJ7Y5o+ekwDrmdQQbKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+Mpnmfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+Mpnmfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D7AC4CEF7;
	Mon, 30 Mar 2026 09:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863202;
	bh=/koXv/gRjWCD4wnT3R4wEMCqKnoLsgkzSsKyyfQH1N8=;
	h=From:To:Cc:Subject:Date:From;
	b=C+MpnmflUAexr9yUfnKfYhsdkTFpT072SNykzOyHzX/rmMSrAQR0X6bg5a07Furd2
	 34hKMEYAyasvqt2jPuLhFDcz+Xhp9VJkx9FRXjNNObsjJtLHeoWtB2dt4gfmxZLK4w
	 /UylOJ3eb39QAM7Srm2H29QbIDIUP1kIKl0xHRqLcYxwmNKOllPizEXZkXe7uGyr4P
	 hAGY9nCq/39i5FQIl7raFwPthF2k/cvPsqY0Rcn+uGJrG0TGCuEoxJcQh8QKbJBIbo
	 59mrjoM54KjrdbyjB4HlMcsmuILuULZzgZNGX7kqFNMZ5EMMHgePZ2oe/Q1iTMBWU+
	 UbwHlrdGbBj/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w78zn-00000006nx1-2npq;
	Mon, 30 Mar 2026 11:33:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Mon, 30 Mar 2026 11:33:11 +0200
Message-ID: <20260330093311.1621965-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OOB wakeup irq is device managed but its lifetime is incorrectly
tied to the child HCI device rather than the USB interface to which the
driver is bound.

This should not cause any trouble currently as the interrupt is only
enabled during suspend, but it is technically wrong as the reference
counted HCI device could remain after the driver has been unbound.

Note that the data passed to the interrupt handler is not device managed
and is typically freed before the interrupt during disconnect, but this
is also safe as long as the interrupt is disabled.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c535f3ab722..4c5344ce16c1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3801,7 +3801,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	}
 
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
+	ret = devm_request_irq(&data->intf->dev, irq, btusb_oob_wake_handler,
 			       0, "OOB Wake-on-BT", data);
 	if (ret) {
 		bt_dev_err(hdev, "%s: IRQ request failed", __func__);
-- 
2.52.0

