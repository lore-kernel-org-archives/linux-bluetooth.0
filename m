Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4062C2F9.5090808@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] resetting usb bt device
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
Date: Thu, 25 Mar 2004 12:31:05 +0100

hi,
notice that sometimes the bluez stack runs into a state where I cannot
connect rfcomm channels any more etc. To get into a sane mode of operatio=
n,
pulling and plugging the bt dongle helps normally.

As we build a system that will be hidden behind a wall, I need a software=
-
only solution to this. I tried to stop the bluetooth services as well as =
hotplug,
unload any dangling modules, then start hotplug and bluetooth services ag=
ain and
I send a hci_reset to the device.

Unfortunately, this does not resolve my issues, but I get lots of submit =
failures:
Mar 25 07:59:46 wall6 kernel: Written 2000,2001 by Maxim Krasnyansky <max=
k@qualcomm.com>
Mar 25 07:59:46 wall6 kernel: sco_sock_connect: sk dedfe080
Mar 25 07:59:46 wall6 kernel: sco_conn_ready: conn dfc92e00
Mar 25 07:59:46 wall6 kernel: usb-uhci.c: uhci_submit_urb: pipesize for p=
ipe 18200 is zero
Mar 25 07:59:46 wall6 kernel: __tx_submit: hci0 tx submit failed urb f7e3=
fe14 type 3 err -90
Mar 25 07:59:47 wall6 kernel: usb-uhci.c: uhci_submit_urb: pipesize for p=
ipe 18200 is zero
Mar 25 07:59:47 wall6 kernel: __tx_submit: hci0 tx submit failed urb f7e3=
fe14 type 3 err -90
Mar 25 07:59:47 wall6 kernel: usb-uhci.c: uhci_submit_urb: pipesize for p=
ipe 18200 is zero
Mar 25 07:59:47 wall6 kernel: __tx_submit: hci0 tx submit failed urb f7e3=
fe14 type 3 err -90
Mar 25 07:59:47 wall6 kernel: usb-uhci.c: uhci_submit_urb: pipesize for p=
ipe 18200 is zero

etc., as well as loads of other mysterious happenings.

Is there a proper way to reset this device other than soldering a paralle=
l-port controlled
power switch?

SImon


--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=C3=BCr Pervasive Computing, Johannes Kepler Universit=C3=A4t L=
inz
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
