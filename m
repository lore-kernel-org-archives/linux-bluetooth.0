Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B152A8D4-5FE0-4DA4-AB9F-FFE5B295155E@holtmann.org>
References: <20140409010501.4B23E100A34@puck.mtv.corp.google.com>
	<7DA0218C-A05A-4E9C-9042-AA7E6F933302@holtmann.org>
	<CAGXr9JF-SxutMuhkrqKhC7xEg7-9pPaW26MmbXxg2df0-DFxzQ@mail.gmail.com>
	<C41A1B83-9150-4090-A182-0245F8CD715F@holtmann.org>
	<CAGXr9JFqfvD+dD4ciidzpODuUQ2erg-L3RA=jEc_RDrjSPaa=Q@mail.gmail.com>
	<9C3840B5-AE5F-4338-A863-5545065575C6@holtmann.org>
	<CAGXr9JGVU4i69ie=f1YU7w=RvVo-m02W7YM3zrnEv9fSLK32rQ@mail.gmail.com>
	<B152A8D4-5FE0-4DA4-AB9F-FFE5B295155E@holtmann.org>
Date: Wed, 7 May 2014 15:28:27 -0700
Message-ID: <CAGXr9JEg_Cczj9g9=0PEhO50JvomEiP=Rm2WhutShL4Tx9rt7Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add BCM20702 firmware upgrade support
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, May 5, 2014 at 11:01 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Petri,
>
>>>>>>>> After hardware reset, BCM20702 obtains its initial firmware from a=
 PROM chip.
>>>>>>>> Once this initial firmware is running, the firmware can be further=
 upgraded
>>>>>>>> over HCI interface with .hcd files provided by Broadcom. This is a=
lso known
>>>>>>>> as "patch RAM" support. This change implements that.
>>>>>>>>
>>>>>>>> If the .hcd file is not found in /lib/firmware, BCM20702 continues=
 to operate
>>>>>>>> with the initial firmware. Sample kernel log:
>>>>>>>> hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/bcm20702-0a5c-22be.hcd=
 dev=3D...
>>>>>>>> Bluetooth: hci0: BCM20702: patch brcm/bcm20702-0a5c-22be.hcd not f=
ound
>>>>>>>> Bluetooth: hci0: BCM20702: firmware hci_ver=3D06 hci_rev=3D1000 lm=
p_ver=3D06 lmp_subver=3D220e
>>>>>>>>
>>>>>>>> If the .hcd file is found, btusb driver pushes it to BCM20702, and=
 BCM20702
>>>>>>>> starts using the new firmware. Sample kernel log:
>>>>>>>> hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/bcm20702-0a5c-22be.hcd=
 dev=3D...
