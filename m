Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 18:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349234AbiDKSrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbiDKSru (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 14:47:50 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528402CC9F
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:45:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2eafabbc80aso175899157b3.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p3bN3ZG1sFv0w36j9uW2MNlGWIeVcizrsv1xoxYlhg=;
        b=Qm2yxZkUVPJ4/fSD3xtlhg1aUKW3eMSsx5IdVv3zGFCmuCfupU9im0VoijyvDNiATk
         V8q0LI1wb2eUjia5LNqF6VR1fXsCp4I3PUWlLj1SxzyGvWeKKI6ELdw/FkmdPw0cB1iB
         QaMB3FahGxKRI2/AQTcl2sTUpc4KIAWlh5lhljkhYSMqWVIDE4cQtO6hMc6FFMCd2+2r
         vEn5pEOpme1kMRJdp36/Dagi72XFOnbxc6wrHy4ISwZgJCkK3YJw5Rr67wUVbQhHcNJG
         xFPpvZXGl5cksUT6ciFOkAzTZW94zgjeVSNfMQOx95d6VV9T/vGPcCEWeWwhg5M+qvMD
         VnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p3bN3ZG1sFv0w36j9uW2MNlGWIeVcizrsv1xoxYlhg=;
        b=CUPTYdGdu+JU+4oziSQHWP9S4dJl+++F3n0OoF4pcW0Y8LDHGg+AigwyvbnEhD0R99
         SBD5e/tbgm4hQc0zyfjLJKSq6e2BfvOozI7ki4hr8UAMO6DSXOeAY902M9Rg/+9LUH9c
         iFafC/W//meHQ1Avw16qBbrloVGigcrD47TGcK5beS1fjmemWdzEqSK6qVVuUii5hU+/
         ZfopoFuy5ZfoCcHk6i4FuKXdzqG36mJ+ESuVS/FPTf1LMst83i6USIpiDDpSlFivt4wQ
         CIbxRX5eYj0rTXNaNZ9bTcvQ/w90eVVelFpkYAadx5i9VAFhIq3u1uWwROlwYiQYnhj0
         wf/w==
X-Gm-Message-State: AOAM533xKD/ryVYgS6UF9xEEypP+yznBX85d5nBAta3r69rjhrJ/rpTU
        dxgaLoWzSX6pZfbAscVlOZztXLkaNe2KCwsnkfErSpT7
X-Google-Smtp-Source: ABdhPJzOj/7LbfUVF97G8jjq77FUeN8rWY7e3aC04DtbQbYtBj4Kc1DMTbj4Mt0ntfb17QGB5DExpQLOZN2JlY4i3ws=
X-Received: by 2002:a81:4987:0:b0:2ec:4986:eeb4 with SMTP id
 w129-20020a814987000000b002ec4986eeb4mr2580395ywa.150.1649702733431; Mon, 11
 Apr 2022 11:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220408080633.20463-1-kiran.k@intel.com>
In-Reply-To: <20220408080633.20463-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 11 Apr 2022 11:45:22 -0700
Message-ID: <CABBYNZJSE32xQF5buFUCN-QcmMyPPuHpnPMp_vvHRkRUTM65ng@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support to configure TX power
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Seema S <seema.sreemantha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Fri, Apr 8, 2022 at 1:02 AM Kiran K <kiran.k@intel.com> wrote:
>
> BRDS - Bluetooth Regulatory Domain Specific absorption rate
> -----------------------------------------------------------
>
> Bluetooth has regulatory limitations which prohibit or allow usage
> of certain bands or channels as well as limiting Tx power. The Tx power
> values can be configured in ACPI table. This patch reads ACPI entry of
> Bluetooth SAR and configures the controller accordingly.

It should be great to have a trace example of the commands in use, so
if we can have btmon decoding these to show what is being sent that
way we can also debug if something goes wrong.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Seema S <seema.sreemantha@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 229 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  18 +++
>  2 files changed, 247 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 818681c89db8..d3dc703eba78 100644
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
> @@ -32,6 +33,9 @@ struct cmd_write_boot_params {
>         u8  fw_build_yy;
>  } __packed;
>
> +#define BTINTEL_SAR_NAME       "BRDS"
> +#define BTINTEL_SAR_PREFIX     "\\_SB_.PC00.XHCI.RHUB"
> +
>  int btintel_check_bdaddr(struct hci_dev *hdev)
>  {
>         struct hci_rp_read_bd_addr *bda;
> @@ -2250,6 +2254,228 @@ static int btintel_configure_offload(struct hci_dev *hdev)
>         return err;
>  }
>
> +static acpi_status btintel_sar_callback(acpi_handle handle, u32 lvl, void *data,
> +                                       void **ret)
> +{
> +       acpi_status status;
> +       int len;
> +       struct btintel_sar *sar;
> +       union acpi_object *p, *elements;
> +       struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
> +       struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +
> +       status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
> +       if (ACPI_FAILURE(status)) {
> +               BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
> +               return status;
> +       }
> +
> +       if (strncmp(BTINTEL_SAR_PREFIX, string.pointer,
> +                   strlen(BTINTEL_SAR_PREFIX))) {
> +               kfree(string.pointer);
> +               return AE_OK;
> +       }
> +
> +       len = strlen(string.pointer);
> +       if (strncmp((char *)string.pointer + len - 4, BTINTEL_SAR_NAME, 4)) {
> +               kfree(string.pointer);
> +               return AE_OK;
> +       }
> +       kfree(string.pointer);
> +
> +       status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
> +               return status;
> +       }
> +
> +       p = buffer.pointer;
> +       sar = data;
> +
> +       if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
> +               kfree(buffer.pointer);
> +               BT_DBG("Invalid object type or package count");
> +               return AE_ERROR;
> +       }
> +
> +       elements = p->package.elements;
> +
> +       /* SAR table is located at element[1] */
> +       p = &elements[1];
> +
> +       if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 8) {
> +               kfree(buffer.pointer);
> +               return AE_ERROR;
> +       }
> +
> +       sar->domain = (u8)p->package.elements[0].integer.value;
> +       sar->type = (u8)p->package.elements[1].integer.value;
> +       sar->br = (u32)p->package.elements[2].integer.value;
> +       sar->edr2 = (u32)p->package.elements[3].integer.value;
> +       sar->edr3 = (u32)p->package.elements[4].integer.value;
> +       sar->le = (u32)p->package.elements[5].integer.value;
> +       sar->le_2mhz = (u32)p->package.elements[6].integer.value;
> +       sar->le_lr  = (u32)p->package.elements[7].integer.value;
> +       kfree(buffer.pointer);
> +       return AE_CTRL_TERMINATE;
> +}
> +
> +static void btintel_send_sar_ddc(struct hci_dev *hdev, void *data, u8 len)
> +{
> +       struct sk_buff *skb;
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc8b, len, data, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send Intel Write SAR DDC (%ld)", PTR_ERR(skb));
> +               return;
> +       }
> +       kfree_skb(skb);
> +}
> +
> +static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar *sar)
> +{
> +       struct btintel_cp_ddc_write     *cmd;
> +       u8      buffer[64];
> +
> +       if (!sar)
> +               return -EINVAL;

Add a memset to 0 as this may trigger uninitialized errors in the
likes of static analyzers.

> +       cmd = (void *)buffer;
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x0131);
> +       cmd->data[0] = sar->br >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 4);

