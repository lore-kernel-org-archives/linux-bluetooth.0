Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf050630083549f68fef@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] H5 3 wire UART connect problem
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
Date: Thu, 30 Jun 2005 21:05:36 +0530

Hello all,

We are presently working on Silicon wave Serial Port Bluetooth module
with Linux version 2.4.20.
When we try to attach the UART with HCI layer.

Bluetooth module : Silicon Wave bluetooth module. (H5 3 Wire interface)
Linux Kernel : 2.4.20.

We have done different trial with the module. Below we have given two
of them major, that we have noticed in our experiment.

Experiment 1:
When we connect Bluetooth module with the full functional serial port
(thatr contains Hard ware flow control)
The HCI layer is attached with UART layer.
But when we try to UP the HCI0 it returns
cannot Init Device hci0.

Experiment 2:
When we connect the Bluetooth module with 3 WIRE serial cable (consist
of TXD, RXD and GND)

hciattach /dev/ttyS0 swave 115200 noflow

Actually our plan is to work the bluetooth with 3WIRE (H5) Bluetooth interf=
ace.
Kindly confirm whether the HCI_UART_3WIRE functionality is included in
the linux kernel.

if possible, adivse us a path to fix this issue.
This application returns=20

Initializaion timed out.

Advise to fix it

Thanks and regards
Hariharan.v.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
