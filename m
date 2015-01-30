Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add support for QCA ROME chipset family
Date: Fri, 30 Jan 2015 04:22:57 +0000
Message-ID: <15E046BB-8877-40F7-8AE4-C5F3676BECAF@qca.qualcomm.com>
References: <27c299b26b2c489aa7d8ad1114a10a2e@nalasexr02e.na.qualcomm.com>
 <D064A6CA-D4B6-4FA2-BC81-0BC6A8C5CDAC@holtmann.org>
In-Reply-To: <D064A6CA-D4B6-4FA2-BC81-0BC6A8C5CDAC@holtmann.org>
Content-Type: multipart/alternative;
	boundary="_000_15E046BB887740F78AE4C5F3676BECAFqcaqualcommcom_"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--_000_15E046BB887740F78AE4C5F3676BECAFqcaqualcommcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Jan 29, 2015, at 5:50 PM, Marcel Holtmann <marcel@holtmann.org<mailto:ma=
rcel@holtmann.org>> wrote:

Hi Ben,

This patch supports ROME Bluetooth family from Qualcomm Atheros,
e.g. QCA61x4 or QCA6574.

New chipset have similar firmware downloading sequences to previous
chipset from Atheros, however, it doesn't support vid/pid switching
after downloading the patch so that firmware needs to be handled by
btusb module directly.

please always include the content from /sys/kernel/debug/usb/devices for yo=
ur devices. I want to have them recorded in the commit messages.

With that in mind it might be actually beneficial to add first one module a=
nd then extend it to the second one. That would keep in clean in the histor=
y.

Sure, I=92ll do that


ROME chipset can be differentiated from previous version by reading
ROM version.

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com<mailto:ytkim@qca.q=
ualcomm.com>>
---
drivers/bluetooth/btusb.c | 266 +++++++++++++++++++++++++++++++++++++++++++=
+++
1 file changed, 266 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -52,6 +52,7 @@ static struct usb_driver btusb_driver;
#define BTUSB_SWAVE 0x1000
#define BTUSB_INTEL_NEW 0x2000
#define BTUSB_AMP 0x4000
+#define BTUSB_QCA_ROME 0x8000

