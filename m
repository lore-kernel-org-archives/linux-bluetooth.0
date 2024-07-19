Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30E29A1;
	Fri, 19 Jul 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383561; cv=none; b=avIAvCS/wZy/bzf8nydYPa4BOdhZrV4/yQBUNlHXoe84WSZ+OKPygIsoY2KWbGii6VtXEwZK+EfDnn2aakLsQeU+g8nJiffbekJwMs1IRcIJXE49sww/4OzIVZ5k4JOAki7BAczOACey9GGOOZdOoRYYggC1l9AC6e6Rxy1jeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383561; c=relaxed/simple;
	bh=sINWgXxddUzYRyDAErofwiMxBkh6XLtJM46yfDgg1vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CVDIQnk5LEbayML71+b0WM1utlDSbqgMTmgMnRd8jruTsBYA6BQIAbYwtmdpxrG5Zb5y+DMzH7Wkx9/yWwrAq6gPtQetjVqEFRAEa4iJOPkCf2bzuYXBme+Q2fNcvq61Vftp/T9dnXJW0rCdSrfgttvOUUK8qmwyjQPaoYPipGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLJEqbF7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLJEqbF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EC6C4AF0A;
	Fri, 19 Jul 2024 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721383560;
	bh=sINWgXxddUzYRyDAErofwiMxBkh6XLtJM46yfDgg1vQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rLJEqbF7yRdgk3+DvdhBj0jFTmQH5lU4E6NnWFT8Xn4RiQrzAYWYSvQQ5TTPWzU87
	 KvLfofiV3SwTPEHCXXNWAK8+FI5PQQwQZN0KlxCdmk+KY0XfixtrUYRkR7iLtwIzkY
	 KDAwSz/N8oJVcKvc/oZaE0eufN+QqAP2k3AEqKEl7XwuWxaSQOcRIpOrHiDYy5kbjD
	 Wv+/+fp4HX8N/KqCgbogF2RYX8/Oca8rjRlLj4xZzjzkXl8Z9WbzjDzEce7WSf1U64
	 niy6ly2P7gNixlrbMPvdBZGDLtBo6Sv1w+89+jif75ZymxalL6hVm6nGvywrMykCo0
	 0J6JwddhXXKfw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sven Peter <sven@svenpeter.dev>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtk: add USB dependencies
Date: Fri, 19 Jul 2024 12:05:45 +0200
Message-Id: <20240719100554.4183635-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The mediatek bluetooth drivers have a common portion that is now used for
all front-ends (usb, sdio, uart) but that internally relies on USB
interface functions:

ERROR: modpost: "usb_alloc_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_anchor_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_submit_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_free_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_unanchor_urb" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_kill_anchored_urbs" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_set_interface" [drivers/bluetooth/btmtk.ko] undefined!
ERROR: modpost: "usb_control_msg" [drivers/bluetooth/btmtk.ko] undefined!

It would be possible to split this up further, but in practice anything
that uses this driver will have USB enabled anyway and it only matters
for build testing, so just go with a much stricter dependency.

Fixes: f5c3f98946e3 ("Bluetooth: btmtkuart: rely on BT_MTK module")
Fixes: 3a722044aacf ("Bluetooth: btmtksido: rely on BT_MTK module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 44a2de58337b..2894a345562c 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -21,6 +21,7 @@ config BT_QCA
 
 config BT_MTK
 	tristate
+	depends on USB
 	select FW_LOADER
 
 config BT_HCIBTUSB
@@ -413,6 +414,7 @@ config BT_ATH3K
 config BT_MTKSDIO
 	tristate "MediaTek HCI SDIO driver"
 	depends on MMC
+	depends on USB
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI SDIO driver.
@@ -425,6 +427,7 @@ config BT_MTKSDIO
 config BT_MTKUART
 	tristate "MediaTek HCI UART driver"
 	depends on SERIAL_DEV_BUS
+	depends on USB
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI UART driver.
-- 
2.39.2

