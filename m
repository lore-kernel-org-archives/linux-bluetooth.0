Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 1/9] battery: Add generic device battery documentation
Date: Mon,  7 Jan 2013 16:40:56 -0300
Message-Id: <1357587664-16818-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add documentation for the generic battery D-Bus interface.
---
 doc/battery-api.txt |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 doc/battery-api.txt

diff --git a/doc/battery-api.txt b/doc/battery-api.txt
new file mode 100644
index 0000000..9267bbd
--- /dev/null
+++ b/doc/battery-api.txt
@@ -0,0 +1,24 @@
+BlueZ D-Bus Battery API description
+***********************************
+
+	Texas Instruments, Inc. <chen.ganir@ti.com>
+
+Device Battery hierarchy
+========================
+
+Service		org.bluez
+Interface	org.bluez.Battery1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
+
+Methods		Refresh()
+
+			Refresh the battery level. If the battery level changed,
+			the Level signal will be sent with the new value.
+
+Properties	uint16 Level [readonly]
+
+			Battery level (0-100).
+
+		object Device [readonly]
+
+			Device object that owns the battery.
-- 
1.7.9.5

