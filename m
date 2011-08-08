Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 11/11] Fix wrong alert value for ImmediateAlertLevel
Date: Mon,  8 Aug 2011 15:46:50 -0300
Message-Id: <1312829210-6781-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GetProperties method is returning wrong value for ImmediateAlertLevel.
Bug introduced by ffd21d4027cd91d864857d2d4c3664b3087c5e0a
---
 proximity/monitor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index b59e7a0..55d3985 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -463,7 +463,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	if (monitor->enabled.findme || monitor->enabled.pathloss)
 		dict_append_entry(&dict, "ImmediateAlertLevel",
-				DBUS_TYPE_STRING, &monitor->linklosslevel);
+				DBUS_TYPE_STRING, &monitor->immediatelevel);
 
 	if (monitor->enabled.pathloss)
 		dict_append_entry(&dict, "SignalLevel",
-- 
1.7.6

