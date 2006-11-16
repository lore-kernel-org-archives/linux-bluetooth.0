Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <455C8857.9050008@xmission.com>
References: <455C01C4.7090801@xmission.com>
	<1163672537.5169.16.camel@localhost>  <455C8857.9050008@xmission.com>
Date: Thu, 16 Nov 2006 17:03:16 +0100
Message-Id: <1163692996.5169.67.camel@localhost>
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

> > So what you need is some kind of capabilities command and then you can
> > use this to create instances for all devices. So my proposal would be
> > that we use org.bluez.Audio as a configuration interface (like Manager)
> > and then org.bluez.Headset to actually connect, disconnect etc.
> 
> Ok... whatever it takes so the Play method is not ambiguous. I was 
> preparing to do all kinds of acrobatics to figure out what was intended 
> when changing the volume without a device connected but with the manager 
> idea that won't be so complicated.
> 
> I have looked over Manager but I need to examine the code to get a 
> better feel for this.

you basically differentiate the various attached headsets via different
object paths on D-Bus. So every headset is its own object.

> > No. Use IncreaseVolume and DecreaseVolume.
> 
> I was looking over my notes and the HSP profile and couldn't see the 
> need for these. I left them out but do we need them? Do we treat mic 
> gain this way too?
> 
> I started using Gain below instead of Volume since it applies to both 
> speaker and mic.

I don't care. My point was that we don't use a direction parameter.

> >> 		void AddWiredVoice()
> >>
> >> 			Add wired audio output to the voice routing rule
> >>
> >> 		void RemoveWiredVoice()
> >>
> >> 			Remove wired audio output from the voice routing
> >> 			rule
> > 
> > Not needed at all. This is not our business and the PCM routing will be
> > a parameter to the daemon. No need to support PCM and HCI routing at the
> > same time.
> 
> hmm... this is actually for interacting with the builtin speaker. Johan 
> mentioned the scenario of custom ringing both the headset and the 
> speaker simultaneously and there are other scenarios we would need to 
> interact with builtin audio (for example, to get a mic input with 
> today's a2dp headsets you would use the built-in mic)

This will be up to ALSA or GStreamer. It is not the job of the audio
daemon to handle non-Bluetooth stuff.

> Headset hierarchy (experimental)
> ==============================
> 
> Service		org.bluez
> Interface	org.bluez.Headset
> 
> Methods		void Connect(string identifier)
> 
> 			Opens the control connection to an audio device.
> 			Will not open the audio channel until requested
> 			by the audio plugin or directly from the
> 			application.
> 
> 		void Disconnect(string identifier)
> 
> 			Stops audio if it was playing and closes the
> 			control connection to the audio device.
> 
> 		void Play(string identifier)
> 
> 			Opens the audio stream. Called from the audio
> 			plugin or from the application if audio is
> 			routed somewhere other than the daemon (eg
> 			through PCM, direct to the DSP).
> 
> 		void Stop(string identifier)
> 
> 		void Pause(string identifier)
> 
> 		void Resume(string identifier)
> 
> 		void SetTimeout(string identifier, uint32 timeout)
> 
> 			Set the idle Stop for the device.
> 
> 			Only applicable when audio is routed through the
> 			daemon. Stop the stream and emit a signal if
> 			timeout elapses without any audio being sent
> 			to the daemon from an application. A value of 0
> 			indicates no idle stop; this is the default.
> 
> 		uint32 GetTimeout(string identifier)
> 
> 		uint16 GetSpeakerGain(string identifier)
> 
> 		uint16 GetMicrophoneGain(string identifier)
> 
> 		void SetSpeakerGain(string identifier, uint16 gain)
> 
> 			Gain is 0..15
> 
> 		void SetMicrophoneGain(string identifier, uint16 gain)
> 
> 			Gain is 0..15
> 
> 		void AddWiredVoice()
> 
> 			Add wired audio output to the voice routing rule
> 
> 		void RemoveWiredVoice()
> 
> 			Remove wired audio output from the voice routing
> 			rule

As mentioned above. I don't see the need for these two.

> 		void RingHeadset()
> 
> 			Indicate a single RING to the connected headset.

No need to do this. This should be handled automatically via Play or
some other method.

> 		void PressHeadsetButton()
> 
> 			Indicate a button press to the connected audio
> 			gateway.

Unneeded. We are not in the role of a headset.

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
