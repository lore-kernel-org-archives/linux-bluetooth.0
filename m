Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf0507062355523c3d61@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: Bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] OBEX File Receive
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
Date: Thu, 7 Jul 2005 12:25:26 +0530

Dear all/ Marcel,

We are presently working on OBEX FTP file transfer.

We are doing the Obex ftp with following specification:

Machine 1:
Bluetooth Dongle with Windows

Machine 2:
Bluetooth Dongle with Linux 2.4.20 Kernel.

We had made the Machine 1 bluetooth dongle to receive file from any
bluetooth device. We can able to send the file from machine 2 to the
Machine 1.

The command used on Machine 2 Linux machine.
obexftp -b <bdaddr> -B <channel number> --put <filename>

Like the same, when we send the file from Machine 1 to Machine 2. The
file cannot be send to Machine2

whether command is to be given to make the Linux OBEXFTP to be in
receive mode of operation.

Advise us
Thanks and regards
Hariharan.V


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
