Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: tiwai@suse.de, hdegoede@redhat.com
Reply-To: s5h604nranj.wl-tiwai@suse.de
From: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: Re: Re: [4.15 stable regression] "Bluetooth: btusb: Fix quirk for
 Atheros 1525/QCA6174" breaks bluetooth
Message-ID: <ae974150-67c9-af8f-4a7f-72ce742f9ad7@gmail.com>
Date: Sun, 22 Apr 2018 20:50:54 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On Wed, 18 Apr 2018 15:18:59 +0200,
> Hans de Goede wrote:
> > 
> > Hi Takashi, Marcel,
> > 
> > It seems that this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.15.y&id=7ec32f585fefd7c154453aa29ccf8fa2a11cc865
> > 
> > Is breaking bluetooth on some devices, see:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1568911
> > 
> > The problem is the following error now being thrown:
> > 
> > [   28.466248] Bluetooth: hci0: don't support firmware rome 0x1020200
> > 
> > Looking at the code I wonder if maybe we need to mask the ver_rom
> > with & 0xfff when comparing it to the qca_devices_table[i].rom_version
> > filed ?
> > 
> > Or maybe the commit is actually wrong, or maybe devices with the
> > 0cf3:3004 USB id need either the BTUSB_QCA_ROM or BTUSB_ATH3012
> > quirk depending on the device and we need to probe this somehow?
>
> I'd love to know the proper fix, too.  It was already concerned from
> the beginning I asked about the change, as the 0cf3:3004 is the very
> first one that was used for BTUSB_ATH3012 quirk.
>
> In anyway, I myself have no such device but can ask testing if any
> further patch is available.
>
>
> thanks,
>
> Takashi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

My device don't work to

lsusb:
Bus 001 Device 004: ID 0cf3:3004 Qualcomm Atheros Communications AR3012 
Bluetooth 4.0

dmesg:
[   95.607342] Bluetooth: hci0: don't support firmware rome 0x1020200

sysfs:
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=3004 Rev= 0.01
S:  Manufacturer=Atheros Communications
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=Alaska Day 2006
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms


