Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBE35F165;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144989; cv=none; b=aE4vbXu/atvNee7SjQAmDSHGCQ7Hlo2vgPRTb1IKFYeIZxhAqGQ5/KU2iOsToFK2ClJvr6vklHeor7OGdSTRluJzfUu1o6YWV+fEwM+McOzobZPImqXQws9gq4bK0I71nhJixIfP6HqX6k4dROknl1JHg0ZGsr0Lyeh7cf73hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144989; c=relaxed/simple;
	bh=5w5cMnbQ8S9gKwWMF2Qihh0+orwPNLrNq9f+yaKIYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO2FoBpvw4cv9ayY7+ouPAljzQUs5mLFdvD7kO+Zm0cXYB2CHwhTHqlle/VgPX9NsOa4sapOlFaKvs7N9uy2k3OsOXlCzHMDt4/vF3NLFqcIKWDWkmIkjsJKq3R8K5HE1OMBJZbsXrIMRWEub5Rtn8g5sLKKm8I6lIezi7AOdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL230CIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL230CIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C273AC4AF0C;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144988;
	bh=5w5cMnbQ8S9gKwWMF2Qihh0+orwPNLrNq9f+yaKIYbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pL230CIx5VX20b1Wj67I/WC8L9e0cYR/10pRMzqSWsiGbt+D8M/25YmUPHNCcNqeb
	 x3IYnl3P4zlbwYyV5h2VDEG1CyS7qsZvTG6QrBxsey32I1Nbf67h4YFgqPXWOCZBZZ
	 Cwg4zU6vlweUoW1FvXZ6vgyY7vt537a1Q518pBbnhHg/LtPMEd9S0DomwRtsADCaKf
	 nF0os2i6MU62ZVfTursHjeUOS4JkGVqHD1jIQi3nBrL7i5TrKMyTYxXc/5D8sdnV6F
	 lUKpbwIq9SEHqUjx+tppjmV77I2+JuEzSQaRMOTkiB/c6Do/0KLfdW0ejIFEM3917u
	 6dcX8cZmrLfSw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8KIk-0000000ALvS-29mI;
	Thu, 02 Apr 2026 17:49:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v3 3/5] Bluetooth: btusb: fix wakeup source leak on probe failure
Date: Thu,  2 Apr 2026 17:48:08 +0200
Message-ID: <20260402154810.2467291-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402154810.2467291-1-johan@kernel.org>
References: <20260402154810.2467291-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b6f2bed7d1b8..cb0d40a7af8f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4146,7 +4146,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
 #endif
 	if (id->driver_info & BTUSB_CW6622)
@@ -4392,6 +4392,9 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 err_kill_tx_urbs:
 	usb_kill_anchored_urbs(&data->tx_anchor);
+err_disable_wakeup:
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.52.0

