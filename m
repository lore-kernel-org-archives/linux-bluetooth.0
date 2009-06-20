Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Jun 2009 11:49:27 +0530
From: Vikram Kandukuri <vkandukuri@atheros.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Kill session whenever VIRTUAL_CABLE_UNPLUG is
	passed.
Message-ID: <20090620061927.GC9947@atheros-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Whenever the remote device sends VIRTUAL CABLE UNPLUG, the device should
be disconnected.

Signed-off-by: Jothikumar Mothilal <jothikumar.mothilal@atheros.com>
---
 net/bluetooth/hidp/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index b186768..a9f7afb 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -374,6 +374,7 @@ static void hidp_process_hid_control(struct hidp_session *session,
 
 		/* Kill session thread */
 		atomic_inc(&session->terminate);
+		hidp_schedule(session);
 	}
 }
 
-- 
1.6.0.4
