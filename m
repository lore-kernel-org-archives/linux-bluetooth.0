Return-Path: <cyrus@holtmann.org>
Message-ID: <1432570112.3146.5.camel@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Support QCA61x4 ROME v2.0
From: Chanyeol Park <chanyeol.park@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Chan-yeol Park
 <chanyeol.park@samsung.com>
Date: Tue, 26 May 2015 01:08:32 +0900
In-Reply-To: <1432175067-3156-1-git-send-email-chanyeol.park@samsung.com>
References: <1432175067-3156-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel

On Thu, 2015-05-21 at 11:24 +0900, Chan-yeol Park wrote:
> The previous commit(3267c88) missed QCA61x4 ROME v2.0 info on Samsung
> so its BT is not activated and the below message is shown.
> 
> [    8.009638] usb 1-1: New USB device found, idVendor=0cf3, 
> idProduct=e300
> [    8.012637] usb 1-1: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=0
> [    8.102901] Bluetooth: hci0: don't support firmware rome 0x200
> 
> This patch adds QCA61x4 ROME v2.0 info in qca_devices_table[], and is
> verified on Samsung with the firmware provided by Kim, Ben Young Tae
> <ytkim@qca.qualcomm.com>.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
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
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b9f2821..c334620 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2382,6 +2382,7 @@ struct qca_device_info {
>  static const struct qca_device_info qca_devices_table[] = {
>       { 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
>       { 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
> +     { 0x00000200, 28, 4, 18 }, /* Rome 2.0 */
>       { 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>       { 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>       { 0x00000302, 28, 4, 18 }, /* Rome 3.2 */

I also verified this with fedora 22 on Samsung laptop today. Kindly
could you review this? I would like to use the Bluetooth with upstream Kernel on my machine :).

Thanks
Chanyeol
