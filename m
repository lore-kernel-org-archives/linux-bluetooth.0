Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Subject: hci0 is  invisible
Date: Wed, 16 Sep 2009 12:04:13 -0400
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Message-id: <200909161204.13479.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings Marcel;
Yet another failed pass at getting these &*^$ dongles from Conwise Tech to 
work as a simple rs-232 link.

I have simlinked the contents of /etc/bluetooth, /usr/etc/bluetooth, and 
/usr/local/etc/bluetooth so that regardless of where it might look for config 
files, it will find something.

I've put the device on the other end of the path back into the non-paired 
state.  It is an eb101, according to test-discovery, is:
[root@coyote test]# ./test-discovery
[ 00:0C:84:00:86:F8 ]               
    Name = eb101                    
    Paired = 0                      
    LegacyPairing = 1               
    Alias = eb101                   
    Address = 00:0C:84:00:86:F8     
    RSSI = 0                        
    Class = 0x001f00                

[root@coyote tools]# hcitool  inq
Inquiring ...
        00:0C:84:00:86:F8       clock offset: 0x5711    class: 0x001f00
[root@coyote tools]# hcitool  cc 00:0C:84:00:86:F8
This last command can be repeated, with no errors reported.  And no device 
can be created either in /dev, or in the link the messages file reports when 
the dongle is plugged in:

Sep 16 11:39:04 coyote kernel: [564988.826049] usb 2-5.1: new full speed USB 
device using ohci_hcd and address 9
Sep 16 11:39:05 coyote kernel: [564988.919053] usb 2-5.1: New USB device 
found, idVendor=0e5e, idProduct=6622
Sep 16 11:39:05 coyote kernel: [564988.919057] usb 2-5.1: New USB device 
strings: Mfr=0, Product=0, SerialNumber=0
Sep 16 11:39:05 coyote kernel: [564988.919145] usb 2-5.1: configuration #1 
chosen from 1 choice
Sep 16 11:39:05 coyote bluetoothd[892]: HCI dev 0 registered
Sep 16 11:39:05 coyote bluetoothd[892]: HCI dev 0 up
Sep 16 11:39:05 coyote bluetoothd[892]: Starting security manager 0
Sep 16 11:39:05 coyote bluetoothd[892]: Parsing 
/usr/local/etc/bluetooth/serial.conf failed: Key file does not start with a 
group
Sep 16 11:39:05 coyote bluetoothd[892]: Adapter /org/bluez/892/hci0 has been 
enabled

Q: What defines this missing "group" in the serial.conf file?, which is now 
100% commented.  Copied from the 4.51 serial tree verbatum since it wasn't 
installed by a make install.

Firing up bluetooth-wizard, the eb101 is displayed, and can be selected, but 
the pairing attempt fails.  Pin on both ends is 0000.

What can I do to make minicom find and use this hci0 device as a modem 
circuit?  /dev/hci0 doesn't exist, and minicom can't find  
/org/bluez/892/hci0.

Having minicom -s set for it, then save as coco3 (not df1), then launching a
minicom coco3 returns:
[root@coyote tools]# minicom coco3
Device /org/bluez/892/hci0 access failed: No such file or directory.


Thank you.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
The NRA is offering FREE Associate memberships to anyone who wants them.
<https://www.nrahq.org/nrabonus/accept-membership.asp>

Avoid the Gates of Hell.  Use Linux
	-- unknown source
