Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] re: UART-based bluetooth stuff / serial_cs
	problems solved?
From: Marcel Holtmann <marcel@holtmann.org>
To: Kevin Page <bluez-devel@krp.org.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0411031821120.19391@moog.ecs.soton.ac.uk>
References: <Pine.LNX.4.58.0411031120260.18518@moog.ecs.soton.ac.uk>
	 <1099496495.6330.7.camel@notepaq>
	 <Pine.LNX.4.58.0411031821120.19391@moog.ecs.soton.ac.uk>
Content-Type: text/plain
Message-Id: <1099509152.7125.155.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 03 Nov 2004 20:12:32 +0100

Hi Kevin,

> > > With linux-2.6.10-rc1-mm2:
> > > hciattach /dev/ttyS3 socket
> > > seems to complete ok (none of the "BCSP initialization timed out" 
> > 
> > Can you retest it with 2.6.10-rc1-bk13 and see if these patches are
> > already merged back mainline.
> 
> Ok, just tested this, and hciattach fails with "BCSP initialization
> timed out", as it does with earlier kernels - so the significant
> modifications must be in the mm2 patches (though I couldn't say
> where!).

too bad, but I think we are on the right way.

Russel, do you may know what patches from -mm are not merged back
mainline at the moment and Kevin can apply one by one to find out what
makes these cards working again?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
