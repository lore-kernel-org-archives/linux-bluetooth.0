Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474181FA.2010906@aircable.net>
Date: Mon, 19 Nov 2007 09:30:50 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Rfcomm is not buffering received data?
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

Hello everyone,

I'm working on a dbus version of obexftp [1]. My goal was to remove all
the calls to hci-lib and replace those for the dbus equivalent. It
wasn't a though task, but now I'm facing a huge problem.

It took me almost 5 hours to detect the problem, firstly I thought that
the phone wasn't replying the request, but then after a brilliant idea I
probed that the phone was replying because hcidump was showing that. My
first conclusion was: "someone else is reading /dev/rfcomm# and erasing
the buffer before I can read it"

Then I checked with fuser which PIDs where using that file. For my
surprise there where two PIDs, one was my program the other was the
serial port service from BlueZ. I enabled gdb and did step debugging
until I faced the first write function, and then I kill the serial port
service PID. But I wasn't lucky at all, someone was still reading the
rfcomm.

Well after a couple of hours of thinking I cammed to the conclusion that
some how the rfcomm device is not buffering the data it receives. I'm
sure that the rfcomm buffer is not been overflowed, as the first reply
from the phone is not more than 30 bytes long. I'm gonna start going
through the rfcomm kernel sources, but if someone knows what's going on
please let me know.

I'm working on an Open Source Proximity Marketing Solution, and this is
the last thing I need to finish before doing the official announcement
(Marcel do you mind if I send a mail to the list saying this?)

Thanks,
Manuel

[1] http://code.google.com/p/proximitymarketing/



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
