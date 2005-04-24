Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <426C017A.3040500@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
References: <1114345112.10706.64.camel@pegasus> <20050424134746.GA31151@externe.net> <1114355799.10706.91.camel@pegasus> <20050424171103.GB12143@externe.net>
In-Reply-To: <20050424171103.GB12143@externe.net>
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
Date: Sun, 24 Apr 2005 14:28:42 -0600

Guylhem

> Brad who now has an xscale board now realise how much precious space
> is. Honnestly using alsa is only good if you consider existing
> applications.

I think the bottom line is that the general solution (alsa plugin) 
doesn't scale down to very small devices.

That is fine. Very small devices do a lot of things differently and we 
will continue to maintain something like a2play. It should be improved 
to be a little more general (eg no hardcoded usleep) and have more 
features (like mp3 decoding, live line-in streaming) but the basic 
operation wouldn't change.

Apps on the desktop should get used to using an alsa plugin and then we 
have the freedom to move whatever is appropriate into the kernel without 
changing the app interface. I don't believe we'd ever move "enough" into 
the kernel to eliminate alsa-lib.

One thing I've been trying on my gumstix is experimenting to see if the 
plugin design might scale down to a fairly capable arm board (xscale 
400mhz/64mb ram). alsa-lib is big but it might work. Another thing I've 
been doing is tweaking our project so our stuff is easily cross-compiled 
and works well as a buildroot module.

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
