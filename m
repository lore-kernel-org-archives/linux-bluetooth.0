Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Add release all sessions when adapter is switched off
Date: Mon, 21 Mar 2011 17:39:19 +0200
Message-Id: <1300721959-5913-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All sessions should be released when adapter is switched off. Then a new
RequestSession method call always results in change from power off to power
on such ensuring operational mode. Otherwise, it is possible to end up in
adapter state being powered off after RequestSession succeded.
---
 src/adapter.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc4f43e..f1c0e2a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2507,6 +2507,10 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	DBG("");
 
+	if (adapter->mode == MODE_OFF)
+		g_slist_foreach(adapter->mode_sessions, (GFunc)  session_free,
+									NULL);
+
 	if (adapter->pending_mode == NULL)
 		return;
 
-- 
1.7.1