>>>>>>>> Bluetooth: hci0: BCM20702: patching hci_ver=3D06 hci_rev=3D1000 lm=
p_ver=3D06 lmp_subver=3D220e
>>>>>>>> Bluetooth: hci0: BCM20702: firmware hci_ver=3D06 hci_rev=3D1389 lm=
p_ver=3D06 lmp_subver=3D220e
>>>>>>>>
>>>>>>>> Above, we can see that hci_rev goes from 1000 to 1389 as a result =
of the upgrade.
>>>>>>>
>>>>>>> this is a nice feature to have. Where are these hcd files are comin=
g from. Are they available somewhere or do we have them available in linux-=
firmware.git tree.
>>>>>>
>>>>>> In our case, we get these files directly from the vendor. I haven't
>>>>>> seen these in linux-firmware.git tree. Some searching reveals that
>>>>>> Windows drivers contain either .hex or .hcd files, and there appears
>>>>>> to be a tool hex2hcd to convert to .hcd. See page
>>>>>> http://swiesmann.de/?p=3D30.
>>>>>
>>>>> what is the firmware name that the files from the vendor have. My pro=
blem with introducing a VID+PID based naming is that it might causes proble=
ms when the VID+PID is re-used for a different SKU or revision of the same =
board and we should have picked the firmware based on the board version.
>>>>
>>>> The firmware files seem to have a naming pattern
>>>> BCM20702A0_aaa.bbb.ccc.dddd.eeee. I don't know where
>>>> aaa.bbb.ccc.dddd.eeee are derived from. Some version number, I guess.
>>>
>>> I am trying to figure out what they mean. Any chance you can ask your v=
endor for help.
>>>
>>
>> I've looked a bit more into this. It turns out that there are cases
>> where BCM A0 chip might actually use BCM A1 firmware file. So, I don't
>> think we can reliably use the product string (e.g. BCM20702A0) as a
>> prefix.
>>
>> So, any problem going with VID-PID approach here? That is easy for the
>> user, as they can figure out the VID-PID pair with lsusb, and then
>> place properly named file to /lib/firmware/brcm/
>>
>> And, if the firmware file is missing, no problem. The device will
>> operate with the default firmware from OTPROM.
>
> in theory this all will apply to more than just the USB versions of the B=
roadcom chips, but that is what we might need to focus on first here. For t=
he UART versions it can be easily done within hciattach.
>
> So the first thing I would like to change is that we use USB_VENDOR_AND_I=
NTERFACE_INFO() to identify the Broadcom device. That way the usb_device_id=
 table gets smaller and we ensure that this works on every single one of th=
e devices even if there is no firmware file present. The more expose this g=
ets the better.
>
> T:  Bus=3D05 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12   =
MxCh=3D 0
> D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0a5c ProdID=3D22be Rev=3D 1.12
> S:  Manufacturer=3DBroadcom Corp
> S:  Product=3DBCM20702A0
> S:  SerialNumber=3D000000000000
>
> Almost all newer Broadcom device identify themselves as vendor class, but=
 then keep the subclass and protocol fields matching up with the H:2 specif=
