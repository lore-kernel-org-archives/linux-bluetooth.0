Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <422E59A9.2040408@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco and alsa driver interaction
References: <d0ktcr$n2i$1@sea.gmane.org>
In-Reply-To: <d0ktcr$n2i$1@sea.gmane.org>
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
Date: Tue, 08 Mar 2005 19:04:25 -0700

Luis

It's good to see your interest... I think you have the right ideas on 
how things work.

> I also imagine that when we poll data from the hwdep interface, we are 
> not polling SCO data type (which I assume it is being drived 
> automatically); instead, we are polling for volume-control data type 
> which is enigmatically (for me) generated at the core of the driver. Is 
> it right?

if the volume change is initiated through a generic mixer, then yes. 
Think of a mixer application running on your computer. Run any 
alsa-aware mixer and it will let you choose the alsa mixer device to be 
the headset.

> The question is, 'when does the following condition evaluate TRUE  ?
> 
> if (!snd_hwdep_poll_descriptors_revents(handle, &pfds[nfds - 1], 1, 
> revents) && revents & POLLIN) {

It evaluates true when there are volume-change events to be examined 
that were initiated through a soft mixer.

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
