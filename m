Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android: Change TODO with explaining comment
Date: Fri, 8 Nov 2013 16:48:31 +0100
Message-ID: <1383925711-26374-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index cd820df..cb25954 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -509,7 +509,10 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
-	/* TODO name and CoD of remote devices should probably be cached */
+	/* It is ok to have empty name and CoD of remote devices here since
+	* those information has been already provided on device_connected event
+	* or during device scaning. Android will use that instead.
+	*/
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
 
@@ -522,7 +525,10 @@ static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
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