We should probably handle the errors when sending these commands and
don't continue, also perhaps it would be better to have each command
in its own function with a proper name indicating what it is doing.

> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x0132);
> +       cmd->data[0] = sar->br >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       cmd->len = 5;
> +       cmd->id = cpu_to_le16(0x0137);
> +       cmd->data[0] = sar->br >> 3;
> +       cmd->data[1] = sar->edr2 >> 3;
> +       cmd->data[2] = sar->edr3 >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +       cmd->len = 5;
> +       cmd->id = cpu_to_le16(0x0138);
> +       cmd->data[0] = sar->br >> 3;
> +       cmd->data[1] = sar->edr2 >> 3;
> +       cmd->data[2] = sar->edr3 >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +       cmd->len = 5;
> +       cmd->id = cpu_to_le16(0x013b);
> +       cmd->data[0] = sar->br >> 3;
> +       cmd->data[1] = sar->edr2 >> 3;
> +       cmd->data[2] = sar->edr3 >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +       cmd->len = 5;
> +       cmd->id = cpu_to_le16(0x013c);
> +       cmd->data[0] = sar->br >> 3;
> +       cmd->data[1] = sar->edr2 >> 3;
> +       cmd->data[2] = sar->edr3 >> 3;
> +       btintel_send_sar_ddc(hdev, cmd, 6);
> +
> +       return 0;
> +}
> +
> +static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar *sar)
> +{
> +       u8 buffer[64];
> +       struct btintel_cp_ddc_write *cmd;
> +       u8 enable[1] = {1};
> +       struct sk_buff *skb;
> +
> +       if (!sar)
> +               return -EINVAL;
> +
> +       cmd = (void *)buffer;
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x019e);
> +       if (!(sar->le_2mhz & BIT(7)))
> +               cmd->data[0] = 0x01;
> +       else
> +               cmd->data[0] = 0x00;
> +       btintel_send_sar_ddc(hdev, cmd, 4);

