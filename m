Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] re: UART-based bluetooth stuff / serial_cs
	problems solved?
From: Marcel Holtmann <marcel@holtmann.org>
To: Kevin Page <bluez-devel@krp.org.uk>
Cc: bluez-devel@lists.sourceforge.net, rmk@arm.linux.org.uk
In-Reply-To: <Pine.LNX.4.58.0411031120260.18518@moog.ecs.soton.ac.uk>
References: <Pine.LNX.4.58.0411031120260.18518@moog.ecs.soton.ac.uk>
Content-Type: text/plain
Message-Id: <1099496495.6330.7.camel@notepaq>
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
Date: Wed, 03 Nov 2004 16:41:35 +0100

Hi Kevin,

> I have a IBM Thinkpad X31 with a CF Socket bluetooth card (rev. G),
> which has been one of the serial PCMCIA/CF bluetooth cards which
> mysteriously haven't worked since 2.6. Just done a periodic scan of 
> the list archives, and thought I'd give the latest kernel at try, 
> as changes to serial/UART have been mentioned (I'm normally running
> Fedora Core 2 with 2.6.8).
> 
> Anyway, basically, it seems to fix things.

this will be perfect and I am going to test my cards that stopped
working. I don't have the Socket one, but some others.

> With linux-2.6.10-rc1-mm2:
> 
> hciattach /dev/ttyS3 socket
> 
> seems to complete ok (none of the "BCSP initialization timed out" 
> messages I was seeing before). I do get a lone:
> 
> hcid[2543]: HCI dev 0 registered
> kernel: bcsp_recv: Out-of-order packet arrived, got 1 expected 0
> hcid[2543]: HCI dev 0 up
> 
> but then I can successfully hcitool scan etc.

The ouf-of-order packet is ok, because BCSP can deal with these things
by itself. Maybe I have to change that message into a debug message.
 
> I don't know what's changed, but thanks! This seems to be good news.
> Unfortunately I haven't had the chance to do more rigorous testing as
> the new kernel either doesn't like something else in the thinkpad, or
> I screwed up the config :-/

Can you retest it with 2.6.10-rc1-bk13 and see if these patches are
already merged back mainline.

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
