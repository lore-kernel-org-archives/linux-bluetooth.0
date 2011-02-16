Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix creating device object on disconnect complete event
Date: Wed, 16 Feb 2011 15:23:49 +0200
Message-Id: <1297862629-27805-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no need to create a new object if disconnected and the device is
not permanent/paired.
---
 src/event.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index b979a8e..ba8f84a 100644
--- a/src/event.c
+++ b/src/event.c
@@ -697,7 +697,10 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 
 	DBG("");
 
-	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
+	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
+		return;
+
+	if (!device)
 		return;
 
 	adapter_remove_connection(adapter, device);
-- 
1.7.1

