Return-Path: <mussitantesmortem@gmail.com>
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH v2 2/5] drivers: bluetooth: ath3k: do not init variables
Date: Mon,  5 Feb 2018 00:09:44 +0300
Message-Id: <20180204210947.31002-3-mussitantesmortem@gmail.com>
In-Reply-To: <20180204210947.31002-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210947.31002-1-mussitantesmortem@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Do not need to initialize variables, because further on the code they
fall into the snprintf.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 0a5cfea44529..b16c01a0b6d4 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -399,7 +399,7 @@ static int ath3k_set_normal_mode(struct usb_device *udev)
 static int ath3k_load_patch(struct usb_device *udev)
 {
 	unsigned char fw_state;
-	char filename[ATH3K_NAME_LEN] = {0};
+	char filename[ATH3K_NAME_LEN];
 	const struct firmware *firmware;
 	struct ath3k_version fw_version;
 	__u32 pt_rom_version, pt_build_version;
@@ -452,7 +452,7 @@ static int ath3k_load_patch(struct usb_device *udev)
 static int ath3k_load_syscfg(struct usb_device *udev)
 {
 	unsigned char fw_state;
-	char filename[ATH3K_NAME_LEN] = {0};
+	char filename[ATH3K_NAME_LEN];
 	const struct firmware *firmware;
 	struct ath3k_version fw_version;
 	int clk_value, ret;
-- 
2.16.1
