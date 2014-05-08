Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C59542AE-0226-4553-90B6-6F0B239BCAE6@holtmann.org>
References: <20140507223541.387FE1005DE@puck.mtv.corp.google.com>
	<C59542AE-0226-4553-90B6-6F0B239BCAE6@holtmann.org>
Date: Thu, 8 May 2014 14:59:21 -0700
Message-ID: <CAGXr9JE_jwvwdHd_uaiZBn9VJt5MwZMjV_j14oR-jvG2q4a_gg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Broadcom patch RAM support
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 8, 2014 at 1:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Petri,
>
>> After hardware reset, some BCM Bluetooth adapters obtain their initial f=
irmware
>> from OTPROM chip. Once this initial firmware is running, the firmware ca=
n be
>> further upgraded over HCI interface with .hcd files provided by Broadcom=
. This
>> is also known as "patch RAM" support. This change implements that.
>>
>> If the .hcd file is not found in /lib/firmware, BCM Bluetooth adapter co=
ntinues
>> to operate with the initial firmware. Sample kernel log:
>>  hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/BCM20702A0-0a5c-22be.hcd de=
v=3D...
>>  Bluetooth: hci0: BCM: patch brcm/BCM20702A0-0a5c-22be.hcd not found
>>  Bluetooth: hci0: BCM: firmware hci_ver=3D06 hci_rev=3D1000 lmp_ver=3D06=
 lmp_subver=3D220e
>>
>> If the .hcd file is found, btusb driver pushes it to the BCM Bluetooth a=
dapter and
>> it starts using the new firmware. Sample kernel log:
>>  hotplug: sys=3Dfirmware act=3Dadd fw=3Dbrcm/BCM20702A0-0a5c-22be.hcd de=
v=3D...
>>  Bluetooth: hci0: BCM: patching hci_ver=3D06 hci_rev=3D1000 lmp_ver=3D06=
 lmp_subver=3D220e
>>  Bluetooth: hci0: BCM: firmware hci_ver=3D06 hci_rev=3D1389 lmp_ver=3D06=
 lmp_subver=3D220e
>>
>> Above, we can see that hci_rev goes from 1000 to 1389 as a result of the=
 upgrade.
>>
>> Signed-off-by: Petri Gynther <pgynther@google.com>
>> ---
>> drivers/bluetooth/btusb.c | 158 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>> 1 file changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index f338b0c..1b3e514 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -49,6 +49,7 @@ static struct usb_driver btusb_driver;
>> #define BTUSB_WRONG_SCO_MTU   0x40
>> #define BTUSB_ATH3012         0x80
>> #define BTUSB_INTEL           0x100
>> +#define BTUSB_BCM_PATCHRAM   0x200
>>
>> static const struct usb_device_id btusb_table[] =3D {
>>       /* Generic Bluetooth USB device */
>> @@ -111,7 +112,8 @@ static const struct usb_device_id btusb_table[] =3D =
{
>>       { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
>>
>>       /* Broadcom devices with vendor specific id */
>> -     { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
>> +     { USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
>> +       .driver_info =3D BTUSB_BCM_PATCHRAM },
>>
>>       /* Belkin F8065bf - Broadcom based */
>>       { USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
>> @@ -1380,6 +1382,157 @@ exit_mfg_deactivate:
>>       return 0;
>> }
>>
>> +static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
>> +{
>> +     struct btusb_data *data =3D hci_get_drvdata(hdev);
>> +     struct usb_device *udev =3D data->udev;
>> +     char fw_name[64];
>> +     const struct firmware *fw;
>> +     const u8 *fw_ptr;
>> +     size_t fw_size;
>> +     const struct hci_command_hdr *cmd;
>> +     const u8 *cmd_param;
>> +     u16 opcode;
>> +     struct sk_buff *skb;
>> +     struct hci_rp_read_local_version *ver;
>> +     long ret;
>> +
>> +     snprintf(fw_name, sizeof(fw_name), "brcm/%s-%04x-%04x.hcd",
>> +              udev->product ? udev->product : "BCM",
>> +              le16_to_cpu(udev->descriptor.idVendor),
>> +              le16_to_cpu(udev->descriptor.idProduct));
>> +
>> +     ret =3D request_firmware(&fw, fw_name, &hdev->dev);
>> +     if (ret < 0) {
>> +             BT_INFO("%s: BCM: patch %s not found", hdev->name,
>> +                     fw_name);
>> +             ret =3D 0;
>> +             goto get_fw_ver;
>> +     }
>
> why are we doing this? Is there a point in reading the HCI version when w=
e do not find the firmware? Can we not just exit here. The local version wi=
ll be read from init anyway and is available via HCI and also hciconfig and=
 even debugfs. I see no point in wasting time in reading something twice if=
 we do not have the firmware file.

Leftover code from my internal testing. Changed to "return 0;"

>
>> +
>> +     /* Reset */
>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEO=
UT);
>> +     if (IS_ERR(skb)) {
>> +             ret =3D PTR_ERR(skb);
>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
>> +             goto reset_fw;
>
> This one I also not get. If the HCI_Reset fails, what makes you think a s=
econd one will succeed. In this case I would just return with an error.
>

Changed to "goto done;" where firmware is released + "return ret;"

>> +     }
>> +     kfree_skb(skb);
>> +
>> +     /* Read Local Version Info */
>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
>> +                          HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             ret =3D PTR_ERR(skb);
>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>> +                     hdev->name, ret);
>> +             goto reset_fw;
>
> Same here. If it fails, we have problems. Just return an error.
>

Changed to "goto done;"

>> +     }
>> +
>> +     if (skb->len !=3D sizeof(*ver)) {
>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatc=
h",
>> +                     hdev->name);
>> +             kfree_skb(skb);
>> +             ret =3D -EIO;
>> +             goto reset_fw;
>
> I would also do the same here. Since I do not see how any chip could reco=
ver with a HCI_Reset if this happens.
>

Changed to "goto done;"

>> +     }
>> +
>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>> +     BT_INFO("%s: BCM: patching hci_ver=3D%02x hci_rev=3D%04x lmp_ver=
=3D%02x "
>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->hci_re=
v,
>> +             ver->lmp_ver, ver->lmp_subver);
>> +     kfree_skb(skb);
>> +
>> +     /* Start Download */
>> +     skb =3D __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             ret =3D PTR_ERR(skb);
>> +             BT_ERR("%s: BCM: Download Minidrv command failed (%ld)",
>> +                     hdev->name, ret);
>> +             goto reset_fw;
>> +     }
>> +     kfree_skb(skb);
>> +
>> +     /* 50 msec delay after Download Minidrv completes */
>> +     msleep(50);
>> +
>> +     fw_ptr =3D fw->data;
>> +     fw_size =3D fw->size;
>> +
>> +     while (fw_size >=3D sizeof(*cmd)) {
>> +             cmd =3D (struct hci_command_hdr *) fw_ptr;
>> +             fw_ptr +=3D sizeof(*cmd);
>> +             fw_size -=3D sizeof(*cmd);
>> +
>> +             if (fw_size < cmd->plen) {
>> +                     BT_ERR("%s: BCM: patch %s is corrupted",
>> +                             hdev->name, fw_name);
>> +                     ret =3D -EINVAL;
>> +                     goto reset_fw;
>> +             }
>> +
>> +             cmd_param =3D fw_ptr;
>> +             fw_ptr +=3D cmd->plen;
>> +             fw_size -=3D cmd->plen;
>> +
>> +             opcode =3D le16_to_cpu(cmd->opcode);
>> +
>> +             skb =3D __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
>> +                                  HCI_INIT_TIMEOUT);
>> +             if (IS_ERR(skb)) {
>> +                     ret =3D PTR_ERR(skb);
>> +                     BT_ERR("%s: BCM: patch command %04x failed (%ld)",
>> +                             hdev->name, opcode, ret);
>> +                     goto reset_fw;
>> +             }
>> +             kfree_skb(skb);
>> +     }
>> +
>> +     /* 250 msec delay after Launch Ram completes */
>> +     msleep(250);
>> +
>> +reset_fw:
>
> I would free the firmware data right here. Then you do not have to worry =
about it anymore.
>

