Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/8] android/bluetooth: Fix coding style issue in set_device_bond_state
Date: Tue, 10 Dec 2013 16:06:17 +0100
Message-Id: <1386687982-1799-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
References: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 17c8e7a..5494dcb 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -372,7 +372,8 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 }
 
 static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
-								int state) {
+								int state)
+{
 
 	struct device *dev;
 
-- 
1.8.3.2

