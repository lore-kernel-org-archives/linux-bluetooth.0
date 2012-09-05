Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH BlueZ v3 6/6] replay: Add tutorial
Date: Wed,  5 Sep 2012 16:14:22 +0200
Message-Id: <1346854462-12396-6-git-send-email-ant@antweb.me>
In-Reply-To: <1346854462-12396-1-git-send-email-ant@antweb.me>
References: <1344533773-12914-1-git-send-email-ant@antweb.me>
 <1346854462-12396-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add short tutorial to show example usage of btreplay.
---
 doc/btreplay-tutorial.txt |   60 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 doc/btreplay-tutorial.txt

diff --git a/doc/btreplay-tutorial.txt b/doc/btreplay-tutorial.txt
new file mode 100644
index 0000000..61e96b6
--- /dev/null
+++ b/doc/btreplay-tutorial.txt
@@ -0,0 +1,60 @@
+BlueZ Bluetooth Replayer Tutorial
+*********************************
+
+Copyright (C) 2012  Anton Weber <ant@antweb.me>
+
+
+Create dump
+===========
+A dump can be recorded using the -b option of btmon.
+The best way to record a suitable dump is to disable the Bluetooth controller
+before recording. That way btmon also records the initialisation sequence.
+
+# sudo btmon -b testdump
+<plug in / enable Bluetooth contoller>
+<connect Bluetooth mouse>
+<move mouse around>
+<CTRL+C>
+
+
+Replay dump
+===========
+
+First make sure the VHCI driver is loaded:
+
+# sudo modprobe hci_vhci
+# ls /dev | grep vhci
+
+Now the dump can be replayed with btreplay. When the same machine is used to
+replay the dump, it is recommended to unplug / disable the Bluetooth controller
+to avoid conflicts.
+
+The simplest way to use the Bluetooth Replayer is to run
+
+# sudo btreplay testdump
+
+Some scenarios require minimal delay during the execution to be replayed
+correctly (such as the example above).
+One solution is to use the delta timing mode that adds delays according to the
+time difference between packets in the dump file.
+
+# sudo btreplay -d delta testdump
+
+Running btreplay with a dump from another machine can cause some issues with
+the initialisation sequence. The host might send out packets in a different
+order.
+btreplay will show several packets marked as "[Unknown] ! Wrong opcode" and
+the replay process can get stuck.
+When these packets are not relevant to the actual scenario, they can be ignored
+using a config file. For example, they can be passed on to the emulator.
+To do so, set the action for these packet types to 'emulate' in a config file.
+
+Example config contents:
+
+HCI_CMD_0x03|0x0001 action=emulate
+HCI_CMD_0x03|0x0018 action=emulate
+
+
+and run btreplay with this config file.
+
+# sudo btreplay -d delta -c testconfig testdump
-- 
1.7.9.5