static const struct usb_device_id btusb_table[] =3D {
/* Generic Bluetooth USB device */
@@ -208,6 +209,9 @@ static const struct usb_device_id blacklist_table[] =3D=
 {
{ USB_DEVICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },
{ USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },

+ /* QCA ROME chipset */
+ { USB_DEVICE(0x0cf3, 0xe300), .driver_info =3D BTUSB_QCA_ROME},
+
/* Broadcom BCM2035 */
{ USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
{ USB_DEVICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },
@@ -2585,6 +2589,249 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev =
*hdev,
return 0;
}

+#define QCA_DFU_PACKET_LEN 4096
+
+#define QCA_GET_TARGET_VERSION 0x09
+#define QCA_CHECK_STATUS 0x05
+#define QCA_DFU_DOWNLOAD 0x01
+
+#define QCA_PATCH_UPDATE 0xA0
+#define QCA_SYSCFG_UPDATE 0x60
+#define QCA_PATCH_SYSCFG_UPDATE (QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)
+#define QCA_DFU_TIMEOUT 3000
+
+struct qca_version {
+ u32 rom_version;
+ u32 patch_version;
+ u32 ram_version;
+ u32 ref_clock;
+ u8 reserved[4];

Use __le32 or __be32.

+} __packed;
+
+struct qca_rampatch_version {
+ u16 rom_version;
+ u16 patch_version;

Same here. Proper endian.

+} __packed;
+
+struct qca_device_info {
+ u32 rom_version;
+ u8 rampatch_hdr; /* length of header in rampatch */
+ u8 nvm_hdr; /* length of header in NVM */
+ u8 ver_offset; /* offset of version structure in rampatch */

And here as well. Use the right endian aware type.

+};
+
+static const struct qca_device_info qca_devices_table[] =3D {
+ { 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
+ { 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
+ { 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
+ { 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
+ { 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
+};
+
+static const struct qca_device_info *btusb_qca_find_device(struct qca_vers=
ion *ver)
+{
+ size_t i;
+
+ for (i =3D 0; i < ARRAY_SIZE(qca_devices_table); i++)

For simpler readability use { } for this loop.

+ if (ver->rom_version =3D=3D qca_devices_table[i].rom_version)
+ return &qca_devices_table[i];
+
+ return NULL;
+}
+
+static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
+      void *data, u16 size)
+{
+ u8 *buf;
+ int pipe, ret;
+
+ buf =3D kmalloc(size, GFP_KERNEL);
+ if (!buf)
+ return -ENOMEM;
+
+ pipe =3D usb_rcvctrlpipe(udev, 0);
+ ret =3D usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN=
,
+       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
+

Why are these done via control endpoint transfers and not just HCI commands=
. What is so special here. Would be nice if we had some comments explaining=
 how this is actually suppose to work.

We can access those informations from OTA(one time programming) memory area=
. At early stage, it may not be possible to access OTP area from HCI Vendor=
 Specific command path. That=92s reason why we=92re using USB endpoint tran=
sfers at this stage. I=92ll put some explanation about it.


+ memcpy(data, buf, size);
+ kfree(buf);
+
+ return ret;
+}
+
+static int btusb_setup_qca_download_fw(struct usb_device *udev,
+        const struct firmware *firmware,
+        size_t hdr_size)
+{
+ u8 *buf;
+ size_t count, size, sent =3D 0;
+ int pipe, len, err =3D 0;

err =3D 0 assignment only when really needed.

+
+ buf =3D kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);
+ if (!buf)
+ return -ENOMEM;
+
+ count =3D firmware->size;
+
+ size =3D min_t(size_t, count, hdr_size);
+ memcpy(buf, firmware->data, size);
+
+ pipe =3D usb_sndctrlpipe(udev, 0);
+ err =3D usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,
+       0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
+ if (err < 0)
+ goto done;
+
+ sent +=3D size;
+ count -=3D size;

This needs some proper comments explaining what is going on here. I am pret=
ty much confused why the first packet is send over control endpoint and the=
 rest over bulk endpoint.

Patch data is made up TLV format (Tag - Length - Value) so that header data=
 should be transferring through control endpoint first and sending body dat=
a over bulk endpoint. I=92ll put some comments as well.


+
+ while (count) {
+ size =3D min_t(size_t, count, QCA_DFU_PACKET_LEN);
+
+ memcpy(buf, firmware->data + sent, size);
+
+ pipe =3D usb_sndbulkpipe(udev, 0x02);
+ err =3D usb_bulk_msg(udev, pipe, buf, size, &len,
+    QCA_DFU_TIMEOUT);
+ if (err)
+ goto done;

if (err < 0)
break;

+
+ if (size !=3D len) {
+ err =3D -EIO;
+ goto done;

err =3D -EILSEQ;
break;

+ }
+
+ sent  +=3D size;
+ count -=3D size;
+ }
+
+done:
+ if (err)
+ BT_ERR("firmware download failed at %zd of %zd (%d)",
+        sent, firmware->size, err);
+
+ kfree(buf);
+ return err;
+}
+
+static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
+  struct qca_version *ver,
+  const struct qca_device_info *info)
+{
+ struct btusb_data *data;
+ struct qca_rampatch_version *rver;
+ const struct firmware *fw;
+ char fwname[64];
+ int err;
+
+ snprintf(fwname, sizeof(fwname), "qca/rampatch_tlv_usb_%08x.tlv",
+  ver->rom_version);

Why is this *_tlv_*.tlv. That seems pretty much repetitive.

Agree with you. I=92ll change it from *.tlv to *.bin file.


+
+ err =3D request_firmware(&fw, fwname, &hdev->dev);
+ if (err) {
+ BT_ERR("%s: failed to request rampatch file: %s (%d)",
+        hdev->name, fwname, err);
+ return err;
+ }
+
+ BT_INFO("%s: using rampatch file: %s", hdev->name, fwname);
+ rver =3D (struct qca_rampatch_version *) &fw->data[info->ver_offset];

(fw->data + info->ver_offset)

+ BT_INFO("%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x "
+ "build 0x%x", hdev->name, rver->rom_version,
+ rver->patch_version, ver->rom_version, ver->patch_version);

Endian conversion missing.

+
+ if (rver->rom_version !=3D ver->rom_version ||
+ rver->patch_version <=3D ver->patch_version) {

Wrong indentation.

+ BT_ERR("rampatch file version did not match with firmware");
+ return -EINVAL;
+ }
+
+ data =3D hci_get_drvdata(hdev);

I rather see this assignment done with the declaration of the variable.

+
+ err =3D btusb_setup_qca_download_fw(data->udev, fw, info->rampatch_hdr);
+
+ release_firmware(fw);
+
+ return err;
+}
+
+static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
+     struct qca_version *ver,
+     const struct qca_device_info *info)
+{
+ struct btusb_data *data;
+ const struct firmware *fw;
+ char fwname[64];
+ int err;
+
+ snprintf(fwname, sizeof(fwname), "qca/nvm_tlv_usb_%08x.bin",
+  ver->rom_version);

Why do we have the _tlv_ in the filename?

As mentioned above, TLV means Tag-Length-Value. NVM config / RAM patch file=
s are made up with TLV format.


+
+ err =3D request_firmware(&fw, fwname, &hdev->dev);
+ if (err) {
+ BT_ERR("%s: failed to request NVM file: %s (%d)",
+        hdev->name, fwname, err);
+ return err;
+ }
+
+ BT_INFO("%s: using NVM file: %s", hdev->name, fwname);
+
+ data =3D hci_get_drvdata(hdev);

Should be assigned at the same time as variable declaration.

Agree with you.


+
+ err =3D btusb_setup_qca_download_fw(data->udev, fw, info->nvm_hdr);
+
+ release_firmware(fw);
+
+ return err;
+}
+
+static int btusb_setup_qca(struct hci_dev *hdev)
+{
+ struct btusb_data *data;
+ struct qca_version ver;
+ u8 status;
+ const struct qca_device_info *info;
+ int err;
+
+ data =3D hci_get_drvdata(hdev);

Assignment during variable declaration.

+
+ err =3D btusb_qca_send_vendor_req(data->udev, QCA_GET_TARGET_VERSION,
+ &ver, sizeof(ver));
+ if (err < 0)
+ goto done;
+
+ info =3D btusb_qca_find_device(&ver);
+ if (!info) {
+ err =3D -ENODEV;
+ goto done;
+ }

Looks like we are doing this twice.

+
+ err =3D btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
+ &status, sizeof(status));
+ if (err < 0)
+ goto done;
+
+ if ((status !=3D QCA_PATCH_UPDATE) || (status !=3D QCA_PATCH_SYSCFG_UPDAT=
E)) {

The extra ( ) are not needed.

+ err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
+ if (err < 0)
+ goto done;
+ }
+
+ err =3D btusb_qca_send_vendor_req(data->udev, QCA_CHECK_STATUS,
+ &status, sizeof(status));

So why are you checking the status twice here. If you do not load the ram p=
atch, then the value will also not change.

You=92re right. It is sufficient to call this one-time.


+ if (err < 0)
+ goto done;
+
+ if ((status !=3D QCA_SYSCFG_UPDATE) || (status !=3D QCA_PATCH_SYSCFG_UPDA=
TE)) {

The extra ( ) are not needed.

+ err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
+ if (err < 0)
+ goto done;
+ }

In general I find this function hard to read and understand. Since status i=
s an enum, why not use a switch statement.

The way I read it this like this:

case QCA_PATCH_UPDATE:
load_rampatch();
break;

case QCA_PATCH_SYSCFG_UPDATE:
load_rampatch();
load_nvm();
break;

case QCA_SYSCFG_UPDATE:
load_nvm();
break;

However now checking in more detail, this is actually not an enum. So this =
is what you actually want:

if (status & QCA_PATCH_UPDATE)
load_rampatch();

if (status & QCA_SYSCFG_UPDATE)
load_nvm();

And re-reading the status in between in pretty pointless. Either it succeed=
s or it fails. If it fails, then it fails and we should just abort hdev->se=
tup.

Agree with you.


+
+done:
+ return err;
+}
+
static int btusb_probe(struct usb_interface *intf,
       const struct usb_device_id *id)
{
@@ -2619,6 +2866,20 @@ static int btusb_probe(struct usb_interface *intf,
return -ENODEV;
}

+ if (id->driver_info & BTUSB_QCA_ROME) {
+ struct usb_device *udev =3D interface_to_usbdev(intf);
+ struct qca_version ver;
+
+ err =3D btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION,
+ &ver, sizeof(ver));
+ if (err < 0)
+ return err;

I am not in favor of sending a blocking USB request during probe. Do we rea=
lly need this. Can that not be done during hdev->setup call.

Also we are clearly duplicating this command.

You=92re right. It is duplicated. I=92ll remove those portion of codes in p=
robe.


+
+ if (!btusb_qca_find_device(&ver)) {
+ return -ENODEV;
+ }

Single line bodies without { }.

+ }
+
data =3D devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
if (!data)
return -ENOMEM;
@@ -2736,6 +2997,11 @@ static int btusb_probe(struct usb_interface *intf,
set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
}

+ if (id->driver_info & BTUSB_QCA_ROME) {
+ hdev->set_bdaddr =3D btusb_set_bdaddr_ath3012;
+ hdev->setup =3D btusb_setup_qca;

The other way around ->setup before ->set_bdaddr.

And the it needs to be guaranteed that the btusb_set_bdaddr_ath3012 for the=
se chipset is also temporary. A power cycle needs to bring it back to its o=
riginal address.

You=92re right. After power recycling, it has a default bdaddr which is com=
ing from OTP area first. If OTP does not contain bd address then pick it up=
 from nvm_tlv_usb.bin.


+ }
+
if (id->driver_info & BTUSB_AMP) {
/* AMP controllers do not support SCO packets */
data->isoc =3D NULL;

Regards

Marcel

Thanks for all your review & feedback. I=92ll regenerate patch file soon an=
d send it to mailing-list.

Thanks
Ben Kim

--_000_15E046BB887740F78AE4C5F3676BECAFqcaqualcommcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <F5010D4D6947504B81EB64DE8A6D6C66@qualcomm.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;">
Hi Marcel,
<div><br>
<div>
<div>On Jan 29, 2015, at 5:50 PM, Marcel Holtmann &lt;<a href=3D"mailto:mar=
cel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</div>
<br class=3D"Apple-interchange-newline">
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
Hi Ben,<br>
<br>
<blockquote type=3D"cite">This patch supports ROME Bluetooth family from Qu=
alcomm Atheros,<br>
e.g. QCA61x4 or QCA6574.<br>
<br>
New chipset have similar firmware downloading sequences to previous<br>
chipset from Atheros, however, it doesn't support vid/pid switching<br>
after downloading the patch so that firmware needs to be handled by<br>
btusb module directly.<br>
</blockquote>
<br>
please always include the content from /sys/kernel/debug/usb/devices for yo=
ur devices. I want to have them recorded in the commit messages.<br>
<br>
With that in mind it might be actually beneficial to add first one module a=
nd then extend it to the second one. That would keep in clean in the histor=
y.<br>
</div>
</blockquote>
<div><br>
</div>
Sure, I=92ll do that</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">ROME chipset can be differentiated from previous =
version by reading<br>
ROM version.<br>
<br>
Signed-off-by: Ben Young Tae Kim &lt;<a href=3D"mailto:ytkim@qca.qualcomm.c=
om">ytkim@qca.qualcomm.com</a>&gt;<br>
---<br>
drivers/bluetooth/btusb.c | 266 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
1 file changed, 266 insertions(&#43;)<br>
<br>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
--- a/drivers/bluetooth/btusb.c<br>
&#43;&#43;&#43; b/drivers/bluetooth/btusb.c<br>
@@ -52,6 &#43;52,7 @@ static struct usb_driver btusb_driver;<br>
#define BTUSB_SWAVE<span class=3D"Apple-tab-span" style=3D"white-space: pre=
;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>0x1000<br=
>
#define BTUSB_INTEL_NEW<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>0x2000<br=
>
#define BTUSB_AMP<span class=3D"Apple-tab-span" style=3D"white-space: pre;"=
> </span><span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>=
0x4000<br>
&#43;#define BTUSB_QCA_ROME<span class=3D"Apple-tab-span" style=3D"white-sp=
ace: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>0x8000<br=
>
<br>
static const struct usb_device_id btusb_table[] =3D {<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>/* Generi=
c Bluetooth USB device */<br>
@@ -208,6 &#43;209,9 @@ static const struct usb_device_id blacklist_table[]=
 =3D {<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>{ USB_DEV=
ICE(0x0489, 0xe036), .driver_info =3D BTUSB_ATH3012 },<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>{ USB_DEV=
ICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },<br>
<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>/* =
QCA ROME chipset */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ U=
SB_DEVICE(0x0cf3, 0xe300), .driver_info =3D BTUSB_QCA_ROME},<br>
&#43;<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>/* Broadc=
om BCM2035 */<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>{ USB_DEV=
ICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>{ USB_DEV=
ICE(0x0a5c, 0x200a), .driver_info =3D BTUSB_WRONG_SCO_MTU },<br>
@@ -2585,6 &#43;2589,249 @@ static int btusb_set_bdaddr_ath3012(struct hci_=
dev *hdev,<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return 0;=
<br>
}<br>
<br>
&#43;#define QCA_DFU_PACKET_LEN<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;">
</span>4096<br>
&#43;<br>
&#43;#define QCA_GET_TARGET_VERSION<span class=3D"Apple-tab-span" style=3D"=
white-space: pre;">
</span>0x09<br>
&#43;#define QCA_CHECK_STATUS<span class=3D"Apple-tab-span" style=3D"white-=
space: pre;"> </span>
0x05<br>
&#43;#define QCA_DFU_DOWNLOAD<span class=3D"Apple-tab-span" style=3D"white-=
space: pre;"> </span>
0x01<br>
&#43;<br>
&#43;#define QCA_PATCH_UPDATE<span class=3D"Apple-tab-span" style=3D"white-=
space: pre;"> </span>
0xA0<br>
&#43;#define QCA_SYSCFG_UPDATE<span class=3D"Apple-tab-span" style=3D"white=
-space: pre;">
</span>0x60<br>
&#43;#define QCA_PATCH_SYSCFG_UPDATE<span class=3D"Apple-tab-span" style=3D=
"white-space: pre;">
</span>(QCA_PATCH_UPDATE | QCA_SYSCFG_UPDATE)<br>
&#43;#define QCA_DFU_TIMEOUT<span class=3D"Apple-tab-span" style=3D"white-s=
pace: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>3000<br>
&#43;<br>
&#43;struct qca_version {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u32=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>rom_version;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u32=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>patch_version;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u32=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>ram_version;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u32=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>ref_clock;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8<=
span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>reserved[4];<br>
</blockquote>
<br>
Use __le32 or __be32.<br>
<br>
<blockquote type=3D"cite">&#43;} __packed;<br>
&#43;<br>
&#43;struct qca_rampatch_version {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u16=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>rom_version;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u16=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>patch_version;<br>
</blockquote>
<br>
Same here. Proper endian.<br>
<br>
<blockquote type=3D"cite">&#43;} __packed;<br>
&#43;<br>
&#43;struct qca_device_info {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u32=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>rom_version;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8<=
span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>rampatch_hdr;<span class=3D"Apple-tab-span" style=3D"white-space: pr=
e;"> </span>
/* length of header in rampatch */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8<=
span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>nvm_hdr;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> =
</span>/* length of header in NVM */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8<=
span class=3D"Apple-tab-span" style=3D"white-space: pre;">
</span>ver_offset;<span class=3D"Apple-tab-span" style=3D"white-space: pre;=
"> </span>
/* offset of version structure in rampatch */<br>
</blockquote>
<br>
And here as well. Use the right endian aware type.<br>
<br>
<blockquote type=3D"cite">&#43;};<br>
&#43;<br>
&#43;static const struct qca_device_info qca_devices_table[] =3D {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ 0=
x00000100, 20, 4, 10 }, /* Rome 1.0 */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ 0=
x00000101, 20, 4, 10 }, /* Rome 1.1 */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ 0=
x00000201, 28, 4, 18 }, /* Rome 2.1 */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ 0=
x00000300, 28, 4, 18 }, /* Rome 3.0 */<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>{ 0=
x00000302, 28, 4, 18 }, /* Rome 3.2 */<br>
&#43;};<br>
&#43;<br>
&#43;static const struct qca_device_info *btusb_qca_find_device(struct qca_=
version *ver)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>siz=
e_t i;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>for=
 (i =3D 0; i &lt; ARRAY_SIZE(qca_devices_table); i&#43;&#43;)<br>
</blockquote>
<br>
For simpler readability use { } for this loop.<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (ver-&=
gt;rom_version =3D=3D qca_devices_table[i].rom_version)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return &amp;qca_devi=
ces_table[i];<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn NULL;<br>
&#43;}<br>
&#43;<br>
&#43;static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 reque=
st,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;void
 *data, u16 size)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8 =
