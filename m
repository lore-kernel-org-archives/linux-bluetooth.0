Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4043753D.50804@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <A1F0D47583A2D711919F00600819B3A4028B8C@goofy.vitronics.com>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028B8C@goofy.vitronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 01 Mar 2004 17:39:09 +0000

Williams, Richard wrote:
> Hi Guys,
> 
> Your discussion is very relevant to me, since I'm building a small
> wearable computer system that will have several Bluetooth devices - 
> among them will be a headset. I was planning to use standard rfcomm
> to send data among the other devices and use SCO for the interface 
> from my computer to the BT headset.
> 
> It sounds from your discussion that SCO is really not ready to be used.
> In my case, since I'm building an embedded system, I want simple
> and low power. For my system I'd really like a socket interface to SCO.
> If I MUST use a large audio package like ALSA, then I'll do that, but
> I really want something small and simple.
> 
> Is there a bluez SCO that I can use ? 
> Do you have any idea when a stable SCO package will be available ?
> 
> I'm currently using linux-2.4.19 on an Intel Xscale processor.
> 
> thank you very much,
> 
> Regards,
> 
> Rich
> 
> Richard B. Williams
> Vitronics, Inc.
> 3 Corbett Way
> Eatontown, NJ 07724-2262
> 732-389-0244 x29
> Richard.Williams@vitronics.com
> 

SCO connections currently functions over the socket interface.
You can send sound to the headset, and receive sound from the headset 
mics. The only problem is in the buffering. That support is there in 
kernel 2.6.4, or 2.6.3 with patches, and also 2.4.x with other patches.

The problem in the buffering is the current lack of any feedback.
E.g. You output 0.1 second of samples. There is no feedback to tell you 
that all the samples have been played, or if it is still in the middle 
of playing.
So, lets take a possible real world setup.
One is playing an internet video stream. One has no way to keep audio in 
sync with video.

Summary: -
The current SCO support if fine, unless you need to keep the playback 
audio in sync with anything.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
