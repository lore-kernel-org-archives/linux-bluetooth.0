Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 15:13:26 +0800
Message-ID: <ac8af0be0902112313i5f0f1bhb911e96767ca9b9d@mail.gmail.com>
Subject: [PATCH 1/4] add the D-Bus interface definition for HFP Audio gateway
From: Zhao Forrest <forrest.zhao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: event <event.riga@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index a73ba20..a3ff033 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -195,3 +195,116 @@ properties	boolean Connected [readonly]

 			Indicates if a stream is active to a A2DP sink on
 			the remote device.
+
+
+Gateway hierarchy
+===================
+
+Service		org.bluez
+Interface	org.bluez.Gateway
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
+		boolean IsConnected()
+
+		void AnswerCall()
+
+			It has to called only after Ring signal received.
+
+		void CancelCurrentCall()
+
+			Cancel call which is running now. This one does nothing
+			with any 3-way situation incl. RaH. Just plain old PDH.
+
+		void Call(string number)
+
+			Dial a number 'number'. No number processing is done
+			thus if AG would reject to dial it don't blame me :)
+
+		string GetOperatorName()
+
+		void VoiceRecognitionActivate()
+			in development
+		void VoiceRecognitionDeactivate()
+			in development
+
+		string GetNumberForLastVoiceTag()
+
+			Ask AG to provide a phone number. It looks like AG shell
+			in turn ask user to choose one. Idea behind this is VR
+			on the HF side.
+
+		void SendDTMF(string digits)
+
+			Will send each digit in the 'digits' sequentially. Would
+			send nothing if there is non-dtmf digit.
+
+		void SendMicrophoneGain(uint8 gain)
+		void SendSpeakerGain(uint8 gain)
+
+			Feel them useless but really easy to implement :)
+
+		string[] GetSubscriberNumbers()
+
+			Get all the numbers of AG
+
+
+Signals
+		void Connected(uint32 ag_features)
+
+			Connection successfully esteblished. 'ag_features' are
+			ORed features:
+				0x001 Three-way calling
+				0x002 Echo cancelling and/or noice reduction
+					function
+				0x004 Voice recognition function
+				0x008 In-band ring tone capability
+				0x010 Attach a number to a voice tag
+				0x020 Ability to reject a call
+				0x040 Enhanced call status
+				0x080 Enhanced call control
+				0x100 Extended Error Result Cod
+
+		void Disconnected()
+
+		void Ring(string number)
+
+			Someone's calling from 'number'.
+			Caller number is provided as received from AG.
+
+		void StatusUpdate(string indicator_name, uint32 indicator_value)
+
+			Indicator 'indicator_name' changed its value to
+			'indicator_value'.
+			System (call, callsetup, etc.) statuses are not signalled.
+
+		void CallCancelled()
+
+			Call failed to set up. It means that we tried to call
+			someone or someone tried to call us but call was not
+			accepted.
+
+		void CallStart()
+
+			Call set up successfully.
+
+		void CallEnd()
+
+			Call was started and now ended. In contrast with
+			CallCancelled where call didn't started
+
+		void VoiceRecognitionActive()
+		void VoiceRecognitionInactive()
+			in development
+
+		void MicrophoneGain(uint8 gain)
+		void SpeakerGain(uint8 gain)
+			AG sent us new gain.
+
