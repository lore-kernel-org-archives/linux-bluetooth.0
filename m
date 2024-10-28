Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AF1DEFDC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136031; cv=none; b=E/lxxyryLT3Kd2n9SFDBuzhpGmgjZ4b6hvQiIx009Dh/kl4KqbZWl5JldABJwmxPO3hPPhXQXlS+/zPUh3D+iw6fUZ39DfjRpeU9Oze2E+YqMr/328Ej3IVTDnUAJEvwFnMkxKQ6es4b+BgDagWRtGupdBi0JPin4ckPaILgWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136031; c=relaxed/simple;
	bh=pKo3woSMiGyL/c9wpuU8E0+Nh7thmtObqVHQ7C9HOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdjNvv+6UF/CtKhyn69T6xRioVQJzJjPO0+S9J9SF/E+say1UmFjBzMNuc4sG9bTA79deno0yAG0zbNg/PK0dXU1uoke5tNqAMDc1E++33Gh1raMEvQzahEWKTll9nOw3pR/NazpgwDHr4q814asqOmj+B8m5ahUmxQQR+uFS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfpTVfHy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfpTVfHy"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so37660541fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136026; x=1730740826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NZdvYfbWDo163WUKOYyBSRhX98z+yOB7ZsLu8BIxgM=;
        b=MfpTVfHy4aCoaX6N1wfFaWV1gYodcLWOuOq4HBpvEZ93QJNx73dAk/80N/duE2j5RW
         40UC7GIbrsLSyaXalhhx0gTbJt/iFi/PVFxaxHaKPD40KEtADlKp1oZpwOMDaYIUX4wk
         wCg9pdmT7d4qTj8HebHsOV6wgzHRF+qfc/XrJzjrafRNflFtIZhaRjqHQLettAk3CCYZ
         PNZWEcfjglWgkuwceOG5pZA7YLQjtuExINNIVuSi1DJFrs2jsaBn4RnOJTCeuwGWYzUB
         w1+uaP8vts3ovjai26buS1uoirOo2klRy5VEDQzDNMDpVdIZj/AwhjCbAV2sLczH80/8
         O41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136026; x=1730740826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NZdvYfbWDo163WUKOYyBSRhX98z+yOB7ZsLu8BIxgM=;
        b=ESEgf9I1YeXzGdFzxboP2ml2v9Zf2l764AeAbk+0VL68GmvaQLgK+hSUq3Cs4w7ivv
         1Vz4cTHLV30iCRA0b/e901r6TwjRHB6S4Fn33ofPoHM4BeLcsAqFID5MM6gk0qBfjAIx
         tXVbfCCYoS8y32RjSxLftFudJcbVJrnGSKUzf5k/KumILcubiAGAeGpZ/4pCWsYl6E1H
         nWHD8+NKps73CPDZeTOP0/Gf/4haQyJpM6nPGUla9tKxJpt2K5ogqNL1Ktz3SYyrpnpt
         0JC6S4ThzyKlRomxnzOgZ84WdHmbkh5qHKHV2fqnpAmv+4RlcL2dP1Xv9qVceItKM4zm
         qp5A==
X-Gm-Message-State: AOJu0YyZ0Nvgm4acM+erCB+EAG9uzNZFR+4G33n9aKFxifT8iUIi3gUG
	RhIokgDdcY8mwe7T8FwOuNuVK43UhXpOi7/23ZK2LksQa/jCA5WSvnZwJKGHQ8TKaTD4DCS6jsT
	6UyQxquYgAnGL6zrB3VFt2nP+EF5aGg==
X-Google-Smtp-Source: AGHT+IETawpHEIrNLMuaM2GMvftzly4MOGQjOVIA5BrotCVzktR2U+ziHAvQIyp9OWyztbR5DwKFvOe5oNyQxS/wzx8=
X-Received: by 2002:a2e:4619:0:b0:2fb:6057:e695 with SMTP id
 38308e7fff4ca-2fcbdfbb83cmr35181181fa.18.1730136025317; Mon, 28 Oct 2024
 10:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025121716.1913833-1-vijay.satija@intel.com>
