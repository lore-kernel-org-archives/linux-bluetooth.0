Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:52:01 -0400
Subject: [PATCH 4/4] Bluetooth: hidp: Don't release device ref if never held
Message-ID: <1312555921.2172.14.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an hidp connection is added for a boot protocol input
device, don't release a device reference that was never
acquired. The device reference is acquired when the session
is linked to the session list (which hasn't happened yet when
hidp_setup_input is called).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a859f90..fb68f34 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -844,7 +844,6 @@ static int hidp_setup_input(struct hidp_session *session,
 	if (err < 0) {
 		input_free_device(input);
 		session->input = NULL;
-		hci_conn_put_device(session->conn);
 		return err;
 	}
 
-- 
1.7.4.1

