Return-Path: <cyrus@holtmann.org>
From: "An, Tedd" <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Hedberg, Johan" <johan.hedberg@intel.com>, "Fry, Don" <don.fry@intel.com>
Subject: RE: [PATCH v2] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Date: Sun, 14 Apr 2013 06:59:45 +0000
Message-ID: <BB52B9B497F0EE4EB05C192A0408F6601FBDAD81@ORSMSX105.amr.corp.intel.com>
References: <9783629.ao7UZkXlOD@tedd-ubuntu>
 <56B55E37-411B-4F5D-AD13-4A2AC83D1244@holtmann.org>
In-Reply-To: <56B55E37-411B-4F5D-AD13-4A2AC83D1244@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel.

> -----Original Message-----
> Hi Tedd,
>=20
> > This patch adds support for Intel Bluetooth device by adding
> > btusb_setup_intel() routine that update the device with ROM patch.
> >
> > This is v2 after running checkpatch script with "strict" option.
>=20
> this comment does not belong here.
>=20
> >
> > T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D00 Cnt=3D01 Dev#=3D  4 Spd=3D12 =
  MxCh=3D 0
> > D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D8087 ProdID=3D07dc Rev=3D 0.01
> > C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb
> > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> >
> > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > ---
>=20
> The v2 changelog should go here. Otherwise git am turns it into the commi=
t
> message.

ACK.

>=20
> > drivers/bluetooth/btusb.c |  333
> > +++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 333 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 3d684d2..c8c816b 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -23,6 +23,7 @@
> >
> > #include <linux/module.h>
> > #include <linux/usb.h>
> > +#include <linux/firmware.h>
>=20
> I just remembered that you most likely need also change the Kconfig to
> depend on the firmware loader support.
>=20
> Actually you do not. You will get an -EINVAL error. Might want to print a=
n
> error in that case. As a general principle, it would be a good idea if bt=
usb.ko
> itself does not depend on the firmware loader.
>=20

Could you explain more about this?
Anyway, this header file is needed to read the firmware patch file (request=
_firmware).

