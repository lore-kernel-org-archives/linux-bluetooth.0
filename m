Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F65CD1D.1020100@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: jp-www@dcs.gla.ac.uk
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [ANNOUNCE] ALSA Bluetooth Headset Driver
References: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
In-Reply-To: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Sep 2003 15:30:53 +0100

jp-www@dcs.gla.ac.uk wrote:
> Hi,
> 
> Having recently got a Bluetooth headset (HBH-60), I've put together a
> preliminary ALSA driver which works with bluez.
> 
> 	http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
> 
> I'd appreciate any feedback on this. The code is a bit messy at the
> moment, but I've had fairly good results with it.
> 
> No changes to bluez are required at the moment -- all the work is done
> through the SCO socket interface. Better performance could likely be
> obtained with a slightly different interface.
> 
> This is a work-in-progress -- no guarantees that it will work!
> 
> 
> An excerpt from the small README file:
> 
> ALSA Bluetooth Headset Driver
> =============================
> 
> This is a preliminary driver for Bluetooth headsets. It has only been
> tested with the following configurations:
> 
>     USB Bluetooth adapter (Bluecore02 and 01b)
>     usb-ohci, usb-uhci and uhci driver (on a desktop and laptop)
>     kernel 2.4.20 single processor (there may be race conditions)
>     alsa-0.9.6
>     HBH-60 Bluetooth headset
>     recent bluez, hci_usb with my extra patches for SCO support (hciusb-isoc.patch)
> 
> Only 8-bit (8000hz) mode is supported at the moment. You must configure
> your hci device with 'hciconfig hci0 voice 0x0040'.
> 
> The speaker and microphone volume levels are presented as ALSA mixer
> controls. The HBH-60 only supports speaker volume, so I haven't managed
> to test the microphone support.
> 
> The ALSA device doesn't produce or consume any audio data when the headset
> isn't connected via the bluezsco control program -- this will cause apps
> to time out after a few seconds.
> 
> Pressing the headset button while connected will disconnect. Pressing the
> headset button while disconnected (assuming the headset decides to connect
> to your PC rather than your phone) will not work, since the control
> program doesn't (yet) act as a server.
> 
> Please get in touch if you manage to get it to work or have any questions.
> 

I was also working on this. Do you have full duplex sound working ?
I was under the impression that changes needed to be made to the 
bluetooth stack before full duplex worked.

Cheers
James





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
