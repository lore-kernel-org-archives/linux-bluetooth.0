Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455EBE0E.6080300@xmission.com>
Date: Sat, 18 Nov 2006 01:02:22 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] another audio/dbus pass
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

btw, I really like the idea of handling this in dbus. We'll have all the 
connection negotiation in a single place and keep it relatively tidy.

Some descriptions cleanup, better coverage of HFP & AVRCP, simplified 
builtin ringing (let the application send individual rings).

Headset hierarchy (experimental)
==============================

Service		org.bluez
Interface	org.bluez.Headset

Methods		void Connect(string identifier)

			Opens the control connection to an audio device.

		void Disconnect(string identifier)

			Stops audio if it was playing and closes the
			control connection to the audio device.

		void Play(string identifier)

			Opens the audio stream. Called from the audio
			plugin or from the application if audio is
			routed somewhere other than the daemon (eg
			through PCM, direct to the DSP).

		void Stop(string identifier)

		void Pause(string identifier)

		void Resume(string identifier)

		void SetTimeout(string identifier, uint32 timeout)

			Set the idle Stop for the device.

			Only applicable when audio is routed through the
			daemon. Stop the stream and emit a signal if
			timeout elapses without any audio being sent
			to the daemon from an application. A value of 0
			indicates no idle stop; this is the default.

		uint32 GetTimeout(string identifier)

		uint16 GetSpeakerGain(string identifier)

		uint16 GetMicrophoneGain(string identifier)

		void SetSpeakerGain(string identifier, uint16 gain)

			Gain is 0..15

		void SetMicrophoneGain(string identifier, uint16 gain)

			Gain is 0..15

		void Ring()

			Use one ring on the headset's builtin ringer
			to indicate an incoming call.

		void CustomRing()

			Start the headset playing to indicate an
			incoming call.

		void CancelRinging()

			Cancel ringing or custom ringing incoming call.

Signals		void Connected()

		void Disconnected()
		
		void Playing()

			Audio stream was started.

		void Stopped()

			Audio stream was stopped.

		void Paused()

			Audio stream was paused.

		void Resumed()

			Audio stream was resumed.

		void PlayRequested()

			The headset requested the stream to (re)start.

		void PauseRequested()

			The headset requested a pause in the stream.

		void NextTrackRequested()

			The headset requested the next track.

		void PreviousTrackRequested()

			The headset requested the previous track.

		void Ringing()

			An incoming call was indicated with a ring
			on the builtin ringer.

		void CustomRinging()

			An incoming call is being indicated with
			a custom ring tone.

		void Canceled()

			Incoming call was canceled.

		void TimeoutChanged()

			Idle disconnect timeout changed.

		void SpeakerGainChanged()

			The speaker gain changed.

		void MicrophoneGainChanged()

			The microphone gain changed.

		void VoiceCommandRequested()

			The headset requested a voice-command session.

		void RedialRequested()

			The headset requested a redial.

		void AnswerRequested()

			User tried to answer an incoming call.

		void RejectRequested()

			User tried to rejected an incoming call.


Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