Ditto as above.

> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x019f);
> +       cmd->data[0] = sar->le_lr;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x01a0);
> +       cmd->data[0] = sar->br;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x01a1);
> +       cmd->data[0] = sar->edr2;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x01a2);
> +       cmd->data[0] = sar->edr3;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       cmd->len = 3;
> +       cmd->id = cpu_to_le16(0x01a3);
> +       cmd->data[0] = sar->le;
> +       btintel_send_sar_ddc(hdev, cmd, 4);
> +
> +       skb = __hci_cmd_sync(hdev, 0xfe25, 1, enable, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)", PTR_ERR(skb));
> +               return PTR_ERR(skb);
> +       }
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +
> +static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
> +                                               struct intel_version_tlv *ver)
> +{
> +       acpi_status status;
> +       struct btintel_sar sar;
> +
> +       switch (ver->cnvr_top & 0xfff) {
> +       case 0x810: /* MsP */
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       memset(&sar, 0, sizeof(sar));
> +
> +       status = acpi_walk_namespace(ACPI_TYPE_METHOD, ACPI_ROOT_OBJECT,
> +                                    ACPI_UINT32_MAX, NULL,
> +                                    btintel_sar_callback, &sar, NULL);
> +
> +       if (ACPI_FAILURE(status))
> +               return -1;
> +
> +       if (sar.domain != 0x12)
> +               return -1;
> +
> +       /* No need to configure controller if Bluetooth SAR is disabled in BIOS
> +        */
> +       if (!sar.type)
> +               return 0;
> +
> +       if (sar.type == 1) {
> +               bt_dev_info(hdev, "Applying both legacy and mutual Bluetooth SAR");
> +               btintel_set_legacy_sar(hdev, &sar);
> +               btintel_set_mutual_sar(hdev, &sar);
> +       }
> +       return 0;
> +}
> +
>  static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>                                         struct intel_version_tlv *ver)
>  {
> @@ -2294,6 +2520,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>         /* Read supported use cases and set callbacks to fetch datapath id */
>         btintel_configure_offload(hdev);
>
> +       /* Set Specific Absorption Rate */
> +       btintel_set_specific_absorption_rate(hdev, ver);
> +
>         hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
>
>         /* Read the Intel version information after loading the FW  */
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index e0060e58573c..7aa58fb7b02a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -137,6 +137,24 @@ struct intel_offload_use_cases {
>         __u8    preset[8];
>  } __packed;
>
> +/* structure to store the data read from ACPI table */
> +struct btintel_sar {
> +       u8      domain;
> +       u8      type;
> +       u32     br;
> +       u32     edr2;
> +       u32     edr3;
> +       u32     le;
> +       u32     le_2mhz;
> +       u32     le_lr;
> +};

The above should also be using __packed, also for data packets the
multibyte field shall tell what is the expected endianness so given
the id below is using __le16 I assume the fields above shall be
__le32.

> +struct btintel_cp_ddc_write {
> +       u8      len;
> +       __le16  id;
> +       u8      data[0];
> +} __packed;
> +
>  #define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
>  #define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >> 16))
>  #define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
