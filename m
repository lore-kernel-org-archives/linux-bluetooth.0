Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv2 3/7] Add DBus OOB API documentation.
Date: Wed, 10 Nov 2010 14:31:13 +0100
Message-ID: <1289395877-12384-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
References: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |    2 +-
 doc/oob-api.txt |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletions(-)
 create mode 100644 doc/oob-api.txt

diff --git a/Makefile.am b/Makefile.am
index 1f8f7fb..9098084 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,7 +358,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/oob-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/oob-api.txt b/doc/oob-api.txt
new file mode 100644
index 0000000..b0f76db
--- /dev/null
+++ b/doc/oob-api.txt
@@ -0,0 +1,61 @@
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
+Methods		array{byte} hash, array{byte} randomizer
+			RequestRemoteOobData(object device)
+
+			This method gets called when the service daemon needs to
+			get device's hash and randomizer for an OOB
+			authentication. Each array should be 16 bytes long.
+
+			Possible errors: org.bluez.Error.NoData
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
+Methods		void RegisterProvider(object provider)
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
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+
+		array{byte} hash, array{byte} randomizer
+			UpdateLocalOobData(object adapter)
+
+			This method generates new local OOB data for adapter.
+			Return value is pair of arrays 16 bytes each. Only
+			registered provider should call this method.
+
+			Possible errors: org.bluez.Error.UpdateFailed
+					 org.bluez.Error.NoProvider
+					 org.bluez.Error.InProgress
-- 
1.7.1

