Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42439ADA.5000006@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] a2dp timing
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
Date: Thu, 24 Mar 2005 22:00:10 -0700

Hi

We've had problems with a2dp timing that I've been ignoring.

For one, a2play crams frames into the headset just as fast as it can. 
Sometimes this is too fast. So we need to clock it so things are 
staggered properly. Does the SBC encoder give us a clue about timing 
between frames?

Second, if the headset wanders out of range, the player stops and starts 
up where it left off when the headset is back. If we're pacing things 
properly, we need to drop frames instead when this happens. I'm thinking 
if it results in a legal SBC stream that I'll drop entire SBC frames in 
the main loop with something like:

	frame_len = read_header(fd, &sbc_info);
	bytes_read = read(fd, killbuffer, frame_len);

Are there other timing issues I need to think about? Does it get so 
messy that I need to watch jitter? I can only vaguely remember this 
stuff from my networking classes...

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
