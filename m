Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Getting an adaptor to be supported (for SCO
	audio)
From: Alexandros Vellis <avel@noc.uoa.gr>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42EDBD25.4050301@xmission.com>
References: <1122875141.6800.8.camel@amy>  <42EDBD25.4050301@xmission.com>
Content-Type: text/plain
Message-Id: <1122888885.6800.13.camel@amy>
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
Date: Mon, 01 Aug 2005 12:34:44 +0300

Brad Midgley wrote:

> It seems that hci routing of sco audio is only available on CSR chips.
> 
> SCO will be routed through the PCM hardware on your silicon wave chip 
> but that PCM interface is not connected to anything in a usb dongle.

Voice audio works perfectly in Windows XP, though.

Is it a case such as the one with winmodems, in that software is doing
the voice routing?

Or would these (cheap, admittedly, I got mine for 15 euros) dongles need
some sort of (difficult) reverse engineering to pass through the audio?

Just wondering. :)

> I have the same problem with the builtin infineon bluetooth on gumstix 
> (see http://bluetooth-alsa.sf.net/embed.html for more)

I don't particulary like this TODO item:

- Find out if SCO can be mapped to HCI as it can on CSR (*no*)

:-D

Thanks,
Alexandros




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
