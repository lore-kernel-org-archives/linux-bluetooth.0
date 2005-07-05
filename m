Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Lindner <mailinglists@xgm.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200507052226.53218.mailinglists@xgm.de>
Subject: [Bluez-users] A couple of bluetooth & Samsung D500 problems
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
Date: Tue, 5 Jul 2005 22:26:52 +0200

Hello,
I've a Dell Inspiron 8600 with a builtin bluetooth module. I'm using a Linux 
2.6.11.5 on Gentoo.

First problem: I have a special key for switching WLAN and Bluetooth on/off. 
This key is on upon boot. But I need to swich it on and off before I can use 
bluetooth.

horus florian # modprobe bluetooth

syslog:

Jun 26 14:05:39 horus Bluetooth: Core ver 2.7
Jun 26 14:05:39 horus NET: Registered protocol family 31
Jun 26 14:05:39 horus Bluetooth: HCI device and connection manager initialized
Jun 26 14:05:39 horus Bluetooth: HCI socket layer initialized

horus florian # /etc/init.d/bluetooth start
 * Starting Bluetooth ...
 *     Starting hcid ...                                                                                                                                                                                                             
[ ok ]
 *     Starting sdpd ...                                                                                                                                                                                                             
[ ok ]
 *     Starting rfcomm ...                                                                                                                                                                                                           
[ ok ]

syslog:

Jun 26 14:06:49 horus hcid[16296]: Bluetooth HCI daemon
Jun 26 14:06:49 horus Bluetooth: L2CAP ver 2.7
Jun 26 14:06:49 horus Bluetooth: L2CAP socket layer initialized
Jun 26 14:06:49 horus sdpd[16298]: Bluetooth SDP daemon
Jun 26 14:06:49 horus Bluetooth: RFCOMM ver 1.5
Jun 26 14:06:49 horus Bluetooth: RFCOMM socket layer initialized
Jun 26 14:06:49 horus Bluetooth: RFCOMM TTY layer initialized

horus florian # hcitool scan
Device is not available: Success

switching bluetooth on and off again, syslog:


Jun 26 14:08:24 horus usb 2-2: USB disconnect, address 2

Jun 26 14:08:27 horus usb 2-2: new full speed USB device using uhci_hcd and 
address 3
Jun 26 14:08:27 horus Bluetooth: HCI USB driver ver 2.8
Jun 26 14:08:27 horus usbcore: registered new driver hci_usb
Jun 26 14:08:27 horus hcid[16296]: HCI dev 0 registered
Jun 26 14:08:27 horus hcid[16296]: HCI dev 0 up
Jun 26 14:08:27 horus hcid[16296]: Starting security manager 0

now it works:

horus florian # hcitool scan
Scanning ...
        00:12:47:39:41:84       Handy Florian Lindner

(Handy is a cellphone in German). The cellphone is a Samsung D-500

horus florian # hcitool info 00:12:47:39:41:84
Requesting information ...
        BD Address:  00:12:47:39:41:84
        Device Name: Handy Florian Lindner
        LMP Version: 1.1 (0x1) LMP Subversion: 0x3d4
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>


binding works too: (I've udev)

horus florian # rfcomm bind 0 00:12:47:39:41:84
[chmod to make it world readable and writeable]
horus / # ll /dev/rfcomm0
crw-rw-rw-  1 root root 216, 0  5. Jul 22:19 /dev/rfcomm0

When echoing ATZ on the bluetooth channel:

horus florian # echo "ATZ" > /dev/rfcomm0

My cellphone asks if I should make a Audio connection with the Laptop. If I 
say yes, nothing happens. Other commands like "ATDT06126500492" (my home 
number) gives the same result.

Now I try to use kmobiletools the cellphone asks for audio connection too. 
kmobiltools is not able to retrieve any data and on the konsole it displays:

>>>AT+CBC
<<<
ERROR
(returning error)
>>>AT+CPMS="MT"
<<<
ERROR
(returning error)
>>>AT+CPMS=MT
<<<
ERROR
(returning error)

all the time (the AT commands change).

I don't know where the problem is so I ask here as well.

If the problem is at kmobiletolls side: anyone know a good app to read out and 
send SMS via bluetooth?

Thanks for help,

Florian





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
