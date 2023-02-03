Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Feb 2023 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjBCVJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjBCVJW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Feb 2023 16:09:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35203A4280
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Feb 2023 13:08:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br9so9568089lfb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Feb 2023 13:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tDT+ajjPRsqihM9eKMg7V1spbsr4eTuDiaK9GO4sy0=;
        b=VDxAorcsXumC5fFAc9buKtFIooRO5jVomyYM5fTwrNVAFXbiY5OEPCAo0zryZrXHxR
         NTXTj/CV0UXTQd/Uz9GKFtALzZWml30Mj1q6dfic/NTAymkOPnQ2gSSKSBAbTvNVvdgC
         XuiDf5cusp5j1/r+IYSy5aBKXZBc/KiiV2Uh5OAQx6PjqrXReWszBJJl8Vtti3E5CoPQ
         7Joq8HDFwmnqMyEb/xYb4SzPpJarihvroouT4oY03Gx/Q0NVg1/IWRHGgETdIsAqJtfY
         xW+V7iLWdi5MC2Ow30w7W1ezcXaLjC0t0m4l77txr+/D3ahRf6l4N4cuyzpQQW4/487x
         Xckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tDT+ajjPRsqihM9eKMg7V1spbsr4eTuDiaK9GO4sy0=;
        b=KT2ZiBvhzv0iLR/EIBq9RUe+hiUdnF9pzT/W8aLNpK9APuC98GCOOw+bhwVm8BRfvS
         M5bdQqogbnxdteb4Z/72Tg9U+Gbst9h+GNicn+z945dG4dR9GSKbxtB7SBY5xJrnofEh
         lQU2o+7cLFr5r4zTYM/I7GMN5hpXa+AAjzCG9q2lw2KWXcDVytHg6CjiVMpjJvG0n4PP
         hnZ8XX8g8R0WtkR8S//2kCnleopmtMlPmEN4+x4MKkDhdXnq1/R89KqpvIYxs7IaHCaS
         RguHGvyGapB0yQnGZibNQLsb6cP05Ip6oxMQAEmH7AJnazD5QTseZQCBs4HJcolZxmMZ
         QbDQ==
X-Gm-Message-State: AO0yUKWZeV1B51NLjMHsE57iastovVhvK8f8KYCRZM61mmgDTBIcoaAt
        8tum+34xmdLcdFHm5x4EtI+74hXUUQhl91FCpqQ=
X-Google-Smtp-Source: AK7set+nXTe58Pf+K8Usb6wEYtqvvFX+sH/T+R379bEuwR4MzaJBB+7i2XWgj1okiJi1cHmLOz6Eo2M7Y2MfvopuZNs=
X-Received: by 2002:a19:9209:0:b0:4d8:5137:a89d with SMTP id
 u9-20020a199209000000b004d85137a89dmr2067347lfd.176.1675458498939; Fri, 03
 Feb 2023 13:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20230203093332.4736-1-kiran.k@intel.com>
In-Reply-To: <20230203093332.4736-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Feb 2023 13:08:07 -0800
Message-ID: <CABBYNZK+nFom8DVXabKMgzSockktY4tcTPD+A-RWSw-3PVAQRw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        lokendra.singh@intel.com, chethan.tumkur.narayan@intel.com,
        Seema Sreemantha <seema.sreemantha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran, Seema,

On Fri, Feb 3, 2023 at 1:28 AM Kiran K <kiran.k@intel.com> wrote:
>
> From: Seema Sreemantha <seema.sreemantha@intel.com>
>
> Antenna gain is defined as the antenna=E2=80=99s ability to
> increase the Tx power in a given direction. Intel
> is certifying its products with fixed reference
> antenna peak gain values (3/5dBi). The feature takes
> into account the actual antenna gain, and increases
> output power values, which results in a performance
> improvement.
>
> After firmware download is completed, driver reads from
> ACPI table and configures PPAG as required. ACPI table
> entry for PPAG is defined as below.
>
> Name (PPAG, Package (0x02)
> {
>     0x00000001,
>     Package (0x02)
>     {
>         0x00000012, /* Bluetooth Domain */
>         0x00000001  /* 1 - Enable PPAG, 0 - Disable PPAG */
>     }
> })
>
> btmon log:
>
> < HCI Command: Vendor (0x3f|0x0219) plen 12
>     00 00 00 00 00 00 00 00 00 00 00 00
> > HCI Event: Command Complete (0x0e) plen 4
>     Vendor (0x3f|0x0219) ncmd 1
>     Status: Success (0x00)

