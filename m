Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5A167D97
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188234; cv=none; b=Ur+JlCvX1mxWE7Onbr7RxThA13iGWr2hbB65uiyyChLWu7aGa3DpIHL3t+e6KorCmKyR8NdghAqEW5qb2vx4uc8HzHiY66PVpzutHoWfY6cm9YcizpHG2LcU5aiulwIi471so7V82XepDrlZT9AKuNyPMCdX77Tp74CBmE0OTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188234; c=relaxed/simple;
	bh=EVgrIvabjyEO6yRab0q2GghLi5joCBveKxdTO6Qg78E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IM9+q5QoNPYXfeaag3nsQylSiurPHlgrRqpQRMO74YHe19wKz+aqVL0/J9fznysuqkzBvQWrjg/vfPmP+4bE6bUwzB2bjwM9V4JM2t9X5aRYi7LLcMcEtU+e/cpMqgQat7yErcaJKmdUszGJeFKqwDTh1EhMcKJz5GcGG+eBYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f372.dip0.t-ipconnect.de [79.249.243.114])
	by mail.holtmann.org (Postfix) with ESMTPSA id A8B16CED08;
	Fri,  5 Jul 2024 15:54:11 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength
 of BRI
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240626092801.2343844-1-kiran.k@intel.com>
Date: Fri, 5 Jul 2024 15:54:00 +0200
Cc: BlueZ <linux-bluetooth@vger.kernel.org>,
 ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <99916FE7-7E60-4512-852F-F08F73D27EA1@holtmann.org>
References: <20240626092801.2343844-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Kiran,

> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
> causing cross talk step errors to WiFi. As a workaround, driver needs =
to
> reduce the drive strength of BRI. During *setup*, driver reads the =
drive
> strength value from efi variable and passes it to the controller via =
vendor
> specific command with opcode 0xfc0a.
>=20
> dmesg:
> .....
> [16.767459] Bluetooth: hci0: Found device firmware: =
intel/ibt-0190-0291-iml.sfi
> [16.767464] Bluetooth: hci0: Boot Address: 0x30099000
> [16.767464] Bluetooth: hci0: Firmware Version: 9-25.24
> [16.825418] Bluetooth: hci0: Waiting for firmware download to complete
> [16.825421] Bluetooth: hci0: Firmware loaded in 56600 usecs
> [16.825463] Bluetooth: hci0: Waiting for device to boot
> [16.827510] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [16.827529] Bluetooth: hci0: Device booted in 2053 usecs
> [16.827707] Bluetooth: hci0: dsbr: enabled: 0x01 value: 0x0f
> [16.830179] Bluetooth: hci0: Found device firmware: =
intel/ibt-0190-0291-pci.sfi
> [16.830188] Bluetooth: hci0: Boot Address: 0x10000800
> [16.830189] Bluetooth: hci0: Firmware Version: 9-25.24
> [16.928308] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [16.928311] Bluetooth: BNEP filters: protocol multicast
> [16.928315] Bluetooth: BNEP socket layer initialized
> [17.333292] Bluetooth: hci0: Waiting for firmware download to complete
> [17.333313] Bluetooth: hci0: Firmware loaded in 491339 usecs
> [17.333353] Bluetooth: hci0: Waiting for device to boot
> [17.368741] Bluetooth: hci0: Device booted in 34585 usecs
> [17.368742] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [17.368942] Bluetooth: hci0: Found Intel DDC parameters: =
intel/ibt-0190-0291-pci.ddc
> [17.369199] Bluetooth: hci0: Applying Intel DDC parameters completed
> [17.369447] Bluetooth: hci0: Firmware timestamp 2024.25 buildtype 3 =
build 64777
> [17.369448] Bluetooth: hci0: Firmware SHA1: 0xc33eb15f
> [17.369648] Bluetooth: hci0: Fseq status: Success (0x00)
> [17.369649] Bluetooth: hci0: Fseq executed: 00.00.04.183
> [17.369650] Bluetooth: hci0: Fseq BT Top: 00.00.04.183
> [17.408366] Bluetooth: MGMT ver 1.23
> [17.408415] Bluetooth: ISO socket layer initialized
> [17.434375] Bluetooth: RFCOMM TTY layer initialized
> [17.434385] Bluetooth: RFCOMM socket layer initialized
> [17.434389] Bluetooth: RFCOMM ver 1.11
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> drivers/bluetooth/btintel.c | 117 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 117 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5d735391545a..fb9d4221ccd6 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -12,6 +12,8 @@
> #include <linux/acpi.h>
> #include <acpi/acpi_bus.h>
> #include <asm/unaligned.h>
> +#include <linux/efi.h>
> +
>=20

