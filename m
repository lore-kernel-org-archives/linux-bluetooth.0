Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Add support for Intel Bluetooth device 8265 [8087:0a2b]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160505130115.506a4d13@fedora-linux-22.shared>
Date: Thu, 5 May 2016 17:59:45 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CFFAA6FA-195A-4BFD-A5E7-A0F9EB44CE7B@holtmann.org>
References: <20160505130115.506a4d13@fedora-linux-22.shared>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds support for Intel Bluetooth device 8265 also known
> as Windstorm Peak (WsP).
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  6 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=8087 ProdID=0a2b Rev= 0.10
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0d4e372..4763e8c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2001,12 +2001,12 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 		return -EINVAL;
> 	}
> 
> -	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP) is
> +	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP/WsP) is
> 	 * supported by this firmware loading method. This check has been
> 	 * put in place to ensure correct forward compatibility options
> 	 * when newer hardware variants come along.
> 	 */

lets write this cleaner so that we remember which variant is which.

	/* At the moment the iBT 3.0 hardware variants 0x0b (LnP/SfP)
	 * and 0x0c (WsP) are supported by this firmware loading method.
	 *
	 * This check has been put in place to ensure correct forward
	 * compatibility options when newer hardware variants are released.
	 */

> -	if (ver.hw_variant != 0x0b) {
> +	if ((ver.hw_variant != 0x0b) && (ver.hw_variant != 0x0c)) {

The extra () are not needed. So change it to this:

	if (ver.hw_variant != 0x0b && ver.hw_variant != 0x0c)

> 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
> 		       hdev->name, ver.hw_variant);
> 		return -EINVAL;

If you have time, you might want to also send a patch to tools/bluemoon.c to update the identification tables.

Regards

Marcel

