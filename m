Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] android/tester: Fix remote advertising data
Date: Thu, 21 Dec 2017 09:43:39 +0100
Message-Id: <20171221084339.6761-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Advertising Data doesn't have terminator field like EIR. This was
causing error logs from kernel when data length was corrected.
---
 android/tester-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 3a557923b..e9b13537a 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2722,12 +2722,11 @@ void emu_setup_powered_remote_action(void)
 
 	if ((data->hciemu_type == HCIEMU_TYPE_LE) ||
 				(data->hciemu_type == HCIEMU_TYPE_BREDRLE)) {
-		uint8_t adv[4];
+		uint8_t adv[3];
 
 		adv[0] = 0x02;	/* Field length */
 		adv[1] = 0x01;	/* Flags */
 		adv[2] = 0x02;	/* Flags value */
-		adv[3] = 0x00;	/* Field terminator */
 
 		bthost_set_adv_data(bthost, adv, sizeof(adv));
 		bthost_set_adv_enable(bthost, 0x01);
-- 
2.14.3