ication. So lets focus on adding support to this entry:
>
>         /* Broadcom devices with vendor specific id */
>         { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
>
> And then we use brcm/{product}-%04x-%04x.hcd as your firmware filename. S=
o getting the {product} string is something we should work out. Do you happ=
en to know if we can issue a Broadcom vendor command to get the product ide=
ntifier. We could use the UBS product string and just turn it into lower ca=
se. The appended a0 or b0 or whatever does not matter. However being able t=
o just get the bcm20702 from the the device would be helpful.
>
> As I side note here, we could check the serial number being zero or the d=
efault address being present to set an internal flag to tell the Bluetooth =
core that this device needs an address programmed before being fully operat=
ional. However that is a separate patch. Just a hint here.
>

New patch coming soon. I ended up using udev->product to obtain the
iProduct string "BCM20702A0". Kernel doesn't have strlwr(), so I left
it as-is uppercase. If you strongly prefer lowercase, we can add code
to do so.

-- Petri

>>>>> And the HEX vs HCD is most likely the same as Intel=E2=80=99s seq vs =
bseq. Just one is a text file and the other a binary version of the same da=
ta. In all cases these are HCI commands anyway.
>>>>>
>>>>>> Interestingly, now that I look at that page more closely, Ubuntu 12.=
04
>>>>>> LTS with kernel 3.8 supports this already? Has Ubuntu made a patch
>>>>>> that bluetooth-next doesn't have?
>>>>>
>>>>> That is Ubuntu for you. They just push patches into their kernel and =
never give them back to upstream or make sure they get merged into bluetoot=
h-next. I really dislike that behavior. It is always the easy way out inste=
ad of trying to do the right thing.
>>>>>
>>>>
>>>> See this page: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/10=
65400
>>>
>>> It is a stupid userspace version that is racy as hell. Even the bug men=
tions that it should be done in the kernel. And I am pretty sure that was m=
y initial comment as well. Just posting the userspace patch for reference.
>>>
>>>>>>> I also wonder if there is a bit more general naming convention for =
the files. For example with a quick search I found references to BCM2045B2_=
002.002.011.0348.0349.hcd and similar. They indicate that the naming is not=
 based on the USB vendor and product ID.
>>>>>>
>>>>>> Some version numbering scheme is applied by Broadcom. However, at
>>>>>> least initially, I'd prefer using USB vid/pid in the .hcd filename. =
I
>>>>>> know that the .hcd file that I have works on our specific vid/pid of
>>>>>> BCM20702, but I have no idea whether it would work on other BCM20702
>>>>>> variants.
>>>>>
>>>>> I am worried to back us into a corner. Reuse of PIDs is plenty. Espec=
ially with the cheaper dongle manufactures.
>>>>>
>>>>>>> For example for the Intel ROM patching, we used internal versioning=
 to pick the right file. That way we were able to run it for all of our dev=
ices. For the Broadcom devices, it might make sense to run the patchram rou=
tine for all devices not just this one specific one.
>>>>>>
>>>>>> It would make sense, but I have no way of testing it. I only feel
>>>>>> comfortable introducing this to the single device that I've been abl=
e
>>>>>> to test with. It can later be extended to other BCM variants as peop=
le
>>>>>> test this.
>>>>>
>>>>> I have a bunch of Broadcom USB dongles around here. I might not get t=
o it this week, but worth while trying to see how this works out.
>>>>>
>>>>> At least the product string could be taken from the USB descriptors. =
Seems that Broadcom devices are pretty good in that regard no matter what. =
So quickly checking with mine, they give you BCM20702A0 and from the looks =
of it, the firmware files are prefix with exactly that.
>>>>
>>>> Yes, using the product string as the FW filename prefix sounds good.
>>>> But, we would need to hardcode the rest, which appears to be some kind
>>>> of version number.
>>>
>>> With the Intel firmware loading we fall back to a generic file in case =
the proper ROM patch file is not found. Maybe we should do something simila=
r here as well. The more we can follow standard Broadcom procedure for thes=
e patch files, the better of course. It makes it a lot easier for any new d=
evices.
>>>
>>
>> We don't need a fallback as the FW file is optional. The device
>> operates fine with OTPROM FW.
>
> So there are no generic variables or configuration that should be set. If=
 not, then this fine, we don=E2=80=99t need a fallback.
>
>>>>>>>> Signed-off-by: Petri Gynther <pgynther@google.com>
>>>>>>>> ---
>>>>>>>> drivers/bluetooth/btusb.c | 139 ++++++++++++++++++++++++++++++++++=
++++++++++++
>>>>>>>> 1 file changed, 139 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>>>>>> index f338b0c..371d7e9 100644
>>>>>>>> --- a/drivers/bluetooth/btusb.c
>>>>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>>>>> @@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
>>>>>>>> #define BTUSB_WRONG_SCO_MTU   0x40
>>>>>>>> #define BTUSB_ATH3012         0x80
>>>>>>>> #define BTUSB_INTEL           0x100
>>>>>>>> +#define BTUSB_BCM20702_PATCHRAM      0x200
>>>>>>>>
>>>>>>>> static const struct usb_device_id btusb_table[] =3D {
>>>>>>>>    /* Generic Bluetooth USB device */
>>>>>>>> @@ -103,6 +104,7 @@ static const struct usb_device_id btusb_table[=
] =3D {
>>>>>>>>    /* Broadcom BCM20702A0 */
>>>>>>>>    { USB_DEVICE(0x0489, 0xe042) },
>>>>>>>>    { USB_DEVICE(0x04ca, 0x2003) },
>>>>>>>> +     { USB_DEVICE(0x0a5c, 0x22be), .driver_info =3D BTUSB_BCM2070=
2_PATCHRAM },
>>>>>>>>    { USB_DEVICE(0x0b05, 0x17b5) },
>>>>>>>>    { USB_DEVICE(0x0b05, 0x17cb) },
>>>>>>>>    { USB_DEVICE(0x413c, 0x8197) },
>>>>>>>> @@ -1380,6 +1382,140 @@ exit_mfg_deactivate:
>>>>>>>>    return 0;
>>>>>>>> }
>>>>>>>>
>>>>>>>> +static int btusb_setup_bcm20702(struct hci_dev *hdev)
>>>>>>>> +{
>>>>>>>> +     struct btusb_data *data =3D hci_get_drvdata(hdev);
>>>>>>>> +     struct usb_device *udev =3D data->udev;
>>>>>>>> +     char fw_name[64];
>>>>>>>> +     const struct firmware *fw;
>>>>>>>> +     const u8 *fw_ptr;
>>>>>>>> +     size_t fw_size;
>>>>>>>> +     const struct hci_command_hdr *cmd;
>>>>>>>> +     const u8 *cmd_param;
>>>>>>>> +     u16 opcode;
>>>>>>>> +     struct sk_buff *skb;
>>>>>>>> +     struct hci_rp_read_local_version *ver;
>>>>>>>> +     long ret;
>>>>>>>> +
>>>>>>>> +     snprintf(fw_name, sizeof(fw_name), "brcm/bcm20702-%04x-%04x.=
hcd",
>>>>>>>> +              le16_to_cpu(udev->descriptor.idVendor),
>>>>>>>> +              le16_to_cpu(udev->descriptor.idProduct));
>>>>>>>> +
>>>>>>>> +     ret =3D request_firmware(&fw, fw_name, &hdev->dev);
>>>>>>>> +     if (ret < 0) {
>>>>>>>> +             BT_INFO("%s: BCM20702: patch %s not found", hdev->na=
me,
>>>>>>>> +                     fw_name);
>>>>>>>> +             ret =3D 0;
>>>>>>>> +             goto get_fw_ver;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /* Reset */
>>>>>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT=
_TIMEOUT);
>>>>>>>> +     if (IS_ERR(skb)) {
>>>>>>>> +             ret =3D PTR_ERR(skb);
>>>>>>>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, =
ret);
>>>>>>>> +             goto reset_fw;
>>>>>>>> +     }
>>>>>>>> +     kfree_skb(skb);
>>>>>>>> +
>>>>>>>> +     /* Read Local Version Info */
>>>>>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, N=
ULL,
>>>>>>>> +                          HCI_INIT_TIMEOUT);
>>>>>>>> +     if (IS_ERR(skb)) {
>>>>>>>> +             ret =3D PTR_ERR(skb);
>>>>>>>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>>>>>>>> +                     hdev->name, ret);
>>>>>>>> +             goto reset_fw;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>
>>>>>>> You need a length check here to ensure that resulting buffer is the=
 correct length. Trusting the hardware is not a good idea. I have seen this=
 go wrong in some cases.
>>>>>>
>>>>>> Will do. I'll send revised diff for this.
>>>>>>
>>>>>>>
>>>>>>>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>>>>>>>> +     BT_INFO("%s: BCM20702: patching hci_ver=3D%02x hci_rev=3D%04=
x lmp_ver=3D%02x "
>>>>>>>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->=
hci_rev,
>>>>>>>> +             ver->lmp_ver, ver->lmp_subver);
>>>>>>>> +     kfree_skb(skb);
>>>>>>>> +
>>>>>>>> +     /* Start Download */
>>>>>>>> +     skb =3D __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEO=
UT);
>>>>>>>> +     if (IS_ERR(skb)) {
>>>>>>>> +             ret =3D PTR_ERR(skb);
>>>>>>>> +             BT_ERR("%s: BCM20702: Download Minidrv command faile=
d (%ld)",
>>>>>>>> +                     hdev->name, ret);
>>>>>>>> +             goto reset_fw;
>>>>>>>> +     }
>>>>>>>> +     kfree_skb(skb);
>>>>>>>> +
>>>>>>>> +     /* 50 msec delay after Download Minidrv completes */
>>>>>>>> +     msleep(50);
>>>>>>>> +
>>>>>>>> +     fw_ptr =3D fw->data;
>>>>>>>> +     fw_size =3D fw->size;
>>>>>>>> +
>>>>>>>> +     while (fw_size >=3D sizeof(*cmd)) {
>>>>>>>> +             cmd =3D (struct hci_command_hdr *) fw_ptr;
>>>>>>>> +             fw_ptr +=3D sizeof(*cmd);
>>>>>>>> +             fw_size -=3D sizeof(*cmd);
>>>>>>>> +
>>>>>>>> +             if (fw_size < cmd->plen) {
>>>>>>>> +                     BT_ERR("%s: BCM20702: patch %s is corrupted"=
,
>>>>>>>> +                             hdev->name, fw_name);
>>>>>>>> +                     ret =3D -EINVAL;
>>>>>>>> +                     goto reset_fw;
>>>>>>>> +             }
>>>>>>>> +
>>>>>>>> +             cmd_param =3D fw_ptr;
>>>>>>>> +             fw_ptr +=3D cmd->plen;
>>>>>>>> +             fw_size -=3D cmd->plen;
>>>>>>>> +
>>>>>>>> +             opcode =3D le16_to_cpu(cmd->opcode);
>>>>>>>> +
>>>>>>>> +             skb =3D __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_=
param,
>>>>>>>> +                                  HCI_INIT_TIMEOUT);
>>>>>>>> +             if (IS_ERR(skb)) {
>>>>>>>> +                     ret =3D PTR_ERR(skb);
>>>>>>>> +                     BT_ERR("%s: BCM20702: patch command %04x fai=
led (%ld)",
>>>>>>>> +                             hdev->name, opcode, ret);
>>>>>>>> +                     goto reset_fw;
>>>>>>>> +             }
>>>>>>>> +             kfree_skb(skb);
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     /* 250 msec delay after Launch Ram completes */
>>>>>>>> +     msleep(250);
>>>>>>>> +
>>>>>>>> +reset_fw:
>>>>>>>> +     /* Reset */
>>>>>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT=
_TIMEOUT);
>>>>>>>> +     if (IS_ERR(skb)) {
>>>>>>>> +             ret =3D PTR_ERR(skb);
>>>>>>>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, =
ret);
>>>>>>>> +             goto done;
>>>>>>>> +     }
>>>>>>>> +     kfree_skb(skb);
>>>>>>>> +
>>>>>>>> +get_fw_ver:
>>>>>>>> +     /* Read Local Version Info */
>>>>>>>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, N=
ULL,
>>>>>>>> +                          HCI_INIT_TIMEOUT);
>>>>>>>> +     if (IS_ERR(skb)) {
>>>>>>>> +             ret =3D PTR_ERR(skb);
>>>>>>>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>>>>>>>> +                     hdev->name, ret);
>>>>>>>> +             goto done;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>>>>>>>> +     BT_INFO("%s: BCM20702: firmware hci_ver=3D%02x hci_rev=3D%04=
x lmp_ver=3D%02x "
>>>>>>>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->=
hci_rev,
>>>>>>>> +             ver->lmp_ver, ver->lmp_subver);
>>>>>>>> +     kfree_skb(skb);
>>>>>>>
>>>>>>> Is this HCI_Reset and HCI_Read_Local_Version_Info really needed. Th=
e standard init procedure will do exactly that anyway. I have no problem in=
 having this in here. I am just saying that it will be run anyway again aft=
