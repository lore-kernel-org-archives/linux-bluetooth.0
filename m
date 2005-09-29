Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e555255705092908451b2be938@mail.gmail.com>
From: Anderson Briglia <briglia.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] snd-bt-sco on an UART bluetooth device
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
Date: Thu, 29 Sep 2005 11:45:49 -0400

Hi all,

I'm trying to use the snd-bt-sco driver and btsco application (both
for using a bluetooth headset). When I used a usb bluetooth dongle,
everything was ok. But, when I use the bluetooh on-board (UART type),
the sound on bluetooth headset is very bad and I can't hear anything,
just noise.
I tryed to change the ACL MTU and SCO MTU to be the same on the UART
bluetooth and usb bluetooth, but I got the same problem with the sound
on bt headset.
I'm using a btsco version 0.4. And this is the output from a hciconfig
command typed on the device:

hci0:   Type: UART
       BD Address: 00:12:37:20:BF:F0 ACL MTU: 339:6 SCO MTU: 180:4
       UP RUNNING
       RX bytes:562 acl:0 sco:0 events:15 errors:0
       TX bytes:10150 acl:0 sco:0 commands:14 errors:0

Somebody can help me?

Thanks in advance,

Anderson


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
