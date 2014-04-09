Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C41A1B83-9150-4090-A182-0245F8CD715F@holtmann.org>
References: <20140409010501.4B23E100A34@puck.mtv.corp.google.com>
	<7DA0218C-A05A-4E9C-9042-AA7E6F933302@holtmann.org>
	<CAGXr9JF-SxutMuhkrqKhC7xEg7-9pPaW26MmbXxg2df0-DFxzQ@mail.gmail.com>
	<C41A1B83-9150-4090-A182-0245F8CD715F@holtmann.org>
Date: Wed, 9 Apr 2014 13:06:49 -0700
Message-ID: <CAGXr9JFqfvD+dD4ciidzpODuUQ2erg-L3RA=jEc_RDrjSPaa=Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add BCM20702 firmware upgrade support
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 9, 2014 at 10:01 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Petri,
>
>>>> After hardware reset, BCM20702 obtains its initial firmware from a PRO=
M chip.
>>>> Once this initial firmware is running, the firmware can be further upg=
raded
>>>> over HCI interface with .hcd files provided by Broadcom. This is also =
known
>>>> as "patch RAM" support. This change implements that.
>>>>
>>>> If the .hcd file is not found in /lib/firmware, BCM20702 continues to =
operate
>>>> with the initial firmware. Sample kernel log:
>>>> hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/bcm20702-0a5c-22be.hcd dev=
=3D...
>>>> Bluetooth: hci0: BCM20702: patch brcm/bcm20702-0a5c-22be.hcd not found
>>>> Bluetooth: hci0: BCM20702: firmware hci_ver=3D06 hci_rev=3D1000 lmp_ve=
r=3D06 lmp_subver=3D220e
>>>>
>>>> If the .hcd file is found, btusb driver pushes it to BCM20702, and BCM=
20702
>>>> starts using the new firmware. Sample kernel log:
>>>> hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/bcm20702-0a5c-22be.hcd dev=
=3D...
>>>> Bluetooth: hci0: BCM20702: patching hci_ver=3D06 hci_rev=3D1000 lmp_ve=
r=3D06 lmp_subver=3D220e
>>>> Bluetooth: hci0: BCM20702: firmware hci_ver=3D06 hci_rev=3D1389 lmp_ve=
r=3D06 lmp_subver=3D220e
>>>>
>>>> Above, we can see that hci_rev goes from 1000 to 1389 as a result of t=
he upgrade.
>>>
>>> this is a nice feature to have. Where are these hcd files are coming fr=
om. Are they available somewhere or do we have them available in linux-firm=
ware.git tree.
>>
>> In our case, we get these files directly from the vendor. I haven't
>> seen these in linux-firmware.git tree. Some searching reveals that
>> Windows drivers contain either .hex or .hcd files, and there appears
>> to be a tool hex2hcd to convert to .hcd. See page
>> http://swiesmann.de/?p=3D30.
>
> what is the firmware name that the files from the vendor have. My problem=
 with introducing a VID+PID based naming is that it might causes problems w=
hen the VID+PID is re-used for a different SKU or revision of the same boar=
d and we should have picked the firmware based on the board version.

The firmware files seem to have a naming pattern
BCM20702A0_aaa.bbb.ccc.dddd.eeee. I don't know where
aaa.bbb.ccc.dddd.eeee are derived from. Some version number, I guess.

>
> And the HEX vs HCD is most likely the same as Intel=E2=80=99s seq vs bseq=
. Just one is a text file and the other a binary version of the same data. =
In all cases these are HCI commands anyway.
>
>> Interestingly, now that I look at that page more closely, Ubuntu 12.04
>> LTS with kernel 3.8 supports this already? Has Ubuntu made a patch
>> that bluetooth-next doesn't have?
>
> That is Ubuntu for you. They just push patches into their kernel and neve=
r give them back to upstream or make sure they get merged into bluetooth-ne=
xt. I really dislike that behavior. It is always the easy way out instead o=
f trying to do the right thing.
>

