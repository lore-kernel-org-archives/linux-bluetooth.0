Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v3] Add release all sessions when adapter is switched off
Date: Tue, 22 Mar 2011 14:29:07 +0200
Message-Id: <1300796947-1518-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1300796947-1518-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1300796947-1518-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All sessions should be released when adapter is switched off. Then a new
RequestSession method call always results in change from power off to power
on such ensuring operational mode. Otherwise, it is possible to end up in
adapter state being powered off after RequestSession succeded.

g_slist_free is not called after g_slist_foreach because the list is updated
using g_slist_remove inside of session_free, which is called for each element
by g_slist_foreach.
---
 src/adapter.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc4f43e..691b963 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2507,6 +2507,15 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	DBG("");
 
+	/*
+	 * g_slist_free is not called after g_slist_foreach because the list is
+	 * updated using g_slist_remove in session_remove which is called by
+         * session_free, which is called for each element by g_slist_foreach.
+	 */
+	if (adapter->mode == MODE_OFF)
+		g_slist_foreach(adapter->mode_sessions, (GFunc) session_free,
+									NULL);
+
 	if (adapter->pending_mode == NULL)
 		return;
 
-- 
1.7.1