*buf;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int=
 pipe, ret;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>buf=
 =3D kmalloc(size, GFP_KERNEL);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(!buf)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return -ENOM=
EM;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>pip=
e =3D usb_rcvctrlpipe(udev, 0);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
 =3D usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0, 0, buf, siz=
e, USB_CTRL_SET_TIMEOUT);<br>
&#43;<br>
</blockquote>
<br>
Why are these done via control endpoint transfers and not just HCI commands=
. What is so special here. Would be nice if we had some comments explaining=
 how this is actually suppose to work.<br>
</div>
</blockquote>
<div><br>
</div>
We can access those informations from OTA(one time programming) memory area=
. At early stage, it may not be possible to access OTP area from HCI Vendor=
 Specific command path. That=92s reason why we=92re using USB endpoint tran=
sfers at this stage. I=92ll put some explanation
 about it.</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
memcpy(data, buf, size);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>kfr=
ee(buf);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int btusb_setup_qca_download_fw(struct usb_device *udev,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const
 struct firmware *firmware,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;size_t
 hdr_size)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8 =
*buf;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>siz=
e_t count, size, sent =3D 0;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int=
 pipe, len, err =3D 0;<br>
</blockquote>
<br>
err =3D 0 assignment only when really needed.<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>buf=
 =3D kmalloc(QCA_DFU_PACKET_LEN, GFP_KERNEL);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(!buf)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return -ENOM=
