Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 02/16] doc: Add telephony interface to audio-api.txt
Date: Thu, 23 Aug 2012 16:38:51 +0200
Message-Id: <1345732745-28706-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/audio-api.txt |  155 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index ca430fc..7aa07a4 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -423,3 +423,158 @@ properties	boolean Connected [readonly]
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
+			Object path should be unique for an agent and a UUID.
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
+Methods		object, dict properties NewConnection(filedescriptor fd,
+		                                      dict properties)
+
+			Returns a TelephonyConnection object for the connection
+			with its properties.
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
+				uint16 Version:
+
+					Remote profile version.
+
+				uint16 Features:
+
+					Optional. Remote profile features.
+
+				string Codecs:
+
+					Optional. List of supported audio
+					codec ids separated by a comma.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the TelephonyAgent registers itself is removed.
+
+TelephonyConnection hierarchy
+=============================
+
+Service		unique name
+Interface	org.bluez.TelephonyConnection
+Object path	freely definable
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
+		byte GetAudioCodec()
+
+			Returns the codec to use for upcoming audio connection.
+			This may start a new codec negotiation if needed.
+
+Signals		void PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+		void AudioConnectionRequested()
+
+			This signal indicates that remote has requested an audio
+			connection.
+
+Properties	byte	AudioCodec [readonly]
+
+			Optional. Indicates the currently selected audio codec.
+
+		boolean NREC [readwrite]
+
+			Optional. Indicates if echo cancelling and noise
+			reduction functions are active.
+
+		boolean InbandRingtone [readwrite]
+
+			Optional. Indicates if sending ringtones is supported.
+
+		uint16 OutputGain  [readwrite]
+
+			Optional. The speaker gain when available.
+
+			Possible values: 0-15
+
+		uint16 InputGain  [readwrite]
+
+			Optional. The microphone gain when available.
+
+			Possible values: 0-15
-- 
1.7.9.5

