Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F0EF99B.6000400@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez Dev <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Headset via usb dongle devel problems.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 11 Jul 2003 18:53:31 +0100

Hi,

I have discovered that the performance of the bluez stack is a problem 
when using the hci_usb.c driver.
I cannot get it to send SCO packets quicker than one urb per 40ms.
As the headset needs one urb per 3ms, this is quite a problem.
I would also assume that other applications like file transfer over 
bluetooth would be bad.
Would it be ok for the hci_usb.c driver to implement say 100 urbs per 
type. I.E. 100 output urbs for BULK, 100 output urbs for SCO etc.
The driver would then be sent a packet from the bluez stack and then get 
one of the 100 urbs, and send it immeadiately to the usb device 
(usb_submit_urb). But if all 100 urbs are used up, it would block, until 
an urb was freed (tx_complete callback).

Also, I need to know what the intended buffer management in the bluez 
driver is.
1) Application allocs some memory.
2) Application fills memory with data
3) Application calls bluez with pointer and length of memory.
4) What does bluez do now?
Does it: -
5) memcpy the data from user memory (maybe copyfromuser), add headers to 
it creating a packet, cutting it up into multiple packets if needed. 
(E.g. adding connection numbers etc.)
6) calls the low level device driver with pointer and length of packet.
7) low level device driver queues it for output. blocks here is the 
queue is full.
8) Returns control back to application.
9) low level device driver outputs the packet, and calls tx_complete 
callback.
10) tx_complete callback signals to higher layers in bluez that the tx 
is complete, and the higher layers release the memory.

For performance reasons, we should try to reduce the amount of 
alloc/free calls, and also reduce the amount of memcpy calls.
In my "Does it" section above, there is only one memcpy (copyfromuser), 
but it looks like the current bluez stack does many more memcpy's than that.

Can anyone help explain what does in fact happen at the moment.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
