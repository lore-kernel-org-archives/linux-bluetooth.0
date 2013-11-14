Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/3] android: Change TODO with explaining comment
Date: Thu, 14 Nov 2013 16:24:20 +0100
Message-ID: <1384442660-2730-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384442660-2730-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384442660-2730-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b4e74e5..dfeb54b 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -598,7 +598,10 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
 {
 	struct hal_ev_ssp_request ev;
 
-	/* TODO name and CoD of remote devices should probably be cached */
+	/* It is ok to have empty name and CoD of remote devices here since
+	* those information has been already provided on device_connected event
+	* or during device scaning. Android will use that instead.
+	*/
 	memset(&ev, 0, sizeof(ev));
 	bdaddr2android(addr, ev.bdaddr);
 	ev.pairing_variant = variant;
-- 
1.8.4

