Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] neard: Set device name in cache and device object
Date: Wed,  7 Nov 2012 12:02:02 +0100
Message-Id: <1352286123-12992-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/neard.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 8018977..8f8381c 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -42,6 +42,7 @@
 #include "storage.h"
 #include "agent.h"
 #include "hcid.h"
+#include "event.h"
 
 #define NEARD_NAME "org.neard"
 #define NEARD_PATH "/"
@@ -293,8 +294,8 @@ static int process_eir(struct btd_adapter *adapter, uint8_t *eir, size_t size,
 
 	/* TODO handle incomplete name? */
 	if (eir_data.name)
-		write_device_name(adapter_get_address(adapter), &eir_data.addr,
-						BDADDR_BREDR, eir_data.name);
+		btd_event_remote_name(adapter_get_address(adapter),
+					&eir_data.addr, eir_data.name);
 
 	if (eir_data.hash)
 		btd_adapter_add_remote_oob_data(adapter, &eir_data.addr,
-- 
1.7.9.5

