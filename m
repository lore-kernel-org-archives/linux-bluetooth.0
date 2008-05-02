Return-Path: <cyrus@holtmann.org>
Message-ID: <481B2525.3090600@kernelconcepts.de>
Date: Fri, 02 May 2008 16:28:53 +0200
From: Nils Faerber <nils@kernelconcepts.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Sychip/Murata WLBT8111 experience?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi!
By some lucky coincidence I have a development board with a
Sychip/Murata WLBT8111 on it laying on my desk.
I try to get the UART HCI to respond but so far it is not recognised by
BlueZ. I see that the module sends data about every 300 to 400
miliseconds but with any baudrate I tried BlueZ only sais "h4_recv:
Unknown HCI packet type...".

So, has anyone else yet experience with that chip?
Any hints or tricks to make it behave?

Objective for me later on is to get audio working, first A2DP and then
probably SCO...

Any hint would be appreciated ;)
Thanks!

Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
--


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
