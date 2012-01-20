Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Remove dead code from bonding_request_new
Date: Fri, 20 Jan 2012 16:26:26 +0100
Message-ID: <1327073187-1009-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

agent_create always return valid pointer so there is not need to check
for NULL as this will never happen.
---
 src/device.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 16855b1..5224984 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2225,7 +2225,6 @@ static struct bonding_req *bonding_request_new(DBusConnection *conn,
 {
 	struct bonding_req *bonding;
 	const char *name = dbus_message_get_sender(msg);
-	struct agent *agent;
 	char addr[18];
 
 	ba2str(&device->bdaddr, addr);
@@ -2234,16 +2233,10 @@ static struct bonding_req *bonding_request_new(DBusConnection *conn,
 	if (!agent_path)
 		goto proceed;
 
-	agent = agent_create(device->adapter, name, agent_path,
+	device->agent = agent_create(device->adapter, name, agent_path,
 					capability,
 					device_agent_removed,
 					device);
-	if (!agent) {
-		error("Unable to create a new agent");
-		return NULL;
-	}
-
-	device->agent = agent;
 
 	DBG("Temporary agent registered for %s at %s:%s",
 			addr, name, agent_path);
-- 
on behalf of ST-Ericsson

