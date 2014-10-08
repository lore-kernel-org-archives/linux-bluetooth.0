Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412765090.21709.18.camel@linux-0dmf.site>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
	<CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	<1412602169.28177.2.camel@linux-0dmf.site>
	<CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
	<1412607050.1743.1.camel@linux-0dmf.site>
	<CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
	<CAG0bkv+_t8CqM9w5N1hKJtT=_mQmtWWCPe-9jSHuOkNZCL3B9A@mail.gmail.com>
	<1412676071.1926.1.camel@linux-0dmf.site>
	<CAG0bkvKYT5+ZBZwdvG71g98CqZR03er6rN4y5RRfq6UUL5KnCw@mail.gmail.com>
	<CAG0bkv+YK6_wP+cnZEmfRZnLXa=7N1CMyYqVAbao22gf74dhbw@mail.gmail.com>
	<1412759368.21709.15.camel@linux-0dmf.site>
	<CAG0bkvKugdQSDm+GKRbLGLzrURth5ty9KU-8d3ED-a9sgdDkMg@mail.gmail.com>
	<1412765090.21709.18.camel@linux-0dmf.site>
Date: Wed, 8 Oct 2014 18:31:12 +0530
Message-ID: <CAG0bkvLy9YNdD-0hYNygT0cVEHAZebobxwJKdsuUcXsLmq9BfQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Do you see the problem with single devices?

If I connect only one device to system then I did not see this issue.
Usually I will use 8 devices(all with the same firmware) for testing.





I tried different method to get some clue. First I disconnected all
the devices and rebooted the system and later connected only one
device and observed hci0 related debug print statements in the kernel
log. Waited for 16mins idle, but did not get –EPIPE.

Oct  8 16:41:46 banunxcas29 kernel: [  488.018751] usb 1-1.5.1.7: new
full speed USB device number 13 using ehci_hcd

Oct  8 16:41:46 banunxcas29 kernel: [  488.093487] usb 1-1.5.1.7: New
USB device found, idVendor=0451, idProduct=2036

Oct  8 16:41:46 banunxcas29 kernel: [  488.093494] usb 1-1.5.1.7: New
USB device strings: Mfr=0, Product=1, SerialNumber=0

Oct  8 16:41:46 banunxcas29 kernel: [  488.093499] usb 1-1.5.1.7:
Product: General Purpose USB Hub

Oct  8 16:41:46 banunxcas29 kernel: [  488.094581] hub 1-1.5.1.7:1.0:
USB hub found

Oct  8 16:41:46 banunxcas29 kernel: [  488.094811] hub 1-1.5.1.7:1.0:
2 ports detected

Oct  8 16:41:46 banunxcas29 kernel: [  488.261141] usb 1-1.5.2: new
full speed USB device number 14 using ehci_hcd

Oct  8 16:41:46 banunxcas29 kernel: [  488.323983] usb 1-1.5.2: device
descriptor read/64, error -32

Oct  8 16:41:47 banunxcas29 kernel: [  488.518202] usb 1-1.5.2: New
USB device found, idVendor=0a12, idProduct=0001

Oct  8 16:41:47 banunxcas29 kernel: [  488.518208] usb 1-1.5.2: New
USB device strings: Mfr=0, Product=0, SerialNumber=0

Oct  8 16:41:47 banunxcas29 kernel: [  488.551389] Bluetooth: Core ver 2.16

Oct  8 16:41:47 banunxcas29 kernel: [  488.551402] NET: Registered
protocol family 31

Oct  8 16:41:47 banunxcas29 kernel: [  488.551404] Bluetooth: HCI
device and connection manager initialized

Oct  8 16:41:47 banunxcas29 kernel: [  488.551406] Bluetooth: HCI
socket layer initialized

Oct  8 16:41:47 banunxcas29 kernel: [  488.551408] Bluetooth: L2CAP
socket layer initialized

Oct  8 16:41:47 banunxcas29 kernel: [  488.551411] Bluetooth: SCO
socket layer initialized

Oct  8 16:41:47 banunxcas29 kernel: [  488.565663] Bluetooth: Generic
Bluetooth USB driver ver 0.6

Oct  8 16:41:47 banunxcas29 kernel: [  488.565693] intf
ffff880128640800 id ffffffffa0197f00

Oct  8 16:41:47 banunxcas29 kernel: [  488.580231] hci0

Oct  8 16:41:47 banunxcas29 kernel: [  488.580236] hci0

Oct  8 16:41:47 banunxcas29 kernel: [  488.580258] intf
ffff880128641000 id ffffffffa0197f00

Oct  8 16:41:47 banunxcas29 kernel: [  488.580296] usbcore: registered
new interface driver btusb

Oct  8 16:41:47 banunxcas29 kernel: [  488.580480] hci0

Oct  8 16:41:47 banunxcas29 kernel: [  488.580486] hci0

Oct  8 16:41:47 banunxcas29 kernel: [  488.580503] hci0

Oct  8 16:41:47 banunxcas29 kernel: [  488.581314] hci0 urb
ffff880131dbe3c0 status 0 count 6







Later connected one more device to system and noticed hci1 related
debug print statements in the kernel log. Waited for 20mins idle and
now also not received –EPIPE.

