Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455E0EE6.6000402@xmission.com>
Date: Fri, 17 Nov 2006 12:35:02 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455C01C4.7090801@xmission.com>	<1163672537.5169.16.camel@localhost>
	<455C8857.9050008@xmission.com>	<1163692996.5169.67.camel@localhost>
	<455C95AB.8030800@xmission.com>
	<1163697494.5169.72.camel@localhost>
In-Reply-To: <1163697494.5169.72.camel@localhost>
Subject: Re: [Bluez-devel] audio & dbus
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

>>>> 		void RingHeadset()
>>>>
>>>> 			Indicate a single RING to the connected headset.
>>> No need to do this. This should be handled automatically via Play or
>>> some other method.

It looks like RING could be sent when sco is up but probably is not a 
good idea.

I've been reading through HFP more and I think we need special states 
for both kinds of incoming calls: custom ring and builtin ring. If we 
don't use special states then the use cases are very different--in the 
custom ring case, it means Playing() will be signaled before the call is 
in progress. I'd much rather have Answered() and Playing() always 
signaled together regardless of the ring type used to indicate the call.

Headset hierarchy (experimental)
==============================

Service		org.bluez
Interface	org.bluez.Headset

Methods		void Connect(string identifier)

			Opens the control connection to an audio device.
			Will not open the audio channel until requested
			by the audio plugin or directly from the
			application.

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

			Uses the headset's builtin ringer and go into
			ringing state to indicate an incoming call.

		void CustomRing()

			Brings up the audio connection (similar to the
			playing state) to indicate a custom ring tone
			and go into custom ringing state.

		void CancelRinging()

			Cancel ringing or custom ringing incoming call.

Signals		void Connected()

			Indicate device and profile.

		void Disconnected()
		
			Indicate device and profile.

		void Playing()

			Indicate device and profile.

		void Stopped()

			Indicate device and profile.

		void Paused()

			Indicate device and profile.

		void Resumed()

			Indicate device and profile.

		void Ringing()

			Headset is in ringing state. RING will be
			sent every 3 seconds.

		void CustomRinging()

			Headset is in custom ringing state. Application
			may now send custom ring tone.

		void Answered()

			User answered a call so ringing or custom
			ringing	state will go to playing state.

		void Ignored()

			User ignored a call.

		void Canceled()

			Ringing call was canceled.

		void TimeoutChanged()

			Indicate the new idle, device, profile

		void SpeakerGainChanged()

			Indicate new gain, device, profile.

		void MicrophoneGainChanged()

			Indicate new gain, device, profile.

		void HeadsetButtonPressed()

			Indicates the headset button was pressed.

		void RedialButtonPressed()

			Indicates the headset requested the last number
			redialed.

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
