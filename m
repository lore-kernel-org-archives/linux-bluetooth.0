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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE2AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26FA64EB4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 16:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhBIQrD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhBIQp0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 11:45:26 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53406C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 08:44:46 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id y11so18062254otq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iJs6HzxDAPg9BxeR+B0vf69Tj48vU5wD52AD6Ky724=;
        b=KYwNph7CnVo6U4fLAFl32ySW30Uz+S3c5GT59tgpKnTOS8oTrJzcyfzdpPmuBZewxR
         Ef6J1F7aJ0JNsb1r72CadwnPt3mwYg9OieZVbXsrB1jI7Gx11FCV8Zggv2KyQyEucpp5
         QTinZh2zABczw6PGWk9i8YGy+nhPYhnvCVL1o1FgRzfktiXBNtyocqrp0Ye1aWbOj3cR
         nrsTaEPx3XfwqT9UUKEKcq/pvfVGvMHNQYz/WmvoeiAA5rTAclsNKtTt86103DRJRlc0
         tl87trRKIy3FENMqzAH/F2VUtsRtU3hCV992qHV2z09W4Kv/t2tb6wiaargvkDHn+Nsh
         lnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iJs6HzxDAPg9BxeR+B0vf69Tj48vU5wD52AD6Ky724=;
        b=a/L3HStCqvdPpuUOQ2qPp2nBrctTfQrh9XscYdfNV9WPKOS2FgwF6SBp+HQ1fFd/89
         e6x4GbJFtqIH8DD4yzWBfu34ed6UHsuNvb3iJKNegzZNtnz3dqC/QIPPCbIZAGyeDETQ
         VM7XRxzRYH17US358tzdym/L3zPdVDXFx0dB01AHkw/XfudcJ/6oQos/Oq9Y51vzw13J
         x3zQ9XHOk28uEjpAUwgF3Jy6k8bhE6nacVEgRA+O+OOAQ+9g5AVY37cKxXjWrDKEu8+n
         XcMYcheEQL4+L+5xt7wYTr2wby4Qeg/KrzcBbTfA1eZV8Ut9xExL7N6UMSLSeAIwNxhl
         jEUA==
X-Gm-Message-State: AOAM530pD2SUSlqg/3TdvgRQ8jv7BKkqcAow2JKC1vRbeAVyE0geSfxy
        df2STf72YVZTL0DR6i4FHLDHSHGY9rZ8WhyZ5cpJNhb/pvE=
X-Google-Smtp-Source: ABdhPJzP3JbhJBjopmn+pkEqOFoyCZqigTGkix/j81BMyFi9J1uNvMBZotlxEj5G631rCg6B9UPoKffxP/XdiBzHRqY=
X-Received: by 2002:a9d:6c7:: with SMTP id 65mr7783171otx.240.1612889085447;
 Tue, 09 Feb 2021 08:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20210204213414.1417675-1-luiz.dentz@gmail.com> <48a1f50435579ea07ab41d6e5faa766f21047d1f.camel@intel.com>
In-Reply-To: <48a1f50435579ea07ab41d6e5faa766f21047d1f.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Feb 2021 08:44:34 -0800
Message-ID: <CABBYNZ+f7D79Ri_QZCTzaYSuZS+HFqM2BBm=4tdDQy3MGD4L9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel: Check firmware version before download
To:     "An, Tedd" <tedd.an@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Tue, Feb 9, 2021 at 12:46 AM An, Tedd <tedd.an@intel.com> wrote:
>
> Hi Luiz,
>
> I ran a quick test with "New FW + Reboot" scenario and it didn't update
> to the new firmware after reboot.
>
> There is a checking of fw_variant in the btusb_intel_download_firmware() in btusb.c,
> which will exit the function when the fw is running in operational mode.
>
>         /* The firmware variant determines if the device is in bootloader
>          * mode or is running operational firmware. The value 0x06 identifies
>          * the bootloader and the value 0x23 identifies the operational
>          * firmware.
>          *
>          * When the operational firmware is already present, then only
>          * the check for valid Bluetooth device address is needed. This
>          * determines if the device will be added as configured or
>          * unconfigured controller.
>          *
>          * It is not possible to use the Secure Boot Parameters in this
>          * case since that command is only available in bootloader mode.
>          */
>         if (ver->fw_variant == 0x23) {
>                 clear_bit(BTUSB_BOOTLOADER, &data->flags);
>                 btintel_check_bdaddr(hdev);
>                 return 0;
>         }
>
> So, the checking firmware version will never be called if the firmware is already running in operational firmware.

I think we might need to remove this check actually since as Tedd
pointed out it actually prevents updates to the firmware given that it
is already operational, now with the version checking it would prevent
the loading of the same firmware anyway which is probably why this was
introduced in the first place.

