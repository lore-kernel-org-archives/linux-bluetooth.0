Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4291146C.4000603@rjmx.net>
From: Ron Murray <rjmx@rjmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Ambicom BT-2000CF doesn't want to work with kernel 2.6.11.8
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
Date: Sun, 22 May 2005 19:23:24 -0400

    I'm running Debian sarge on a Sony PCG-505FX laptop, using a 
home-built kernel (currently 2.6.11.8 with current bluez patches). I've 
had trouble getting SCO working with another dongle, so I thought I'd 
try it with the Ambicom card, using the CF <--> PCMCIA adapter that 
comes with it.

    The card had been working with 2.4 kernels (using the bt950 driver), 
but I'd never tried it on a 2.6 kernel before. First thing I discovered 
was that I needed the serial_cs module compiled into the kernel, and I 
didn't have it (might it not be a good idea to have the hci_uart module 
depend on it?). I built a new kernel, and was able to load drivers anyway.

    When I plugged the card into the PCMCIA slot, I got this in my syslog:

 > May 22 16:01:26 cleopatra cardmgr[5721]: initializing socket 0
 > May 22 16:01:26 cleopatra cardmgr[5721]: socket 0: AmbiCom BT2000E 
Bluetooth Card
 > May 22 16:01:26 cleopatra cardmgr[5721]: product info:
 >  "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
 > May 22 16:01:26 cleopatra cardmgr[5721]:   manfid: 0x022d, 0x2000 
function: 2 (serial)
 > May 22 16:01:26 cleopatra cardmgr[5721]: executing: 'modprobe serial_cs'
 > May 22 16:01:27 cleopatra kernel: ttyS3: detected caps 00000700 
should be 00000100
 > May 22 16:01:27 cleopatra kernel: ttyS3 at I/O 0x2e8 (irq = 11) is a 
16C950/954
 > May 22 16:01:27 cleopatra cardmgr[5721]: executing: './bluetooth 
start ttyS3'
 > May 22 16:01:28 cleopatra udev[5758]: removing device node '/dev/ttyS3'
 > May 22 16:01:29 cleopatra udev[5785]: creating device node '/dev/ttyS3'
 > May 22 16:01:35 cleopatra cardmgr[5721]: + Initialization timed out.
 > May 22 16:01:51 cleopatra kernel: Bluetooth: HCI UART driver ver 2.1
 > May 22 16:01:51 cleopatra kernel: Bluetooth: HCI H4 protocol initialized
 > May 22 16:01:51 cleopatra kernel: Bluetooth: HCI BCSP protocol 
initialized
 > May 22 16:01:51 cleopatra hcid[5727]: HCI dev 0 registered

    Attempts to use 'hciattach ttyS3 ericsson' resulted eventually in:

 > May 22 16:02:01 cleopatra hcid[5817]: Can't init device hci0:
 >  Connection timed out (110)

    ... and 'hciconfig -a' tells me the hci0 interface is down. It had 
00:00:00:00:00:00 for the MAC address.

    From my work with the bt950 driver, I think that the Ericsson 
chipset defaults to a baud rate of 57600. So I tried:

    hciattach ttyS3 ericsson 57600

    and got:

 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 00
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 00
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 78
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 00
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 00
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type c0
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 00
 > May 22 16:50:08 cleopatra kernel: h4_recv: Unknown HCI packet type 80
 > May 22 16:50:08 cleopatra hcid[4922]: HCI dev 0 registered
 > May 22 16:50:18 cleopatra hcid[7658]: Can't init device hci0:
 >  Connection timed out (110)

    It does appear that the serial ports on the card and the radio
section are not set to the same baud rate. Does this sound likely? Any 
suggestions for getting it working?

Thanks,

  .....Ron

-- 
Ron Murray   (rjmx@rjmx.net)
http://www.rjmx.net/~ron
GPG Public Key Fingerprint: F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 
D86C 74DE


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
