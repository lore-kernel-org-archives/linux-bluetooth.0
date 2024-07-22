Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8E21340;
	Mon, 22 Jul 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640462; cv=none; b=eL4vjXlzg7MjMRlU7vPMMtVeIknahpNY20WXbYQiXbUt4aoQ0Affa9Qazp7xUSJicBxSFGo9oA55Lr0BvSf8gK590VRII9uNPunfO22afw90km4WfWOZkro7qtRv8tlHz/B3XDU0nJzmPFmXET1gMCx+7eDP1rW32/pcnIN+SV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640462; c=relaxed/simple;
	bh=YDL2QDJFgsrUPVIO83HKDODRmJYD+Y8GkwoGpOeigAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rc1NN9xWUBiWCHCMcOub978lSxv5rTUf/xqmZ4BC+1CT0mQXXRpBpHT0nHGKsvkDAJXIe06BRAy6KuMhWYdbAbi6QRsFs3Lx9dYgAtf+V4q64YARa36nDPv533veW9Cp96ixF8bTxBoneQ44ynCGO4dR97GqmkBUZyN7VxA8mEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StRPkGLq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StRPkGLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E66C116B1;
	Mon, 22 Jul 2024 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721640461;
	bh=YDL2QDJFgsrUPVIO83HKDODRmJYD+Y8GkwoGpOeigAU=;
	h=From:To:Cc:Subject:Date:From;
	b=StRPkGLqOtB83vx+W3ktNb4bBaGeu/mEHETNfo3B0v/OM6njm2Bw32L8F6HZbt3a6
	 j3DzKLEls461IjgDwITqmdAuuheRJkOqPk/MEMVvNDrhUtT60LKclUfdmP8JpAbZJw
	 PoaCQfH972nqWBxoHSDM78LeP5yf9/v/K6pNa/iF8QCdX2SRoTR1rOo3gc4E/fKPl6
	 mWwccli7bzH28MTNdvqQSoSwAcxRKwON4I7G2/nZ2x9O1TvCD3QgZGnNGng56SygZj
	 hISeuP3qNix7aQ4syJRzeOyNmCiKAjxP5+F+QDAxhE4c8Ai9RfjSKODYd7kPO7kZ0i
	 3/6ND3TgHriUA==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Chris Lu <chris.lu@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
Date: Mon, 22 Jul 2024 11:27:05 +0200
Message-Id: <20240722092735.1109925-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The previous fix was incomplete as the link failure still persists
with CONFIG_USB=m when the sdio or serial wrappers for btmtk.c
are build-in:

btmtk.c:(.text+0x468): undefined reference to `usb_alloc_urb'
btmtk.c:(.text+0x488): undefined reference to `usb_free_urb'
btmtk.c:(.text+0x500): undefined reference to `usb_anchor_urb'
btmtk.c:(.text+0x50a): undefined reference to `usb_submit_urb'
btmtk.c:(.text+0x92c): undefined reference to `usb_control_msg'
btmtk.c:(.text+0xa92): undefined reference to `usb_unanchor_urb'
btmtk.c:(.text+0x11e4): undefined reference to `usb_set_interface'
btmtk.c:(.text+0x120a): undefined reference to `usb_kill_anchored_urbs'

Disallow this configuration.

Fixes: 52828ea60dfd ("Bluetooth: btmtk: Fix btmtk.c undefined reference build error")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 44a2de58337b..082698675849 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -413,6 +413,7 @@ config BT_ATH3K
 config BT_MTKSDIO
 	tristate "MediaTek HCI SDIO driver"
 	depends on MMC
+	depends on USB || !BT_HCIBTUSB_MTK
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI SDIO driver.
@@ -425,6 +426,7 @@ config BT_MTKSDIO
 config BT_MTKUART
 	tristate "MediaTek HCI UART driver"
 	depends on SERIAL_DEV_BUS
+	depends on USB || !BT_HCIBTUSB_MTK
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI UART driver.
-- 
2.39.2

