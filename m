Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050426124632.43110.qmail@web8309.mail.in.yahoo.com>
References: <20050426124632.43110.qmail@web8309.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1114522132.10706.277.camel@pegasus>
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
Date: Tue, 26 Apr 2005 15:28:52 +0200

Hi Mayank,

> > I haven't noticed that you also played with adding
> > usleep(). I only
> > tried a2play once on a Logitech headphone and it was
> > terrible. However
> > this can be the final solution and we need an exact
> > timing source for
> > proper A2DP support.

this must be read "_can't_ be the final". Silly typo :(

> But, this is not a very good approach. Also, it will
> depend on the kind of sink. for example some sinks
> have buffers. Also we do not know what the buffer size
> is.
> 
> But this may just be the solution since we can always
> leave some buffer space of the sink empty, but we
> can't afford to overflow it, else the speed
> automatically increases about 5 times !
> 
> And will the parameter to usleep be a constant ?

No. It depends on the CPU speed and the CPU load.

> Another point that i wanted to share is that before
> adding the sbc encoding in the a2play code i had to
> put  usleep(10000).
> But once i included the sbc encoding, it came down to
> usleep(30).
> So, as Henryk said, sbc encoding should be there in
> the a2play code rather than as a separate application.

Maybe we should change the SBC encoding routines so that it times how
long it needed to encode the resulting SBC frame. Together with the
known time of the PCM data the SBC frame is encoded for, we can
calculate the actual time for the usleep() in a2play.

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
