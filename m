Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Mr Dini <diniboy74@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez Can't see my adapter
Date: Wed, 15 Jun 2016 12:24:47 +0200
Message-ID: <1735193.DjGFazkIj4@leonov>
In-Reply-To: <CANVNt1Y=9Jz8tC-Awg0YeG4hzMzo-T9y3u8qbW1Jth-V-AUiuw@mail.gmail.com>
References: <CANVNt1Yn_e6Cifr3RS-j+V3zfernk68wEp_t-BgTcs6o1FJ-Fw@mail.gmail.com> <1949209.JsJb5RHiCb@leonov> <CANVNt1Y=9Jz8tC-Awg0YeG4hzMzo-T9y3u8qbW1Jth-V-AUiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 15 of June 2016 12:21:09 Mr Dini wrote:
> And if I try bluez4 or older? What is the best for mine case?
> 
> Thanks!

BlueZ4 should work. Just note that it is quite old and unsupported by 
upstream.

> 
> 2016.06.15. 12:18, "Szymon Janc" <ext.szymon.janc@tieto.com> ezt írta:
> > Hi,
> > 
> > On Wednesday 15 of June 2016 11:18:22 Mr Dini wrote:
> > > Hi!
> > > 
> > > I have a 0a12:0001 bluetooth dongle and an arm5 based nas. It is an
> > > embedded linux with the old 2.6.31.8 kernel.
> > 
> > BlueZ5 requires kernel 3.4 or newer. You could try with kernel backports
> > but
> > I'm not sure if they still support 2.6 kernels.
> > 
> > > Unfortunately the manufacturer disabled the bt at the kernel, So I had
> > > to recompile a kernel with Bluetooth support. I flashed it using an
> > > USB TTL cable via u-boot.
> > > 
> > > After it I compiled the latest bluez 5.40 with "./configure
> > > --prefix=/ffp --disable-systemd" command and I wrote a patch to not
> > > use ppol, because the kernel not supports that syscall...
> > > 
> > > After a make and an install I Can launch the bluetoothd and I Can use
> > > the whole bluez package as expected. :)
> > > 
> > > Now I tried to load the btusb module, but the dmesg said, it already
> > > loaded. So I put on my dongle and saw this dmesg part(the dongle is
> > > reattached):
> > > 
> > > btusb_intr_complete: hci0 urb ce155da0 failed to resubmit (19)
> > > btusb_bulk_complete: hci0 urb c01832c0 failed to resubmit (19)
> > > btusb_bulk_complete: hci0 urb c0183540 failed to resubmit (19)
> > > btusb_send_frame: hci0 urb c0183540 submission failed
> > > usb 1-1.1: new full speed USB device using ehci_marvell and address 8
> > > usb 1-1.1: device descriptor read/64, error -32
> > > In hub_port_init, usb_device_id = 7, devnum = 8
> > > In hub_port_init, and number is 2, retry 0, port 1 .....
> > > usb 1-1.1: configuration #1 chosen from 1 choice
> > > 
> > > When I execute "hciconfig hci0 up" I Can see my dongle at the hciconfig:
> > > 
> > > hci0:   Type: BR/EDR  Bus: USB
> > > 
> > >         BD Address: secret  ACL MTU: 310:10  SCO MTU: 64:8
> > >         UP RUNNING
> > >         RX bytes:380 acl:0 sco:0 events:13 errors:0
> > >         TX bytes:38 acl:0 sco:0 commands:11 errors:0
> > > 
> > > And I Can see my nearby bt devices if I make a scan using the hcitool.
> > > 
> > > But if I try to use the bluetoothctl to do this, it says:
> > > 
> > > # bluetoothctl
> > > [bluetooth]# scan on
> > > No default controller available
> > > 
> > > But why? I have run out of ideas at this part...
> > > 
> > > Some additional information:
> > > 
> > > The system uses uClibc compiler.
> > > 
> > > And the rfkill says my device isn't blocked:
> > > 
> > > # rfkill list
> > > 2: hci0: Bluetooth
> > > 
> > >         Soft blocked: no
> > >         Hard blocked: no
> > > 
> > > Thanks a lot!
> > > 
> > > Ps: Sorry for my bad English and for the unformatted message (I am
> > > using mutt)...
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > 
> > linux-bluetooth"
> > 
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > BR
> > Szymon Janc

-- 
BR
Szymon Janc
