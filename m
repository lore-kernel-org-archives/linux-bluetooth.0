Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Add support for QCA ROME chipset family
Date: Fri, 30 Jan 2015 06:57:04 +0000
Message-ID: <D3654EF0-7CE5-43B3-80CF-52E8AA166AB3@qca.qualcomm.com>
References: <c91d59687e224bb582d1be6fd0b29adf@nalasexr02e.na.qualcomm.com>
 <20F1EBA1-1051-42DD-B400-F5F04711EFAE@holtmann.org>
In-Reply-To: <20F1EBA1-1051-42DD-B400-F5F04711EFAE@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Jan 29, 2015, at 9:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Ben,
>=20
>> This patch supports ROME Bluetooth family from Qualcomm Atheros,
>> e.g. QCA61x4 or QCA6574.
>>=20
>> New chipset have similar firmware downloading sequences to previous
>> chipset from Atheros, however, it doesn't support vid/pid switching
>> after downloading the patch so that firmware needs to be handled by
>> btusb module directly.
>>=20
>> ROME chipset can be differentiated from previous version by reading
>> ROM version.
>>=20
>> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 16 Spd=3D12  =
 MxCh=3D 0
>> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
>> P:  Vendor=3D0cf3 ProdID=3De300 Rev=3D 0.01
>> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
>> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
>> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
>> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Drive=
r=3Dbtusb
>> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>>=20
>> Signed-off-by: Ben Kim <ytkim@qca.qualcomm.com>
>> ---
>> drivers/bluetooth/btusb.c | 251 ++++++++++++++++++++++++++++++++++++++++=
++++++
>> 1 file changed, 251 insertions(+)
>>=20
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 3aa4b3c..15b68b1 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
>> #define BTUSB_SWAVE		0x1000
>> #define BTUSB_INTEL_NEW		0x2000
>> #define BTUSB_AMP		0x4000
>> +#define BTUSB_QCA_ROME		0x8000
>>=20
>> static const struct usb_device_id btusb_table[] =3D {
>> 	/* Generic Bluetooth USB device */
>> @@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[] =
=3D {
>> 	{ USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },
>> 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },
>>=20
>> +	/* QCA ROME chipset */
>> +	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info =3D BTUSB_QCA_ROME},
>> +
>> 	/* Broadcom BCM2035 */
>> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },
>> @@ -2585,6 +2589,248 @@ static int btusb_set_bdaddr_ath3012(struct hci_d=
ev *hdev,
>> 	return 0;
>> }
>>=20
>> +#define QCA_DFU_PACKET_LEN	4096
>> +
>> +#define QCA_GET_TARGET_VERSION	0x09
>> +#define QCA_CHECK_STATUS	0x05
>> +#define QCA_DFU_DOWNLOAD	0x01
>> +
>> +#define QCA_PATCH_UPDATE	0xA0
>> +#define QCA_SYSCFG_UPDATE	0x60
>> +#define QCA_PATCH_SYSCFG_UPDATE	(QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)
>=20
> no longer needed. Remove this one.

Will remove this

