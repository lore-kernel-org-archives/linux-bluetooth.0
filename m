Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] core: Fix typo in adapter.c comments
Date: Fri, 18 Oct 2013 09:32:32 -0300
Message-Id: <1382099552-5562-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1382099552-5562-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1382099552-5562-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 40a9c4e..30bcc4d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -285,7 +285,7 @@ static void set_dev_class_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -487,7 +487,7 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -631,7 +631,7 @@ static void set_local_name_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -753,7 +753,7 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -805,7 +805,7 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -856,7 +856,7 @@ static void clear_uuids_complete(uint8_t status, uint16_t length,
 	}
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
@@ -1868,7 +1868,7 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 	g_dbus_pending_property_success(data->id);
 
 	/*
-	 * The parameters are idential and also the task that is
+	 * The parameters are identical and also the task that is
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
-- 
1.8.3.1

