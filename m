Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Major A <andras.major@univie.ac.at>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Logitech Mobile Freedom headset problems
Message-ID: <20050411163938.GA7850@janus>
References: <20050411082345.GA24929@janus> <425A3894.20301@xmission.com> <20050411091807.GB29989@janus> <425AA325.9050404@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <425AA325.9050404@xmission.com>
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
Date: Mon, 11 Apr 2005 18:39:39 +0200


> maybe the adapter? look at the debug section of bluetooth-alsa.sf.net 
> and post the various output here on the list.

I tried two different ones (BCM2033-based dongle, and the USB one
built into the Thinkpad X31), same results. Now if I do "hciconfig
hci0 voice 0x0060" before the btsco command, it seems to work,
i.e. alsamixer comes up with something sensible. On the other hand, I
haven't been able to get the headset to make any noise at all so far,
I've tried to play WAV files with aplay or mplayer and even tried
getting kphone to work -- no success so far. But at least it's moving
in the right direction...

  Andras


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