I'm handling firmware release in one place at "done:"

>> +     /* Reset */
>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEO=
UT);
>> +     if (IS_ERR(skb)) {
>> +             ret =3D PTR_ERR(skb);
>> +             BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
>> +             goto done;
>
> If you free the firmware data above, then this can just become a return r=
et.
>

Changed to "goto done;"

>> +     }
>> +     kfree_skb(skb);
>> +
>> +get_fw_ver:
>> +     /* Read Local Version Info */
>> +     skb =3D __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
>> +                          HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             ret =3D PTR_ERR(skb);
>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
>> +                     hdev->name, ret);
>> +             goto done;
>
> Same here. Just return.
>

Changed to "goto done;"

>> +     }
>> +
>> +     if (skb->len !=3D sizeof(*ver)) {
>> +             BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatc=
h",
>> +                     hdev->name);
>> +             kfree_skb(skb);
>> +             ret =3D -EIO;
>> +             goto done;
>
> And here as well.
>

Changed to "goto done;"

>> +     }
>> +
>> +     ver =3D (struct hci_rp_read_local_version *) skb->data;
>> +     BT_INFO("%s: BCM: firmware hci_ver=3D%02x hci_rev=3D%04x lmp_ver=
=3D%02x "
>> +             "lmp_subver=3D%04x", hdev->name, ver->hci_ver, ver->hci_re=
v,
>> +             ver->lmp_ver, ver->lmp_subver);
>> +     kfree_skb(skb);
>> +
>> +done:
>> +     if (fw)

Removed "if (fw)" from here, since we come to "done:" always with firmware.

>> +             release_firmware(fw);
>> +
>> +     return ret;
>> +}
>> +
>> static int btusb_probe(struct usb_interface *intf,
>>                               const struct usb_device_id *id)
>> {
>> @@ -1485,6 +1638,9 @@ static int btusb_probe(struct usb_interface *intf,
>>       if (id->driver_info & BTUSB_BCM92035)
>>               hdev->setup =3D btusb_setup_bcm92035;
>>
>> +     if (id->driver_info & BTUSB_BCM_PATCHRAM)
>> +             hdev->setup =3D btusb_setup_bcm_patchram;
>> +
>>       if (id->driver_info & BTUSB_INTEL) {
>>               usb_enable_autosuspend(data->udev);
>>               hdev->setup =3D btusb_setup_intel;
>
> The changes are all cosmetic, but I prefer to have them done before apply=
ing the patch. I need to also test run this by myself and see what impact t=
his has on all the devices we do not have firmware for.
>

Yes, please test with a few BCM adapters and let me know if you see any iss=
ues.

> Regards
>
> Marcel
>
