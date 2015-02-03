Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v3] Bluetooth: Add support for QCA ROME chipset family
Date: Tue, 3 Feb 2015 18:02:53 +0000
Message-ID: <15c2286c483d4d2896087c85fd80ce11@nalasexr02e.na.qualcomm.com>
References: <42adba3be47c4323ac2744b9918cca2e@nalasexr02e.na.qualcomm.com>
 <3EDD8519-D73A-4A9A-84A6-0C6E89B695D7@holtmann.org>
 <DC8A92A7-4E24-4252-BB05-14FE1FECB43F@qca.qualcomm.com>
In-Reply-To: <DC8A92A7-4E24-4252-BB05-14FE1FECB43F@qca.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Feb 2, 2015, at 10:15 AM, Kim, Ben Young Tae <ytkim@qca.qualcomm.com> wr=
ote:
Hi Marcel,

On Jan 30, 2015, at 5:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Ben,
>=20
>> This patch supports ROME Bluetooth family from Qualcomm Atheros, e.g.=20
>> QCA61x4 or QCA6574.
>>=20
>> New chipset have similar firmware downloading sequences to previous=20
>> chipset from Atheros, however, it doesn't support vid/pid switching=20
>> after downloading the patch so that firmware needs to be handled by=20
>> btusb module directly.
>>=20
>> ROME chipset can be differentiated from previous version by reading=20
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
>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>> ---
>> drivers/bluetooth/btusb.c | 251=20
>> ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 251 insertions(+)
>>=20
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=20
>> index a3a47c5..f7f39ef 100644
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
>> 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },=20
>> @@ -2580,6 +2584,248 @@ static int btusb_set_bdaddr_ath3012(struct hci_d=
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
>> +#define QCA_SYSCFG_UPDATED	0x40
>> +#define QCA_PATCH_UPDATED	0x80
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
>> +	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */ };
>> +
>> +static int btusb_qca_send_vendor_req(struct hci_dev *hdev, u8 request,
>> +				     void *data, u16 size)
>> +{
>> +	struct btusb_data *btdata =3D hci_get_drvdata(hdev);
>> +	struct usb_device *udev =3D btdata->udev;
>> +	int pipe, err;
>> +	u8 *buf;
>> +
>> +	buf =3D kmalloc(size, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	/* To access OTP(one time programing) memory area at early stage,
>> +	 * use USB endpoint instead of VS HCI command because HCI path may
>> +	 * not be ready to access OTP area.
>> +	 */
>> +	pipe =3D usb_rcvctrlpipe(udev, 0);
>> +	err =3D usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR=
_IN,
>> +			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to access otp area (%d)", hdev->name, err);
>> +		goto done;
>> +	}
>> +
>> +	memcpy(data, buf, size);
>> +
>> +done:
>> +	kfree(buf);
>> +
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
>> +				       const struct firmware *firmware,
>> +				       size_t hdr_size)
>> +{
>> +	struct btusb_data *btdata =3D hci_get_drvdata(hdev);
>> +	struct usb_device *udev =3D btdata->udev;
>> +	size_t count, size, sent =3D 0;
>> +	int pipe, len, err;
>> +	u8 *buf;
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
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to send headers (%d)", hdev->name, err);
>> +		goto done;
>> +	}
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
>> +		if (err < 0) {
>> +			BT_ERR("%s: Failed to send body at %zd of %zd (%d)",
>> +			       hdev->name, sent, firmware->size, err);
>> +			break;
>> +		}
>> +
>> +		if (size !=3D len) {
>> +			BT_ERR("%s: Failed to get bulk buffer", hdev->name);
>> +			err =3D -EILSEQ;
>> +			break;
>> +		}
>> +
>> +		sent  +=3D size;
>> +		count -=3D size;
>> +	}
>> +
>> +done:
>> +	kfree(buf);
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>> +					 struct qca_version *ver,
>> +					 const struct qca_device_info *info) {
>> +	struct qca_rampatch_version *rver;
>> +	const struct firmware *fw;
>> +	char fwname[64];
>> +	int err;
>> +
>> +	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin",
>> +		 le32_to_cpu(ver->rom_version));
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
>> +		le16_to_cpu(rver->patch_version), le32_to_cpu(ver->rom_version),
>> +		le32_to_cpu(ver->patch_version));
>> +
>> +	if (rver->rom_version !=3D ver->rom_version ||
>> +	    rver->patch_version <=3D ver->patch_version) {
>> +		BT_ERR("%s: rampatch file version did not match with firmware",
>> +		       hdev->name);
>> +		err =3D -EINVAL;
>> +		goto done;
>> +	}
>> +
>> +	err =3D btusb_setup_qca_download_fw(hdev, fw, info->rampatch_hdr);
>> +
>> +done:
>> +	release_firmware(fw);
>> +
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>> +				    struct qca_version *ver,
>> +				    const struct qca_device_info *info) {
>> +	const struct firmware *fw;
>> +	char fwname[64];
>> +	int err;
>> +
>> +	snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
>> +		 le32_to_cpu(ver->rom_version));
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
>> +	err =3D btusb_setup_qca_download_fw(hdev, fw, info->nvm_hdr);
>> +
>> +	release_firmware(fw);
>> +
>> +	return err;
>> +}
>> +
>> +static int btusb_setup_qca(struct hci_dev *hdev) {
>> +	const struct qca_device_info *info =3D NULL;
>> +	struct qca_version ver;
>> +	u8 status;
>> +	int i, err;
>> +
>> +	err =3D btusb_qca_send_vendor_req(hdev, QCA_GET_TARGET_VERSION, &ver,
>> +				        sizeof(ver));
>> +	if (err < 0)
>> +		return err;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(qca_devices_table); i++) {
>> +		if (ver.rom_version =3D=3D qca_devices_table[i].rom_version)
>> +			info =3D &qca_devices_table[i];
>> +	}
>> +	if (!info) {
>> +		BT_ERR("%s: don't support firmware rome 0x%x", hdev->name,
>> +		       le32_to_cpu(ver.rom_version));
>> +		return -ENODEV;
>> +	}
>> +
>> +	err =3D btusb_qca_send_vendor_req(hdev, QCA_CHECK_STATUS, &status,
>> +					sizeof(status));
>> +	if (err < 0)
>> +		return err;
>> +
>> +	if (!(status & QCA_PATCH_UPDATED)) {
>> +		err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>> +	if (!(status & QCA_SYSCFG_UPDATED)) {
>> +		err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> static int btusb_probe(struct usb_interface *intf,
>> 		       const struct usb_device_id *id) { @@ -2730,6 +2976,11 @@=20
>> static int btusb_probe(struct usb_interface *intf,
>> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>> 	}
>>=20
>> +	if (id->driver_info & BTUSB_QCA_ROME) {
>> +		hdev->setup =3D btusb_setup_qca;
>> +		hdev->set_bdaddr =3D btusb_set_bdaddr_ath3012;
>> +	}
>> +
>=20
> patch looks fine, but I just realized that using hdev->setup is actually =
misusing that callback. We introduced that callback for drivers that have t=
o send HCI commands before the generic stack can take over. This means actu=
ally that the HCI transport is set up and fully operational.
>=20
> If you hardware is not even providing a functional HCI transport after US=
B enumeration, then it should not actually declare Bluetooth Class descript=
ors in the first place. However it seems you do:
>=20
> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 16 Spd=3D12   =
MxCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0cf3 ProdID=3De300 Rev=3D 0.01
>=20
> So why again, can we not use HCI commands to actually load the patches an=
d NVM entries? I seem to be failing to still get this. And why are we doing=
 this when the HCI transport is already running. When hdev->setup is execut=
ed, we have Interrupt and Bulk URBs in flight to handle data reception. Tha=
t seems not like a smart thing to do. So the HCI transport has Bulk URBs fo=
r IN endpoint pending and you start sending Bulk traffic to the OUT endpoin=
t. This seems pretty dangerous to me.
>=20
> The control endpoint has to some degree a built in multiplexing capabilit=
y and I can see that this is acceptable, but the bulk endpoints don't have =
that. It is pure data. And it is suppose to be ACL data.
>=20
> Do you have a bit more background on how your chips work since I am not c=
onvinced we are executing this patching and NVM loading at the right time. =
All the other manufacturers are using HCI in one shape or another, but it i=
s still HCI. This is something different and I am afraid that hdev->setup i=
s not the right trigger for this.
>=20

While USB patching method is coming from HW team, I had checked with them. =
They said main reason is we have experienced some of USB host has some IOT =
issues with ours so that we shouldn't wait until HCI layer is ready. Most o=
f trial was okay for using HCI VS path but it was not 100% successful at th=
e early stage. Another reason we have to use USB patching VS command is tha=
t we have changed USB patch file format comparing with UART patch file. The=
 USB patch file is exactly fitting to go down through USB path because our =
HCI VS requires to add header binaries for every packets but USB patch file=
 does not have every header binaries inside. Our UART patch is going to dow=
n HCI VS path and USB patch file should be downloading to USB VS path for R=
OME chipset. =20

> Regards
>=20
> Marcel

I think there is no other option to setup patching & NVM files except using=
 USB channel on ROME. If you have some concern to use hdev->setup, is it ok=
ay to move to probe function? Please let me know your recommendation to mov=
ing forward.

Thanks
- Ben Kim
