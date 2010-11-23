Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 6/7] Update D-Bus OOB API with RequestPairing method
Date: Tue, 23 Nov 2010 11:53:11 +0100
Message-ID: <1290509592-9262-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/oob-api.txt      |   14 +++++++++
 doc/oob-api.txt.orig |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 doc/oob-api.txt.orig

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 4796e4c..e08f6f8 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -60,3 +60,17 @@ Methods		void RegisterProvider(object provider)
 			Possible errors: org.bluez.Error.ReadFailed
 					 org.bluez.Error.NoProvider
 					 org.bluez.Error.InProgress
+
+--------------------------------------------------------------------------------
+
+Service		unique name
+Interface	org.bluez.Agent
+Object path	freely definable
+
+Methods		void RequestPairing(object device)
+
+			This method gets called when the service daemon
+			needs to confirm incoming pairing request.
+
+			Possible errors: org.bluez.Error.Rejected
+					 org.bluez.Error.Canceled
diff --git a/doc/oob-api.txt.orig b/doc/oob-api.txt.orig
new file mode 100644
index 0000000..95dd3a4
--- /dev/null
+++ b/doc/oob-api.txt.orig
@@ -0,0 +1,79 @@
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
+<<<<<<< HEAD
+=======
+
+--------------------------------------------------------------------------------
+
+Service		unique name
+Interface	org.bluez.Agent
+Object path	freely definable
+
+Methods		void RequestPairing(object device)
+
+			This method gets called when the service daemon
+			needs to confirm incoming pairing request.
+
+			Possible errors: org.bluez.Error.Rejected
+					 org.bluez.Error.Canceled
+>>>>>>> 4375d12... doc fix
-- 
1.7.1

