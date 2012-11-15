Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] event: Set device class in device object
Date: Thu, 15 Nov 2012 18:31:39 +0100
Message-Id: <1353000701-16605-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
References: <1353000701-16605-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/event.c b/src/event.c
index 5f1fc9f..7fc8f02 100644
--- a/src/event.c
+++ b/src/event.c
@@ -419,7 +419,7 @@ void btd_event_conn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t bdaddr_typ
 	update_lastused(local, peer, bdaddr_type);
 
 	if (class != 0)
-		write_remote_class(local, peer, class);
+		device_set_class(device, class);
 
 	device_set_addr_type(device, bdaddr_type);
 
-- 
1.7.9.5

