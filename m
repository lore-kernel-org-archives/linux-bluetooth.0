Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Device(Headset(Audio)+Data transfer)
	for a Linux PC
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f54d864050226004521c9a1a0@mail.gmail.com>
References: <f54d864050226004521c9a1a0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109578343.17256.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 28 Feb 2005 09:12:23 +0100

Hi Benny,

> We are planning for a single bluetooth device(microcontroller based)
> featuring a headset and our custom hardware device which sends status
> to the PC and gets control information over bluetooth. We plan to use
> a Bluetooth SoC with Headset Profile interfaced to the microcontroller
> over UART which fetches the status/control data from our custom
> hardware.
> 
> On the PC side(linux) we are going to use a standard USB Bluetooth
> dongle. We are using the Bluez on the Linux PC side.
> 
> i) We need to send audio information(playing song using some MP3
> player) from PC to the bluetooth device headset and also send data
> from Mic to the PC for voice recording.
> 
> What setup we need to make for audio configuration in Linux PC to
> route the audio information to the headset and a voice recording
> setup?

look at the information at bluetooth-alsa.sf.net

> ii) Parallely we want to recieve the status info from the bluetooth
> device and need to send the appropriate control information from PC.
> We have tested data transfer between 2 PCs using BT USB dongles at
> L2CAP level. But our final target is we need to implement in firware
> on our Microcontroller.
> 
> Is there a firmware level implementation of Bluez available?

No and we don't have any plans for it, until the firmware of your
Microcontroller is Linux based.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
