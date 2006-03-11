Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20060311190606.236f7cbd.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Subject: [Bluez-devel] New PIN helper, how to include with BlueZ?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Mar 2006 19:06:06 +0100

Hello,
a new PIN helper has been born, and I think it's time to include it in
the BlueZ packages (including source packages) either as a default
helper, or as an option. The problem is neither me, nor the author have
a good sense of how such things happen for BlueZ.

For those who haven't fallowed our discussion I will gave a short
summary of the situation:

Dave Mielke has been working for some time on a new PIN helper for
BlueZ, one that deals in a more complex, and in my opinion complete way,
with the problem.

The basic approach is to have a list of pins and device addresses in a
file, form which the helper will extract the correct PIN. If the device
is not on the list a prompt is started on a new terminal, that asks for
PIN (giving all the standard information). In case the terminal prompt
is not welcomed, a secondary helper can be called (for instance the
python script already shipped with BlueZ, or other for KDE/GPE/OPIE or
any other). The prompt can be fully disabled. The script can be
configured either with a config file, or by command line parameters.

As can be seen above this gives more choices on chow to handle new
devices (list, prompt, secondary helper).

--=20
Rados=B3aw Rurarz
Warsaw Poland
GG: 7249330


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
