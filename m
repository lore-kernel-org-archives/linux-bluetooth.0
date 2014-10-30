Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] tools/mcaptest: Add missing MCL connected log
Date: Thu, 30 Oct 2014 12:15:06 +0100
Message-Id: <1414667707-2640-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Loging state of MCAP channels is very helpful while analyzing
connection.
---
 tools/mcaptest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index dd638c9..6d50544 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -257,6 +257,8 @@ static void mcl_connected(struct mcap_mcl *mcap_mcl, gpointer data)
 
 static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
 {
+	printf("%s\n", __func__);
+
 	if (err) {
 		printf("Could not connect MCL: %s\n", err->message);
 
-- 
1.9.3

