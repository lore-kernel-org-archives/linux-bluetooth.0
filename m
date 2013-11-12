Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] android: Change TODO with explaining comment
Date: Tue, 12 Nov 2013 13:51:40 +0100
Message-ID: <1384260700-16621-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index a59ab4e..ac1ebc2 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -515,7 +515,10 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
-	/* TODO name and CoD of remote devices should probably be cached */
+	/* It is ok to have empty name and CoD of remote devices here since
+	* those information has been already provided on device_connected event
+	* or during device scaning. Android will use that instead.
+	*/
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
@@ -528,7 +531,10 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
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