It would have been better if you guys had added a decoder for it.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Seema Sreemantha <seema.sreemantha@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  13 ++++
>  2 files changed, 127 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d4e2cb9a4eb4..4d6d0dc10caa 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/firmware.h>
>  #include <linux/regmap.h>
> +#include <linux/acpi.h>
>  #include <asm/unaligned.h>
>
>  #include <net/bluetooth/bluetooth.h>
> @@ -24,6 +25,9 @@
>  #define ECDSA_OFFSET           644
>  #define ECDSA_HEADER_LEN       320
>
> +#define BTINTEL_PPAG_NAME   "PPAG"
> +#define BTINTEL_PPAG_PREFIX "\\_SB_.PCI0.XHCI.RHUB"
> +
>  #define CMD_WRITE_BOOT_PARAMS  0xfc0e
>  struct cmd_write_boot_params {
>         __le32 boot_addr;
> @@ -1278,6 +1282,63 @@ static int btintel_read_debug_features(struct hci_=
dev *hdev,
>         return 0;
>  }
>
> +static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, vo=
id *data,
> +                                        void **ret)
> +{
> +       acpi_status status;
> +       size_t len;
> +       struct btintel_ppag *ppag;

You can probably just assign ppag =3D data above;

> +       union acpi_object *p, *elements;
> +       struct acpi_buffer string =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +       struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +       struct hci_dev *hdev =3D ((struct btintel_ppag *)data)->hdev;

Then use hdev =3D ppga->hdev

> +
> +       status =3D acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
> +       if (ACPI_FAILURE(status)) {
> +               bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_excepti=
on(status));
> +               return status;
> +       }
> +
> +       if (strncmp(BTINTEL_PPAG_PREFIX, string.pointer,
> +                   strlen(BTINTEL_PPAG_PREFIX))) {
> +               kfree(string.pointer);
> +               return AE_OK;
> +       }
> +
> +       len =3D strlen(string.pointer);
> +       if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, =
4)) {
> +               kfree(string.pointer);
> +               return AE_OK;
> +       }
> +       kfree(string.pointer);
> +
> +       status =3D acpi_evaluate_object(handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_excepti=
on(status));
> +               return status;
> +       }
> +
> +       p =3D buffer.pointer;
> +       ppag =3D (struct btintel_ppag *)data;
> +
> +       if (p->type !=3D ACPI_TYPE_PACKAGE || p->package.count !=3D 2) {
> +               kfree(buffer.pointer);
> +               bt_dev_warn(hdev, "Invalid object type: %d or package cou=
nt: %d",
> +                           p->type, p->package.count);
> +               return AE_ERROR;
> +       }
> +
> +       elements =3D p->package.elements;
> +
> +       /* PPAG table is located at element[1] */
> +       p =3D &elements[1];
> +
> +       ppag->domain =3D (u32)p->package.elements[0].integer.value;
> +       ppag->mode =3D (u32)p->package.elements[1].integer.value;
> +       kfree(buffer.pointer);
> +       return AE_CTRL_TERMINATE;
> +}
> +
>  static int btintel_set_debug_features(struct hci_dev *hdev,
>                                const struct intel_debug_features *feature=
s)
>  {
> @@ -2251,6 +2312,56 @@ static int btintel_configure_offload(struct hci_de=
v *hdev)
>         return err;
>  }
>
> +static int btintel_set_ppag(struct hci_dev *hdev, struct intel_version_t=
lv *ver)
> +{
> +       acpi_status status;
> +       struct btintel_ppag ppag;
> +       struct sk_buff *skb;
> +       struct btintel_loc_aware_reg ppag_cmd;
> +
> +    /* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
> +       switch (ver->cnvr_top & 0xFFF) {
> +       case 0x504:     /* Hrp2 */
> +       case 0x202:     /* Jfp2 */
> +       case 0x201:     /* Jfp1 */
> +               return 0;
> +       }
> +
> +       memset(&ppag, 0, sizeof(ppag));
> +
> +       ppag.hdev =3D hdev;
> +       status =3D acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
> +                                    ACPI_UINT32_MAX, NULL,
> +                                    btintel_ppag_callback, &ppag, NULL);
> +
> +       if (ACPI_FAILURE(status)) {
> +               bt_dev_warn(hdev, "PPAG: ACPI Failure: %s", acpi_format_e=
xception(status));

Shouldn't we consider it ok if the ACPI doesn't have an entry? I mean
it should be possible to plug a new controller in an old laptop that
possibly doesn't have this entry, right?

> +               return -1;
> +       }
> +
> +       if (ppag.domain !=3D 0x12) {
> +               bt_dev_warn(hdev, "PPAG-BT Domain disabled");
> +               return -1;
> +       }
> +
> +       /* PPAG mode, BIT0 =3D 0 Disabled, BIT0 =3D 1 Enabled */
> +       if (!(ppag.mode & BIT(0))) {
> +               bt_dev_dbg(hdev, "PPAG disabled");
> +               return 0;
> +       }
> +
> +       ppag_cmd.mcc =3D 0;
> +       ppag_cmd.sel =3D 0; /* 0 - Operational, 1 - Disable, 2 - Testing =
mode */
> +       ppag_cmd.delta =3D 0;
> +       skb =3D __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd,=
 HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR=
_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +       return 0;
> +}
> +
>  static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>                                         struct intel_version_tlv *ver)
>  {
> @@ -2297,6 +2408,9 @@ static int btintel_bootloader_setup_tlv(struct hci_=
dev *hdev,
>
>         hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
>
> +       /* Set PPAG feature */
> +       btintel_set_ppag(hdev, ver);

Looks like you are not using the return above which I guess is fine
since this step can be considered optional but I'd document it as such
and probably make btintel_set_ppag return void as it shouldn't be
considered as an error if it fails.

> +
>         /* Read the Intel version information after loading the FW  */
>         err =3D btintel_read_version_tlv(hdev, &new_ver);
>         if (err)
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index e0060e58573c..af508a0e0c42 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -137,6 +137,19 @@ struct intel_offload_use_cases {
>         __u8    preset[8];
>  } __packed;
>
> +/* structure to store the PPAG data read from ACPI table */
> +struct btintel_ppag {
> +       u32     domain;
> +       u32     mode;
> +       struct hci_dev *hdev;
> +};
> +
> +struct btintel_loc_aware_reg {
> +       u32 mcc;
> +       u32 sel;
> +       s32 delta;
> +};

The above struct seems to be used as command data, in which case it
should be __packed, also they shall probably use le32 since there is
no guarantee we would be running in a system with the same byte order
as the controller.

> +
>  #define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >>=
 8))
>  #define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >>=
 16))
>  #define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
