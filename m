Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Re: MS Optical Desktop Elite for BT; can"t
	reconnect after idle
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502112202380.29873@frodo.dd.chalmers.se>
References: <Pine.GSO.4.58.0502112202380.29873@frodo.dd.chalmers.se>
Content-Type: text/plain
Message-Id: <1108163705.18099.72.camel@pegasus>
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
Date: Sat, 12 Feb 2005 00:15:05 +0100

Hi Tomas,

> Yes it's the second version. As I see it the transciever seems to be
> working (had to upgrade the kernel to 2.6.10 though). Except the mouse and
> keyboard I have managed to recieve an image from my Sony Ericsson T630
> cellphone via "Bluetooth File Sharing". The cellphone doesn't see any
> services on the computer but that could very well be because I haven't
> even tried configuring any yet.

please try 2.6.11-rc3-bk8, because I pushed some changes for this device
into mainline. Can you send me /proc/bus/usb/devices with the dongle
attached to your machine?

> A strange thing is that in /dev/input I get a few (1-2) keyboard entries
> (which are not outputing anything when I 'cat' them) on top of the normal
> keyboard and bluetooth-keyboard. These all are removed when the keyboard
> goes into idle state.
> 
> To get the mouse and keyboard working I used the following steps (I
> havn't touched any scipt- or configfiles yet except bluetooth/pin):
> 1. "hciconfig hci0 up"
> 2. Pressing the buttons underneath the mouse and keyboard for a few
> seconds.
> 3. "hcitool scan"
> 4. "hidd --connect mAddr"
> 5. "hidd --connect kAddr"
> 
> In the use of hidd I feel quite lost. It seems to be living it's own life.
> It can add devices by just searching for them and sometimes killall
> doesn't kill all connections for example. So if I'm doing something wrong,
> it might be there.
> 
> And to reconnect it after it becomes idle I repeat steps 2 though 5. OK,
> that's the complete background, now over to the output you requested.

There should be a "hidd --server" running to catch the re-connect
attempts of the mouse and the keyboard. Otherwise it can't work.

> Didn't know exactly what you where looking for in sdptool so I am sending
> the whole output. I strange thing I noticed when using hcidump was that
> the scroll-wheel and the special buttons (not the left, scroll-wheel and
> right buttons) only generated output when the mouse was in idle mode. The
> extra keys (or the scroll-wheel) on the keyboard never generated any
> output.

The optimal is the output of "sdptest records" from the libs2 CVS
repository, because it tries to get every information available.

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