See this page: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1065400

>>> I also wonder if there is a bit more general naming convention for the =
files. For example with a quick search I found references to BCM2045B2_002.=
002.011.0348.0349.hcd and similar. They indicate that the naming is not bas=
ed on the USB vendor and product ID.
>>
>> Some version numbering scheme is applied by Broadcom. However, at
>> least initially, I'd prefer using USB vid/pid in the .hcd filename. I
>> know that the .hcd file that I have works on our specific vid/pid of
>> BCM20702, but I have no idea whether it would work on other BCM20702
>> variants.
>
> I am worried to back us into a corner. Reuse of PIDs is plenty. Especiall=
y with the cheaper dongle manufactures.
>
>>> For example for the Intel ROM patching, we used internal versioning to =
pick the right file. That way we were able to run it for all of our devices=
. For the Broadcom devices, it might make sense to run the patchram routine=
 for all devices not just this one specific one.
>>
>> It would make sense, but I have no way of testing it. I only feel
>> comfortable introducing this to the single device that I've been able
>> to test with. It can later be extended to other BCM variants as people
>> test this.
>
> I have a bunch of Broadcom USB dongles around here. I might not get to it=
 this week, but worth while trying to see how this works out.
>
> At least the product string could be taken from the USB descriptors. Seem=
s that Broadcom devices are pretty good in that regard no matter what. So q=
uickly checking with mine, they give you BCM20702A0 and from the looks of i=
t, the firmware files are prefix with exactly that.

Yes, using the product string as the FW filename prefix sounds good.
But, we would need to hardcode the rest, which appears to be some kind
of version number.