>=20
>> +#define QCA_DFU_TIMEOUT		3000
>> +
>> +struct qca_version {
>> +	__le32	rom_version;
>> +	__le32	patch_version;
>> +	__le32	ram_version;
>> +	__le32	ref_clock;
>> +	__u8	reserved[4];
>> +} __packed;
>> +
>> +struct qca_rampatch_version {
>> +	__le16	rom_version;
>> +	__le16	patch_version;
>> +} __packed;
>> +
>> +struct qca_device_info {
>> +	__le32	rom_version;
>> +	__u8	rampatch_hdr;	/* length of header in rampatch */
>> +	__u8	nvm_hdr;	/* length of header in NVM */
>> +	__u8	ver_offset;	/* offset of version structure in rampatch */
>> +};
>> +
>> +static const struct qca_device_info qca_devices_table[] =3D {
>> +	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
>> +	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
>> +	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
>> +	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
>> +	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
>> +};
>> +
>> +static const struct qca_device_info *btusb_qca_find_device(struct qca_v=
ersion *ver)
>> +{
>> +	size_t i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(qca_devices_table); i++) {
>> +		if (ver->rom_version =3D=3D qca_devices_table[i].rom_version)
>> +			return &qca_devices_table[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>=20
> I think this one can be just put directly into btusb_setup_qca. You only =
have single user of it. Avoids have to jump around and figure out what is g=
oing on.

Agree. Will put those into actual line called

>=20
>> +
>> +static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 reques=
t,
>> +				     void *data, u16 size)
>> +{
>> +	u8 *buf;
>> +	int pipe, ret;
>> +
>> +	buf =3D kmalloc(size, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	/* To access OTP(one time programing) memory area at early stage,
>> +	 * use USB endpoint instead of VS HCI command because HCI path may=20
>> +	 * not be ready to access OTP area.
>> +	 */
>> +	pipe =3D usb_rcvctrlpipe(udev, 0);
>> +	ret =3D usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR=
_IN,
>> +			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>> +
>> +	memcpy(data, buf, size);
>> +	kfree(buf);
>> +
>> +	return ret;
>> +}
>> +
>> +static int btusb_setup_qca_download_fw(struct usb_device *udev,
>> +				       const struct firmware *firmware,
>> +				       size_t hdr_size)
>> +{
>> +	u8 *buf;
>> +	size_t count, size, sent =3D 0;
>> +	int pipe, len, err;
>> +
>> +	buf =3D kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	count =3D firmware->size;
>> +
>> +	size =3D min_t(size_t, count, hdr_size);
>> +	memcpy(buf, firmware->data, size);
>> +
>> +	/* Patch header goes down through control path */
>> +	pipe =3D usb_sndctrlpipe(udev, 0);
>> +	err =3D usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,
>> +			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>> +	if (err < 0)
>> +		goto done;
>=20
> Put the error message here and make it clear that the header fails.

Okay

>=20
>> +
>> +	sent +=3D size;
>> +	count -=3D size;
>> +
>> +	while (count) {
>> +		size =3D min_t(size_t, count, QCA_DFU_PACKET_LEN);
>> +
>> +		memcpy(buf, firmware->data + sent, size);
>> +
>> +		/* Patch body goes down through bulk channel */
>> +		pipe =3D usb_sndbulkpipe(udev, 0x02);
>> +		err =3D usb_bulk_msg(udev, pipe, buf, size, &len,
>> +				   QCA_DFU_TIMEOUT);
>> +		if (err < 0)
>> +			break;
>=20
> This should include the error message that the body failed.

Okay

>=20
>> +
>> +		if (size !=3D len) {
>> +			err =3D -EILSEQ;
>> +			break;
>> +		}
>> +
>> +		sent  +=3D size;
>> +		count -=3D size;
>> +	}
>> +
>> +done:
>> +	if (err)
>> +		BT_ERR("firmware download failed at %zd of %zd (%d)",
>> +		       sent, firmware->size, err);
>=20
> Actually I think you want the error message where it happens. This locati=
on is not a good idea. See both comments above.
>=20

Yes, if messages print out in actual code line above, this code is able to =
remove.

>> +
>> +	kfree(buf);
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>> +					 struct qca_version *ver,
>> +					 const struct qca_device_info *info)
>> +{
>> +	struct btusb_data *data =3D hci_get_drvdata(hdev);
>> +	struct qca_rampatch_version *rver;
>> +	const struct firmware *fw;
>> +	char fwname[64];
>> +	int err;
>> +
>> +	snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.bin",
>> +		 ver->rom_version);
>=20
> Honestly, qca/rampatch_%08x.bin should be plenty. I still have no idea wh=
at value tlv adds and why we need the statement in there that is is for USB=
? Do you use different files for UART version?

Yes we have UART version of config / ram patch files. As mentioned, will re=
move _tlv_ term but would leave _usb_ string on the filename.

>=20
> And btw. le32_to_cpu(ver->rom_version) since otherwise this does not do t=
he right thing on big endian machines.

Right thanks.

>=20
>> +
>> +	err =3D request_firmware(&fw, fwname, &hdev->dev);
>> +	if (err) {
>> +		BT_ERR("%s: failed to request rampatch file: %s (%d)",
>> +		       hdev->name, fwname, err);
>> +		return err;
>> +	}
>> +
>> +	BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
>> +	rver =3D (struct qca_rampatch_version *)(fw->data + info->ver_offset);
>> +	BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
>> +		"build 0x%x", hdev->name, le16_to_cpu(rver->rom_version),
>> +		le16_to_cpu(rver->patch_version), le32_to_cpu(ver->rom_version),=20
>> +		le32_to_cpu(ver->patch_version));
>> +
>> +	if (rver->rom_version !=3D ver->rom_version ||
>> +		rver->patch_version <=3D ver->patch_version) {
>=20
> Indentation is still wrong.

I thought it is right. It would be appreciated if you can give me some hint=
 ;-)

>=20
>> +		BT_ERR("rampatch file version did not match with firmware");
>> +		return -EINVAL;
>=20
> You are leaking the firmware data here.
>=20

Yes, thanks for catching the bug.

>> +	}
>> +
>> +	err =3D btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_hdr=
);
>> +
>> +	release_firmware(fw);
>> +
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>> +				    struct qca_version *ver,
>> +				    const struct qca_device_info *info)
>> +{
>> +	struct btusb_data *data =3D hci_get_drvdata(hdev);
>> +	const struct firmware *fw;
>> +	char fwname[64];
>> +	int err;
>> +
>> +	snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
>> +		 ver->rom_version);
>=20
> Same applies from comment above. Including the endian bug.

