Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v5 6/6] Add oob-api.txt with documentation about OOB D-Bus methods
Date: Fri, 4 Mar 2011 16:08:35 +0100
Message-ID: <1299251315-2041-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
References: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/oob-api.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 doc/oob-api.txt

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
new file mode 100644
index 0000000..7fa09f7
--- /dev/null
+++ b/doc/oob-api.txt
@@ -0,0 +1,38 @@
+BlueZ D-Bus Out Of Band API description
+***********************************
+
+Copyright (C) 2011  Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+
+Service		org.bluez
+Interface	org.bluez.Oob
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		array{byte} hash, array{byte} randomizer ReadLocalOobData()
+
+			This method reads local OOB data from adapter. Return
+			value is pair of arrays 16 bytes each.
+
+			Note: This method will generate and return new local
+			OOB data.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+
+		void AddRemoteOobData(string address, array{byte} hash,
+							array{byte} randomizer)
+
+			This method adds new Out Of Band data for specified
+			address. If data for specified address already exists it
+			will be overwritten with new one.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
+
+		void RemoveRemoteOobData(string address)
+
+			This method removes Out Of Band data for specified
+			address. If data for specified address does not exist
+			nothing is removed.
+
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
-- 
1.7.0.4

