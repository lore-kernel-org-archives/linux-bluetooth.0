Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4084F871.5020802@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: zubiwat <zubiwat@poczta.onet.pl>
Cc: bluez devel <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unknown answer while connecting through RFCOMM
References: <002201c42666$69492ee0$fcca010a@firedrake>
In-Reply-To: <002201c42666$69492ee0$fcca010a@firedrake>
Content-Type: text/plain; charset="us-ascii"
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
Date: Tue, 20 Apr 2004 11:16:17 +0100

zubiwat wrote:
> [a sequence of bytes]
[...]
> How should I answer to this packet?

I was going to decode your bytes here, but having looked at your posting
history I see that you're continually posting non-BlueZ questions to
this group.

This group is soley for the development of the BlueZ Bluetooth stack,
it's not a place to get help when developing your own stack and we will
not do your homework for you.

You are being rude. Marcel has already warned you repeatedly.

If you're developing your own Bluetooth stack try the Yahoo Bluetooth
group or go to the Bluetooth web site and try the forums there:

  https://www.bluetooth.org/foundry/orgusers/forums/

	- Steven

PS. Not only is your understanding of Bluetooth flawed, but your
    hardware is broken too. Your UART is corrupting bytes - the first
    byte of your log should be 0x04 not 0x14. I suggest you try better
    UART cables and/or a lower baud rate.
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