EM;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>cou=
nt =3D firmware-&gt;size;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>siz=
e =3D min_t(size_t, count, hdr_size);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>mem=
cpy(buf, firmware-&gt;data, size);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>pip=
e =3D usb_sndctrlpipe(udev, 0);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D usb_control_msg(udev, pipe, QCA_DFU_DOWNLOAD, USB_TYPE_VENDOR,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0, 0, buf, siz=
e, USB_CTRL_SET_TIMEOUT);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err &lt; 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>sen=
t &#43;=3D size;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>cou=
nt -=3D size;<br>
</blockquote>
<br>
This needs some proper comments explaining what is going on here. I am pret=
ty much confused why the first packet is send over control endpoint and the=
 rest over bulk endpoint.<br>
</div>
</blockquote>
<div><br>
</div>
Patch data is made up TLV format (Tag - Length - Value) so that header data=
 should be transferring through control endpoint first and sending body dat=
a over bulk endpoint. I=92ll put some comments as well.</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>whi=
le (count) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>size =3D min=
_t(size_t, count, QCA_DFU_PACKET_LEN);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>memcpy(buf, =
firmware-&gt;data &#43; sent, size);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>pipe =3D usb=
_sndbulkpipe(udev, 0x02);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D usb_=
bulk_msg(udev, pipe, buf, size, &amp;len,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;QCA_DFU_TIMEOUT);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (err)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<br>
</blockquote>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (err &=
lt; 0)<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>break;<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (size !=
=3D len) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D -EIO;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<br>
</blockquote>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"App=
le-tab-span" style=3D"white-space: pre;"></span>err =3D -EILSEQ;<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"App=
le-tab-span" style=3D"white-space: pre;"></span>break;<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>}<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>sent &nbsp;&=
#43;=3D size;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>count -=3D s=
ize;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
&#43;<br>
&#43;done:<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>BT_ERR(&quot=
;firmware download failed at %zd of %zd (%d)&quot;,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;sent, firmware-&gt;size, err);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>kfr=
ee(buf);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn err;<br>
&#43;}<br>
&#43;<br>
&#43;static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span><span class=3D"Apple-converted-space">=
&nbsp;</span>struct
 qca_version *ver,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span><span class=3D"Apple-converted-space">=
