Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/4] android/daemon: Clean up get_address name
Date: Mon,  4 Nov 2013 15:22:36 +0200
Message-Id: <1383571358-4942-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383571358-4942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZLUUPkLM_b2DDb=mxc5-QqLrwN9in7XmZGpV+xQ-DpzzQ@mail.gmail.com>
 <1383571358-4942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make function name consistent with the rest of the code.
---
 android/adapter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 3e43d44..c2a6bf3 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -995,7 +995,7 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 	return false;
 }
 
-static void send_adapter_address(void)
+static void get_address(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	int len;
@@ -1096,7 +1096,7 @@ static bool get_property(void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_ADDR:
-		send_adapter_address();
+		get_address();
 		return true;
 	case HAL_PROP_ADAPTER_NAME:
 		return get_name();
-- 
1.7.10.4

