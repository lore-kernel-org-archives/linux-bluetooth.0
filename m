Return-Path: <cyrus@holtmann.org>
From: Forrest <forrest.zhao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Forrest <forrest.zhao@gmail.com>
Subject: [PATCH 1/4] add the D-Bus interface definition for HFP Audio gateway -- take4 -- rebased
Date: Fri,  3 Apr 2009 11:49:12 +0800
Message-Id: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/audio-api.txt |  114 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 7e8492d..7eea7ca 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -289,3 +289,117 @@ properties	string State [readonly]
 
 			Indicates if a stream is active to a A2DP sink on
 			the remote device.
+
+
+Gateway hierarchy
+===================
+
+Service		org.bluez
+Interface	org.bluez.HeadsetGateway
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+This interface is available for remote devices which can function in the Audio
+Gateway role of the HFP profiles.
+
+Methods		void Connect()
+
+			Connect to the AG service on the remote device.
+
+		void Disconnect()
+
+			Disconnect from the AG service on the remote device
+
+		void AnswerCall()
+
+			It has to called only after Ring signal received.
+
+		void TerminateCall()
+
+			Terminate call which is running or reject an incoming
+			call. This has nothing with any 3-way situation incl.
+			RaH. Just plain old PDH.
+
+		void Call(string number)
+
+			Dial a number 'number'. No number processing is done
+			thus if AG would reject to dial it don't blame me :)
+
+		string GetOperatorName()
+
+			Find out the name of the currently selected network
+			operator by AG.
+
+		void SendDTMF(string digits)
+
+			Will send each digit in the 'digits' sequentially. Would
+			send nothing if there is non-dtmf digit.
+
+		string GetSubscriberNumber()
+
+			Get the voicecall subscriber number of AG
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+Signals		void Ring(string number)
+
+			Someone's calling from 'number'.
+			Caller number is provided as received from AG.
+
+		void CallTerminated()
+
+			Call failed to set up. It means that we tried to call
+			someone or someone tried to call us but call was not
+			accepted.
+
+		void CallStarted()
+
+			Call set up successfully.
+
+		void CallEnded()
+
+			Call was started and now ended. In contrast with
+			CallTerminated where call didn't started
+
+		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+properties	boolean Connected [readonly]
+
+			Indicates if there is an active connection to the
+			AG service on the remote device.
+
+		uint16 RegistrationStatus [readonly]
+
+			Service availability indicatior of AG, where:
+			0 implies no service. No Home/Roam network available.
+			1 implies presense of service. Home/Roam network
+			  available.
+
+		uint16 SignalStrength [readonly]
+
+			Signal strength indicator of AG, the value ranges from
+			0 to 5.
+
+		uint16 RoamingStatus [readonly]
+
+			Roaming status indicator of AG, where:
+			0 means roaming is not active
+			1 means a roaming is active
+
+		uint16 BatteryCharge [readonly]
+
+			Battery Charge indicator of AG, the value ranges from
+			0 to 5.
+
+		uint16 SpeakerGain  [readonly]
+
+			The speaker gain when available.
+
+		uint16 MicrophoneGain  [readonly]
+
+			The speaker gain when available.
-- 
1.5.4.5

