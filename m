Return-Path: <bluez-devel@krp.org.uk>
Date: Wed, 3 Nov 2004 18:21:48 +0000 (GMT)
From: Kevin Page <bluez-devel@krp.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-devel@lists.sourceforge.net, rmk@arm.linux.org.uk
Subject: Re: [Bluez-devel] re: UART-based bluetooth stuff / serial_cs problems
 solved?
In-Reply-To: <1099496495.6330.7.camel@notepaq>
Message-ID: <Pine.LNX.4.58.0411031821120.19391@moog.ecs.soton.ac.uk>
References: <Pine.LNX.4.58.0411031120260.18518@moog.ecs.soton.ac.uk>
 <1099496495.6330.7.camel@notepaq>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>


On Wed, 3 Nov 2004, Marcel Holtmann wrote:
> > With linux-2.6.10-rc1-mm2:
> > hciattach /dev/ttyS3 socket
> > seems to complete ok (none of the "BCSP initialization timed out" 
> 
> Can you retest it with 2.6.10-rc1-bk13 and see if these patches are
> already merged back mainline.

Ok, just tested this, and hciattach fails with "BCSP initialization
timed out", as it does with earlier kernels - so the significant
modifications must be in the mm2 patches (though I couldn't say
where!).


For reference, here's a bit more of messages when the card works
under 2.6.10-rc1-mm2; I presume the "detected caps" is nothing to
bother about:

cardmgr[2470]: socket 1: Serial or Modem
kernel: ttyS3: detected caps 00000700 should be 00000100
kernel: ttyS3 at I/O 0x2e8 (irq = 3) is a 16C950/954



Regards,

kev
