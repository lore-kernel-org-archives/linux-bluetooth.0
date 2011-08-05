Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:51:34 -0400
Subject: [PATCH 2/4] Bluetooth: hidp: Fix memory leak of cached report
 descriptor
Message-ID: <1312555894.2172.12.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Free the cached HID report descriptor on thread terminate.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 7e19a01..26f0d10 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -764,6 +764,7 @@ static int hidp_session(void *arg)
 
 	up_write(&hidp_session_sem);
 
+	kfree(session->rd_data);
 	kfree(session);
 	return 0;
 }
-- 
1.7.4.1

