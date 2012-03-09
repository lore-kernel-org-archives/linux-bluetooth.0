Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <Arkadiusz.Lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Arek Lichwa <Arkadiusz.Lichwa@tieto.com>
Subject: [PATCH BlueZ] lib: Populate response status field with rigth error code value taken from command status event.
Date: Fri, 9 Mar 2012 12:12:46 +0100
Message-ID: <1331291566-8997-1-git-send-email-Arkadiusz.Lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 269c021..186d408 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1156,6 +1156,7 @@ int hci_send_req(int dd, struct hci_request *r, int to)
 
 			if (r->event != EVT_CMD_STATUS) {
 				if (cs->status) {
+					memcpy(r->rparam, &cs->status, 1);
 					errno = EIO;
 					goto failed;
 				}
-- 
1.7.0.4

