Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 13/13] soletta: Add a sample flow using the heartrate node
Date: Thu,  2 Jul 2015 11:33:54 -0300
Message-Id: <1435847634-22831-14-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The flow and associated conffile, defines a very simple flow using the
heartrate node.

With soletta already installed you just run it, something like this:

$ sol-fbp-runner heartrate.fbp

It will look for the sol-flow.conf (which would define options for the
nodes) in the current directory.
---
 soletta/heartrate.fbp | 1 +
 soletta/sol-flow.conf | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 soletta/heartrate.fbp
 create mode 100644 soletta/sol-flow.conf

diff --git a/soletta/heartrate.fbp b/soletta/heartrate.fbp
new file mode 100644
index 0000000..63185c4
--- /dev/null
+++ b/soletta/heartrate.fbp
@@ -0,0 +1 @@
+Timer(timer:interval=1000) OUT -> IN Heartrate(heartrate)
diff --git a/soletta/sol-flow.conf b/soletta/sol-flow.conf
new file mode 100644
index 0000000..08ea12e
--- /dev/null
+++ b/soletta/sol-flow.conf
@@ -0,0 +1,2 @@
+[SolettaNodeEntry Heartrate]
+Type=heartrate
-- 
2.4.5

