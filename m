Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH BlueZ] gdbus: Fix crash error when calling g_dbus_remove_all_watches
Date: Fri, 24 Aug 2012 13:09:19 +0300
Message-Id: <1345802959-11774-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
Hi,

While using gdbus on some other code, I found out that bug around g_dbus_remove_all_watches() usage.

Tomasz

 gdbus/watch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index d749176..968a38a 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -298,6 +298,9 @@ static void filter_data_call_and_free(struct filter_data *data)
 		g_free(cb);
 	}
 
+	g_slist_free(data->callbacks);
+	data->callbacks = NULL;
+
 	filter_data_free(data);
 }
 
-- 
1.7.8.6