Oct  8 16:57:44 banunxcas29 kernel: [ 1443.815276] usb 1-1.5.3: new
full speed USB device number 17 using ehci_hcd

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.400987] usb 1-1.5.3: New
USB device found, idVendor=0a12, idProduct=0001

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.400993] usb 1-1.5.3: New
USB device strings: Mfr=0, Product=0, SerialNumber=0

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403218] intf
ffff880124c45800 id ffffffffa0197f00

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403360] hci1

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403364] hci1

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403500] intf
ffff880124c44c00 id ffffffffa0197f00

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403511] hci1

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403515] hci1

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.403529] hci1

Oct  8 16:57:45 banunxcas29 kernel: [ 1444.404872] hci1 urb
ffff880129162840 status 0 count 6





Later connected third device(hci2) and after 2mins observed –EPIPE for
hci2(hci2 urb ffff880124f11cc0 status -32 count 0)

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.069853] usb 1-1.5.4: new
full speed USB device number 18 using ehci_hcd

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.681729] usb 1-1.5.4: New
USB device found, idVendor=0a12, idProduct=0001

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.681735] usb 1-1.5.4: New
USB device strings: Mfr=0, Product=0, SerialNumber=0

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.683689] intf
ffff880119c3b400 id ffffffffa0197f00

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.683886] hci2

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.683889] hci2

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.684083] intf
ffff880119c3a800 id ffffffffa0197f00

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.684161] hci2

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.684166] hci2

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.684184] hci2

Oct  8 17:18:21 banunxcas29 kernel: [ 2677.685364] hci2 urb
ffff880124f11cc0 status 0 count 6

Oct  8 17:18:22 banunxcas29 kernel: [ 2678.126333] hci2 urb
ffff880124f11cc0 status 0 count 6

Oct  8 17:20:20 banunxcas29 kernel: [ 2795.645039] hci2 urb
ffff880124f11cc0 status -32 count 0

Oct  8 17:20:20 banunxcas29 kernel: [ 2795.646013] hci2





Later connected 4th device(hci3) and now repeatedly getting –EPIPE for
hci3 and hci2

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.073252] usb 1-1.5.5: new
full speed USB device number 19 using ehci_hcd

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.746971] usb 1-1.5.5: New
USB device found, idVendor=0a12, idProduct=0001

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.746977] usb 1-1.5.5: New
USB device strings: Mfr=0, Product=0, SerialNumber=0

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749042] intf
ffff880124c47400 id ffffffffa0197f00

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749403] hci3

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749407] hci3

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749526] intf
ffff880124c47000 id ffffffffa0197f00

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749679] hci3

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749684] hci3

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.749700] hci3

Oct  8 17:44:14 banunxcas29 kernel: [ 4226.750520] hci3 urb
ffff8801344e6a80 status 0 count 6

Oct  8 17:49:45 banunxcas29 kernel: [ 4556.495180] hci3 urb
ffff8801344e6a80 status -32 count 0

Oct  8 17:49:45 banunxcas29 kernel: [ 4556.496341] hci3

Oct  8 17:51:24 banunxcas29 kernel: [ 4655.170274] hci2 urb
ffff880131c6ea80 status -32 count 0

Oct  8 17:51:24 banunxcas29 kernel: [ 4655.170345] hci3 urb
ffff880124dfb480 status -32 count 0

Oct  8 17:51:24 banunxcas29 kernel: [ 4655.171381] hci2

Oct  8 17:51:24 banunxcas29 kernel: [ 4655.171759] hci3

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.920586] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.921890] hci3

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.928470] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.929511] hci3

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.933570] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.934402] hci3

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.940425] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:00:24 banunxcas29 kernel: [ 5193.941531] hci3

Oct  8 18:05:18 banunxcas29 kernel: [ 5487.003279] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:05:18 banunxcas29 kernel: [ 5487.004528] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.844852] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.846068] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.860809] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.861776] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.867701] hci3 urb
ffff880124f11d80 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.868651] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.874669] hci2 urb
ffff880124f11cc0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.874738] hci3 urb
ffff880124f183c0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.875772] hci2

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.875949] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.877734] hci2 urb
ffff880124f11cc0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.877800] hci3 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.878720] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5552.878922] hci2

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.098220] hci3 urb
ffff880124f11cc0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.098291] hci2 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.099158] hci2

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.099339] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.101145] hci3 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.102165] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.107198] hci3 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.108141] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.121160] hci3 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.122130] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.133127] hci2 urb
ffff880124f11cc0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.133196] hci3 urb
ffff880124f11e40 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.134075] hci3

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.134300] hci2

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.136143] hci3 urb
ffff880124f11cc0 status -32 count 0

Oct  8 18:06:24 banunxcas29 kernel: [ 5553.136176] hci2 urb
ffff880124f11e40 status -32 count 0





I ran hcidump for each hci device separately, but it does not show any
activity during EPIPE occurrence.

It clearly tells that device not producing stalls , looks like issue
might be in between btusb and ehci_hcd\hub.

What might the best way to recover and avoid spurious stalls?



Thanks,

Naveen

On Wed, Oct 8, 2014 at 4:14 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Wed, 2014-10-08 at 15:51 +0530, Naveen Kumar Parna wrote:
>> hcidump does not show anything when the stalls happen.
>
> There is nothing in all logs. Do you see the problem
> with single devices?
>
>         Regards
>                 Oliver
>
>
