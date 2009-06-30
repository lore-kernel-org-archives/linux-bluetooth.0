Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] test/agent.c: honour commandline --device
Date: Tue, 30 Jun 2009 17:16:46 +0200
Message-Id: <1246375008-8282-1-git-send-email-filippo@esaurito.net>
In-Reply-To: <20090630133439.GA27640@jh-x301>
References: <20090630133439.GA27640@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b256f52..334618e 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -281,9 +281,10 @@ static int unregister_agent(DBusConnection *conn, const char *device_path,
 
 static char *get_device(const char *device)
 {
-	char *path;
+	char *path = "/org/bluez/hci0";
 
-	path = strdup("/org/bluez/hci0");
+	if (device)
+		path = strdup(device);
 
 	return path;
 }
-- 
1.6.3.3

