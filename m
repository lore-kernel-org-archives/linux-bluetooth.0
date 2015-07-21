Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 13/15] soletta: Add a sample flow using the heartrate node
Date: Tue, 21 Jul 2015 20:16:46 -0300
Message-Id: <1437520608-22444-14-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The flow and associated conffile, defines a very simple flow using the
heartrate node.

With soletta already installed you just run it, something like this:

$ sol-fbp-runner heartrate.fbp

It will look for the sol-flow.conf (which would define options for the
nodes) in the current directory.
---
 peripheral/soletta/heartrate.fbp | 1 +
 peripheral/soletta/sol-flow.json | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 peripheral/soletta/heartrate.fbp
 create mode 100644 peripheral/soletta/sol-flow.json

diff --git a/peripheral/soletta/heartrate.fbp b/peripheral/soletta/heartrate.fbp
new file mode 100644
index 0000000..63185c4
--- /dev/null
+++ b/peripheral/soletta/heartrate.fbp
@@ -0,0 +1 @@
+Timer(timer:interval=1000) OUT -> IN Heartrate(heartrate)
diff --git a/peripheral/soletta/sol-flow.json b/peripheral/soletta/sol-flow.json
new file mode 100644
index 0000000..c1f8fca
--- /dev/null
+++ b/peripheral/soletta/sol-flow.json
@@ -0,0 +1,8 @@
+{
+ "nodetypes": [
+  {
+   "name": "Heartrate",
+   "type": "heartrate"
+  }
+ ]
+}
-- 
2.4.6

