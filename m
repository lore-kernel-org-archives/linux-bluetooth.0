Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Use DMI matching for QCA reset_resume
 quirking
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180220080618.7054-2-hdegoede@redhat.com>
Date: Tue, 20 Feb 2018 13:23:20 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Message-Id: <EBC5738E-E920-4593-8869-4A8F0AC0CB36@holtmann.org>
References: <20180220080618.7054-1-hdegoede@redhat.com>
 <20180220080618.7054-2-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Commit 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume fix
> with a "rewritten" version") applied the USB_QUIRK_RESET_RESUME to all QCA
> USB Bluetooth modules. But it turns out that the resume problems are not
> caused by the QCA Rome chipset, on most platforms it resumes fine. The
> resume problems are actually a platform problem (likely the platform
> cutting all power when suspended).
> 
> The USB_QUIRK_RESET_RESUME quirk also disables runtime suspend, so by
> matching on usb-ids, we're causing all boards with these chips to use extra
> power, to fix resume problems which only happen on some boards.
> 
> This commit fixes this by applying the quirk based on DMI matching instead
> of on usb-ids, so that we match the platform and not the chipset.
> 
> Here is the /sys/kernel/debug/usb/devices for the Bluetooth module:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  5 Spd=12   MxCh= 0
> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Fixes: 61f5acea8737 ("Bluetooth: btusb: Restore QCA Rome suspend/resume..")
> Cc: stable@vger.kernel.org
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-and-tested-by: Kevin Fenzi <kevin@scrye.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 26 ++++++++++++++++++++------
> 1 file changed, 20 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

