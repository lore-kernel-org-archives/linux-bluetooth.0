Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455C01C4.7090801@xmission.com>
Date: Wed, 15 Nov 2006 23:14:28 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] audio & dbus
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

Marcel,

Can we discuss the audio dbus api some more?

fwiw, I'm not sure how to break away from the need to specify the 
profile for the case of a combo a2dp/sco device.

I'm focusing on routing "voice" (2-way audio) as a first priority. I 
don't provide methods for adding and removing SCO from the voice route 
since that's implied by connect/disconnect.

If this looks good I'll start boiling down HSP/HFP methods & signals.

Audio hierarchy (experimental)
==============================

Service		org.bluez
Interface	org.bluez.Audio

Methods		array{string} ListDevices()

			Return array of bdaddr strings for each audio
			device we have paired with.

		void Connect(string identifier, string profile)

			Opens the control connection to an audio device.
			Will not open the audio channel until requested
			by the audio plugin or directly from the
			application.

		void Disconnect(string identifier, string profile)

			Stops audio if it was playing and closes the
			control connection to the audio device.

		void Play(string identifier, string profile)

			Opens the audio stream. Called from the audio
			plugin or from the application if audio is
			routed somewhere other than the daemon (eg
			through PCM, direct to the DSP).

		void Stop(string identifier, string profile)

		void Pause(string identifier, string profile)

		void Resume(string identifier, string profile)

		void SetIdleDisconnect(string identifier, string profile, int32 delay)

			Set the idle Stop for the device.

			Only applicable when audio is routed through the
			daemon. Stop the stream and emit a signal if
			delay seconds pass without any audio being sent
			to the daemon from an application. A value of 0
			indicates no idle stop; this is the default.

		int32 GetIdleDisconnect(string identifier, string profile)

		int32 GetVolume(string identifier, string profile)

		void SetVolume(string identifier, string profile, int32 volume)

			Volume is 0..15

		void ChangeVolume(string identifier, string profile, int16 delta)

			delta is +1 or -1

		void AddWiredVoice()

			Add wired audio output to the voice routing rule

		void RemoveWiredVoice()

			Remove wired audio output from the voice routing
			rule

Signals		void Connected()

			Indicate device and profile.

		void Disconnected()
		
			Indicate device and profile.

		void Played()

			Indicate device and profile.

		void Stopped()

			Indicate device and profile.

		void Paused()

			Indicate device and profile.

		void Resumed()

			Indicate device and profile.

		void IdleStopChanged()

			Indicate the new idle, device, profile

		void VolumeSet()

			Indicate new volume, device, profile.

		void VolumeChanged()

			Indicate +1 or -1, device, profile.

		void WiredVoiceAdded()

			Indicated when wired audio is added to the
			voice route, also automatically when a SCO
			set is disconnected.

		void WiredVoiceRemoved()

			Indicated when wired audio is removed from
			the voice route, also automatically when a
			SCO set is connected.


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
