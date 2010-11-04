Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] Add DBus OOB API documentation.
Date: Thu, 4 Nov 2010 11:11:00 +0100
Message-ID: <1288865461-3760-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |    3 +-
 doc/oob-api.txt |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100644 doc/oob-api.txt

diff --git a/Makefile.am b/Makefile.am
index d6cbf92..b5157cd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,7 +358,8 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/oob-api.txt
+
 
 AM_YFLAGS = -d
 
diff --git a/doc/oob-api.txt b/doc/oob-api.txt
new file mode 100644
index 0000000..fce18a7
--- /dev/null
+++ b/doc/oob-api.txt
@@ -0,0 +1,62 @@
+BlueZ D-Bus OOB API description
+*******************************
+
+Copyright (C) 2010  ST-Ericsson SA
+
+Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+
+OOB hierarchy
+=================
+
+Service         unique name
+Interface       org.bluez.OOB
+Object path     freely definable
+
+Methods		array{bye}, array{byte} RequestRemoteOobData(string address)
+
+			This method gets called when the service daemon needs to
+			get hash and randomizer for an OOB authentication.
+
+			The return value should be pair of arrays of 16 bytes
+			each. First hash, second randomizer.
+
+			If no OOB data is present for specified address empty
+			reply should be returned.
+
+		void Deactivate()
+
+			This method gets called when DBus plug-in for OOB was
+			deactivated. There is no need to unregister provider,
+			because when this method gets called it has already been
+			unregistered.
+
+--------------------------------------------------------------------------------
+
+Service         org.bluez
+Interface       org.bluez.OOB
+Object path     /org/bluez
+
+		void RegisterProvider(object provider)
+
+			This method registers provider for DBus OOB plug-in.
+			When provider is successfully registered plug-in becomes
+			active. Only one provider can be registered at time.
+
+			Possible errors: org.bluez.Error.AlreadyExists
+
+		void UnregisterProvider(object provider)
+
+			This method unregisters provider for DBus OOB plug-in.
+			When provider is successfully unregistered plug-in
+			becomes inactive and will emit Deactivated() signal.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+		array{bye}, array{byte} UpdateLocalOobData(string address)
+
+			This method generates new local OOB data for specified
+			address (adapter). Return value is pair of arrays 16
+			bytes each. First hash, second randomizer. Only
+			registered provider should call this method.
+
+			Possible errors: org.bluez.Error.UpdateFailed
-- 
1.7.1

