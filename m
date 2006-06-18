Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4495C348.70501@uni-koblenz.de>
Date: Sun, 18 Jun 2006 23:19:04 +0200
From: Kevin Read <kread@uni-koblenz.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4493FEAF.3000904@uni-koblenz.de>
	<1150657327.8816.20.camel@localhost>
In-Reply-To: <1150657327.8816.20.camel@localhost>
Subject: Re: [Bluez-users] Multiple connections with kernel 2.4 make HCI die
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:

Hi Marcel,

thanks for the quick answer.

>> I know that kernel 2.4 is no longer supported, but I hope that somebody 
>> can give me a clue here...
>>
>> I'm attempting to create a multi-threaded, multi-dongle OBEX client
>> appliance. When I run it on a kernel 2.6 based machine (either a x86 or
>> on a NSLU2, which is a big-endian ARM box), everything runs very smooth.
>>
>> The same code compiled for a little endian MIPS machine running kernel
>> 2.4.30 has problems. I cannot change the kernel version, because the
>> on-board Broadcom wireless chipset of the router doesn't really work yet
>>   under kernel 2.6 (damn closed source drivers) :(
> 
> I am not buying this argument, because the bcm43xx open source driver
> exists. Otherwise simply swap the mini-PCI card for an Intel one.

This is slightly OT but I hope it might be of interest to some:
I have already tried to compile the bcm43xx driver in OpenWRT kamikaze. 
Master mode will only work with the devicescape-branch of bcm43xx. Some 
OpenWRT co-users patched the Kamikaze kernel up to the latest code from 
the wireless-dev git repository. Unfortunately there was no joy there. 
Master mode does not yet run correctly, although the outlook is pretty 
good, as patches integrating bcm43xx and Hostap where sent to the 
bcm43xx devs and will hopefully get integrated soon.

Unfortunately for me, I need WDS and this has not yet been coded. And 
Kamikaze kernel 2.6 USB is broken at the moment, so I couldn't test 
bluetooth operation on the 2.6 :(

I'll look into swapping the mini-PCI card, thanks for the pointer. That 
might become a great alternative once the USB problems get sorted out.

<snip>
>>
>> I have applied the changes in the 2.4.32 patch by Marcel, but I think
>> they only refer to module unloading. Bluez installed is version 2.32. I
>> already stressed the USB bus with wireless and a hard disk, to rule out
>> that the usb driver has some funkiness, but everything went smooth.
> 
> You can try to make sure that the hci_usb driver doesn't use any ISOC
> transfers for SCO. The 2.4 USB subsystem was kinda picky about it. Other
> than that you don't really have a choice except re-writing the hci_usb
> driver.

Ok, I'll rebuild a kernel with SCO support right away. Will that 
suffice, or should I comment out the ISOC stuff in hci_usb.c?

I don't think I'll manage a re-write of hci_usb :/ Waiting for solid 2.6 
usb and bcm43xx support will definitely be faster than that ;)

Regards and thanks,

Kevin


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
