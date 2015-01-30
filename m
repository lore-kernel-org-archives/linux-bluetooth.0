Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Add support for QCA ROME chipset family
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <15E046BB-8877-40F7-8AE4-C5F3676BECAF@qca.qualcomm.com>
Date: Thu, 29 Jan 2015 21:03:56 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <42F36B40-A440-4590-82A5-2E5CACBABB85@holtmann.org>
References: <27c299b26b2c489aa7d8ad1114a10a2e@nalasexr02e.na.qualcomm.com> <D064A6CA-D4B6-4FA2-BC81-0BC6A8C5CDAC@holtmann.org> <15E046BB-8877-40F7-8AE4-C5F3676BECAF@qca.qualcomm.com>
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
>> 
>> please always include the content from /sys/kernel/debug/usb/devices for your devices. I want to have them recorded in the commit messages.
>> 
>> With that in mind it might be actually beneficial to add first one module and then extend it to the second one. That would keep in clean in the history.
> 
> Sure, I’ll do that
> 
>> 
>>> ROME chipset can be differentiated from previous version by reading
>>> ROM version.
>>> 
>>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>>> ---
>>> drivers/bluetooth/btusb.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 266 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
>>> #define BTUSB_SWAVE  0x1000
>>> #define BTUSB_INTEL_NEW  0x2000
>>> #define BTUSB_AMP 0x4000
>>> +#define BTUSB_QCA_ROME  0x8000
>>> 
>>> static const struct usb_device_id btusb_table[] = {
>>> /* Generic Bluetooth USB device */
>>> @@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[] = {
>>> { USB_DEVICE(0x0489, 0xe036), .driver_info = BTUSB_ATH3012 },
>>> { USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
>>> 
>>> + /* QCA ROME chipset */
>>> + { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME},
>>> +
>>> /* Broadcom BCM2035 */
>>> { USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
>>> { USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
>>> @@ -2585,6 +2589,249 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
>>> return 0;
>>> }
>>> 
>>> +#define QCA_DFU_PACKET_LEN
>>> 4096
>>> +
>>> +#define QCA_GET_TARGET_VERSION
>>> 0x09
>>> +#define QCA_CHECK_STATUS  0x05
>>> +#define QCA_DFU_DOWNLOAD  0x01
>>> +
>>> +#define QCA_PATCH_UPDATE  0xA0
>>> +#define QCA_SYSCFG_UPDATE
>>> 0x60
>>> +#define QCA_PATCH_SYSCFG_UPDATE
>>> (QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)
>>> +#define QCA_DFU_TIMEOUT  3000
>>> +
>>> +struct qca_version {
>>> + u32
>>> rom_version;
>>> + u32
>>> patch_version;
>>> + u32
>>> ram_version;
>>> + u32
>>> ref_clock;
>>> + u8
>>> reserved[4];
>> 
>> Use __le32 or __be32.
>> 
>>> +} __packed;
>>> +
>>> +struct qca_rampatch_version {
>>> + u16
>>> rom_version;
>>> + u16
>>> patch_version;
>> 
>> Same here. Proper endian.
>> 
>>> +} __packed;
>>> +
>>> +struct qca_device_info {
>>> + u32
>>> rom_version;
>>> + u8
>>> rampatch_hdr;  /* length of header in rampatch */
>>> + u8
>>> nvm_hdr; /* length of header in NVM */
>>> + u8
>>> ver_offset;  /* offset of version structure in rampatch */
>> 
>> And here as well. Use the right endian aware type.
>> 
>>> +};
>>> +
>>> +static const struct qca_device_info qca_devices_table[] = {
>>> + { 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
>>> + { 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
>>> + { 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>>> + { 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>>> + { 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
>>> +};
>>> +
>>> +static const struct qca_device_info *btusb_qca_find_device(struct qca_version *ver)
>>> +{
>>> + size_t i;
>>> +
>>> + for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++)
>> 
>> For simpler readability use { } for this loop.
>> 
>>> +  if (ver->rom_version == qca_devices_table[i].rom_version)
>>> + return &qca_devices_table[i];
>>> +
>>> + return NULL;
>>> +}
>>> +
>>> +static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
>>> +      void *data, u16 size)
>>> +{
>>> + u8 *buf;
>>> + int pipe, ret;
>>> +
>>> + buf = kmalloc(size, GFP_KERNEL);
>>> + if (!buf)
>>> + return -ENOMEM;
>>> +
>>> + pipe = usb_rcvctrlpipe(udev, 0);
>>> + ret = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
>>> +       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>>> +
>> 
>> Why are these done via control endpoint transfers and not just HCI commands. What is so special here. Would be nice if we had some comments explaining how this is actually suppose to work.
> 
> We can access those informations from OTA(one time programming) memory area. At early stage, it may not be possible to access OTP area from HCI Vendor Specific command path. That’s reason why we’re using USB endpoint transfers at this stage. I’ll put some explanation about it.
> 
>> 
>>> +  memcpy(data, buf, size);
>>> + kfree(buf);
>>> +
>>> + return ret;
>>> +}
>>> +
>>> +static int btusb_setup_qca_download_fw(struct usb_device *udev,
>>> +        const struct firmware *firmware,
>>> +        size_t hdr_size)
>>> +{
>>> + u8 *buf;
>>> + size_t count, size, sent = 0;
>>> + int pipe, len, err = 0;
>> 
>> err = 0 assignment only when really needed.
>> 
>>> +
>>> + buf = kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
>>> + if (!buf)
>>> + return -ENOMEM;
>>> +
>>> + count = firmware->size;
>>> +
>>> + size = min_t(size_t, count, hdr_size);
>>> + memcpy(buf, firmware->data, size);
>>> +
>>> + pipe = usb_sndctrlpipe(udev, 0);
>>> + err = usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,
>>> +       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>>> + if (err < 0)
>>> + goto done;
>>> +
>>> + sent += size;
>>> + count -= size;
>> 
>> This needs some proper comments explaining what is going on here. I am pretty much confused why the first packet is send over control endpoint and the rest over bulk endpoint.
> 
> Patch data is made up TLV format (Tag - Length - Value) so that header data should be transferring through control endpoint first and sending body data over bulk endpoint. I’ll put some comments as well.
> 
>> 
>>> +
>>> + while (count) {
>>> + size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
>>> +
>>> + memcpy(buf, firmware->data + sent, size);
>>> +
>>> + pipe = usb_sndbulkpipe(udev, 0x02);
>>> + err = usb_bulk_msg(udev, pipe, buf, size, &len,
>>> +    QCA_DFU_TIMEOUT);
>>> + if (err)
>>> + goto done;
>> 
>> if (err < 0)
>> break;
>> 
>>> +
>>> + if (size != len) {
>>> + err = -EIO;
>>> + goto done;
>> 
>> err = -EILSEQ;
>> break;
>> 
>>> +  }
>>> +
>>> + sent  += size;
>>> + count -= size;
>>> + }
>>> +
>>> +done:
>>> + if (err)
>>> + BT_ERR("firmware download failed at %zd of %zd (%d)",
>>> +        sent, firmware->size, err);
>>> +
>>> + kfree(buf);
>>> + return err;
>>> +}
>>> +
>>> +static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>> +  struct qca_version *ver,
>>> +  const struct qca_device_info *info)
>>> +{
>>> + struct btusb_data *data;
>>> + struct qca_rampatch_version *rver;
>>> + const struct firmware *fw;
>>> + char fwname[64];
>>> + int err;
>>> +
>>> + snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.tlv",
>>> +  ver->rom_version);
>> 
>> Why is this *_tlv_*.tlv. That seems pretty much repetitive.
> 
> Agree with you. I’ll change it from *.tlv to *.bin file.
> 
>> 
>>> +
>>> + err = request_firmware(&fw, fwname, &hdev->dev);
>>> + if (err) {
>>> + BT_ERR("%s: failed to request rampatch file: %s (%d)",
>>> +        hdev->name, fwname, err);
>>> + return err;
>>> + }
>>> +
>>> + BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
>>> + rver = (struct qca_rampatch_version *) &fw->data[info->ver_offset];
>> 
>> (fw->data + info->ver_offset)
>> 
>>> +  BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
>>> + "build 0x%x", hdev->name, rver->rom_version,
>>> + rver->patch_version, ver->rom_version, ver->patch_version);
>> 
>> Endian conversion missing.
>> 
>>> +
>>> + if (rver->rom_version != ver->rom_version ||
>>> + rver->patch_version <= ver->patch_version) {
>> 
>> Wrong indentation.
>> 
>>> +  BT_ERR("rampatch file version did not match with firmware");
>>> + return -EINVAL;
>>> + }
>>> +
>>> + data = hci_get_drvdata(hdev);
>> 
>> I rather see this assignment done with the declaration of the variable.
>> 
>>> +
>>> + err = btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_hdr);
>>> +
>>> + release_firmware(fw);
>>> +
>>> + return err;
>>> +}
>>> +
>>> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>>> +     struct qca_version *ver,
>>> +     const struct qca_device_info *info)
>>> +{
>>> + struct btusb_data *data;
>>> + const struct firmware *fw;
>>> + char fwname[64];
>>> + int err;
>>> +
>>> + snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
>>> +  ver->rom_version);
>> 
>> Why do we have the _tlv_ in the filename?
> 
> As mentioned above, TLV means Tag-Length-Value. NVM config / RAM patch files are made up with TLV format.

I figured as much that TLV mean tag length value, but that is still no reason to put that into the file name ;)

Honestly I would just call them rampatch_*.bin and nvm_*.bin. Do you need to differentiate between USB and non-USB versions here. Aren't the information the same, no matter how the chip transport is connected?

>>> +
>>> + err = request_firmware(&fw, fwname, &hdev->dev);
>>> + if (err) {
>>> + BT_ERR("%s: failed to request NVM file: %s (%d)",
>>> +        hdev->name, fwname, err);
>>> + return err;
>>> + }
>>> +
>>> + BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
>>> +
>>> + data = hci_get_drvdata(hdev);
>> 
>> Should be assigned at the same time as variable declaration.
> 
> Agree with you. 
> 
>> 
>>> +
>>> + err = btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
>>> +
>>> + release_firmware(fw);
>>> +
>>> + return err;
>>> +}
>>> +
>>> +static int btusb_setup_qca(struct hci_dev *hdev)
>>> +{
>>> + struct btusb_data *data;
>>> + struct qca_version ver;
>>> + u8 status;
>>> + const struct qca_device_info *info;
>>> + int err;
>>> +
>>> + data = hci_get_drvdata(hdev);
>> 
>> Assignment during variable declaration.
>> 
>>> +
>>> + err = btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION,
>>> + &ver, sizeof(ver));
>>> + if (err < 0)
>>> + goto done;
>>> +
>>> + info = btusb_qca_find_device(&ver);
>>> + if (!info) {
>>> + err = -ENODEV;
>>> + goto done;
>>> + }
>> 
>> Looks like we are doing this twice.
>> 
>>> +
>>> + err = btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
>>> + &status, sizeof(status));
>>> + if (err < 0)
>>> + goto done;
>>> +
>>> + if ((status != QCA_PATCH_UPDATE) || (status != QCA_PATCH_SYSCFG_UPDATE)) {
>> 
>> The extra ( ) are not needed.
>> 
>>> +  err = btusb_setup_qca_load_rampatch(hdev, &ver, info);
>>> + if (err < 0)
>>> + goto done;
>>> + }
>>> +
>>> + err = btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
>>> + &status, sizeof(status));
>> 
>> So why are you checking the status twice here. If you do not load the ram patch, then the value will also not change.
> 
> You’re right. It is sufficient to call this one-time.
> 
>> 
>>> +  if (err < 0)
>>> + goto done;
>>> +
>>> + if ((status != QCA_SYSCFG_UPDATE) || (status != QCA_PATCH_SYSCFG_UPDATE)) {
>> 
>> The extra ( ) are not needed.
>> 
>>> +  err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>>> + if (err < 0)
>>> + goto done;
>>> + }
>> 
>> In general I find this function hard to read and understand. Since status is an enum, why not use a switch statement.
>> 
>> The way I read it this like this:
>> 
>> case QCA_PATCH_UPDATE:
>> load_rampatch();
>> break;
>> 
>> case QCA_PATCH_SYSCFG_UPDATE:
>> load_rampatch();
>> load_nvm();
>> break;
>> 
>> case QCA_SYSCFG_UPDATE:
>> load_nvm();
>> break;
>> 
>> However now checking in more detail, this is actually not an enum. So this is what you actually want:
>> 
>> if (status & QCA_PATCH_UPDATE)
>> load_rampatch();
>> 
>> if (status & QCA_SYSCFG_UPDATE)
>> load_nvm();
>> 
>> And re-reading the status in between in pretty pointless. Either it succeeds or it fails. If it fails, then it fails and we should just abort hdev->setup.
> 
> Agree with you.
> 
>> 
>>> +
>>> +done:
>>> + return err;
>>> +}
>>> +
>>> static int btusb_probe(struct usb_interface *intf,
>>>        const struct usb_device_id *id)
>>> {
>>> @@ -2619,6 +2866,20 @@ static int btusb_probe(struct usb_interface *intf,
>>> return -ENODEV;
>>> }
>>> 
>>> + if (id->driver_info & BTUSB_QCA_ROME) {
>>> + struct usb_device *udev = interface_to_usbdev(intf);
>>> + struct qca_version ver;
>>> +
>>> + err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION,
>>> + &ver, sizeof(ver));
>>> + if (err < 0)
>>> + return err;
>> 
>> I am not in favor of sending a blocking USB request during probe. Do we really need this. Can that not be done during hdev->setup call.
>> 
>> Also we are clearly duplicating this command.
> 
> You’re right. It is duplicated. I’ll remove those portion of codes in probe.
>  
>> 
>>> +
>>> + if (!btusb_qca_find_device(&ver)) {
>>> + return -ENODEV;
>>> + }
>> 
>> Single line bodies without { }.
>> 
>>> +  }
>>> +
>>> data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
>>> if (!data)
>>> return -ENOMEM;
>>> @@ -2736,6 +2997,11 @@ static int btusb_probe(struct usb_interface *intf,
>>> set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>>> }
>>> 
>>> + if (id->driver_info & BTUSB_QCA_ROME) {
>>> + hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>>> + hdev->setup = btusb_setup_qca;
>> 
>> The other way around ->setup before ->set_bdaddr.
>> 
>> And the it needs to be guaranteed that the btusb_set_bdaddr_ath3012 for these chipset is also temporary. A power cycle needs to bring it back to its original address.
> 
> You’re right. After power recycling, it has a default bdaddr which is coming from OTP area first. If OTP does not contain bd address then pick it up from nvm_tlv_usb.bin. 

Actually if there is no valid BD_ADDR, then use the HCI_QUIRK_INVALID_BDADDR to flag it like that. That way the controller comes up as unconfigured and lets userspace program the address. Putting addresses in the NVM files is a really bad idea. They do not belong there unless you have proper methods for installing individual NVM files on each machine.

Regards

Marcel

