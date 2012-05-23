Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 12/12] input: Remove unwanted codes from device
Date: Wed, 23 May 2012 21:27:32 +0530
Message-id: <1337788652-23697-13-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here the variable iconn never be NULL, so no need to check it
against NULL.
---
 input/device.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/input/device.c b/input/device.c
index 77e77b3..e2c48b9 100644
--- a/input/device.c
+++ b/input/device.c
@@ -1153,8 +1153,6 @@ int input_device_register(DBusConnection *conn, struct btd_device *device,
 	}
 
 	iconn = input_conn_new(idev, uuid, timeout);
-	if (!iconn)
-		return -EINVAL;
 
 	idev->connections = g_slist_append(idev->connections, iconn);
 
@@ -1176,9 +1174,6 @@ int fake_input_register(DBusConnection *conn, struct btd_device *device,
 	}
 
 	iconn = input_conn_new(idev, uuid, 0);
-	if (!iconn)
-		return -EINVAL;
-
 	iconn->fake = g_new0(struct fake_input, 1);
 	iconn->fake->ch = channel;
 	iconn->fake->connect = rfcomm_connect;
-- 
1.7.4.1

