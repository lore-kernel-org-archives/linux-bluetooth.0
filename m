Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2dp timing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <42439ADA.5000006@xmission.com>
References: <42439ADA.5000006@xmission.com>
Content-Type: text/plain
Message-Id: <1111756476.9195.105.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 25 Mar 2005 14:14:36 +0100

Hi Brad,

> We've had problems with a2dp timing that I've been ignoring.
> 
> For one, a2play crams frames into the headset just as fast as it can. 
> Sometimes this is too fast. So we need to clock it so things are 
> staggered properly. Does the SBC encoder give us a clue about timing 
> between frames?

it would be really great to get a FTS or CATC trace from the HP
headphone and the iPAQ for example.

In the case of an ALSA plugin, we may simple use the timing of the ALSA
system itself. However it would be great if the SBC encoder would also
calculate the time of the PCM fragment.

> Second, if the headset wanders out of range, the player stops and starts 
> up where it left off when the headset is back. If we're pacing things 
> properly, we need to drop frames instead when this happens. I'm thinking 
> if it results in a legal SBC stream that I'll drop entire SBC frames in 
> the main loop with something like:
> 
> 	frame_len = read_header(fd, &sbc_info);
> 	bytes_read = read(fd, killbuffer, frame_len);

And then you need to sleep some time before reading/dropping the next
SBC frame.

> Are there other timing issues I need to think about? Does it get so 
> messy that I need to watch jitter? I can only vaguely remember this 
> stuff from my networking classes...

I don't think that this will be needed, but we will see.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