er ->setup() completed.
>>>>>>>
>>>>>>> You can check for yourself when running btmon before plugging this =
device or manually loading btusb.
>>>>>>
>>>>>> The reset is important because it activates the new firmware. And, I
>>>>>> do like seeing the local version info in kernel log because it makes
>>>>>> it clear what FW version was before and is after the upgrade.
>>>>>
>>>>> I get that. What I am saying is that after you go through ->setup() t=
he kernel will call these commands anyway.
>>>>>
>>>>> So what you are getting now is this:
>>>>>
>>>>>       setup()
>>>>>               HCI_Reset
>>>>>               HCI_Read_Local_Version_Info
>>>>>               .. load HCD
>>>>>               HCI_Reset
>>>>>               HCI_Read_Local_Version_Info
>>>>>       init()
>>>>>               HCI_Reset
>>>>>               HCI_Read_Local_Features
>>>>>               HCI_Read_Local_Version_Info
>>>>>               HCI_Read_BD_Address
>>>>>
>>>>> The init is always executed right after the setup. Unload btusb, star=
t btmon and reload btusb. You will see.
>>>>
>>>> I understand. I looked at the code in hci_dev_do_open() and
>>>> __hci_init(). I'm OK to remove the first HCI_Read_Local_Version_Info
>>>> before loading HCD. But, I'd like to keep the rest, so setup() becomes
>>>> reset + load HCD + reset + read local version info. I'd like to see in
>>>> kernel log what the FW version is after the HCD push.
>>>
>>> We can keep it as well. I do not care much either way since ->setup() i=
s only run once. I was more curious if there is some specific reason for it=
.
>>>
>>
>> OK.
>>
>>>>>>>> +
>>>>>>>> +done:
>>>>>>>> +     if (fw)
>>>>>>>> +             release_firmware(fw);
>>>>>>>> +
>>>>>>>> +     return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> static int btusb_probe(struct usb_interface *intf,
>>>>>>>>                            const struct usb_device_id *id)
>>>>>>>> {
>>>>>>>> @@ -1485,6 +1621,9 @@ static int btusb_probe(struct usb_interface =
*intf,
>>>>>>>>    if (id->driver_info & BTUSB_BCM92035)
>>>>>>>>            hdev->setup =3D btusb_setup_bcm92035;
>>>>>>>>
>>>>>>>> +     if (id->driver_info & BTUSB_BCM20702_PATCHRAM)
>>>>>>>> +             hdev->setup =3D btusb_setup_bcm20702;
>>>>>>>> +
>>>>>>>
>>>>>>> If we are somehow able to just do BTUSB_BROADCOM and always trigger=
 the patchram loading based on the hardware found that would be super great=
.
>>>>>>
>>>>>> It would be nice, but I don't have enough resources to test it. I'd
>>>>>> say let's start with this and extend from there.
>>>>>
>>>>> We can not easily go back and revert this change though. Can you incl=
ude /sys/kernel/debug/usb/devices part for this device.
>>>>
>>>> T:  Bus=3D05 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12=
   MxCh=3D 0
>>>> D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
 1
>>>> P:  Vendor=3D0a5c ProdID=3D22be Rev=3D 1.12
>>>> S:  Manufacturer=3DBroadcom Corp
>>>> S:  Product=3DBCM20702A0
>>>> S:  SerialNumber=3D000000000000
>>>
>>> Did you block out the serial number on purpose? Normally that is your B=
D_ADDR. Or do you happen to have a different kind of module and the firmwar=
e loading will actually set the address. If so, then careful that the firmw=
are not program the same BD_ADDR for all devices.
>>>
>>
>> No, I didn't block the serial number. The device truly has
>> SerialNumber=3D0. Also, by default, it uses BD_ADDR =3D 00:20:70:02:A0:0=
0.
>> The BD_ADDR needs to be reprogrammed at every boot (or at hot plug).
>
> After you changed the BD_ADDR, I was wondering if you manually re-read th=
e USB string descriptor for the serial number that it now returns the actua=
l address. Linux caches the descriptors, so it will most likely keep tellin=
g you it is 0. Might have to write a tiny libusb program to verify this.
>
> Regards
>
> Marcel
>
