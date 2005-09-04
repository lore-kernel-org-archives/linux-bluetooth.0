Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <dc98d8d9050904050925daa428@mail.gmail.com>
From: Paul Webster <pjwebster@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bcm2035
In-Reply-To: <001301c5b0be$d4717f90$0100a8c0@rdhome>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local>
	 <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
	 <001301c5b0be$d4717f90$0100a8c0@rdhome>
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
Date: Sun, 4 Sep 2005 22:09:52 +1000

> Anybody tested the chip 2035 under BlueZ stack?
I have a laptop sporting one of these USB based chips "built-in". An
HP Pavilion zd8004AP

> I have been playing with it with good results, but suddently i get the
> BD_ADDR as 00:00:00:00:00:00, and the dongle due to this (i think) is not
> working even in windows. All other commands or inquiry process is working
Same, although, when I first purchased the laptop, it came with
Windows XP installed, and the bluetooth _WAS_ working. After
repartitioning the 80Gb HDD and re-installing XP on a smaller
partition, using the discs that came with the laptop, I couldn't get
bluetooth installed again. I kept getting errors saying that the
bluetooth license was not valid, and asking to locate the correct
license file.

Under linux, it works fine, although I have to specify the interface
(hci0) every time I use things like hcitool and hciconfig. For
example:

~ $ hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN=20
        RX bytes:111 acl:0 sco:0 events:14 errors:0
        TX bytes:310 acl:0 sco:0 commands:14 errors:0
~ $ hcitool scan
Device is not available: No such device
~ $ hcitool -i hci0 scan
Scanning ...
        00:0A:94:C0:2A:6E       Bluetooth Mouse
~ $ hidd --connect 00:0A:94:C0:2A:6E
~ $ hidd --show                    =20
00:0A:94:C0:2A:6E HID Boot Device [0000:0000] connected [boot-protocol]

> Looks like it forgot its BD_ADDR, and as far as i know there is no SW
> way(hci command) to set it again, I wonder if there is a SW way that i co=
uld
> have deleted it by mistake....
This is kind of an interesting idea. I would have assumed that the
BD_ADDR was a harware adress, and not alterable by software.
Certainly, what I assume was/is the original adress is stamped on a
sticker on the module (I pulled the laptop appart to check it out last
week).

> The model is BT3035 from Tecom with as i said the chip is Broadcom 2035
for reference:
~ $ lsusb
...
Bus 002 Device 002: ID 0a5c:2035 Broadcom Corp. BCM2035 Bluetooth
...

The lable on the module says:
Broadcom BCM92035NMD
FCC ID: QDS-BRCM1009
Canada IC: 4324A-BRCM1009
HP PN: 36438-001
Product of Taiwan
F/W: 105.97 Rev:0A
SPS PN: 376651-001

> Any idea / advice ?
I'm planning on looking into it some more once I have some more time


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
