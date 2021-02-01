Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72A8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 22:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E61B64E9A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 22:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBAWOF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhBAWOF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 17:14:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4AC061573
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 14:13:25 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d7so17938715otf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Feb 2021 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZBoUQM98jU3MCog77APQ8Wnn1sTP5JXcpD1hzzisn4=;
        b=pF/6fCfm9Nb4f+pDnI6eBJA9USdpkjJayHE7VsL9CVh+q/3RMjWOICbV/16MXXeJ+Q
         iltzaCCyIOy6GX2D5964m+otoeSiLV05/EUhLgC7fW5l7QndJS4tQPQqqATsY1R+Pheg
         XyUkmr46+PUmJKSIGczIy6O1Lteh3F3ov70DGJPoxMWGDxggxM17lZGGOxAu87u2ud58
         D8ppm/Z4aDfccXPDQLg7VJekoUZAllbOjSWB81K6Nzmca6B/SSpsT3n1Ra/C8MspTLUc
         JshquHGWIAdV8fApRY7JUnjsei9BK20vEMhBKWHZmk+ZzY43JRHhRwJNeN5cFoxibqMO
         4xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZBoUQM98jU3MCog77APQ8Wnn1sTP5JXcpD1hzzisn4=;
        b=m8e+m9O/WgTQVLN5cEpL72jX6lEnFfnAErP4DBmp3krVPhES+eRuO0/vb5SII+Cjat
         fZt+dmc2j9B3mDMrdfHyJMGU87uWnoZdTxSApX5O8mkAqGbwHwrlx7e6LnanNhBZjfr5
         jVS5Jd9f8K39gIguSo5T3wa1PAKFNFchdUTededsW+IAqsy88pL4hiZXTJCpV3DearEw
         6KRsx3YqKW34FFs50cwjpNjUsdjtoVuzxentGWaLiqnkxSMMHjIIND/wvHqBhGnOZ89d
         fiVd78xPsECbNbEMysBmJLlTKzWP7iH928LIpQG4YxlI0095HMAwk1UjSReCCFw8v3KW
         EU4g==
X-Gm-Message-State: AOAM5314D4PWpoH1+VSO+SA2qK7cW6vpqbuTikqQQFU9vk9L1CCBaKf8
        TgLx5/p10yL/glp1RWXtSpQl3y+oeYP3SdPFeR0GDAiOesI=
X-Google-Smtp-Source: ABdhPJxGLvxgVNpeskeOd/a12hcRN8GgwleSNSXblwpYimgn9qqQwpWZKarZRc1du4eE5+IrG31C2P8lbYNRbsl+lN4=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr13222540otq.371.1612217604168;
 Mon, 01 Feb 2021 14:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20210201220626.890923-1-luiz.dentz@gmail.com>
In-Reply-To: <20210201220626.890923-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Feb 2021 14:13:13 -0800
Message-ID: <CABBYNZ+7LC_39uJ6s_UpJ7snhc3917ko7AJSr1BRKQXNNX0ToA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: btintel: Check firmware version before download
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Feb 1, 2021 at 2:06 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This checking the firmware build number, week and years matches and then
> skip the download process.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 88 ++++++++++++++++++++++++++++---------
>  drivers/bluetooth/btintel.h |  5 ++-
>  drivers/bluetooth/btusb.c   | 22 +++++-----
>  3 files changed, 83 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 88ce5f0ffc4b..bf7b910966c8 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -24,6 +24,14 @@
>  #define ECDSA_OFFSET           644
>  #define ECDSA_HEADER_LEN       320
>
> +#define CMD_WRITE_BOOT_PARAMS  0xfc0e
> +struct cmd_write_boot_params {
> +       u32 boot_addr;
> +       u8  fw_build_num;
> +       u8  fw_build_ww;
> +       u8  fw_build_yy;
> +} _packed;
> +
>  int btintel_check_bdaddr(struct hci_dev *hdev)
>  {
>         struct hci_rp_read_bd_addr *bda;
> @@ -841,7 +849,7 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
>
>  static int btintel_download_firmware_payload(struct hci_dev *hdev,
>                                              const struct firmware *fw,
> -                                            u32 *boot_param, size_t offset)
> +                                            size_t offset)
>  {
>         int err;
>         const u8 *fw_ptr;
> @@ -854,20 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
>         while (fw_ptr - fw->data < fw->size) {
>                 struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
>
> -               /* Each SKU has a different reset parameter to use in the
> -                * HCI_Intel_Reset command and it is embedded in the firmware
> -                * data. So, instead of using static value per SKU, check
> -                * the firmware data and save it for later use.
> -                */
> -               if (le16_to_cpu(cmd->opcode) == 0xfc0e) {
> -                       /* The boot parameter is the first 32-bit value
> -                        * and rest of 3 octets are reserved.
> -                        */
> -                       *boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
> -
> -                       bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
> -               }
> -
>                 frag_len += sizeof(*cmd) + cmd->plen;
>
>                 /* The parameter length of the secure send command requires
> @@ -896,28 +890,84 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
>         return err;
>  }
>
> +static bool btintel_firmware_version(struct hci_dev *hdev,
> +                                    u8 num, u8 ww, u8 yy,
> +                                    const struct firmware *fw,
> +                                    u32 *boot_addr)
> +{
> +       const u8 *fw_ptr;
> +       u32 frag_len;
> +
> +       fw_ptr = fw->data;
> +       frag_len = 0;
> +
> +       while (fw_ptr - fw->data < fw->size) {
> +               struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> +
> +               /* Each SKU has a different reset parameter to use in the
> +                * HCI_Intel_Reset command and it is embedded in the firmware
> +                * data. So, instead of using static value per SKU, check
> +                * the firmware data and save it for later use.
> +                */
> +               if (le16_to_cpu(cmd->opcode) == CMD_WRITE_BOOT_PARAMS) {
> +                       struct cmd_write_boot_params *params;
> +
> +                       params = (void *)(fw_ptr + sizeof(*cmd));
> +
> +                       bt_dev_dbg(hdev, "Boot Address: 0x%x\n"
> +                                  "Firmware Version: %u-%u.%u",
> +                                  le32_to_cpu(params->boot_addr),
> +                                  params->fw_build_num, params->fw_build_ww,
> +                                  params->fw_build_yy);
> +
> +                       if (num == params->fw_build_num &&
> +                           ww == params->fw_build_ww &&
> +                           yy == params->fw_build_yy)
> +                               return true;
> +                       else
> +                               return false;
> +               }
> +
> +               frag_len += sizeof(*cmd) + cmd->plen;
> +       }
> +
> +       return false;
> +}
> +
>  int btintel_download_firmware(struct hci_dev *hdev,
> +                             struct intel_version *ver,
>                               const struct firmware *fw,
>                               u32 *boot_param)
>  {
>         int err;
>
> +       /* Skip download if firmware has the same version */
> +       if (btintel_firmware_version(hdev, ver->fw_build_num, ver->fw_build_ww,
> +                                    ver->fw_build_yy, fw, boot_param))
> +               return -EALREADY;
> +
>         err = btintel_sfi_rsa_header_secure_send(hdev, fw);
>         if (err)
>                 return err;
>
> -       return btintel_download_firmware_payload(hdev, fw, boot_param,
> -                                                RSA_HEADER_LEN);
> +       return btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
>  }
>  EXPORT_SYMBOL_GPL(btintel_download_firmware);
>
>  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +                                    struct intel_version_tlv *ver,
>                                      const struct firmware *fw, u32 *boot_param,
>                                      u8 hw_variant, u8 sbe_type)
>  {
>         int err;
>         u32 css_header_ver;
>
> +       /* Skip download if firmware has the same version */
> +       if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> +                                    ver->min_fw_build_cw, ver->min_fw_build_yy,
> +                                    fw, boot_param))
> +               return -EALREADY;
> +

