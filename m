Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v15 01/14] doc: Add telephony interface documents
Date: Thu, 26 Jul 2012 10:45:11 +0200
Message-Id: <1343292324-959-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am                    |    2 +-
 doc/assigned-numbers.txt       |    1 +
 doc/audio-api.txt              |   90 ++++++++++++++++++++++++++++++++++
 doc/audio-telephony-design.txt |  106 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 doc/audio-telephony-design.txt

diff --git a/Makefile.am b/Makefile.am
index 45a811c..1aa302c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -381,7 +381,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
 		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
-		doc/supported-features.txt
+		doc/supported-features.txt doc/audio-telephony-design.txt
 
 AM_YFLAGS = -d
 
diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
index cda934c..120d7ea 100644
--- a/doc/assigned-numbers.txt
+++ b/doc/assigned-numbers.txt
@@ -8,6 +8,7 @@ avoid conflicts.
 Profile		Channel
 -----------------------
 DUN		1
+HSP HS		6
 HFP HF		7
 OPP		9
 FTP		10
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index ca430fc..cc94267 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -423,3 +423,93 @@ properties	boolean Connected [readonly]
 		uint16 MicrophoneGain  [readonly]
 
 			The speaker gain when available.
+
+
+Telephony hierarchy
+===================
+
+Service		org.bluez
+Interface	org.bluez.Telephony
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterAgent(object path, dict properties)
+
+			Register a TelephonyAgent to sender, the sender can
+			register as many agents as it likes.
+
+			Note: If the sender disconnects its agents are
+			automatically unregistered.
+
+			possible properties:
+
+				string UUID:
+
+					UUID of the profile which the agent is
+					for.
+
+				uint16 Version:
+
+					Version of the profile which the agent
+					implements.
+
+				uint16 Features:
+
+					Agent supported features as defined in
+					profile spec e.g. HFP.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void UnregisterAgent(object path)
+
+			Unregister sender agent.
+
+TelephonyAgent hierarchy
+========================
+
+Service		unique name
+Interface	org.bluez.TelephonyAgent
+Object path	freely definable
+
+Methods		void NewConnection(filedescriptor fd, dict properties)
+
+			This method gets called whenever a new connection
+			has been established. This method assumes that D-Bus
+			daemon with file descriptor passing capability is
+			being used.
+
+			The agent should only return successfully once the
+			establishment of the service level connection (SLC)
+			has been completed.  In the case of Handsfree this
+			means that BRSF exchange has been performed and
+			necessary initialization has been done.
+
+			possible properties:
+
+				object Device:
+
+					BlueZ remote device object.
+
+				string UUID:
+
+					Profile UUID of the connection.
+
+				uint16 Version:
+
+					Remote profile version.
+
+				uint16 Features:
+
+					Remote profile features.
+
+				object Transport:
+
+					Optional. MediaTransport object path.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the TelephonyAgent registers itself is removed.
diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
new file mode 100644
index 0000000..a5936f6
--- /dev/null
+++ b/doc/audio-telephony-design.txt
@@ -0,0 +1,106 @@
+The org.bluez.Telephony interface will simplify BlueZ code by focusing on
+the Bluetooth communication part and by letting the external application (i.e.
+oFono) take charge of the Telephony tasks (AT parsing and modem specific code).
+So, it becomes simpler, easier to maintain and debug.
+
+External applications, which should implement AT parsing and telephony
+part of HeadSet or HandsFree Profiles, will have to register an
+org.bluez.TelephonyAgent using this new interface. This will setup a SDP record
+for the profile and a RFCOMM server listening for incoming connection.
+
+When a new device is connected, NewConnection method of TelephonyAgent is
+called. The telephony agent should reply to it after proper communication
+establishment (directly for HSP or after SLC setup completes for HFP).
+
+Interaction with the audio component (i.e. PulseAudio) will be done through the
+MediaTransport object (passed to telephony agent during NewConnection call).
+
+Here is some flowcharts of interactions between BlueZ, telephony agent (oFono)
+and audio component (PulseAudio):
+
+        .....>  Bluetooth communication between headset and phone
+        ----->  Dbus messages and signals
+
+SCO connection - AG initiated
+
+	PulseAudio              BlueZ             HF
+	|                         |               |
+	|    transport acquire    |               |
+	|------------------------>|               |
+	|                         |  connect SCO  |
+	|                         |<.............>|
+	|      return SCO fd      |               |
+	|<------------------------|               |
+	|                         |               |
+
+SCO connection - HF initiated
+
+	PulseAudio              BlueZ             HF
+	|                         |               |
+	|                         |  connect SCO  |
+	|                         |<.............>|
+	|  state changed signal   |               |
+	|<------------------------|               |
+	|                         |               |
+	|    transport acquire    |               |
+	|------------------------>|               |
+	|                         |               |
+	|      return SCO fd      |               |
+	|<------------------------|               |
+	|                         |               |
+
+AT+NREC
+
+	HF              oFono           BlueZ           PulseAudio
+	|     AT+NREC     |               |                  |
+	|................>|               |                  |
+	|                 |  SetProperty  |                  |
+	|                 |-------------->|                  |
+	|                 |               | property changed |
+	|                 |               |      signal      |
+	|                 |               |----------------->|
+
+
++BSIR
+
+	HF          oFono         BlueZ        PulseAudio        app
+	|             |             |               |             |
+	|             |             |               |<------------|
+	|             |             |  SetProperty  |             |
+	|             |             |<--------------|             |
+	|             |             |               |             |
+	|             |   property changed signal   |             |
+	|             |<------------*-------------->|             |
+	|   +BSIR:x   |             |               |             |
+	|<............|             |               |             |
+	|             |             |               |             |
+
+
+AT+VGS,AT+VGM
+
+	HF          oFono         BlueZ        PulseAudio        app
+	|             |             |               |             |
+	|  AT+VGS=xx  |             |               |             |
+	|............>|             |               |             |
+	|             | SetProperty |               |             |
+	|             |------------>|               |             |
+	|             |             |               |             |
+	|             |   property changed signal   |             |
+	|             |<------------*-------------->|             |
+	|             |             |               |------------>|
+	|             |             |               |             |
+
+
++VGS,+VGM
+
+	HF          oFono         BlueZ        PulseAudio        app
+	|             |             |               |             |
+	|             |             |               |<------------|
+	|             |             |  SetProperty  |             |
+	|             |             |<--------------|             |
+	|             |             |               |             |
+	|             |   property changed signal   |             |
+	|             |<------------*-------------->|             |
+	|   +VGS:xx   |             |               |             |
+	|<............|             |               |------------>|
+	|             |             |               |             |
-- 
1.7.9.5