In-Reply-To: <20241025121716.1913833-1-vijay.satija@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 13:20:12 -0400
Message-ID: <CABBYNZJNw-i7ceTr0m5rCbnVSQnG5VEKQEN7y+39Hpb-C5Nr6Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support to configure TX power
To: Vijay Satija <vijay.satija@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

On Fri, Oct 25, 2024 at 8:17=E2=80=AFAM Vijay Satija <vijay.satija@intel.co=
m> wrote:
>
> Bluetooth has regulatory limitations which prohibit or allow usage
> of certain bands or channels or limiting Tx power. The Tx power
> values can be configured in ACPI table. This patch reads from ACPI entry
> and configures the TX power to be used accordingly.
>
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 313 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  35 ++++
>  2 files changed, 348 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d496cf2c3411..aa4ebe230cc5 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -29,6 +29,11 @@
>
>  #define BTINTEL_EFI_DSBR       L"UefiCnvCommonDSBR"
>
> +#define BTINTEL_BT_DOMAIN              0x12
> +#define BTINTEL_SAR_LEGACY             0
> +#define BTINTEL_SAR_INC_PWR            1
> +#define BTINTEL_SAR_INC_PWR_SUPPORTED  0
> +
>  enum {
>         DSM_SET_WDISABLE2_DELAY =3D 1,
>         DSM_SET_RESET_METHOD =3D 3,
> @@ -2799,6 +2804,311 @@ static int btintel_set_dsbr(struct hci_dev *hdev,=
 struct intel_version_tlv *ver)
>         return 0;
>  }
>
> +#ifdef CONFIG_ACPI
> +static acpi_status btintel_evaluate_acpi_method(struct hci_dev *hdev,
> +                                               acpi_string method,
> +                                               union acpi_object **ptr,
> +                                               u8 pkg_size)
> +{
> +       struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *p;
> +       acpi_status status;
> +       acpi_handle handle;
> +
> +       handle =3D ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
> +       if (!handle) {
> +               bt_dev_dbg(hdev, "ACPI-BT: No ACPI support for Bluetooth =
device");
> +               return AE_NOT_EXIST;
> +       }
> +
> +       status =3D acpi_evaluate_object(handle, method, NULL, &buffer);
> +
> +       if (ACPI_FAILURE(status)) {
> +               bt_dev_dbg(hdev, "ACPI-BT: ACPI Failure: %s method: %s",
> +                          acpi_format_exception(status), method);
> +               return status;
> +       }
> +
> +       p =3D buffer.pointer;
> +
> +       if (p->type !=3D ACPI_TYPE_PACKAGE || p->package.count < pkg_size=
) {
> +               bt_dev_warn(hdev, "ACPI-BT: Invalid object type: %d or pa=
ckage count: %d",
> +                           p->type, p->package.count);
> +               kfree(buffer.pointer);
> +               return AE_ERROR;
> +       }
> +
> +       *ptr =3D buffer.pointer;
> +       return 0;
> +}
> +
> +static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buf=
fer)
> +{
> +       union acpi_object *domain, *bt_pkg;
> +       int i;
> +
> +       for (i =3D 1; i < buffer->package.count; i++) {
> +               bt_pkg =3D &buffer->package.elements[i];
> +               domain =3D &bt_pkg->package.elements[0];
> +               if (domain->type =3D=3D ACPI_TYPE_INTEGER &&
> +                   domain->integer.value =3D=3D BTINTEL_BT_DOMAIN)
> +                       return bt_pkg;
> +       }
> +       return ERR_PTR(-ENOENT);
> +}
> +
> +static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_=
ddc_write *data, u8 len)
> +{
> +       struct sk_buff *skb;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfc8b, len, data, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send sar ddc id:0x%4.4x (%ld=
)",
> +                           le16_to_cpu(data->id), PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btintel_set_legacy_sar(struct hci_dev *hdev,
> +                                 struct btintel_sar_inc_pwr *sar)
> +{
> +       struct btintel_cp_ddc_write *cmd;
> +       u8 buffer[64];
> +       int ret;
> +
> +       cmd =3D (void *)buffer;
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x0131);
> +       cmd->data[0] =3D sar->br >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;

It might be a good idea to handle each command on its own function and
then name it according to what the command would be doing.

> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x0132);
> +       cmd->data[0] =3D sar->br >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x0133);
> +       cmd->data[0] =3D min3(sar->le, sar->le_lr, sar->le_2mhz) >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 5;
> +       cmd->id =3D cpu_to_le16(0x0137);
> +       cmd->data[0] =3D sar->br >> 3;
> +       cmd->data[1] =3D sar->edr2 >> 3;
> +       cmd->data[2] =3D sar->edr3 >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 6);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 5;
> +       cmd->id =3D cpu_to_le16(0x0138);
> +       cmd->data[0] =3D sar->br >> 3;
> +       cmd->data[1] =3D sar->edr2 >> 3;
> +       cmd->data[2] =3D sar->edr3 >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 6);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 5;
> +       cmd->id =3D cpu_to_le16(0x013b);
> +       cmd->data[0] =3D sar->br >> 3;
> +       cmd->data[1] =3D sar->edr2 >> 3;
> +       cmd->data[2] =3D sar->edr3 >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 6);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 5;
> +       cmd->id =3D cpu_to_le16(0x013c);
> +       cmd->data[0] =3D sar->br >> 3;
> +       cmd->data[1] =3D sar->edr2 >> 3;
> +       cmd->data[2] =3D sar->edr3 >> 3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +       return ret;
> +}
> +
> +static int btintel_set_mutual_sar(struct hci_dev *hdev,
> +                                 struct btintel_sar_inc_pwr *sar)
> +{
> +       struct btintel_cp_ddc_write *cmd;
> +       struct sk_buff *skb;
> +       u8 buffer[64];
> +       bool enable;
> +       int ret;
> +
> +       cmd =3D (void *)buffer;
> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x019e);
> +
> +       if (sar->revision =3D=3D BTINTEL_SAR_INC_PWR &&
> +           sar->inc_power_mode =3D=3D BTINTEL_SAR_INC_PWR_SUPPORTED)
> +               cmd->data[0] =3D 0x01;
> +       else
> +               cmd->data[0] =3D 0x00;
> +
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       if (sar->revision =3D=3D BTINTEL_SAR_INC_PWR &&
> +           sar->inc_power_mode =3D=3D BTINTEL_SAR_INC_PWR_SUPPORTED) {
> +               cmd->len =3D 3;
> +               cmd->id =3D cpu_to_le16(0x019f);
> +               cmd->data[0] =3D sar->sar_2400_chain_a;
> +
> +               ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x01a0);
> +       cmd->data[0] =3D sar->br;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;

