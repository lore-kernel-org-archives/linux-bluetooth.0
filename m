Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4042575B.20305@superbug.demon.co.uk>
References: <40421024.20602@superbug.demon.co.uk>
	 <1078074126.1942.31.camel@pegasus> <40423226.8050007@superbug.demon.co.uk>
	 <1078087109.1942.54.camel@pegasus> <4042575B.20305@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078092105.1942.93.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 29 Feb 2004 23:01:46 +0100

Hi James,

> alsa handles format conversion automatically, all we have to tell alsa 
> is which formats we can do, and alsa does the rest. So, if alsa is not 
> allowed to modify the hciconfig hci0 voice XX setting, it can just be 
> told what it is via an IOCTL and then tell alsa to do conversions for 
> any other formats.

we don't need an ioctl for that, because the current voice setting for a
HCI device is already present in the hci_dev structure.

> Some audio applications need this "pointer" feature, which is why alsa 
> provides it.
> An example of this is playback of DVDs.
> Video output needs to be kept closely in sync with the audio, and this 
> "pointer" and "trigger" feature allow the application to closely control 
> exactly when the sound plays. "trigger" handles the "start the sound 
> exactly now", and "pointer" provides feedback, saying that "sound sample 
> xyz is currently playing, so display video frame xyz now". "pointer" 
> also provides for "audio is playing 0.25 seconds ahead of video, adjust 
> it to match".
> These are not hardware specific features, all sound hardware has these 
> features, including bluetooth audio, and we just need some way for 
> higher layers to get access to the values.
> Another example is Voice over IP. If using a headset, one might want to 
> use it to make VoIP calls over the internet. One of the most important 
> issues with VoIP is latency. The lower the latency, the more natural the 
> conversation will be. Long latency produces conversations will long 
> breaks in between and possible delayed echos. It is a lot more difficult 
> to have a natually smooth conversation if the latency is high. These 
> "pointer" and "trigger" and "period_time_elapsed" functions allow for 
> applications to program minimum latancy that any particular hardware can 
> handle.

You shouldn't think so much about it. Try to implement the ALSA driver
without it and we see how it goes.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