Yes, will fix it

>=20
>> +
>> +	err =3D request_firmware(&fw, fwname, &hdev->dev);
>> +	if (err) {
>> +		BT_ERR("%s: failed to request NVM file: %s (%d)",
>> +		       hdev->name, fwname, err);
>> +		return err;
>> +	}
>> +
>> +	BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
>> +
>> +	err =3D btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
>> +
>> +	release_firmware(fw);
>> +
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca(struct hci_dev *hdev)
>> +{
>> +	struct btusb_data *data;
>> +	struct qca_version ver;
>> +	u8 status;
>> +	const struct qca_device_info *info;
>> +	int err;
>> +
>> +	data =3D hci_get_drvdata(hdev);
>=20
> 	struct btusb_data *data =3D hci_get_drvdata(hdev);
>=20
> That should be always first in the function.
>=20

Okay,

>> +
>> +	err =3D btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION,
>> +					&ver, sizeof(ver));
>> +	if (err < 0)
>> +		goto done;
>=20
> 		return err;
>=20
>> +
>> +	info =3D btusb_qca_find_device(&ver);
>> +	if (!info) {
>> +		err =3D -ENODEV;
>> +		goto done;
>=20
> 		return -ENODEV;
>=20
>> +	}
>=20
> Replace the call to btusb_qca_find_device with a direct coding of that lo=
okup here.
>=20

Okay,

>> +
>> +	err =3D btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
>> +					&status, sizeof(status));
>> +	if (err < 0)
>> +		goto done;
>=20
> 		return err;
>=20
>> +
>> +	if (status !=3D QCA_PATCH_UPDATE) {
>=20
> 	if (status & QCA_PATCH_UPDATE) {
> 	}
>=20
> Otherwise you have to explain how that thing works. Since I do not unders=
tand it.
>=20

e.g, if no cfg / patch are downloaded, it returns 0x20. If cfg is present o=
nly, it has 0x60. If patch is present but not cfg, it has 0xA0. Both of pat=
ch / cfg are present then it returns 0xE0.
It would be good if QCA_PATCH_UPDATE is 0x80 and if QCA_SYSCFG_UPDATE is 0x=
40 then we can use bit-ordering scheme.


>> +		err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
>> +		if (err < 0)
>> +			goto done;
>=20
> 			return err;
>=20
>> +	}
>> +
>> +	if (status !=3D QCA_SYSCFG_UPDATE) {
>=20
> Same as above.
>=20
>> +		err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
>> +		if (err < 0)
>> +			goto done;
>=20
> 		return err;
>=20
>> +	}
>> +
>> +done:
>> +	return err;
>=20
> 	return 0;
>=20
>> +}
>> +
>> static int btusb_probe(struct usb_interface *intf,
>> 		       const struct usb_device_id *id)
>> {
>> @@ -2736,6 +2982,11 @@ static int btusb_probe(struct usb_interface *intf=
,
>> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>> 	}
>>=20
>> +	if (id->driver_info & BTUSB_QCA_ROME) {
>> +		hdev->setup =3D btusb_setup_qca;
>> +		hdev->set_bdaddr =3D btusb_set_bdaddr_ath3012;
>> +	}
>> +
>> 	if (id->driver_info & BTUSB_AMP) {
>> 		/* AMP controllers do not support SCO packets */
>> 		data->isoc =3D NULL;
>> --=20
>> 1.9.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20

Thanks
Ben Kim
