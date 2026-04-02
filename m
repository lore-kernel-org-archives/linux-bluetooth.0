Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFE289367;
	Thu,  2 Apr 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139086; cv=none; b=QxzE4ZvDArrFNPsb6KPS3rE6dA/aEKwd8eb8XogXVTyon9MHzs2ez0cOW3zoPhp+VWL5giMTDrVnPOeZQK6dY0ptkB1fHQQOfawFPbh80JqujIN3mXemypFUy95euWl+JIX5aq6wVsFj2DBoJIBpiXLWGapeoxXd0SWRX8CWcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139086; c=relaxed/simple;
	bh=+6ca/Obmn4va08+h17L1/nNzv5x2583fM9j2PQdNcdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DK+pn7XB0MYS5pCBXu3ZWrBxhS6waszZEjwAOiTRgQuAL58I6KfbMf9MCDmQpSI0U8W7rU6C00k1tRq9xsLUNS9/SZi5oOW8UobeUkX3mZs1wazHruvNRX3/p76f4ZxxW7W9YZmli5kjZ0OUwaa2iNS8GnopGgMB467n1Exh/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL7/F0qQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL7/F0qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F12C116C6;
	Thu,  2 Apr 2026 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775139085;
	bh=+6ca/Obmn4va08+h17L1/nNzv5x2583fM9j2PQdNcdI=;
	h=From:To:Cc:Subject:Date:From;
	b=nL7/F0qQVtHVQ5aSo/IlwVnjKBud5//OsJER78W5GUNtxUyrEMG3wa3DXrM2ngv+G
	 Y5ogpABSGhDHj3vvctyVf2JBUEk1bZiedX0VFsTkbQNgAKC2TSybaK9UUxc9hmalX0
	 +vE2Y9VwoU2CVhgt8xHaICwNbaYhKzMD8039r3c75iwm+PcM+981rkBHb9lZjqtn6+
	 M9Uff64uESOrSszNRM32HZP1lgVVzvAzYXfwRN4JFzutdsewPembNz6PAcrwarnnAz
	 W/GTYU8N9/HfARegpokJ0iPA0plitzQ4WwBgVXsMXF9kc9m0MySjd6Usvk9miklIED
	 FkGvCZqzJZPzg==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Javier Tia <floss@jetm.me>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Chris Lu <chris.lu@mediatek.com>,
	Kees Cook <kees@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Jiande Lu <jiande.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtk: hide unused  btmtk_mt6639_devs[] array
Date: Thu,  2 Apr 2026 16:11:15 +0200
Message-Id: <20260402141119.2732591-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When USB support is disabled, the array is not referenced anywhere,
causing a warning:

drivers/bluetooth/btmtk.c:35:3: error: 'btmtk_mt6639_devs' defined but not used [-Werror=unused-const-variable=]
   35 | } btmtk_mt6639_devs[] = {
      |   ^~~~~~~~~~~~~~~~~

Move it into the #ifdef block.

Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btmtk.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 099188bf772e..6fb6ca274808 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -25,22 +25,6 @@
 /* It is for mt79xx iso data transmission setting */
 #define MTK_ISO_THRESHOLD	264
 
-/* Known MT6639 (MT7927) Bluetooth USB devices.
- * Used to scope the zero-CHIPID workaround to real MT6639 hardware,
- * since some boards return 0x0000 from the MMIO chip ID register.
- */
-static const struct {
-	u16 vendor;
-	u16 product;
-} btmtk_mt6639_devs[] = {
-	{ 0x0489, 0xe13a },	/* ASUS ROG Crosshair X870E Hero */
-	{ 0x0489, 0xe0fa },	/* Lenovo Legion Pro 7 16ARX9 */
-	{ 0x0489, 0xe10f },	/* Gigabyte Z790 AORUS MASTER X */
-	{ 0x0489, 0xe110 },	/* MSI X870E Ace Max */
-	{ 0x0489, 0xe116 },	/* TP-Link Archer TBE550E */
-	{ 0x13d3, 0x3588 },	/* ASUS ROG STRIX X870E-E */
-};
-
 struct btmtk_patch_header {
 	u8 datetime[16];
 	u8 platform[4];
@@ -483,6 +467,22 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 EXPORT_SYMBOL_GPL(btmtk_process_coredump);
 
 #if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
+/* Known MT6639 (MT7927) Bluetooth USB devices.
+ * Used to scope the zero-CHIPID workaround to real MT6639 hardware,
+ * since some boards return 0x0000 from the MMIO chip ID register.
+ */
+static const struct {
+	u16 vendor;
+	u16 product;
+} btmtk_mt6639_devs[] = {
+	{ 0x0489, 0xe13a },	/* ASUS ROG Crosshair X870E Hero */
+	{ 0x0489, 0xe0fa },	/* Lenovo Legion Pro 7 16ARX9 */
+	{ 0x0489, 0xe10f },	/* Gigabyte Z790 AORUS MASTER X */
+	{ 0x0489, 0xe110 },	/* MSI X870E Ace Max */
+	{ 0x0489, 0xe116 },	/* TP-Link Archer TBE550E */
+	{ 0x13d3, 0x3588 },	/* ASUS ROG STRIX X870E-E */
+};
+
 static void btmtk_usb_wmt_recv(struct urb *urb)
 {
 	struct hci_dev *hdev = urb->context;
-- 
2.39.5

