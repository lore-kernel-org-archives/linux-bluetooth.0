Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2009 20:22:24 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: hci0 is  invisible
Message-ID: <20090916202224.3eef8bd3@strolchi.home.s3e.de>
In-Reply-To: <200909161204.13479.gene.heskett@verizon.net>
References: <200909161204.13479.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gene,

On Wed, 16 Sep 2009 12:04:13 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

> Greetings Marcel;
> Yet another failed pass at getting these &*^$ dongles from Conwise
> Tech to work as a simple rs-232 link.
> 
> I have simlinked the contents of /etc/bluetooth, /usr/etc/bluetooth,
> and /usr/local/etc/bluetooth so that regardless of where it might
> look for config files, it will find something.

It should actually work without lots of config files.
 
> I've put the device on the other end of the path back into the
> non-paired state.  It is an eb101, according to test-discovery, is:
> [root@coyote test]# ./test-discovery
> [ 00:0C:84:00:86:F8 ]               
>     Name = eb101                    
>     Paired = 0                      
>     LegacyPairing = 1               
>     Alias = eb101                   
>     Address = 00:0C:84:00:86:F8     
>     RSSI = 0                        
>     Class = 0x001f00                

Very good, it means your adapter and the other side is up and running.

> [root@coyote tools]# hcitool  inq
> Inquiring ...
>         00:0C:84:00:86:F8       clock offset: 0x5711    class:
> 0x001f00 [root@coyote tools]# hcitool  cc 00:0C:84:00:86:F8
> This last command can be repeated, with no errors reported.  And no
> device can be created either in /dev, or in the link the messages
> file reports when the dongle is plugged in:

This is a misunderstanding on your side. There is no such thing as a
device in /dev for the bluetooth adapter. Think of it like an ethernet
interface - you also don't have /dev/eth0 and still it works.

> Sep 16 11:39:04 coyote kernel: [564988.826049] usb 2-5.1: new full
> speed USB device using ohci_hcd and address 9
> Sep 16 11:39:05 coyote kernel: [564988.919053] usb 2-5.1: New USB
> device found, idVendor=0e5e, idProduct=6622
> Sep 16 11:39:05 coyote kernel: [564988.919057] usb 2-5.1: New USB
> device strings: Mfr=0, Product=0, SerialNumber=0
> Sep 16 11:39:05 coyote kernel: [564988.919145] usb 2-5.1:
> configuration #1 chosen from 1 choice
> Sep 16 11:39:05 coyote bluetoothd[892]: HCI dev 0 registered
> Sep 16 11:39:05 coyote bluetoothd[892]: HCI dev 0 up
> Sep 16 11:39:05 coyote bluetoothd[892]: Starting security manager 0
> Sep 16 11:39:05 coyote bluetoothd[892]: Parsing 
> /usr/local/etc/bluetooth/serial.conf failed: Key file does not start
> with a group
> Sep 16 11:39:05 coyote bluetoothd[892]: Adapter /org/bluez/892/hci0
> has been enabled
 
> Q: What defines this missing "group" in the serial.conf file?, which
> is now 100% commented.  Copied from the 4.51 serial tree verbatum
> since it wasn't installed by a make install.

It is not needed, since the defaults are just fine.

> Firing up bluetooth-wizard, the eb101 is displayed, and can be
> selected, but the pairing attempt fails.  Pin on both ends is 0000.
> 
> What can I do to make minicom find and use this hci0 device as a
> modem circuit?  /dev/hci0 doesn't exist, and minicom can't find  
> /org/bluez/892/hci0.

You need to either create a rfcomm device with "rfcomm bind <bdaddr>
<channel>" or use something like test-serial to set up the rfcomm
device for you.

This rfcomm device (usually "/dev/rfcomm0") then is the "serial port"
that you hook up screen, or minicom or pppd or whatever.

I have written something up about rfcomm in a former life on
http://en.opensuse.org/Bluetooth
(it is not suse specific at all, but it might be outdated), for your
case http://en.opensuse.org/Bluetooth/rfcomm might be even more
specific.

Nowadays, you might also get good results with "test-serial".
At least on my phone "test-serial <bdaddr>" gets me an /dev/rfcomm0
which I can use to talk to it with AT commands. Be prepared that all
those test-* commands will cancel the connection after 1000 seconds,
but increasing the timeout is easy as it is a simple python script ;)

The /org/bluez/892/hci0 is no filesystem path but a pointer to where
the device lives on the famous D-Bus ;)

> [root@coyote tools]# minicom coco3
> Device /org/bluez/892/hci0 access failed: No such file or directory.

which then, of course, is to be expected.

I hope this gets you going into the right direction, have fun ;)

Best regards,

	Stefan
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