> > #include <net/bluetooth/bluetooth.h>
> > #include <net/bluetooth/hci_core.h>
> > @@ -47,6 +48,7 @@ static struct usb_driver btusb_driver;
> > #define BTUSB_BROKEN_ISOC	0x20
> > #define BTUSB_WRONG_SCO_MTU	0x40
> > #define BTUSB_ATH3012		0x80
> > +#define BTUSB_INTEL		0x100
> >
> > static struct usb_device_id btusb_table[] =3D {
> > 	/* Generic Bluetooth USB device */
> > @@ -207,6 +209,9 @@ static struct usb_device_id blacklist_table[] =3D {
> > 	/* Frontline ComProbe Bluetooth Sniffer */
> > 	{ USB_DEVICE(0x16d3, 0x0002), .driver_info =3D BTUSB_SNIFFER },
> >
> > +	/* Intel Bluetooth device */
> > +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info =3D BTUSB_INTEL },
> > +
> > 	{ }	/* Terminating entry */
> > };
> >
> > @@ -943,6 +948,331 @@ static int btusb_setup_bcm92035(struct hci_dev
> *hdev)
> > 	return 0;
> > }
> >
> > +static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev
> *hdev,
> > +							struct sk_buff *skb,
> > +							int *use_default)
>=20
> > +{
> > +	struct intel_fw_version {
>=20
> Make it intel_version since it is more than just the firmware version.

ACK.

>=20
> > +		u8 hw_platform;
> > +		u8 hw_variant;
> > +		u8 hw_revision;
> > +		u8 fw_variant;
> > +		u8 fw_revision;
> > +		u8 fw_build_num;
> > +		u8 fw_build_ww;
> > +		u8 fw_build_yy;
> > +		u8 fw_patch_num;
> > +	} __packed;
> > +
> > +	struct intel_fw_version	*ver;
> > +	const struct firmware	*fw;
> > +	char			fwname[64];
>=20
> Don't bother aligning these with white spaces. We only do that in structs=
.

ACK.

>=20
> > +
> > +	if (skb->len !=3D sizeof(*ver)) {
> > +		BT_ERR("%s invalid length of Intel firmware version %d",
> > +		       hdev->name, skb->len);
> > +		return NULL;
> > +	}
> > +
> > +	ver =3D (void *)skb->data;
> > +	snprintf(fwname, sizeof(fwname),
> > +		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x-%x.bseq",
> > +		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
> > +		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
> > +		 ver->fw_build_ww, ver->fw_build_yy, ver-
> >fw_patch_num);
> > +	kfree_skb(skb);
>=20
> So I am not so sure that this is what we should be doing for the firmware
> versions.
>=20
> Lets brainstorm this a little bit. My idea is that we check give an easy =
way for
> configuration and firmware handling.
>=20
> I have a few questions with this. Can we have firmware ROM masks with a
> pre-patched version already. Meaning can fw_patch_num be something else
> than 0. If we can not incremental patch anyway, then we should leave that
> part out and not continue here further.

No and Yes. The firmware ROM mask cannot have pre-patched version, which me=
ans the fw_patch_num is always 0.
However, once the patches are activated after patching, fw_patch_num will b=
e updated to reflect the version of the activated patch and this will not b=
e changed until power recycled the device.

The fw_patch_num can be used as an indicator whether device is patched or n=
ot.
If the fw_patch_num is ignored, the driver will try to patch the device eac=
h time the device is enumerated or enter the setup stage even if the device=
 is patched.
Anyway, I just realized that, in the current implementation, if the device =
is already patched and if the setup routine is being called again, it will =
try to use the default patch (in the current implementation), which is not =
correct.
I will make a change to check the fw_patch_num and only patch if this is 0.=
 If it is non-zero, it will just exit with success - device is already patc=
hed.

>=20
> Also it might be a good idea to look for default settings with hw_platfor=
m and
> hw_variant, but where revision is not relevant so much.

ACK.

>=20
> > +
> > +	*use_default =3D 0;
>=20
> About this one. Lets figure out if we have to activate a patch or not, bu=
t doing
> that in the patching routine and not by a firmware file name. If there is=
 a
> command that loads a patch in the firmware file, then enable the activate
> otherwise just disable.

ACK.

>=20
> > +
> > +	if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> > +		BT_ERR("%s failed to open Intel firmware file: %s",
> > +		       hdev->name, fwname);
> > +
> > +		snprintf(fwname, sizeof(fwname), "intel/ibt-default-
> %x.bseq",
> > +			 ver->hw_variant);
> > +		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> > +			BT_ERR("%s failed to open default Intel fw file: %s",
> > +			       hdev->name, fwname);
> > +			return NULL;
> > +		}
> > +
> > +		*use_default =3D 1;
> > +	}
> > +
> > +	BT_INFO("%s Intel Bluetooth firmware file: %s", hdev->name,
> fwname);
> > +
> > +	return fw;
> > +}
> > +
> > +#define INTEL_HCI_MFG_MODE	0xfc11
> > +#define INTEL_HCI_GET_VER	0xfc05
> > +#define INTEL_HCI_CMD		0x01
> > +#define INTEL_HCI_EVT		0x02
>=20
> I am fine if you use this as hex codes in the code. The comment above giv=
es
> enough explanation and it makes the lines shorter.

ACK.=20

>=20
> > +static int btusb_setup_intel(struct hci_dev *hdev) {
> > +	struct sk_buff		*skb;
> > +	const struct firmware	*fw;
> > +	const u8		*fw_ptr;
> > +	int			use_default;
> > +
> > +	u8 mfg_enable[] =3D { 0x01, 0x00 };
> > +	u8 mfg_no_reset[] =3D { 0x00, 0x00 };
>=20
> I would call this one mfg_disable. Previous patch was not needing it, so =
I did
> not mention it.

ACK

>=20
> > +	u8 mfg_reset_deactivate[] =3D { 0x00, 0x01 };
> > +	u8 mfg_reset_activate[] =3D { 0x00, 0x02 };
> > +
> > +	BT_DBG("%s", hdev->name);
> > +
> > +	/* The controller has a bug with the first HCI command send to it
> > +	 * returning number of completed commands as zero. This would
> stall the
> > +	 * command processing in the Bluetooth core
> > +	 *
> > +	 * As a workaround, send HCI Reset command first which will reset
> the
> > +	 * number of completed commands and allow normal command
> processing
> > +	 * from now on
> > +	 */
> > +	skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
> HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s sending initial HCI reset command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	/* Read Intel specific controller version first to allow selection of
> > +	 * which firmware file to load.
> > +	 *
> > +	 * The returned information are hardware variant and revision plus
> > +	 * firmware variant, revision and build number.
> > +	 */
> > +	skb =3D __hci_cmd_sync(hdev, INTEL_HCI_GET_VER, 0, NULL,
> > +			     HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		BT_ERR("%s reading Intel fw version command failed (%ld)",
> > +		       hdev->name, PTR_ERR(skb));
> > +		return -PTR_ERR(skb);
> > +	}
> > +
>=20
> Maybe add just a u8 status to the intel_version struct and make sure to
> check the length here. I would still print the version details with BT_IN=
FO so
> we have them in dmesg logging.

ACK.

>=20
> Regards
>=20
> Marcel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html
