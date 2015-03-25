Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?J=FCrgen?= Bausa <Juergen.Bausa@online.de>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Broadcom 43340 BT support
Date: Wed, 25 Mar 2015 23:31:07 +0100
Message-ID: <2062075.mRqYCfPv9s@lina>
In-Reply-To: <F2171E58-C919-4EEB-9305-6BC3858A7242@holtmann.org>
References: <201503242237.07923.Juergen.Bausa@online.de> <F2171E58-C919-4EEB-9305-6BC3858A7242@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Am Dienstag, 24. März 2015, 16:42:29 schrieben Sie:
> Hi Juergen,
> 
> > I have a laptop (asus x205ta / intel-baytrail) with the broadcom 43340
> > chipset. However, while wireless is working now, bluetooth is not. I am
> > running debian jessie 32 bit with kernel 4.0rc4:
> > 
> > root@lina:/home/jba# hciconfig --all
> > hci0:   Type: BR/EDR  Bus: SDIO
> > 
> >        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
> >        DOWN
> >        RX bytes:0 acl:0 sco:0 events:0 errors:0
> >        TX bytes:0 acl:0 sco:0 commands:0 errors:0
> >        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >        Packet type: DM1 DH1 HV1
> >        Link policy:
> >        Link mode: SLAVE ACCEPT
> 
> can you figure out which driver is claiming that it is SDIO based? I assumed
> the Baytrail Bluetooth controllers are all attached via UARTs. I didn't
> know that Broadcom had Bluetooth on SDIO. The WiFi part yes, but the
> Bluetooth part should be on an UART.

I think it is btsdio. When I rmmod the driver, I dont see hci0 anymore. So if 
this is not the correct driver, I need another one. But it seems the correct 
one is still under developement, correct?



> 
> Please also check with "rfkill list" if the device might be blocked.

Its not blocked.

> 
> Arend might know more, but you would need to dig into the list of SDIO
> devices. Sadly I think Linux does not yet have a lssdio tool. So maybe lshw
> can get us some info on what the kernel thinks about this device.
> Alternatively you need to dig you sysfs and look at ACPI. Maybe dmesg
> reveals something useful.
> 

With lshw and lsusb I found nothing. Under /sys I found this:

root@lina:/sys/bus/sdio/drivers# ll
insgesamt 0
drwxr-xr-x 2 root root 0 Mär 25 22:09 brcmfmac_sdio
drwxr-xr-x 2 root root 0 Mär 25 22:09 btsdio
root@lina:/sys/bus/sdio/drivers# ll brcmfmac_sdio/
insgesamt 0
--w------- 1 root root 4096 Mär 25 23:12 bind
lrwxrwxrwx 1 root root    0 Mär 25 23:12 mmc1:0001:1 -> 
../../../../devices/platform/INT33BB:00/mmc_host/mmc1/mmc1:0001/mmc1:0001:1
lrwxrwxrwx 1 root root    0 Mär 25 23:12 mmc1:0001:2 -> 
../../../../devices/platform/INT33BB:00/mmc_host/mmc1/mmc1:0001/mmc1:0001:2
lrwxrwxrwx 1 root root    0 Mär 25 23:12 module -> ../../../../module/brcmfmac
--w------- 1 root root 4096 Mär 25 22:09 uevent
--w------- 1 root root 4096 Mär 25 23:12 unbind
root@lina:/sys/bus/sdio/drivers# ll btsdio/
insgesamt 0
--w------- 1 root root 4096 Mär 25 23:12 bind
lrwxrwxrwx 1 root root    0 Mär 25 23:12 mmc1:0001:3 -> 
../../../../devices/platform/INT33BB:00/mmc_host/mmc1/mmc1:0001/mmc1:0001:3
--w------- 1 root root 4096 Mär 25 22:09 uevent
--w------- 1 root root 4096 Mär 25 23:12 unbind

If I interpret this correctly, Arend is right. There is a sdio driver claiming 
the bt and uses the same mmc but with #3, while wifi takes #1 and #2.

Googling I found that the intel edison board also has a broadcom 43340. I also 
read BT works on this device. So, there should be a driver for it, right?

Juergen
