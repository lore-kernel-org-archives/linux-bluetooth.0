Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <406AB277.2030503@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: paolo2278@freemail.it
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] absolute clock
References: <20040331104607.18049.qmail@mail.supereva.it>
In-Reply-To: <20040331104607.18049.qmail@mail.supereva.it>
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
Date: Wed, 31 Mar 2004 12:58:47 +0100

paolo2278@freemail.it wrote:
> I have a great problem, I'd like to know wich is the structure where I
> can find the value of the bluetooth's absolute clock, or the function
> that I could call for read this value.
[...]
> P.S. I have a CSR Bluetooth

As Marcel pointed out in another message, there's no standard HCI
command to read the Bluetooth clock in BT 1.1 but there is in BT 1.2.

However, if you have a CSR BT 1.1 device there are vendor specific
commands. If you use CSR's BCCMD mechanism then there are two IDs of
interest: BCCMDVARID_BT_CLOCK (0x2c00) returns the local Bluetooth clock
of the controller; BCCMDVARID_PICONET_INSTANT (0x3009) returns the
current Bluetooth clock for the a given piconet (it expects you to pass
in an ACL handle for any link on that piconet).

If you have access to the CSR support website (www.csrsupport.com) then
it's all fully documented. Don't forget that you may need to tunnel the
commands over HCI. Alternatively, you might find it easier to dig through
the BlueZ source and find out where it sends the commands to change the
uart baud rate - that should give you a good example to work from.

I can't recall if BlueZ has a tool that allows you to send arbitrary
BCCMDs to CSR chips - if not, it sounds like a good project for
someone.

	- Steven
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
