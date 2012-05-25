Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/10] sap-dummy: Use constants when setting ongoing call status
Date: Fri, 25 May 2012 16:20:55 +0200
Message-ID: <1337955662-19016-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This improves readbility of whan new ongoing call status is being set.
---
 sap/sap-dummy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 679adbb..9a21779 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -227,10 +227,10 @@ static DBusMessage *ongoing_call(DBusConnection *conn, DBusMessage *msg,
 	if (ongoing_call_status && !ongoing) {
 		/* An ongoing call has finished. Continue connection.*/
 		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_RESET);
-		ongoing_call_status = ongoing;
+		ongoing_call_status = FALSE;
 	} else if (!ongoing_call_status && ongoing) {
 		/* An ongoing call has started.*/
-		ongoing_call_status = ongoing;
+		ongoing_call_status = TRUE;
 	}
 
 	DBG("OngoingCall status set to %d", ongoing_call_status);
-- 
on behalf of ST-Ericsson