>
>>>> Signed-off-by: Petri Gynther <pgynther@google.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 139 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> 1 file changed, 139 insertions(+)
>>>>
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index f338b0c..371d7e9 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
>>>> #define BTUSB_WRONG_SCO_MTU   0x40
>>>> #define BTUSB_ATH3012         0x80
>>>> #define BTUSB_INTEL           0x100
>>>> +#define BTUSB_BCM20702_PATCHRAM      0x200
>>>>
>>>> static const struct usb_device_id btusb_table[] =3D {
>>>>      /* Generic Bluetooth USB device */
>>>> @@ -103,6 +104,7 @@ static const struct usb_device_id btusb_table[] =
=3D {
>>>>      /* Broadcom BCM20702A0 */
>>>>      { USB_DEVICE(0x0489, 0xe042) },
>>>>      { USB_DEVICE(0x04ca, 0x2003) },
>>>> +     { USB_DEVICE(0x0a5c, 0x22be), .driver_info =3D BTUSB_BCM20702_PA=
TCHRAM },
>>>>      { USB_DEVICE(0x0b05, 0x17b5) },
>>>>      { USB_DEVICE(0x0b05, 0x17cb) },
>>>>      { USB_DEVICE(0x413c, 0x8197) },
>>>> @@ -1380,6 +1382,140 @@ exit_mfg_deactivate:
>>>>      return 0;
>>>> }
>>>>
>>>> +static int btusb_setup_bcm20702(struct hci_dev *hdev)
>>>> +{
>>>> +     struct btusb_data *data =3D hci_get_drvdata(hdev);
>>>> +     struct usb_device *udev =3D data->udev;
>>>> +     char fw_name[64];
>>>> +     const struct firmware *fw;
>>>> +     const u8 *fw_ptr;
>>>> +     size_t fw_size;
>>>> +     const struct hci_command_hdr *cmd;
>>>> +     const u8 *cmd_param;
>>>> +     u16 opcode;
>>>> +     struct sk_buff *skb;
>>>> +     struct hci_rp_read_local_version *ver;
>>>> +     long ret;
>>>> +
>>>> +     snprintf(fw_name, sizeof(fw_name), "brcm/bcm20702-%04x-%04x.hcd"=
,
>>>> +              le16_to_cpu(udev->descriptor.idVendor),
>>>> +              le16_to_cpu(udev->descriptor.idProduct));
>>>> +
>>>> +     ret =3D request_firmware(&fw, fw_name, &hdev->dev);
>>>> +     if (ret < 0) {
>>>> +             BT_INFO("%s: BCM20702: patch %s not found", hdev->name,
>>>> +                     fw_name);
>>>> +             ret =3D 0;
>>>> +             goto get_fw_ver;
>>>> +     }
>>>> +
>>>> +     /* Reset */
>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIM=
EOUT);
>>>> +     if (IS_ERR(skb)) {
>>>> +             ret =3D PTR_ERR(skb);
>>>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret)=
;
>>>> +             goto reset_fw;
>>>> +     }
>>>> +     kfree_skb(skb);
>>>> +
>>>> +     /* Read Local Version Info */
>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
>>>> +                          HCI_INIT_TIMEOUT);
>>>> +     if (IS_ERR(skb)) {
>>>> +             ret =3D PTR_ERR(skb);
>>>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>>>> +                     hdev->name, ret);
>>>> +             goto reset_fw;
>>>> +     }
>>>> +
>>>
>>> You need a length check here to ensure that resulting buffer is the cor=
rect length. Trusting the hardware is not a good idea. I have seen this go =
wrong in some cases.
>>
>> Will do. I'll send revised diff for this.
>>
>>>
>>>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>>>> +     BT_INFO("%s: BCM20702: patching hci_ver=3D%02x hci_rev=3D%04x lm=
p_ver=3D%02x "
>>>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->hci_=
rev,
>>>> +             ver->lmp_ver, ver->lmp_subver);
>>>> +     kfree_skb(skb);
>>>> +
>>>> +     /* Start Download */
>>>> +     skb =3D __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
>>>> +     if (IS_ERR(skb)) {
>>>> +             ret =3D PTR_ERR(skb);
>>>> +             BT_ERR("%s: BCM20702: Download Minidrv command failed (%=
ld)",
>>>> +                     hdev->name, ret);
>>>> +             goto reset_fw;
>>>> +     }
>>>> +     kfree_skb(skb);
>>>> +
>>>> +     /* 50 msec delay after Download Minidrv completes */
>>>> +     msleep(50);
>>>> +
>>>> +     fw_ptr =3D fw->data;
>>>> +     fw_size =3D fw->size;
>>>> +
>>>> +     while (fw_size >=3D sizeof(*cmd)) {
>>>> +             cmd =3D (struct hci_command_hdr *) fw_ptr;
>>>> +             fw_ptr +=3D sizeof(*cmd);
>>>> +             fw_size -=3D sizeof(*cmd);
>>>> +
>>>> +             if (fw_size < cmd->plen) {
>>>> +                     BT_ERR("%s: BCM20702: patch %s is corrupted",
>>>> +                             hdev->name, fw_name);
>>>> +                     ret =3D -EINVAL;
>>>> +                     goto reset_fw;
>>>> +             }
>>>> +
>>>> +             cmd_param =3D fw_ptr;
>>>> +             fw_ptr +=3D cmd->plen;
>>>> +             fw_size -=3D cmd->plen;
>>>> +
>>>> +             opcode =3D le16_to_cpu(cmd->opcode);
>>>> +
>>>> +             skb =3D __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_para=
m,
>>>> +                                  HCI_INIT_TIMEOUT);
>>>> +             if (IS_ERR(skb)) {
>>>> +                     ret =3D PTR_ERR(skb);
>>>> +                     BT_ERR("%s: BCM20702: patch command %04x failed =
(%ld)",
>>>> +                             hdev->name, opcode, ret);
>>>> +                     goto reset_fw;
>>>> +             }
>>>> +             kfree_skb(skb);
>>>> +     }
>>>> +
>>>> +     /* 250 msec delay after Launch Ram completes */
>>>> +     msleep(250);
>>>> +
>>>> +reset_fw:
>>>> +     /* Reset */
>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIM=
EOUT);
>>>> +     if (IS_ERR(skb)) {
>>>> +             ret =3D PTR_ERR(skb);
>>>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret)=
;
>>>> +             goto done;
>>>> +     }
>>>> +     kfree_skb(skb);
>>>> +
>>>> +get_fw_ver:
>>>> +     /* Read Local Version Info */
>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
>>>> +                          HCI_INIT_TIMEOUT);
>>>> +     if (IS_ERR(skb)) {
>>>> +             ret =3D PTR_ERR(skb);
>>>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>>>> +                     hdev->name, ret);
>>>> +             goto done;
>>>> +     }
>>>> +
>>>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>>>> +     BT_INFO("%s: BCM20702: firmware hci_ver=3D%02x hci_rev=3D%04x lm=
p_ver=3D%02x "
>>>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->hci_=
rev,
>>>> +             ver->lmp_ver, ver->lmp_subver);
>>>> +     kfree_skb(skb);
>>>
>>> Is this HCI_Reset and HCI_Read_Local_Version_Info really needed. The st=
andard init procedure will do exactly that anyway. I have no problem in hav=
ing this in here. I am just saying that it will be run anyway again after -=
>setup() completed.
>>>
>>> You can check for yourself when running btmon before plugging this devi=
ce or manually loading btusb.
>>
>> The reset is important because it activates the new firmware. And, I
>> do like seeing the local version info in kernel log because it makes
>> it clear what FW version was before and is after the upgrade.
>
> I get that. What I am saying is that after you go through ->setup() the k=
ernel will call these commands anyway.
>
> So what you are getting now is this:
>
>         setup()
>                 HCI_Reset
>                 HCI_Read_Local_Version_Info
>                 .. load HCD
>                 HCI_Reset
>                 HCI_Read_Local_Version_Info
>         init()
>                 HCI_Reset
>                 HCI_Read_Local_Features
>                 HCI_Read_Local_Version_Info
>                 HCI_Read_BD_Address
>
> The init is always executed right after the setup. Unload btusb, start bt=
mon and reload btusb. You will see.