introducing extra empty line is not acceptable. Please carefully review
patches before sending them to the mailing list. These things are easily
caught by just looking at the patch.

> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -26,6 +28,8 @@
> #define ECDSA_OFFSET 644
> #define ECDSA_HEADER_LEN 320
>=20
> +#define BTINTEL_EFI_DRBR L"UefiCnvCommonDSBR"
> +

I don=E2=80=99t get the naming. Is it DRBR or DSBR?

> enum {
> DSM_SET_WDISABLE2_DELAY =3D 1,
> DSM_SET_RESET_METHOD =3D 3,
> @@ -49,6 +53,38 @@ static const guid_t btintel_guid_dsm =3D
> GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
>  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
>=20
> +static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t =
*guid)
> +{
> + void *data;
> + efi_status_t status;
> + unsigned long data_size =3D 0;
> +
> + if (!IS_ENABLED(CONFIG_EFI))
> + return ERR_PTR(-EOPNOTSUPP);
> +
> + if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> + return ERR_PTR(-EOPNOTSUPP);
> +
> + status =3D efi.get_variable(name, guid, NULL, &data_size, NULL);
> +
> + if (status !=3D EFI_BUFFER_TOO_SMALL || !data_size)
> + return ERR_PTR(-EIO);
> +
> + data =3D kmalloc(data_size, GFP_KERNEL);
> +
> + if (!data)
> + return ERR_PTR(-ENOMEM);
> +
> + status =3D efi.get_variable(name, guid, NULL, &data_size, data);
> +
> + if (status !=3D EFI_SUCCESS) {
> + kfree(data);
> + return ERR_PTR(-ENXIO);
> + }
> +
> + return data;
> +}
> +

This is something I don=E2=80=99t like at all. You are reading a single =
EFI
variable, but putting an abstraction in place as if we would be reading
at least a dozen of them. Please don=E2=80=99t do that since they only =
thing
you are doing in the end is hiding compiler warnings by casting
everything to void and making the code a memory allocation hard to
follow.

This could be just like this:

	static u32 btintel_uefi_get_dsbr(void).

If at any point in the future more abstraction is needed, this is
internal code and changes are easy. No ABI breakage will happen. For
now keep it simple.

