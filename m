Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v5] Bluetooth: Add support for QCA ROME chipset family
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5D613851-2AAB-4104-BD45-5A7A95647BEA@qca.qualcomm.com>
Date: Sat, 14 Feb 2015 15:35:58 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D68C4A91-FF79-411F-8E80-95AFE46DE339@holtmann.org>
References: <5355d8dbb7584d488f6d059306d3a1ad@nalasexr02e.na.qualcomm.com> <230EFAD9-F4D1-43E0-B84B-CD8AFB612B96@holtmann.org> <5D613851-2AAB-4104-BD45-5A7A95647BEA@qca.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

>>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>>> e.g. QCA61x4 or QCA6574.
>>> 
>>> New chipset have similar firmware downloading sequences to previous
>>> chipset from Atheros, however, it doesn't support vid/pid switching
>>> after downloading the patch so that firmware needs to be handled by
>>> btusb module directly.
>>> 
>>> ROME chipset can be differentiated from previous version by reading
>>> ROM version.
>>> 
>>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 16 Spd=12   MxCh= 0
>>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>> P:  Vendor=0cf3 ProdID=e300 Rev= 0.01
>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> 
>>> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  8 Spd=12   MxCh= 0
>>> D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>> P:  Vendor=0cf3 ProdID=e360 Rev= 0.01
>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> 
>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 265 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index b876888..45fe262 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
>>> #define BTUSB_SWAVE		0x1000
>>> #define BTUSB_INTEL_NEW		0x2000
>>> #define BTUSB_AMP		0x4000
>>> +#define BTUSB_QCA_ROME		0x8000
>>> 
>>> static const struct usb_device_id btusb_table[] = {
>>> 	/* Generic Bluetooth USB device */
>>> @@ -212,6 +213,10 @@ static const struct usb_device_id blacklist_table[] = {
>>> 	{ USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
>>> 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
>>> 
>>> +	/* QCA ROME chipset */
>>> +	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME},
>>> +	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME},
>>> +
>>> 	/* Broadcom BCM2035 */
>>> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
>>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
>>> @@ -336,6 +341,8 @@ struct btusb_data {
>>> 
>>> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
>>> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
>>> +
>>> +	int (*setup_patch_usb)(struct hci_dev *hdev);
>>> };
>> 
>> I prefer to do this in two patches. One that add the extra callback handling. And then the other adding QCA support.
>> 
>> However I do wonder if setup_patch_usb is the right name here. I current fail to come up with a better name. So I am open for ideas.
>> 
>> One other thing I am wondering is if this should take a btusb_data pointer. Since we are bypassing hci_dev anyway. We do not have to do that, but I am wondering if that makes sense.
> 
> If we’re okay to touch hci_dev structure, I would prefer to add this function pointer in hci_dev. The reason why btusb_data struct was chosen is it doesn’t need to touch outside of header or files except btusb.c file. If possible, I’ll add setup function pointer in hci_dev as ’setup_on_usb’. That is more clean & easily readable.

we are not okay with that at all. This is btusb.c internal detail on how to handle the USB transport. That is why I asked about doing this over HCI. Then we could involve the core layer, but for USB specific details we can never ever involve the Bluetooth core layer.

>> 
>> The overall patch looks fine to me and if it works for you I am fine doing it. I think we just need to make sure this is clean and all angles are thought through before I merge it.
> 
> My testing has been good & got couple of testing feedbacks said this patch is good to go.


Yes. It is just cosmetics at this point.

Regards

Marcel

