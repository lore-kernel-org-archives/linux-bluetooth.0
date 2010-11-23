Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 3/7] Add D-Bus OOB API documentation
Date: Tue, 23 Nov 2010 11:53:08 +0100
Message-ID: <1290509592-9262-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |    2 +-
 doc/oob-api.txt |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)
 create mode 100644 doc/oob-api.txt

diff --git a/Makefile.am b/Makefile.am
index 9607553..ab56edc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -360,7 +360,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/oob-api.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/oob-api.txt b/doc/oob-api.txt
new file mode 100644
index 0000000..4796e4c
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
+Interface       org.bluez.OobProvider
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
+		void Release()
+
+			This method gets called when D-Bus plug-in for OOB was
+			deactivated. There is no need to unregister provider,
+			because when this method gets called it has already been
+			unregistered.
+
+--------------------------------------------------------------------------------
+
+Service		org.bluez
+Interface	org.bluez.OobManager
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterProvider(object provider)
+
+			This method registers provider for D-Bus OOB plug-in.
+			When provider is successfully registered plug-in becomes
+			active. Only one provider per adapter can be registered.
+
+			Possible errors: org.bluez.Error.AlreadyExists
+
+		void UnregisterProvider(object provider)
+
+			This method unregisters provider for D-Bus OOB plug-in.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+		array{byte} hash, array{byte} randomizer ReadLocalOobData()
+
+			This method reads local OOB data for adapter. Return
+			value is pair of arrays 16 bytes each. Only registered
+			provider should call this method.
+
+			Note: This method will generate and return new local
+			OOB data.
+
+			Possible errors: org.bluez.Error.ReadFailed
+					 org.bluez.Error.NoProvider
+					 org.bluez.Error.InProgress
-- 
1.7.1