> int btintel_check_bdaddr(struct hci_dev *hdev)
> {
> struct hci_rp_read_bd_addr *bda;
> @@ -2615,6 +2651,80 @@ static u8 btintel_classify_pkt_type(struct =
hci_dev *hdev, struct sk_buff *skb)
> return hci_skb_pkt_type(skb);
> }
>=20
> +static int btintel_set_dsbr(struct hci_dev *hdev, struct =
intel_version_tlv *ver)
> +{
> + struct btintel_dsbr_cmd {
> + u8 enable;
> + u8 dsbr;
> + } __packed;
> +
> + struct btintel_dsbr {
> + u8 header;
> + u32 dsbr;
> + } __packed;
> +
> + struct btintel_dsbr *dsbr;
> + struct btintel_dsbr_cmd cmd;
> + struct sk_buff *skb;
> + u8 status;
> + efi_guid_t guid =3D EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x03,
> +   0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
> +
> + memset(&cmd, 0, sizeof(cmd));
> + dsbr =3D btintel_uefi_get_variable(BTINTEL_EFI_DRBR, &guid);
> + if (IS_ERR(dsbr)) {
> + /* If efi variable is not present, driver still needs to send
> + * 0xfc0a command with default values
> + */
> + bt_dev_dbg(hdev, "Error reading efi: %ls DSBR (%ld)",
> +   BTINTEL_EFI_DRBR, PTR_ERR(dsbr));
> + dsbr =3D NULL;
> + }
> +
> + if (dsbr) {
> + /* bit0: 0 - Use firmware default value
> + *       1 - Override firmware value
> + * bit3:1 - Reserved
> + * bit7:4 - DSBR override values
> + * bt31:7 - Reserved
> + */
> + cmd.enable =3D dsbr->dsbr & BIT(0);
> + if (cmd.enable)
> + cmd.dsbr =3D dsbr->dsbr >> 4 & 0xF;
> + kfree(dsbr);
> + }
> +
> + bt_dev_info(hdev, "dsbr: enabled: 0x%2.2x value: 0x%2.2x", =
cmd.enable,
> +    cmd.dsbr);
> +
> + skb =3D __hci_cmd_sync(hdev, 0xfc0a, sizeof(cmd), &cmd,  =
HCI_CMD_TIMEOUT);
> + if (IS_ERR(skb)) {
> + bt_dev_err(hdev, "Failed to send Intel DSBR command (%ld)",
> +   PTR_ERR(skb));
> + return -bt_to_errno(PTR_ERR(skb));
> + }
> +
> + status =3D skb->data[0];
> + kfree_skb(skb);
> +
> + if (status) {
> + bt_dev_err(hdev, "Set DSBR failed 0x%2.2x", status);
> + return -bt_to_errno(status);
> + }
> + return 0;
> +}

=46rom the comments, I gather the command to set DSBR is mandatory to be
run on a given set of products, no matter if the EFI variable is set or
not. So all the testing is overly complicated and clutters the code.

My problem is the fact that I don=E2=80=99t understand the combination =
of enable
and dsbr value in the HCI command parameter structure. It would be
really beneficial if the EFI variable and the HCI command is actually
documented in the code.

> +
> +static int btintel_apply_dsbr(struct hci_dev *hdev,
> +      struct intel_version_tlv *ver)
> +{
> + /* For BlazarI + B0 step, DSBR command needs to be sent just after
> + * downloading IML firmware
> + */
> + return ver->img_type =3D=3D BTINTEL_IMG_IML &&
> + ((ver->cnvi_top & 0xfff) =3D=3D BTINTEL_CNVI_BLAZARI) &&
> + INTEL_CNVX_TOP_STEP(ver->cnvi_top) =3D=3D 0x01;
> +}
> +
> int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
> struct intel_version_tlv *ver)
> {
> @@ -2649,6 +2759,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev =
*hdev,
> if (err)
> return err;
>=20
> + if (btintel_apply_dsbr(hdev, ver)) {
> + /* set drive strength BRI response */
> + err =3D btintel_set_dsbr(hdev, ver);
> + if (err)
> + return err;
> + }
> +

Here I would really just call the command:

	err =3D btintel_set_dsbr(hdev);

And then let the command figure out what value needs to be read and
if it is applicable to the hardware.

The function btintel_apply_dsbr() is not acceptable. That will get
out of control with the next hardware release. It is already for
this hardware version unreadable.

In addition the wording "drive strength of BRI=E2=80=9D make little =
sense to
me. I don=E2=80=99t know what =E2=80=9Cdrive strength=E2=80=9D actually =
means. When I google
it then it talks about current and values in mA. So I really echo
Pauls comments here. Please add documentation and comments in the code.

Regards

Marcel

