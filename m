Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix crash after simultaneous authentication requests
Date: Thu, 25 Nov 2010 11:06:55 +0100
Message-Id: <1290679615-26273-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously simultaneous authentication requests to the same device caused
bluetoothd crash. Now if ongoing authentication occurs error is returned,
preventing from simultaneous requests to the same device.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7c421e3..4427cd4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2178,6 +2178,11 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 	struct agent *agent;
 	int err;
 
+	if (device->authr) {
+		error("%s: authentication already requested", device->path);
+		return -EALREADY;
+	}
+
 	DBG("%s: requesting agent authentication", device->path);
 
 	agent = device_get_agent(device);
-- 
1.6.3.3

