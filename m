Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <arkadiusz.lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>,
	Arek Lichwa <arkadiusz.lichwa@tieto.com>
Subject: [PATCH] Remove too early null assignment to working rfcomm channel in sap server.
Date: Mon, 18 Jul 2011 15:21:34 +0200
Message-ID: <1310995294-3215-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When dropping rfcomm channel to sap server, the component's channel
cleanup process doesn't trigger disallocation of assigned glib resources
since reference to working channel is already marked as null.
---
 sap/server.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index c55aa6e..8bd8fe1 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1122,7 +1122,6 @@ static void sap_io_destroy(void *data)
 				conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
 			sap_disconnect_req(NULL, 1);
 
-		conn->io = NULL;
 		sap_conn_remove(conn);
 	}
 }
-- 
1.7.6

