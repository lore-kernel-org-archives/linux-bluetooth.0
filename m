Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Fwd: alsa bluetooth module
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
Cc: ms419@freezone.co.uk, durtro@ginnungagap.de
In-Reply-To: <423B6547.5040001@email.it>
References: <e36f1e61ac13a554d52d2f7b8d7a5df4@freezone.co.uk>
	 <1111098892.19889.88.camel@pc7.dolda2000.com>  <423B6547.5040001@email.it>
Content-Type: text/plain
Message-Id: <1111241935.11381.3.camel@pc7.dolda2000.com>
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
Date: Sat, 19 Mar 2005 15:18:55 +0100

On Sat, 2005-03-19 at 00:33 +0100, Antonio-Blasco Bonito wrote:
> Fredrik Tolf ha scritto:
> >By no means. kcalloc() is a core kernel function, defined in mm/slab.c.
> >It's not an ALSA-specific routine.
> >  
> >
> No kcalloc in there... see the appended file from kernel-source-2.6.8

It does indeed seem that you're right. It seems the kcalloc was added in
either 2.6.9 or 2.6.10 (which surprises me, because I believe that the
snd-bt-sco module has been around longer than that). Now that I know
that, the module should be changed to use kmalloc instead. I'll take
care of that right now.

Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
