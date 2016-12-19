Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/test-runner: Fix not creating /usr/share/dbus-1/system.conf
Date: Mon, 19 Dec 2016 13:16:21 +0200
Message-Id: <20161219111621.16199-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Apparently this is the new location where D-Bus will look for its
configuration so just creare a symlink to /etc/dbus-1/system.conf.
---
 tools/test-runner.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 9b54426..fb8f7e2 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -419,6 +419,10 @@ static void create_dbus_system_conf(void)
 
 	fclose(fp);
 
+	if (symlink("/etc/dbus-1/system.conf",
+				"/usr/share/dbus-1/system.conf") < 0)
+		perror("Failed to create system.conf symlink");
+
 	mkdir("/run/dbus", 0755);
 }
 
-- 
2.9.3

