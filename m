Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH BlueZ -v2 4/4] monitor: add example filter file
Date: Wed, 23 May 2012 04:16:08 -0300
Message-Id: <1337757368-19994-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337757368-19994-3-git-send-email-gustavo@padovan.org>
References: <1337757368-19994-1-git-send-email-gustavo@padovan.org>
 <1337757368-19994-2-git-send-email-gustavo@padovan.org>
 <1337757368-19994-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 monitor/filter.example |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 monitor/filter.example

diff --git a/monitor/filter.example b/monitor/filter.example
new file mode 100644
index 0000000..c47b046
--- /dev/null
+++ b/monitor/filter.example
@@ -0,0 +1,34 @@
+#
+# Example filter file for btmon.
+#
+# It should be used with the -f option of btmon:
+#
+# $ btmon -f <filter file>
+#
+#
+# The basic structure of the file is show below, we always need a 'Controller'
+# keyword followed by a Bluetooth pattern, wild card is accepted.
+#
+# Then there is 4 possible configurations you can specify:
+#  - 'Timestamps' to show timestamps or not
+#  - 'Show' to selects which protocols to show, any protocol not listed here is
+# hided.
+#  - 'Hide' to hide specific protocols. All the others are shown. 'Show' and
+# 'Hide' can't be used together.
+#  - 'Ignore' to ignore this device in btmon.
+#
+# The available options for 'Show' and 'Hide' are l2cap, sco and hci.
+#
+# If more than one rule matches a HCI device the last rule (from the beginning
+# to the end of the file) will be used.
+
+Controller *
+	Timestamps on
+	Show l2cap
+
+Controller 00:11:22:33:44:55
+	Timestamps off
+	Hide sco,hci
+
+Controller CA:FE:CA:FE:*
+	Ignore
-- 
1.7.10.1

