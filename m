Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F2B8207.1040200@superbug.demon.co.uk>
Date: Sat, 02 Aug 2003 10:19:03 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI USB driver and SCO support
References: <1059787251.22190.17.camel@pegasus>
In-Reply-To: <1059787251.22190.17.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Max,
> 
> the patch from Jonathan Paisley is working fine. I have tested it on
> 2.4.18 to 2.4.21 and we can safely use two ISOC TX and RX URB's by
> default. But the configuration of the ISOC endpoint must be adjusted on
> demand. It depends on the voice setting and number of SCO connections,
> otherwise you won't hear any sound. At the moment we don't have access
> to these information from within the driver, so I started to extend the
> HCI core.
> 
> The first patch introduces hdev->notify and reads the voice setting on
> device init and stores them in hdev->voice_setting for later use. With
> these modification a driver can be notified about added or deleted
> connections (ACL + SCO) and if the voice setting was changed.
> 
> The second patch is for the HCI USB driver and it shows how to use
> hdev->notify. It also contains Jonathans modifications to use two ISOC
> TX and RX URB's and it keeps track of the number of ACL and SCO
> connections.
> 
> In the next step, we must choose the correct ISOC configuration. The
> default one should be 0, because we don't use any SCO channel. It is
> also a good idea to start the ISOC and BULK transfers only if they are
> needed.
> 
> Comments?
> 
> Regards
> 
> Marcel
> 
If we are going to use the SCO channels for sound output from 
applications, it would be very useful if we could provide some sort of 
ring buffer support, with hardware pointer updates.
Currently, there are no callbacks from sco to the application layer, 
telling it how many sound samples have actually left the PC for the 
Bluetooth device. This is a requirement if we are to support any sound 
card simulation layer above the SCO layer.
Until this is resolved, we will not be able to implement alsa or oss 
support.

Next point:
The current method for allocation of the URB is incompatible with kernel 
2.6.
bluez currently allocates it's own urb as a structure inside _urb.
In 2.6, the requirement is to get the usb subsystem to allocate the urb, 
  and then set the urb->context pointer to point to any bluez specific 
state information.
If the urb allocation is adjusted, it will then work on both 2.4 and 2.6

Cheers
James


Cheers
James