I understand. I looked at the code in hci_dev_do_open() and
__hci_init(). I'm OK to remove the first HCI_Read_Local_Version_Info
before loading HCD. But, I'd like to keep the rest, so setup() becomes
reset + load HCD + reset + read local version info. I'd like to see in
kernel log what the FW version is after the HCD push.

>
>>>> +
>>>> +done:
>>>> +     if (fw)
>>>> +             release_firmware(fw);
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> static int btusb_probe(struct usb_interface *intf,
>>>>                              const struct usb_device_id *id)
>>>> {
>>>> @@ -1485,6 +1621,9 @@ static int btusb_probe(struct usb_interface *int=
f,
>>>>      if (id->driver_info & BTUSB_BCM92035)
>>>>              hdev->setup =3D btusb_setup_bcm92035;
>>>>
>>>> +     if (id->driver_info & BTUSB_BCM20702_PATCHRAM)
>>>> +             hdev->setup =3D btusb_setup_bcm20702;
>>>> +
>>>
>>> If we are somehow able to just do BTUSB_BROADCOM and always trigger the=
 patchram loading based on the hardware found that would be super great.
>>
>> It would be nice, but I don't have enough resources to test it. I'd
>> say let's start with this and extend from there.
>
> We can not easily go back and revert this change though. Can you include =
/sys/kernel/debug/usb/devices part for this device.

T:  Bus=3D05 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a5c ProdID=3D22be Rev=3D 1.12
S:  Manufacturer=3DBroadcom Corp
S:  Product=3DBCM20702A0
S:  SerialNumber=3D000000000000
C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driver=
=3D(none)


>
> Btw. we have seen devices that pretend to be Broadcom dongles or CSR dong=
les, but they are not. They also have a split personality where USB descrip=
tors say they are one thing and HCI_Read_Local_Version tells us they are an=
other. They are essentially cheap knockoffs from China.
>
> Regards
>
> Marcel
>