&nbsp;</span>const
 struct qca_device_info *info)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>str=
uct btusb_data *data;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>str=
uct qca_rampatch_version *rver;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>con=
st struct firmware *fw;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>cha=
r fwname[64];<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int=
 err;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>snp=
rintf(fwname, sizeof(fwname), &quot;qca/rampatch_tlv_usb_%08x.tlv&quot;,<br=
>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>ver-&gt;rom_version);<br>
</blockquote>
<br>
Why is this *_tlv_*.tlv. That seems pretty much repetitive.<br>
</div>
</blockquote>
<div><br>
</div>
Agree with you. I=92ll change it from *.tlv to *.bin file.</div>
<div><br>
</div>
<div>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D request_firmware(&amp;fw, fwname, &amp;hdev-&gt;dev);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>BT_ERR(&quot=
;%s: failed to request rampatch file: %s (%d)&quot;,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;hdev-&gt;name, fwname, err);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return err;<=
br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>BT_=
INFO(&quot;%s: using rampatch file: %s&quot;, hdev-&gt;name, fwname);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>rve=
r =3D (struct qca_rampatch_version *) &amp;fw-&gt;data[info-&gt;ver_offset]=
;<br>
</blockquote>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"App=
le-tab-span" style=3D"white-space: pre;"></span>(fw-&gt;data &#43; info-&gt=
;ver_offset)<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
BT_INFO(&quot;%s: QCA: patch rome 0x%x build 0x%x, firmware rome 0x%x &quot=
;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>&quot;build =
0x%x&quot;, hdev-&gt;name, rver-&gt;rom_version,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>rver-&gt;pat=
ch_version, ver-&gt;rom_version, ver-&gt;patch_version);<br>
</blockquote>
<br>
Endian conversion missing.<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(rver-&gt;rom_version !=3D ver-&gt;rom_version ||<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span>rver-&gt;patch_version
 &lt;=3D ver-&gt;patch_version) {<br>
</blockquote>
<br>
Wrong indentation.<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>BT_ERR(&q=
uot;rampatch file version did not match with firmware&quot;);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return -EINV=
AL;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>dat=
a =3D hci_get_drvdata(hdev);<br>
</blockquote>
<br>
I rather see this assignment done with the declaration of the variable.<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D btusb_setup_qca_download_fw(data-&gt;udev, fw, info-&gt;rampatch_hdr);=
<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>rel=
ease_firmware(fw);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn err;<br>
&#43;}<br>
&#43;<br>
&#43;static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;struct
 qca_version *ver,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-converte=
d-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;const
 struct qca_device_info *info)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>str=
