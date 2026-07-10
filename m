Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958D27281E;
	Fri, 10 Jul 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660640; cv=none; b=t40P04AP5BKoqRdK2Cl487URSe1B5kmYOBfa+5ECjN3608+Uh6HUzfmqeR+MUrMt1jzGwxY7TEdKDPqE7wLHUPrmvSgcnR0TNajZbQHrd4a6MVIEbGDjRSsFC6NHp1DaA+OO4NF4urmqxUW1a9tmuCT1eY+n3r322NBhV2hv9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660640; c=relaxed/simple;
	bh=v8h8OTDsfts+f8xQcfwy8E0kUDGKuTg/aSKZicK6s+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIjM4T5KO0XpoAHLvQHx7p+gh7xlfB1FcXGiMLghwaPeFUUmAwlTDVvGdSl0CeKruSIYK86EcnTuorHyi/VxbyqhPSR39BAZ1a6Rh/BB/TAUeFFa840xwcZ2iaXnKwXtg6Koi/LemIiQYcFOkEvyytJPbw8/VD9MCj/8KWuH+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3QWO8xS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3QWO8xS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1717C2BCB8;
	Fri, 10 Jul 2026 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783660639;
	bh=v8h8OTDsfts+f8xQcfwy8E0kUDGKuTg/aSKZicK6s+c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=X3QWO8xSaSIynshnunmMhWmjYM7riIuCR7wTpFcddWi3GeoSaiZ2gBk8WTHmyw/hV
	 EnsLZvuPSailE8iOboYfSFdIL473q/1aTmmjLOZu8KI/EslOiI4bKZGy40kJ2ntXPu
	 kqoLOIzaUfkdyHtQbj7tcS+axg1vXvT/Mz1X/VONTAz6tW7v6BmHTyVq7YPNHVKHfR
	 1SEiCwtdnXFjTFHP0EnhS7nx5h/VhGwHVqj4YAPx4pP8bZfeCHS/d6wrZZJI88PAVv
	 nTWAG2e9IMOzBd5kvr3YscHGFh1hk3DV+McvzW1X6/MFAv5oOrpBzvTlivBrZ/Nyp3
	 PDUudFUCcr6Zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB15C43458;
	Fri, 10 Jul 2026 05:17:19 +0000 (UTC)
From: Miles Krause via B4 Relay <devnull+mileskrause5200.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 01:17:18 -0400
Subject: [PATCH] Bluetooth: btmtk: use bool for first_block
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-btmtk-first-block-bool-v1-1-e6ac61d918e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF2AUGoC/yXMwQrCMAyA4VcZORtIi6zqq4iHpcs0bq7SVBHG3
 n1Vj9/h/xcwySoGp2aBLG81TXOF2zUQb918FdS+Gjz5loIj5PIoIw6arSBPKY7IKU3IPe0DHwM
 dvIMaP7MM+vmNz5e/7cV3ieV7g3XdALQwKO56AAAA
X-Change-ID: 20260710-btmtk-first-block-bool-bd047b970821
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miles Krause <mileskrause5200@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783660640; l=2026;
 i=mileskrause5200@gmail.com; s=20260710; h=from:subject:message-id;
 bh=w0GMxlpAuvW9E5EoNTZ+r/cb96pIyUjH4Ud4DEGtoUM=;
 b=vYIwok7n0yB2vPf94Ve+SG+QU4JJSO3a1IJ7WltBPX0AqnfPkHP0R5xxqJ7W21A084yFGQG1v
 wCfGgNfnDrCAaLZ4XoWKi0oVnpEF//C8dsVM/JVzQoGMZxHUK1t+lW9
X-Developer-Key: i=mileskrause5200@gmail.com; a=ed25519;
 pk=QNhNjcQarqig3ColJBIEr3DYfWM1PHpP7z+6thxWXaU=
X-Endpoint-Received: by B4 Relay for mileskrause5200@gmail.com/20260710
 with auth_id=861
X-Original-From: Miles Krause <mileskrause5200@gmail.com>
Reply-To: mileskrause5200@gmail.com

From: Miles Krause <mileskrause5200@gmail.com>

first_block is reset for each firmware section and is never used outside
the section loop. Declare it as a bool inside the loop to limit its scope
and make its two-state purpose explicit.

No functional change.

Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
---
Compile-tested on x86_64 with:

  make O=out allmodconfig
  make O=out W=1 drivers/bluetooth/btmtk.o

Sparse-tested with:

  make O=out-sparse allmodconfig
  make O=out-sparse C=1 CHECK=sparse drivers/bluetooth/btmtk.o
---
 drivers/bluetooth/btmtk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 809762d64fc6..b809eb82fc73 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -63,7 +63,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 	const u8 *fw_ptr;
 	const u8 *fw_bin_ptr;
 	int err, dlen, i, status;
-	u8 flag, first_block, retry;
+	u8 flag, retry;
 	u32 section_num, dl_size, section_offset;
 	u8 cmd[64];
 
@@ -79,7 +79,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 	section_num = le32_to_cpu(globaldesc->section_num);
 
 	for (i = 0; i < section_num; i++) {
-		first_block = 1;
+		bool first_block = true;
 		fw_ptr = fw_bin_ptr;
 		sectionmap = (struct btmtk_section_map *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
 			      MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
@@ -132,9 +132,9 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 
 			while (dl_size > 0) {
 				dlen = min_t(int, 250, dl_size);
-				if (first_block == 1) {
+				if (first_block) {
 					flag = 1;
-					first_block = 0;
+					first_block = false;
 				} else if (dl_size - dlen <= 0) {
 					flag = 3;
 				} else {

---
base-commit: 64b5c4c8e79c131fe8f135bab5e5dfaa245c5776
change-id: 20260710-btmtk-first-block-bool-bd047b970821

Best regards,
--  
Miles Krause <mileskrause5200@gmail.com>


