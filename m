Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <455C01C4.7090801@xmission.com>
References: <455C01C4.7090801@xmission.com>
Date: Thu, 16 Nov 2006 11:22:17 +0100
Message-Id: <1163672537.5169.16.camel@localhost>
Mime-Version: 1.0
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

Hi Brad,

> fwiw, I'm not sure how to break away from the need to specify the 
> profile for the case of a combo a2dp/sco device.

I am still not convinced that we need to do this kind of things, but if
you really wanna separate this, then we need a more general approach. In
case of A2DP it can happen that we have two or even more independent
channels (I know that no such device exists at the moment).

So what you need is some kind of capabilities command and then you can
use this to create instances for all devices. So my proposal would be
that we use org.bluez.Audio as a configuration interface (like Manager)
and then org.bluez.Headset to actually connect, disconnect etc.

> Audio hierarchy (experimental)
> ==============================
> 
> Service		org.bluez
> Interface	org.bluez.Audio
> 
> Methods		array{string} ListDevices()
> 
> 			Return array of bdaddr strings for each audio
> 			device we have paired with.
> 
> 		void Connect(string identifier, string profile)
> 
> 			Opens the control connection to an audio device.
> 			Will not open the audio channel until requested
> 			by the audio plugin or directly from the
> 			application.
> 
> 		void Disconnect(string identifier, string profile)
> 
> 			Stops audio if it was playing and closes the
> 			control connection to the audio device.
> 
> 		void Play(string identifier, string profile)
> 
> 			Opens the audio stream. Called from the audio
> 			plugin or from the application if audio is
> 			routed somewhere other than the daemon (eg
> 			through PCM, direct to the DSP).
> 
> 		void Stop(string identifier, string profile)
> 
> 		void Pause(string identifier, string profile)
> 
> 		void Resume(string identifier, string profile)
> 
> 		void SetIdleDisconnect(string identifier, string profile, int32 delay)
> 
> 			Set the idle Stop for the device.
> 
> 			Only applicable when audio is routed through the
> 			daemon. Stop the stream and emit a signal if
> 			delay seconds pass without any audio being sent
> 			to the daemon from an application. A value of 0
> 			indicates no idle stop; this is the default.
> 
> 		int32 GetIdleDisconnect(string identifier, string profile)

Timeouts must be in uint32 and name them "timeout". Delay would be used
in case a process is sent to sleep.

> 		int32 GetVolume(string identifier, string profile)
> 
> 		void SetVolume(string identifier, string profile, int32 volume)
> 
> 			Volume is 0..15

And for what reason is this int32. First of all it must be unsigned and
16-bit seem to be enough.

> 		void ChangeVolume(string identifier, string profile, int16 delta)
> 
> 			delta is +1 or -1

No. Use IncreaseVolume and DecreaseVolume.

> 		void AddWiredVoice()
> 
> 			Add wired audio output to the voice routing rule
> 
> 		void RemoveWiredVoice()
> 
> 			Remove wired audio output from the voice routing
> 			rule

Not needed at all. This is not our business and the PCM routing will be
a parameter to the daemon. No need to support PCM and HCI routing at the
same time.

> Signals		void Connected()
> 
> 			Indicate device and profile.
> 
> 		void Disconnected()
> 		
> 			Indicate device and profile.
> 
> 		void Played()
> 
> 			Indicate device and profile.

Actually this would be Playing.

> 		void Stopped()
> 
> 			Indicate device and profile.
> 
> 		void Paused()
> 
> 			Indicate device and profile.
> 
> 		void Resumed()
> 
> 			Indicate device and profile.
> 
> 		void IdleStopChanged()
> 
> 			Indicate the new idle, device, profile
> 
> 		void VolumeSet()
> 
> 			Indicate new volume, device, profile.

Wrong name. This must be VolumeChanged(uint16 volume).

> 		void VolumeChanged()
> 
> 			Indicate +1 or -1, device, profile.

This must be VolumeIncreased and VolumeDecreased.

> 		void WiredVoiceAdded()
> 
> 			Indicated when wired audio is added to the
> 			voice route, also automatically when a SCO
> 			set is disconnected.
> 
> 		void WiredVoiceRemoved()
> 
> 			Indicated when wired audio is removed from
> 			the voice route, also automatically when a
> 			SCO set is connected.

Since we don't need to set this, we also don't need any signals.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