uct btusb_data *data;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>con=
st struct firmware *fw;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>cha=
r fwname[64];<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int=
 err;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>snp=
rintf(fwname, sizeof(fwname), &quot;qca/nvm_tlv_usb_%08x.bin&quot;,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>ver-&gt;rom_version);<br>
</blockquote>
<br>
Why do we have the _tlv_ in the filename?<br>
</div>
</blockquote>
<div><br>
</div>
As mentioned above, TLV means Tag-Length-Value. NVM config / RAM patch file=
s are made up with TLV format.</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D request_firmware(&amp;fw, fwname, &amp;hdev-&gt;dev);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>BT_ERR(&quot=
;%s: failed to request NVM file: %s (%d)&quot;,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;hdev-&gt;name, fwname, err);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return err;<=
br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>BT_=
INFO(&quot;%s: using NVM file: %s&quot;, hdev-&gt;name, fwname);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>dat=
a =3D hci_get_drvdata(hdev);<br>
</blockquote>
<br>
Should be assigned at the same time as variable declaration.<br>
</div>
</blockquote>
<div><br>
</div>
Agree with you.&nbsp;</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D btusb_setup_qca_download_fw(data-&gt;udev, fw, info-&gt;nvm_hdr);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>rel=
ease_firmware(fw);<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn err;<br>
&#43;}<br>
&#43;<br>
&#43;static int btusb_setup_qca(struct hci_dev *hdev)<br>
&#43;{<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>str=
uct btusb_data *data;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>str=
uct qca_version ver;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>u8 =
status;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>con=
st struct qca_device_info *info;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>int=
 err;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>dat=