Can someone please confirm these parameters above are the same on
Write Boot Parameters? The LTV seems to have changed the version
information.

>         /* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
>          * only RSA secure boot engine. Hence, the corresponding sfi file will
>          * have RSA header of 644 bytes followed by Command Buffer.
> @@ -947,7 +997,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>                 if (err)
>                         return err;
>
> -               err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> +               err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
>                 if (err)
>                         return err;
>         } else if (hw_variant >= 0x17) {
> @@ -968,7 +1018,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>                                 return err;
>
>                         err = btintel_download_firmware_payload(hdev, fw,
> -                                                               boot_param,
>                                                                 RSA_HEADER_LEN + ECDSA_HEADER_LEN);
>                         if (err)
>                                 return err;
> @@ -978,7 +1027,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
>                                 return err;
>
>                         err = btintel_download_firmware_payload(hdev, fw,
> -                                                               boot_param,
>                                                                 RSA_HEADER_LEN + ECDSA_HEADER_LEN);
>                         if (err)
>                                 return err;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 6511b091caf5..51f1f2c883b4 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -163,9 +163,10 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
>  int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
>  int btintel_read_boot_params(struct hci_dev *hdev,
>                              struct intel_boot_params *params);
> -int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
> -                             u32 *boot_param);
> +int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> +                             const struct firmware *fw, u32 *boot_param);
>  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> +                                    struct intel_version_tlv *ver,
>                                      const struct firmware *fw,
>                                      u32 *boot_param, u8 hw_variant,
>                                      u8 sbe_type);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4266c057746e..a06e86f52da3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2612,14 +2612,15 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
>         set_bit(BTUSB_DOWNLOADING, &data->flags);
>
>         /* Start firmware downloading and get boot parameter */
> -       err = btintel_download_firmware_newgen(hdev, fw, boot_param,
> +       err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
>                                                INTEL_HW_VARIANT(ver->cnvi_bt),
>                                                ver->sbe_type);
>         if (err < 0) {
> -               /* When FW download fails, send Intel Reset to retry
> -                * FW download.
> -                */
> -               btintel_reset_to_bootloader(hdev);
> +               if (err != -EALREADY)
> +                       /* When FW download fails, send Intel Reset to retry
> +                        * FW download.
> +                        */
> +                       btintel_reset_to_bootloader(hdev);
>                 goto done;
>         }
>         set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> @@ -2806,12 +2807,13 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
>         set_bit(BTUSB_DOWNLOADING, &data->flags);
>
>         /* Start firmware downloading and get boot parameter */
> -       err = btintel_download_firmware(hdev, fw, boot_param);
> +       err = btintel_download_firmware(hdev, ver, fw, boot_param);
>         if (err < 0) {
> -               /* When FW download fails, send Intel Reset to retry
> -                * FW download.
> -                */
> -               btintel_reset_to_bootloader(hdev);
> +               if (err != -EALREADY)
> +                       /* When FW download fails, send Intel Reset to retry
> +                        * FW download.
> +                        */
> +                       btintel_reset_to_bootloader(hdev);
>                 goto done;
>         }
>         set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> --
> 2.26.2

@Abhishek: Could you please test this with the use case that you had
where you would want to skip the firmware download?

-- 
Luiz Augusto von Dentz
