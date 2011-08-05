Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:51:50 -0400
Subject: [PATCH 3/4] Bluetooth: hidp: Only free input device if failed
 register
Message-ID: <1312555910.2172.13.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an hidp connection is added for a boot protocol input
device, only free the allocated device if device registration fails.
Subsequent failures should only unregister the device (the input
device api documents that unregister will also free the allocated
device).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 26f0d10..a859f90 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -842,6 +842,8 @@ static int hidp_setup_input(struct hidp_session *session,
 
 	err = input_register_device(input);
 	if (err < 0) {
+		input_free_device(input);
+		session->input = NULL;
 		hci_conn_put_device(session->conn);
 		return err;
 	}
@@ -1089,7 +1091,6 @@ purge:
 failed:
 	up_write(&hidp_session_sem);
 
-	input_free_device(session->input);
 	kfree(session);
 	return err;
 }
-- 
1.7.4.1