a =3D hci_get_drvdata(hdev);<br>
</blockquote>
<br>
Assignment during variable declaration.<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D btusb_qca_send_vendor_req(data-&gt;udev, QCA_GET_TARGET_VERSION,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span>&amp;ver,
 sizeof(ver));<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err &lt; 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>inf=
o =3D btusb_qca_find_device(&amp;ver);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(!info) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D -ENO=
DEV;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<b=
r>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
</blockquote>
<br>
Looks like we are doing this twice.<br>
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D btusb_qca_send_vendor_req(data-&gt;udev, QCA_CHECK_STATUS,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span>&amp;status,
 sizeof(status));<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(err &lt; 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
((status !=3D QCA_PATCH_UPDATE) || (status !=3D QCA_PATCH_SYSCFG_UPDATE)) {=
<br>
</blockquote>
<br>
The extra ( ) are not needed.<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D b=
tusb_setup_qca_load_rampatch(hdev, &amp;ver, info);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (err &lt;=
 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>err=
 =3D btusb_qca_send_vendor_req(data-&gt;udev, QCA_CHECK_STATUS,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span>&amp;status,
 sizeof(status));<br>
</blockquote>
<br>
So why are you checking the status twice here. If you do not load the ram p=
atch, then the value will also not change.<br>
</div>
</blockquote>
<div><br>
</div>
You=92re right. It is sufficient to call this one-time.</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
if (err &lt; 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<b=
r>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
((status !=3D QCA_SYSCFG_UPDATE) || (status !=3D QCA_PATCH_SYSCFG_UPDATE)) =
{<br>
</blockquote>
<br>
The extra ( ) are not needed.<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D b=
tusb_setup_qca_load_nvm(hdev, &amp;ver, info);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (err &lt;=
 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>goto done;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>}<b=
r>
</blockquote>
<br>
In general I find this function hard to read and understand. Since status i=
s an enum, why not use a switch statement.<br>
<br>
The way I read it this like this:<br>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>case QCA_=
PATCH_UPDATE:<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_rampatch();<b=
r>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>break;<br>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>case QCA_=
PATCH_SYSCFG_UPDATE:<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_rampatch();<b=
r>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_nvm();<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>break;<br>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>case QCA_=
SYSCFG_UPDATE:<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_nvm();<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>break;<br>
<br>
However now checking in more detail, this is actually not an enum. So this =
is what you actually want:<br>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (statu=
s &amp; QCA_PATCH_UPDATE)<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_rampatch();<b=
r>
<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (statu=
s &amp; QCA_SYSCFG_UPDATE)<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>load_nvm();<br>
<br>
And re-reading the status in between in pretty pointless. Either it succeed=
s or it fails. If it fails, then it fails and we should just abort hdev-&gt=
;setup.<br>
</div>
</blockquote>
<div><br>
</div>
Agree with you.</div>
<div><br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;done:<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>ret=
urn err;<br>
&#43;}<br>
&#43;<br>
static int btusb_probe(struct usb_interface *intf,<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"App=
le-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const =
struct usb_device_id *id)<br>
{<br>
@@ -2619,6 &#43;2866,20 @@ static int btusb_probe(struct usb_interface *int=
f,<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"App=
le-tab-span" style=3D"white-space: pre;"></span>return -ENODEV;<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>}<br>
<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(id-&gt;driver_info &amp; BTUSB_QCA_ROME) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>struct usb_d=
evice *udev =3D interface_to_usbdev(intf);<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>struct qca_v=
ersion ver;<br>
&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>err =3D btus=
b_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION,<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple=
-tab-span" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span=
" style=3D"white-space: pre;"></span><span class=3D"Apple-tab-span" style=
=3D"white-space: pre;"></span>&amp;ver,
 sizeof(ver));<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (err &lt;=
 0)<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return err;<br>
</blockquote>
<br>
I am not in favor of sending a blocking USB request during probe. Do we rea=
lly need this. Can that not be done during hdev-&gt;setup call.<br>
<br>
Also we are clearly duplicating this command.<br>
</div>
</blockquote>
<div><br>
</div>
You=92re right. It is duplicated. I=92ll remove those portion of codes in p=
robe.</div>
<div>&nbsp;<br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (!btusb_q=
ca_find_device(&amp;ver)) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span class=
=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return -ENODEV;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>}<br>
</blockquote>
<br>
Single line bodies without { }.<br>
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
}<br>
&#43;<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>data =3D =
devm_kzalloc(&amp;intf-&gt;dev, sizeof(*data), GFP_KERNEL);<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (!data=
)<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>return -ENOMEM;<br=
>
@@ -2736,6 &#43;2997,11 @@ static int btusb_probe(struct usb_interface *int=
f,<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>set_bit(HCI_QUIRK_=
STRICT_DUPLICATE_FILTER, &amp;hdev-&gt;quirks);<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>}<br>
<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if =
(id-&gt;driver_info &amp; BTUSB_QCA_ROME) {<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>hdev-&gt;set=
_bdaddr =3D btusb_set_bdaddr_ath3012;<br>
&#43;<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><sp=
an class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>hdev-&gt;set=
up =3D btusb_setup_qca;<br>
</blockquote>
<br>
The other way around -&gt;setup before -&gt;set_bdaddr.<br>
<br>
And the it needs to be guaranteed that the btusb_set_bdaddr_ath3012 for the=
se chipset is also temporary. A power cycle needs to bring it back to its o=
riginal address.<br>
</div>
</blockquote>
<div><br>
</div>
You=92re right. After power recycling, it has a default bdaddr which is com=
ing from OTP area first. If OTP does not contain bd address then pick it up=
 from nvm_tlv_usb.bin.&nbsp;</div>
<div>&nbsp;<br>
<blockquote type=3D"cite">
<div style=3D"font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">
<br>
<blockquote type=3D"cite">&#43;<span class=3D"Apple-tab-span" style=3D"whit=
e-space: pre;"> </span>
}<br>
&#43;<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (id-&g=
t;driver_info &amp; BTUSB_AMP) {<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>/* AMP controllers=
 do not support SCO packets */<br>
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>data-&gt;isoc =3D =
NULL;<br>
</blockquote>
<br>
Regards<br>
<br>
Marcel</div>
</blockquote>
</div>
<br>
</div>
<div>Thanks for all your review &amp; feedback. I=92ll regenerate patch fil=
e soon and send it to mailing-list.</div>
<div><br>
</div>
<div>Thanks</div>
<div>Ben Kim</div>
</body>
</html>

--_000_15E046BB887740F78AE4C5F3676BECAFqcaqualcommcom_--
