Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hciconfig doesn't come up
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <d6db2b820602150319o1a15fea8ib7d00796d0b9d814@mail.gmail.com>
References: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
	 <1139993269.26072.25.camel@localhost>
	 <d6db2b820602150319o1a15fea8ib7d00796d0b9d814@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140010830.26072.63.camel@localhost>
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
Date: Wed, 15 Feb 2006 14:40:30 +0100

Hi Michael,

>         > We would like to setup BT communication on embedded
>         MIPS-processor
>         > Broadcom card with Linux 2.4.20 (patched by patch no.18 of
>         M.Holtman).
>         > Kernel contained USB support, HID support and BlueTooth
>         support (on
>         > all layers).
>         > On this card we're using USB-PCI host-controller of Philips
>         > (ISP1562ES1). 
>         > We are using Bluez-2.24 library and utils. We also use the
>         library for
>         > userspace-kernelspace USB translation (libusb-0.1.so.4.4.3).
>         
>         the 2.4 kernel series are no longer supported and actually the
>         USB part 
>         of these kernels might be buggy, too.
> 
> This kernel "slightly" patched by Broadcom (for example, USB 2.0
> support downgraded from 2.4.26, etc.), so it is not "really" 2.4.20,
> but you're right, it's still might be buggy...

downgrade for what reason. This is stupid. Ask for their changes and
then extract the stuff that is needed to drive this board and then port
it to a 2.6 kernel. The Linux kernel is GPL and thus Broadcom can't keep
any secrets.

>         > We are using CSR based BT dongle with the following
>         description:
>         > >T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5
>         Spd=12  MxCh= 0> 
>         > >D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64
>         #Cfgs=  1
>         > >P:  Vendor=0a12 ProdID=0001 Rev= 11.20
>         > (as we saw in the supported products list, it is supported.)
>         
>         It is fully supported. What build id is this? I know that the
>         Rev equals 
>         the build id, but I always forget how to convert it.
> 
> I gues that you are you refering to the build ID of the BT dongle
> firmware. Is there a way to "pull" it from the device?

Use "hciconfig hci0 version revision" if you have the device running.

Maybe using another dongle will solve this. There can be a bug in the
firmware or it is a cheap dongle. I still have dongles around that won't
work specific USB host controller chipsets and don't have any clue on
how to fix this.

>         Make sure only one hcid is running at a time.
> 
> We checked with single hcid and there is no difference in the
> behaviour. 

I don't expected any difference actually, but having multiple hcid
running will get you into trouble later :)

>         Why don't try to use a decent 2.6 kernel for embedded board?
>         This will
>         make all things a lot easier.
> 
> Unfortunately, the embedded board supports only 2.4.20 kernel with all
> its problematic issues.   

Sorry, but this is total nonsense. See my statement above. Start
contacting the MIPS maintainer and one of the USB guys. They will
happily help you fixing it. Of course you might have to donate one of
these boards, but that's worth it.

>         Move to a 2.6 kernel, because I think this is a bug inside the
>         USB 
>         subsystem. However if you don't need SCO support, you might
>         wanna
>         disable the ISOC transfers (SCO support) of the hci_usb
>         driver.
> 
> Hm...  We indeed won't need any SCO support. HCO is not used although
> curently part of the kernel.  How it might influence on our setup?

The ISOC transfers that are needed for SCO support consume USB bandwidth
and some USB host controllers might not be able to handle them right.
Especially if it is a 2.4 host driver.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
