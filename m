Return-Path: <cyrus@holtmann.org>
Message-ID: <4795F3C5.8090208@wurmsdobler.org>
Date: Tue, 22 Jan 2008 13:46:45 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] mx27, csr and bluez: initialisation timed out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I am using a combined WiFi/BlueTooth module called apm6628, integrating
  the CSR BlueTooth silicon which is connected over a serial cable to my
i.MX27 ADS development board, running linux 2.6.19.2. I have bluez
support compiled into the kernel and the bluez-utils installed using
LTIB (not to forget with the --enable-bccmd in the spec file).

The kernel boots, and the bluetooth related facilities printk some
messages such as HCI UART driver ver 2.2, H4 and BCSP protocol
initialised. Since the BlueTooth module does not know the clock
frequency it is using, or the baud rate of the host, I need to
"configure" the BlueCore and warm-reset it:

     mx27# bccmd -t BCSP -d /dev/ttymxc1 psload config.psr warmreset

However, the only message I get is: "Initialization timed out", which,
looking through the code, is generated in bluez/tools/csr_bcsp.c in the
open function. But why?

I then tried to compile bluez-utils on my linux host. For some reason, 
".configure --enable-bccmd" does not generate the bccmd options in the 
tools/Makefile. Any idea why that is so?

Alternatively to bccmd, could I simply use

     "hciattach -s 230400 -d /dev/ttymxc1 csr"

in order to create a hci0 device?

Am I missing something in the way the kernel creates bluetooth devices?

Is there a good (up-to-date) documentation on this matter?

Regards,
peter



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
