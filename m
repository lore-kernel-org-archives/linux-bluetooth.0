Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add support for QCA ROME chipset family
Date: Fri, 30 Jan 2015 06:18:17 +0000
Message-ID: <D2D16CA3-0F16-45C8-B647-8B66AC9D1319@qca.qualcomm.com>
References: <27c299b26b2c489aa7d8ad1114a10a2e@nalasexr02e.na.qualcomm.com>
 <D064A6CA-D4B6-4FA2-BC81-0BC6A8C5CDAC@holtmann.org>
 <15E046BB-8877-40F7-8AE4-C5F3676BECAF@qca.qualcomm.com>
 <42F36B40-A440-4590-82A5-2E5CACBABB85@holtmann.org>
In-Reply-To: <42F36B40-A440-4590-82A5-2E5CACBABB85@holtmann.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Jan 29, 2015, at 9:03 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Ben,
>=20
>>>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>>>> e.g. QCA61x4 or QCA6574.
>>>>=20
>>>> New chipset have similar firmware downloading sequences to previous
>>>> chipset from Atheros, however, it doesn't support vid/pid switching
>>>> after downloading the patch so that firmware needs to be handled by
>>>> btusb module directly.
>>>=20
>>> please always include the content from /sys/kernel/debug/usb/devices fo=
r your devices. I want to have them recorded in the commit messages.
>>>=20
>>> With that in mind it might be actually beneficial to add first one modu=
le and then extend it to the second one. That would keep in clean in the hi=
story.
>>=20
>> Sure, I=92ll do that
>>=20
>>>=20
>>>> ROME chipset can be differentiated from previous version by reading
>>>> ROM version.
>>>>=20
>>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 266 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> 1 file changed, 266 insertions(+)
>>>>=20
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
>>>> #define BTUSB_SWAVE  0x1000
>>>> #define BTUSB_INTEL_NEW  0x2000
>>>> #define BTUSB_AMP 0x4000
>>>> +#define BTUSB_QCA_ROME  0x8000
>>>>=20
>>>> static const struct usb_device_id btusb_table[] =3D {
>>>> /* Generic Bluetooth USB device */
>>>> @@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[=
] =3D {
>>>> { USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },
>>>> { USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },
>>>>=20
>>>> + /* QCA ROME chipset */
>>>> + { USB_DEVICE(0x0cf3, 0xe300), .driver_info =3D BTUSB_QCA_ROME},
>>>> +
>>>> /* Broadcom BCM2035 */
>>>> { USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
>>>> { USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },
>>>> @@ -2585,6 +2589,249 @@ static int btusb_set_bdaddr_ath3012(struct hci=
_dev *hdev,
>>>> return 0;
>>>> }
>>>>=20
>>>> +#define QCA_DFU_PACKET_LEN
>>>> 4096
>>>> +
>>>> +#define QCA_GET_TARGET_VERSION
>>>> 0x09
>>>> +#define QCA_CHECK_STATUS  0x05
>>>> +#define QCA_DFU_DOWNLOAD  0x01
>>>> +
>>>> +#define QCA_PATCH_UPDATE  0xA0
>>>> +#define QCA_SYSCFG_UPDATE
>>>> 0x60
>>>> +#define QCA_PATCH_SYSCFG_UPDATE
>>>> (QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)
>>>> +#define QCA_DFU_TIMEOUT  3000
>>>> +
>>>> +struct qca_version {
>>>> + u32
>>>> rom_version;
>>>> + u32
>>>> patch_version;
>>>> + u32
>>>> ram_version;
>>>> + u32
>>>> ref_clock;
>>>> + u8
>>>> reserved[4];
>>>=20
>>> Use __le32 or __be32.
>>>=20
>>>> +} __packed;
>>>> +
>>>> +struct qca_rampatch_version {
>>>> + u16
>>>> rom_version;
>>>> + u16
>>>> patch_version;
>>>=20
>>> Same here. Proper endian.
>>>=20
>>>> +} __packed;
>>>> +
>>>> +struct qca_device_info {
>>>> + u32
>>>> rom_version;
>>>> + u8
>>>> rampatch_hdr;  /* length of header in rampatch */
>>>> + u8
>>>> nvm_hdr; /* length of header in NVM */
>>>> + u8
>>>> ver_offset;  /* offset of version structure in rampatch */
>>>=20
>>> And here as well. Use the right endian aware type.
>>>=20
>>>> +};
>>>> +
>>>> +static const struct qca_device_info qca_devices_table[] =3D {
>>>> + { 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
>>>> + { 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
>>>> + { 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>>>> + { 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>>>> + { 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
>>>> +};
>>>> +
>>>> +static const struct qca_device_info *btusb_qca_find_device(struct qca=
_version *ver)
>>>> +{
>>>> + size_t i;
>>>> +
>>>> + for (i =3D 0; i < ARRAY_SIZE(qca_devices_table); i++)
>>>=20
>>> For simpler readability use { } for this loop.
>>>=20
>>>> +  if (ver->rom_version =3D=3D qca_devices_table[i].rom_version)
>>>> + return &qca_devices_table[i];
>>>> +
>>>> + return NULL;
>>>> +}
>>>> +
>>>> +static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 requ=
est,
>>>> +      void *data, u16 size)
>>>> +{
>>>> + u8 *buf;
>>>> + int pipe, ret;
>>>> +
>>>> + buf =3D kmalloc(size, GFP_KERNEL);
>>>> + if (!buf)
>>>> + return -ENOMEM;
>>>> +
>>>> + pipe =3D usb_rcvctrlpipe(udev, 0);
>>>> + ret =3D usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_D=
IR_IN,
>>>> +       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>>>> +
>>>=20
>>> Why are these done via control endpoint transfers and not just HCI comm=
ands. What is so special here. Would be nice if we had some comments explai=
ning how this is actually suppose to work.
>>=20
>> We can access those informations from OTA(one time programming) memory a=
rea. At early stage, it may not be possible to access OTP area from HCI Ven=
dor Specific command path. That=92s reason why we=92re using USB endpoint t=
ransfers at this stage. I=92ll put some explanation about it.
>>=20
>>>=20
>>>> +  memcpy(data, buf, size);
>>>> + kfree(buf);
>>>> +
>>>> + return ret;
>>>> +}
>>>> +
>>>> +static int btusb_setup_qca_download_fw(struct usb_device *udev,
>>>> +        const struct firmware *firmware,
>>>> +        size_t hdr_size)
>>>> +{
>>>> + u8 *buf;
>>>> + size_t count, size, sent =3D 0;
>>>> + int pipe, len, err =3D 0;
>>>=20
>>> err =3D 0 assignment only when really needed.
>>>=20
>>>> +
>>>> + buf =3D kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
>>>> + if (!buf)
>>>> + return -ENOMEM;
>>>> +
>>>> + count =3D firmware->size;
>>>> +
>>>> + size =3D min_t(size_t, count, hdr_size);
>>>> + memcpy(buf, firmware->data, size);
>>>> +
>>>> + pipe =3D usb_sndctrlpipe(udev, 0);
>>>> + err =3D usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDO=
R,
>>>> +       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>>>> + if (err < 0)
>>>> + goto done;
>>>> +
>>>> + sent +=3D size;
>>>> + count -=3D size;
>>>=20
>>> This needs some proper comments explaining what is going on here. I am =
pretty much confused why the first packet is send over control endpoint and=
 the rest over bulk endpoint.
>>=20
>> Patch data is made up TLV format (Tag - Length - Value) so that header d=
ata should be transferring through control endpoint first and sending body =
data over bulk endpoint. I=92ll put some comments as well.
>>=20
>>>=20
>>>> +
>>>> + while (count) {
>>>> + size =3D min_t(size_t, count, QCA_DFU_PACKET_LEN);
>>>> +
>>>> + memcpy(buf, firmware->data + sent, size);
>>>> +
>>>> + pipe =3D usb_sndbulkpipe(udev, 0x02);
>>>> + err =3D usb_bulk_msg(udev, pipe, buf, size, &len,
>>>> +    QCA_DFU_TIMEOUT);
>>>> + if (err)
>>>> + goto done;
>>>=20
>>> if (err < 0)
>>> break;
>>>=20
>>>> +
>>>> + if (size !=3D len) {
>>>> + err =3D -EIO;
>>>> + goto done;
>>>=20
>>> err =3D -EILSEQ;
>>> break;
>>>=20
>>>> +  }
>>>> +
>>>> + sent  +=3D size;
>>>> + count -=3D size;
>>>> + }
>>>> +
>>>> +done:
>>>> + if (err)
>>>> + BT_ERR("firmware download failed at %zd of %zd (%d)",
>>>> +        sent, firmware->size, err);
>>>> +
>>>> + kfree(buf);
>>>> + return err;
>>>> +}
>>>> +
>>>> +static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>> +  struct qca_version *ver,
>>>> +  const struct qca_device_info *info)
>>>> +{
>>>> + struct btusb_data *data;
>>>> + struct qca_rampatch_version *rver;
>>>> + const struct firmware *fw;
>>>> + char fwname[64];
>>>> + int err;
>>>> +
>>>> + snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.tlv",
>>>> +  ver->rom_version);
>>>=20
>>> Why is this *_tlv_*.tlv. That seems pretty much repetitive.
>>=20
>> Agree with you. I=92ll change it from *.tlv to *.bin file.
>>=20
>>>=20
>>>> +
>>>> + err =3D request_firmware(&fw, fwname, &hdev->dev);
>>>> + if (err) {
>>>> + BT_ERR("%s: failed to request rampatch file: %s (%d)",
>>>> +        hdev->name, fwname, err);
>>>> + return err;
>>>> + }
>>>> +
>>>> + BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
>>>> + rver =3D (struct qca_rampatch_version *) &fw->data[info->ver_offset]=
;
>>>=20
>>> (fw->data + info->ver_offset)
>>>=20
>>>> +  BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
>>>> + "build 0x%x", hdev->name, rver->rom_version,
>>>> + rver->patch_version, ver->rom_version, ver->patch_version);
>>>=20
>>> Endian conversion missing.
>>>=20
>>>> +
>>>> + if (rver->rom_version !=3D ver->rom_version ||
>>>> + rver->patch_version <=3D ver->patch_version) {
>>>=20
>>> Wrong indentation.
>>>=20
>>>> +  BT_ERR("rampatch file version did not match with firmware");
>>>> + return -EINVAL;
>>>> + }
>>>> +
>>>> + data =3D hci_get_drvdata(hdev);
>>>=20
>>> I rather see this assignment done with the declaration of the variable.
>>>=20
>>>> +
>>>> + err =3D btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_h=
dr);
>>>> +
>>>> + release_firmware(fw);
>>>> +
>>>> + return err;
>>>> +}
>>>> +
>>>> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>>>> +     struct qca_version *ver,
>>>> +     const struct qca_device_info *info)
>>>> +{
>>>> + struct btusb_data *data;
>>>> + const struct firmware *fw;
>>>> + char fwname[64];
>>>> + int err;
>>>> +
>>>> + snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
>>>> +  ver->rom_version);
>>>=20
>>> Why do we have the _tlv_ in the filename?
>>=20
>> As mentioned above, TLV means Tag-Length-Value. NVM config / RAM patch f=
iles are made up with TLV format.
>=20
> I figured as much that TLV mean tag length value, but that is still no re=
ason to put that into the file name ;)
>=20
> Honestly I would just call them rampatch_*.bin and nvm_*.bin. Do you need=
 to differentiate between USB and non-USB versions here. Aren't the informa=
tion the same, no matter how the chip transport is connected?
>=20
Yes, we have another files for UART config / ram patch because SoC core is =
unique but can be programmed to use UART/USB interfaces by sending config /=
 ram patch files. I=92m okay to remove _tlv_ term but would leave =91_usb_=
=92 string on file name.

>>>> +
>>>> + err =3D request_firmware(&fw, fwname, &hdev->dev);
>>>> + if (err) {
>>>> + BT_ERR("%s: failed to request NVM file: %s (%d)",
>>>> +        hdev->name, fwname, err);
>>>> + return err;
>>>> + }
>>>> +
>>>> + BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
>>>> +
>>>> + data =3D hci_get_drvdata(hdev);
>>>=20
>>> Should be assigned at the same time as variable declaration.
>>=20
>> Agree with you.=20
>>=20
>>>=20
>>>> +
>>>> + err =3D btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
>>>> +
>>>> + release_firmware(fw);
>>>> +
>>>> + return err;
>>>> +}
>>>> +
>>>> +static int btusb_setup_qca(struct hci_dev *hdev)
>>>> +{
>>>> + struct btusb_data *data;
>>>> + struct qca_version ver;
>>>> + u8 status;
>>>> + const struct qca_device_info *info;
>>>> + int err;
>>>> +
>>>> + data =3D hci_get_drvdata(hdev);
>>>=20
>>> Assignment during variable declaration.
>>>=20
>>>> +
>>>> + err =3D btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION=
,
>>>> + &ver, sizeof(ver));
>>>> + if (err < 0)
>>>> + goto done;
>>>> +
>>>> + info =3D btusb_qca_find_device(&ver);
>>>> + if (!info) {
>>>> + err =3D -ENODEV;
>>>> + goto done;
>>>> + }
>>>=20
>>> Looks like we are doing this twice.
>>>=20
>>>> +
>>>> + err =3D btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
>>>> + &status, sizeof(status));
>>>> + if (err < 0)
>>>> + goto done;
>>>> +
>>>> + if ((status !=3D QCA_PATCH_UPDATE) || (status !=3D QCA_PATCH_SYSCFG_=
UPDATE)) {
>>>=20
>>> The extra ( ) are not needed.
>>>=20
>>>> +  err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
>>>> + if (err < 0)
>>>> + goto done;
>>>> + }
>>>> +
>>>> + err =3D btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
>>>> + &status, sizeof(status));
>>>=20
>>> So why are you checking the status twice here. If you do not load the r=
am patch, then the value will also not change.
>>=20
>> You=92re right. It is sufficient to call this one-time.
>>=20
>>>=20
>>>> +  if (err < 0)
>>>> + goto done;
>>>> +
>>>> + if ((status !=3D QCA_SYSCFG_UPDATE) || (status !=3D QCA_PATCH_SYSCFG=
_UPDATE)) {
>>>=20
>>> The extra ( ) are not needed.
>>>=20
>>>> +  err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
>>>> + if (err < 0)
>>>> + goto done;
>>>> + }
>>>=20
>>> In general I find this function hard to read and understand. Since stat=
us is an enum, why not use a switch statement.
>>>=20
>>> The way I read it this like this:
>>>=20
>>> case QCA_PATCH_UPDATE:
>>> load_rampatch();
>>> break;
>>>=20
>>> case QCA_PATCH_SYSCFG_UPDATE:
>>> load_rampatch();
>>> load_nvm();
>>> break;
>>>=20
>>> case QCA_SYSCFG_UPDATE:
>>> load_nvm();
>>> break;
>>>=20
>>> However now checking in more detail, this is actually not an enum. So t=
his is what you actually want:
>>>=20
>>> if (status & QCA_PATCH_UPDATE)
>>> load_rampatch();
>>>=20
>>> if (status & QCA_SYSCFG_UPDATE)
>>> load_nvm();
>>>=20
>>> And re-reading the status in between in pretty pointless. Either it suc=
ceeds or it fails. If it fails, then it fails and we should just abort hdev=
->setup.
>>=20
>> Agree with you.
>>=20
>>>=20
>>>> +
>>>> +done:
>>>> + return err;
>>>> +}
>>>> +
>>>> static int btusb_probe(struct usb_interface *intf,
>>>>       const struct usb_device_id *id)
>>>> {
>>>> @@ -2619,6 +2866,20 @@ static int btusb_probe(struct usb_interface *in=
tf,
>>>> return -ENODEV;
>>>> }
>>>>=20
>>>> + if (id->driver_info & BTUSB_QCA_ROME) {
>>>> + struct usb_device *udev =3D interface_to_usbdev(intf);
>>>> + struct qca_version ver;
>>>> +
>>>> + err =3D btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION,
>>>> + &ver, sizeof(ver));
>>>> + if (err < 0)
>>>> + return err;
>>>=20
>>> I am not in favor of sending a blocking USB request during probe. Do we=
 really need this. Can that not be done during hdev->setup call.
>>>=20
>>> Also we are clearly duplicating this command.
>>=20
>> You=92re right. It is duplicated. I=92ll remove those portion of codes i=
n probe.
>>=20
>>>=20
>>>> +
>>>> + if (!btusb_qca_find_device(&ver)) {
>>>> + return -ENODEV;
>>>> + }
>>>=20
>>> Single line bodies without { }.
>>>=20
>>>> +  }
>>>> +
>>>> data =3D devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
>>>> if (!data)
>>>> return -ENOMEM;
>>>> @@ -2736,6 +2997,11 @@ static int btusb_probe(struct usb_interface *in=
tf,
>>>> set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>>> }
>>>>=20
>>>> + if (id->driver_info & BTUSB_QCA_ROME) {
>>>> + hdev->set_bdaddr =3D btusb_set_bdaddr_ath3012;
>>>> + hdev->setup =3D btusb_setup_qca;
>>>=20
>>> The other way around ->setup before ->set_bdaddr.
>>>=20
>>> And the it needs to be guaranteed that the btusb_set_bdaddr_ath3012 for=
 these chipset is also temporary. A power cycle needs to bring it back to i=
ts original address.
>>=20
>> You=92re right. After power recycling, it has a default bdaddr which is =
coming from OTP area first. If OTP does not contain bd address then pick it=
 up from nvm_tlv_usb.bin.=20
>=20
> Actually if there is no valid BD_ADDR, then use the HCI_QUIRK_INVALID_BDA=
DDR to flag it like that. That way the controller comes up as unconfigured =
and lets userspace program the address. Putting addresses in the NVM files =
is a really bad idea. They do not belong there unless you have proper metho=
ds for installing individual NVM files on each machine.
>=20
I thought we=92re talking about default bd address ;-). Of cause NVM contai=
ns default bd address and not be installed as individual file on each machi=
ne. On the factory, however, we have programmed OTP area with unique bd add=
ress for each chipset so that unique bluetooth address should be always pre=
sent on the ROME.

> Regards
>=20
> Marcel
>=20
