Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E28802.8040703@conectiva.com.br>
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] RS232 Control Signals.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 10 Jan 2005 11:49:54 -0200


Hi there!

  I'd like to know if the RS232 Control Signals are available when
using Bluetooth through Serial Emulation whith the rfcomm program.

  I'm writing a program which should detect when a serial device
(which also suports bluetooth) is turned off. The program does its
job using an ioctl() call:

ioctl(fd, TIOCMGET, &status);

  and then checking for the DSR signal.

  It works as expected for the (true) serial port, but when I use
Bluetooth through Serial Emulation with the rfcomm program the signal 
doesn't change its state, and my program fails.

  Are the RS232 Control Signals available?

  I'm using the kernel linux version 2.6.10, and the rfcomm program
from the bluez-utils-2.13.

  I tryed the rfcomm program with the "bind" and "connect" options.

PS: Didn't find an answer for that question in the
Mailing List archieves.

TIA,

-- 
Luiz Fernando N. Capitulino


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