Ditto, hopefully if we have dedicated functions for each of these
commands we can reuse some of them.

> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x01a1);
> +       cmd->data[0] =3D sar->edr2;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x01a2);
> +       cmd->data[0] =3D sar->edr3;
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       cmd->len =3D 3;
> +       cmd->id =3D cpu_to_le16(0x01a3);
> +       cmd->data[0] =3D min3(sar->le, sar->le_lr, sar->le_2mhz);
> +       ret =3D btintel_send_sar_ddc(hdev, cmd, 4);
> +       if (ret)
> +               return ret;
> +
> +       enable =3D true;
> +       skb =3D __hci_cmd_sync(hdev, 0xfe25, 1, &enable, HCI_CMD_TIMEOUT)=
;
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)"=
, PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
> +static int btintel_sar_send_to_device(struct hci_dev *hdev, struct btint=
el_sar_inc_pwr *sar,
> +                                     struct intel_version_tlv *ver)
> +{
> +       u16 cnvi, cnvr;
> +       int ret;
> +
> +       cnvi =3D ver->cnvi_top & 0xfff;
> +       cnvr =3D ver->cnvr_top & 0xfff;
> +
> +       if (cnvi < BTINTEL_CNVI_BLAZARI && cnvr < BTINTEL_CNVR_FMP2) {
> +               bt_dev_info(hdev, "Applying legacy Bluetooth SAR");
> +               ret =3D btintel_set_legacy_sar(hdev, sar);
> +       } else if (cnvi =3D=3D BTINTEL_CNVI_GAP || cnvr =3D=3D BTINTEL_CN=
VR_FMP2) {
> +               bt_dev_info(hdev, "Applying  Mutual Bluetooth SAR");
> +               ret =3D btintel_set_mutual_sar(hdev, sar);
> +       } else {
> +               ret =3D -EOPNOTSUPP;
> +       }
> +
> +       return ret;
> +}
> +
> +static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_versi=
on_tlv *ver)
> +{
> +       union acpi_object *bt_pkg, *buffer =3D NULL;
> +       struct btintel_sar_inc_pwr sar;
> +       acpi_status status;
> +       u8 revision;
> +       int ret;
> +
> +       status =3D btintel_evaluate_acpi_method(hdev, "BRDS", &buffer, 2)=
;
> +       if (ACPI_FAILURE(status))
> +               return -ENOENT;
> +
> +       bt_pkg =3D btintel_acpi_get_bt_pkg(buffer);
> +
> +       if (IS_ERR(bt_pkg)) {
> +               ret =3D PTR_ERR(bt_pkg);
> +               goto error;
> +       }
> +
> +       revision =3D buffer->package.elements[0].integer.value;
> +
> +       if (revision > BTINTEL_SAR_INC_PWR) {
> +               bt_dev_dbg(hdev, "BT_SAR: revision: 0x%2.2x not supported=
", revision);
> +               ret =3D -EOPNOTSUPP;
> +               goto error;
> +       }
> +
> +       if (revision =3D=3D BTINTEL_SAR_LEGACY && bt_pkg->package.count !=
=3D 7) {
> +               sar.revision =3D revision;
> +               sar.bt_sar_bios =3D (u32)bt_pkg->package.elements[1].inte=
ger.value;
> +               sar.br =3D (u8)bt_pkg->package.elements[2].integer.value;
> +               sar.edr2 =3D (u8)bt_pkg->package.elements[3].integer.valu=
e;
> +               sar.edr3 =3D (u8)bt_pkg->package.elements[4].integer.valu=
e;
> +               sar.le =3D (u8)bt_pkg->package.elements[5].integer.value;
> +               sar.le_2mhz =3D (u8)bt_pkg->package.elements[6].integer.v=
alue;
> +               sar.le_lr  =3D (u8)bt_pkg->package.elements[7].integer.va=
lue;

Hmm, are you sure the check is correct? It is !=3D 7 but then it goes
ahead and access element[7]? Are these values aligned and are the acpi
values guaranteed to be in the same endianness as the host? Even if
they are, I'd say using the likes of le32_to_cpu is probably a good
idea anyway.

> +
> +       } else if (revision =3D=3D BTINTEL_SAR_INC_PWR && bt_pkg->package=
.count !=3D 9) {
> +               sar.revision =3D revision;
> +               sar.bt_sar_bios =3D (u32)bt_pkg->package.elements[1].inte=
ger.value;
> +               sar.inc_power_mode =3D (u32)bt_pkg->package.elements[2].i=
nteger.value;
> +               sar.sar_2400_chain_a =3D (u8)bt_pkg->package.elements[3].=
integer.value;
> +               sar.br =3D (u8)bt_pkg->package.elements[4].integer.value;
> +               sar.edr2 =3D (u8)bt_pkg->package.elements[5].integer.valu=
e;
> +               sar.edr3 =3D (u8)bt_pkg->package.elements[6].integer.valu=
e;
> +               sar.le =3D (u8)bt_pkg->package.elements[7].integer.value;
> +               sar.le_2mhz =3D (u8)bt_pkg->package.elements[8].integer.v=
alue;
> +               sar.le_lr  =3D (u8)bt_pkg->package.elements[9].integer.va=
lue;

Ditto, !=3D 9 then it attempts to access element[9]

> +       } else {
> +               ret =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       /* Apply only if it is enabled in BIOS */
> +       if (sar.bt_sar_bios !=3D 1) {
> +               bt_dev_dbg(hdev, "Bluetooth SAR is not enabled");
> +               ret =3D -EOPNOTSUPP;
> +               goto error;
> +       }
> +
> +       ret =3D btintel_sar_send_to_device(hdev, &sar, ver);
> +error:
> +       kfree(buffer);
> +       return ret;
> +}
> +#endif /* CONFIG_ACPI */
> +
> +static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
> +                                               struct intel_version_tlv =
*ver)
> +{
> +#ifdef CONFIG_ACPI
> +       return btintel_acpi_set_sar(hdev, ver);
> +#endif
> +       return 0;
> +}
> +
>  int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>                                  struct intel_version_tlv *ver)
>  {
> @@ -2876,6 +3186,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hd=
ev,
>
>         hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
>
> +       /* Send sar values to controller */
> +       btintel_set_specific_absorption_rate(hdev, ver);
> +
>         /* Set PPAG feature */
>         btintel_set_ppag(hdev, ver);
>
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index fa43eb137821..0b355cb49836 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -56,7 +56,10 @@ struct intel_tlv {
>  #define BTINTEL_CNVI_BLAZARIW          0x901
>  #define BTINTEL_CNVI_GAP               0x910
>  #define BTINTEL_CNVI_BLAZARU           0x930
> +#define BTINTEL_CNVI_GAP               0x910
>
> +/* CNVR */
> +#define BTINTEL_CNVR_FMP2              0x910
>  #define BTINTEL_IMG_BOOTLOADER         0x01    /* Bootloader image */
>  #define BTINTEL_IMG_IML                        0x02    /* Intermediate i=
mage */
>  #define BTINTEL_IMG_OP                 0x03    /* Operational image */
> @@ -164,6 +167,38 @@ struct hci_ppag_enable_cmd {
>  #define INTEL_TLV_DEBUG_EXCEPTION      0x02
>  #define INTEL_TLV_TEST_EXCEPTION       0xDE
>
> +struct btintel_cp_ddc_write {
> +       u8      len;
> +       __le16  id;
> +       u8      data[];
> +} __packed;
> +
> +/* Bluetooth SAR feature (BRDS), Revision 0 */
> +struct btintel_sar {
> +       u8      revision;
> +       u32     bt_sar_bios; /* Mode of SAR control to be used, 1:enabled=
 in bios */
> +       u8      br;
> +       u8      edr2;
> +       u8      edr3;
> +       u8      le;
> +       u8      le_2mhz;
> +       u8      le_lr;
> +} __packed;
> +
> +/* Bluetooth SAR feature (BRDS), Revision 1 */
> +struct btintel_sar_inc_pwr {
> +       u8      revision;
> +       u32     bt_sar_bios;
> +       u32     inc_power_mode;  /* Increased power mode */

For a packed multi-byte field I think it is always a good idea to have
it as a specific byte order rather than expecting it to be the same as
the host order.

> +       u8      sar_2400_chain_a; /* Sar power restriction LB */
> +       u8      br;
> +       u8      edr2;
> +       u8      edr3;
> +       u8      le;
> +       u8      le_2mhz;
> +       u8      le_lr;
> +} __packed;
> +
>  #define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >>=
 8))
>  #define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >>=
 16))
>  #define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz
