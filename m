Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426BAD24.1030507@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
References: <1114345112.10706.64.camel@pegasus> <20050424134746.GA31151@externe.net>
In-Reply-To: <20050424134746.GA31151@externe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 24 Apr 2005 08:28:52 -0600

Guylhem

> IMHO a2dp will be mostly useful for embedded system or in specific
> applications on desktop systems (xmms, etc). Having to use alsa is at
> best useless and at worse a potential showstopper.

we will keep and update the standalone streamer. it doesn't integrate 
well with other apps but you can deal with that when embedding.

> - on desktop systems a2dp could also be managed by a standalone
> application, which could be an audio out plugin for xmms/mplayer etc.
> This plugin would also manage sbc encoding and a2dp streaming until
> some dedicated tool manage a2dp streaming.

We can write one plugin for alsa and get support for 
xmms/mplayer/xine/etc. if someone else wants native plugins for all 
those apps, that's great.

> So my suggestion, at least until a good strategy has been defined, would
> be to use a2play as a work base, and add mp3/ogg decoding - the "all
> in one" approach. Quite easy to test, enhance, fix, finetune, etc -
> better IMHO that separate tools for the moment.

i think this could be an attractive utility for embedded work, but i 
would be careful how you add mp3 decode. my gumstix has analog audio 
out. I wouldn't want to use the space for an app that can decode mp3 
(new a2play) but can't also send it to analog out.

> Later on, like rfcomm manages rfcomm0 etc. entries, some a2dp tool
> could bind a2dp peripherals to /dev/a2dpN where SBC audio would be
> expected and streamed to the a2dp peripheral bound there.

managing connections is kind of a pain. it can't be done entirely in 
kernel space. you can see how this gets spread into the btsco daemon.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
