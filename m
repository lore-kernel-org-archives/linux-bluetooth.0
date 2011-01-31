Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix creating device object when device disconnects
Date: Mon, 31 Jan 2011 14:56:36 +0200
Message-Id: <1296478596-18269-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1296478596-18269-1-git-send-email-luiz.dentz@gmail.com>
References: <1296478596-18269-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

If object doesn't exist the device is not permanent so there is no need
to create a new object just to handle disconnect event.
---
 src/event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/event.c b/src/event.c
index 166e401..5060e84 100644
--- a/src/event.c
+++ b/src/event.c
@@ -692,7 +692,7 @@ void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
 
 	DBG("");
 
-	if (!get_adapter_and_device(local, peer, &adapter, &device, TRUE))
+	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
 	adapter_remove_connection(adapter, device);
-- 
1.7.1