> Regards,
> Tedd
>
> On Thu, 2021-02-04 at 13:34 -0800, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This checks the firmware build number, week and year matches with
> > repective version loaded and then skip the download process.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >
> >
> >  drivers/bluetooth/btintel.c   | 94 +++++++++++++++++++++++++++--------
> >  drivers/bluetooth/btintel.h   |  5 +-
> >  drivers/bluetooth/btusb.c     | 16 +++++-
> >  drivers/bluetooth/hci_intel.c |  7 ++-
> >  4 files changed, 96 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 88ce5f0ffc4b..153989bd8d5f 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -24,6 +24,14 @@
> >  #define ECDSA_OFFSET         644
> >  #define ECDSA_HEADER_LEN     320
> >
> > +#define CMD_WRITE_BOOT_PARAMS        0xfc0e
> > +struct cmd_write_boot_params {
> > +     u32 boot_addr;
> > +     u8  fw_build_num;
> > +     u8  fw_build_ww;
> > +     u8  fw_build_yy;
> > +} __packed;
> > +
> >  int btintel_check_bdaddr(struct hci_dev *hdev)
> >  {
> >       struct hci_rp_read_bd_addr *bda;
> > @@ -841,7 +849,7 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
> >
> >  static int btintel_download_firmware_payload(struct hci_dev *hdev,
> >                                            const struct firmware *fw,
> > -                                          u32 *boot_param, size_t offset)
> > +                                          size_t offset)
> >  {
> >       int err;
> >       const u8 *fw_ptr;
> > @@ -854,20 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
> >       while (fw_ptr - fw->data < fw->size) {
> >               struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> >
> > -             /* Each SKU has a different reset parameter to use in the
> > -              * HCI_Intel_Reset command and it is embedded in the firmware
> > -              * data. So, instead of using static value per SKU, check
> > -              * the firmware data and save it for later use.
> > -              */
> > -             if (le16_to_cpu(cmd->opcode) == 0xfc0e) {
> > -                     /* The boot parameter is the first 32-bit value
> > -                      * and rest of 3 octets are reserved.
> > -                      */
> > -                     *boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
> > -
> > -                     bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
> > -             }
> > -
> >               frag_len += sizeof(*cmd) + cmd->plen;
> >
> >               /* The parameter length of the secure send command requires
> > @@ -896,28 +890,90 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
> >       return err;
> >  }
> >
> > +static bool btintel_firmware_version(struct hci_dev *hdev,
> > +                                  u8 num, u8 ww, u8 yy,
> > +                                  const struct firmware *fw,
> > +                                  u32 *boot_addr)
> > +{
> > +     const u8 *fw_ptr;
> > +     u32 frag_len;
> > +
> > +     fw_ptr = fw->data;
> > +     frag_len = 0;
> > +
> > +     while (fw_ptr - fw->data < fw->size) {
> > +             struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> > +
> > +             /* Each SKU has a different reset parameter to use in the
> > +              * HCI_Intel_Reset command and it is embedded in the firmware
> > +              * data. So, instead of using static value per SKU, check
> > +              * the firmware data and save it for later use.
> > +              */
> > +             if (le16_to_cpu(cmd->opcode) == CMD_WRITE_BOOT_PARAMS) {
> > +                     struct cmd_write_boot_params *params;
> > +
> > +                     params = (void *)(fw_ptr + sizeof(*cmd));
> > +
> > +                     bt_dev_dbg(hdev, "Boot Address: 0x%x",
> > +                                le32_to_cpu(params->boot_addr));
> > +
> > +                     bt_dev_dbg(hdev, "Firmware Version: %u-%u.%u",
> > +                                params->fw_build_num, params->fw_build_ww,
> > +                                params->fw_build_yy);
> > +
> > +                     return (num == params->fw_build_num &&
> > +                             ww == params->fw_build_ww &&
> > +                             yy == params->fw_build_yy);
> > +             }
> > +
> > +             frag_len += sizeof(*cmd) + cmd->plen;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  int btintel_download_firmware(struct hci_dev *hdev,
> > +                           struct intel_version *ver,
> >                             const struct firmware *fw,
> >                             u32 *boot_param)
> >  {
> >       int err;
> >
> > +     /* Skip download if firmware has the same version */
> > +     if (btintel_firmware_version(hdev, ver->fw_build_num, ver->fw_build_ww,
> > +                                  ver->fw_build_yy, fw, boot_param)) {
> > +             /* Return -EALREADY to indicate that the firmware has already
> > +              * been loaded.
> > +              */
> > +             return -EALREADY;
> > +     }
> > +
> >       err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> >       if (err)
> >               return err;
> >
> > -     return btintel_download_firmware_payload(hdev, fw, boot_param,
> > -                                              RSA_HEADER_LEN);
> > +     return btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
> >  }
> >  EXPORT_SYMBOL_GPL(btintel_download_firmware);
> >
> >  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> > +                                  struct intel_version_tlv *ver,
> >                                    const struct firmware *fw, u32 *boot_param,
> >                                    u8 hw_variant, u8 sbe_type)
> >  {
> >       int err;
> >       u32 css_header_ver;
> >
> > +     /* Skip download if firmware has the same version */
> > +     if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
> > +                                  ver->min_fw_build_cw, ver->min_fw_build_yy,
> > +                                  fw, boot_param)) {
> > +             /* Return -EALREADY to indicate that firmware has already been
> > +              * loaded.
> > +              */
> > +             return -EALREADY;
> > +     }
> > +
> >       /* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
> >        * only RSA secure boot engine. Hence, the corresponding sfi file will
> >        * have RSA header of 644 bytes followed by Command Buffer.
> > @@ -947,7 +1003,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> >               if (err)
> >                       return err;
> >
> > -             err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> > +             err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
> >               if (err)
> >                       return err;
> >       } else if (hw_variant >= 0x17) {
> > @@ -968,7 +1024,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> >                               return err;
> >
> >                       err = btintel_download_firmware_payload(hdev, fw,
> > -                                                             boot_param,
> >                                                               RSA_HEADER_LEN + ECDSA_HEADER_LEN);
> >                       if (err)
> >                               return err;
> > @@ -978,7 +1033,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> >                               return err;
> >
> >                       err = btintel_download_firmware_payload(hdev, fw,
> > -                                                             boot_param,
> >                                                               RSA_HEADER_LEN + ECDSA_HEADER_LEN);
> >                       if (err)
> >                               return err;
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index 6511b091caf5..51f1f2c883b4 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -163,9 +163,10 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
> >  int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
> >  int btintel_read_boot_params(struct hci_dev *hdev,
> >                            struct intel_boot_params *params);
> > -int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
> > -                           u32 *boot_param);
> > +int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
> > +                           const struct firmware *fw, u32 *boot_param);
> >  int btintel_download_firmware_newgen(struct hci_dev *hdev,
> > +                                  struct intel_version_tlv *ver,
> >                                    const struct firmware *fw,
> >                                    u32 *boot_param, u8 hw_variant,
> >                                    u8 sbe_type);
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 4266c057746e..9a4a37e396b5 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2612,10 +2612,16 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
> >       set_bit(BTUSB_DOWNLOADING, &data->flags);
> >
> >       /* Start firmware downloading and get boot parameter */
> > -     err = btintel_download_firmware_newgen(hdev, fw, boot_param,
> > +     err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
> >                                              INTEL_HW_VARIANT(ver->cnvi_bt),
> >                                              ver->sbe_type);
> >       if (err < 0) {
> > +             if (err == -EALREADY) {
> > +                     /* Firmware has already been loaded */
> > +                     set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> > +                     goto done;
> > +             }
> > +
> >               /* When FW download fails, send Intel Reset to retry
> >                * FW download.
> >                */
> > @@ -2806,8 +2812,14 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> >       set_bit(BTUSB_DOWNLOADING, &data->flags);
> >
> >       /* Start firmware downloading and get boot parameter */
> > -     err = btintel_download_firmware(hdev, fw, boot_param);
> > +     err = btintel_download_firmware(hdev, ver, fw, boot_param);
> >       if (err < 0) {
> > +             if (err == -EALREADY) {
> > +                     /* Firmware has already been loaded */
> > +                     set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> > +                     goto done;
> > +             }
> > +
> >               /* When FW download fails, send Intel Reset to retry
> >                * FW download.
> >                */
> > diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> > index b20a40fab83e..7249b91d9b91 100644
> > --- a/drivers/bluetooth/hci_intel.c
> > +++ b/drivers/bluetooth/hci_intel.c
> > @@ -735,7 +735,7 @@ static int intel_setup(struct hci_uart *hu)
> >       set_bit(STATE_DOWNLOADING, &intel->flags);
> >
> >       /* Start firmware downloading and get boot parameter */
> > -     err = btintel_download_firmware(hdev, fw, &boot_param);
> > +     err = btintel_download_firmware(hdev, &ver, fw, &boot_param);
> >       if (err < 0)
> >               goto done;
> >
> > @@ -784,7 +784,10 @@ static int intel_setup(struct hci_uart *hu)
> >  done:
> >       release_firmware(fw);
> >
> > -     if (err < 0)
> > +     /* Check if there was an error and if is not -EALREADY which means the
> > +      * firmware has already been loaded.
> > +      */
> > +     if (err < 0 && err != -EALREADY)
> >               return err;
> >
> >       /* We need to restore the default speed before Intel reset */



-- 
Luiz Augusto von Dentz
