Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f54d864050226004521c9a1a0@mail.gmail.com>
From: Benjamin Vasanthakumar J <bennyvasanth@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Bluetooth Device(Headset(Audio)+Data transfer) for a Linux PC
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
Date: Sat, 26 Feb 2005 14:15:08 +0530

Dear all,

We are planning for a single bluetooth device(microcontroller based)
featuring a headset and our custom hardware device which sends status
to the PC and gets control information over bluetooth. We plan to use
a Bluetooth SoC with Headset Profile interfaced to the microcontroller
over UART which fetches the status/control data from our custom
hardware.

On the PC side(linux) we are going to use a standard USB Bluetooth
dongle. We are using the Bluez on the Linux PC side.

i) We need to send audio information(playing song using some MP3
player) from PC to the bluetooth device headset and also send data
from Mic to the PC for voice recording.

What setup we need to make for audio configuration in Linux PC to
route the audio information to the headset and a voice recording
setup?

ii) Parallely we want to recieve the status info from the bluetooth
device and need to send the appropriate control information from PC.
We have tested data transfer between 2 PCs using BT USB dongles at
L2CAP level. But our final target is we need to implement in firware
on our Microcontroller.

Is there a firmware level implementation of Bluez available?

Please advice.

Thanks & Regards,
Benny


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
