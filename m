Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A121340;
	Mon, 22 Jul 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640495; cv=none; b=iebfmWui+dlQ3+1eL0Tn38kQEVMAzhxFU38LJlwT0nELQ2qQ84bXvL2LOIrAbt9Jb1CyqDQ/HA62r5h1L+/1XzmRr9xG1AchzYP3IhdyzhsAXKKrDeQmXkqCbm+EoUt3u3sVFNknKk36FYbYN5WN/yh48htJHiF+GzZc6Kj1how=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640495; c=relaxed/simple;
	bh=YhOXVRafcMg4tYD9zagl52iqpNlfOz9o9bO6OxtTXIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLUw8tZafCI2eJHYCQcXG0mpOdTdT+lDVppvKnAcne069fnTht1M2WeNPrHfOf9511kPYJZ7A/kdWXaBkN4DIp2pA+2q/J6rZ4qKH+qme54ZJKMBBH3CRSv36GqhYmXaiBczizSjDGwHS7aHRJsQirsGQ8O2v5lUz9zUEaMK+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th0NqCl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th0NqCl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C57C4AF0A;
	Mon, 22 Jul 2024 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721640494;
	bh=YhOXVRafcMg4tYD9zagl52iqpNlfOz9o9bO6OxtTXIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=th0NqCl/AHyOVJ+qH5Jn0cTR5xRpXoj9NUd7KC7xwvhbxq9Rlik6WyCrB5BCCyf84
	 7qbANzTllFk6YVvXXhztKlJZc7JS4uV5z2RuuVPP3nE9+sYTfoNZXFvx/fuoJ6Nlni
	 CjPex2FUiYGyhHoNf8K2HCTodsf4WYmpyRH+SP0jaoy/gRxGZCFGSX9rH/X+IYZvaG
	 5r4fhX+inh27tRmsB0SM1jlYuRlEBcgmpSl238IG1MVlSZRXkDH8nQLczN3qR/3a4c
	 4JRi2rVGmvqFxLwB9kxWrqlOKWzCyYEDDOZ7jBJzhLLerOYECdO5rjBG6GJxPr/NWv
	 mgtfYEt1L3IJQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chris Lu <chris.lu@mediatek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sean Wang <sean.wang@mediatek.com>,
	Jing Cai <jing.cai@mediatek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Peter Tsao <peter.tsao@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] Bluetooth: btmtk: remove #ifdef around declarations
Date: Mon, 22 Jul 2024 11:27:06 +0200
Message-Id: <20240722092735.1109925-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722092735.1109925-1-arnd@kernel.org>
References: <20240722092735.1109925-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The caller of these functions in btusb.c is guarded with an
if(IS_ENABLED()) style check, so dead code is left out, but the
declarations are still needed at compile time:

drivers/bluetooth/btusb.c: In function 'btusb_mtk_reset':
drivers/bluetooth/btusb.c:2705:15: error: implicit declaration of function 'btmtk_usb_subsys_reset' [-Wimplicit-function-declaration]
 2705 |         err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
      |               ^~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btusb.c: In function 'btusb_send_frame_mtk':
drivers/bluetooth/btusb.c:2720:23: error: implicit declaration of function 'alloc_mtk_intr_urb' [-Wimplicit-function-declaration]
 2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
      |                       ^~~~~~~~~~~~~~~~~~
drivers/bluetooth/btusb.c:2720:21: error: assignment to 'struct urb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
 2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);
      |                     ^

Fixes: 52828ea60dfd ("Bluetooth: btmtk: Fix btmtk.c undefined reference build error")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btmtk.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6fc69cd8636b..5df7c3296624 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -202,7 +202,6 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
 
-#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
 
 int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
@@ -217,7 +216,6 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
 int btmtk_usb_setup(struct hci_dev *hdev);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev);
-#endif
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
-- 
2.39.2

