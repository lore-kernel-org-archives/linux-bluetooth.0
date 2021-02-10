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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000ECC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB2864E66
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhBJTIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhBJTHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:07:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37317C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:06:58 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m7so3213835oiw.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW6euTmLnXhYdkn4W4SRQZLcO6yNE2ovOJ3GyQWDp9k=;
        b=SdPwM6cYBeeWOhm5ouuDyumBYz6RyfnYvpsZHBoexCmKS0R5qwe++J6obF9JkFFCIM
         jcx06DINAYOP4PQ3g/r9S6/iCxQILc9kHIoHfNLlGSWJuLBViIvy1PlPqOUM9Ufw+4DK
         Iwo42Vq5Bz+DrXcMh7RSiJYrgBTtxN0v0JxiYR/fn6UPakGSVI6F9VVN6t4FB39YjOAp
         zrqIno7V/RhwN2SUq0XpjS7oLUsHCOWDzOr4j9umviSxowD/lWQXAYArhxq4Dc8KVIEq
         FkM47fRPc9/h0fNNX/WEU+ohOcJKS5+HMoGTgHzwqXO/I70RaWN9tQDH27MrPhkSBPRI
         XDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW6euTmLnXhYdkn4W4SRQZLcO6yNE2ovOJ3GyQWDp9k=;
        b=Rzdw1Ot4g379sMzm//o4p4x4aJMFQAWyoVWYx9PIYmH5gVfa5vrPDQVdpcR25lc8Be
         fNopdZV88JTBYYUgcU5PZBy8KX9Fd+oR9VW4T3jUCIHqAa2RfpdPMPc0ImD+FGb1xgz3
         kr+DIA575Bcd17gApjsqLNmmwUggRuPiycHjT0p/foTCb63xJQP/8aNc0VFuqaUqT92k
         aMJJwUim2YQ2SacCgKIoKekF1244RdTiY4TbznrWhe1+dVUtw62WJzjMlNPVYUu66uzM
         8onBxJtN4mqkuKOeyfmswte5p3VN5dRWSdMJucmsZj9n2JR00OCR/lsKvmERNPwvMbc8
         lpCw==
X-Gm-Message-State: AOAM533XgL+DVg4GYXWtMyKsGnIVBV8NY4DpS3v8K3Hg7uEB80PMV/r8
        UiiK2vGUKZxevQwAJTv0d9964vGsrVRl5z7H1o0=
X-Google-Smtp-Source: ABdhPJwItgNDt2Q86RSoMRLMdLpQF3DQMg5s6lFP3Xr/7DDJtU76pOWkOvnCc/JVRUKtp9+4ZLsJAj5sgrsF6ldy96A=
X-Received: by 2002:aca:c109:: with SMTP id r9mr339975oif.64.1612984017451;
 Wed, 10 Feb 2021 11:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20210210165916.2148856-1-luiz.dentz@gmail.com> <027d8851051d084bd3108782c0c3f389a4711be1.camel@linux.intel.com>
In-Reply-To: <027d8851051d084bd3108782c0c3f389a4711be1.camel@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Feb 2021 11:06:46 -0800
Message-ID: <CABBYNZKOV2VDaY3fKAan4Beim5v8b8h5SwPZDe=+f9o2+LnwDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] Bluetooth: btintel: Check firmware version before download
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Feb 10, 2021 at 10:50 AM Tedd Ho-Jeong An
<tedd.an@linux.intel.com> wrote:
>
> Hi Luiz,
>
> On Wed, 2021-02-10 at 08:59 -0800, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This checks the firmware build number, week and year matches with
> > repective version loaded and then skip the download process.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Add patch that mover checks for operational mode after the version
> > checking.
> > v3: Fix not checking for operation mode before using btintel_read_boot_params
> > since some models depend on that to contruct the fw filename. Also attempt to
> > cleanup duplicated code.
> > v4: Fix forwarding -EALREADY when firmware has already been loaded.
> >
> >  drivers/bluetooth/btintel.c   | 96 +++++++++++++++++++++++++++--------
> >  drivers/bluetooth/btintel.h   |  5 +-
> >  drivers/bluetooth/btusb.c     | 18 ++++++-
> >  drivers/bluetooth/hci_intel.c |  7 ++-
> >  4 files changed, 100 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 88ce5f0ffc4b..89f85d54ca64 100644
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
> > @@ -896,28 +890,92 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
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
>
> Looping with all constant value may causes an buffer overflow if the file
> doesn't have "CMD_WRITE_BOOT_PARAMS" for some reason.
>
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
>
> The params doesn't point the right value since the fw_ptr never updates in the loop.
> This might cause reloading the firmware even if fw version is same since it alwasy return false.

Yep, this will never gonna work if we don't advance fw_ptr.

> > +
> > +                     bt_dev_info(hdev, "Boot Address: 0x%x",
> > +                                le32_to_cpu(params->boot_addr));
> > +
> > +                     bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
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
> > +             bt_dev_info(hdev, "Firmware already loaded");
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
> > +             bt_dev_info(hdev, "Firmware already loaded");
> > +             /* Return -EALREADY to indicate that firmware has already been
> > +              * loaded.
> > +              */
> > +             return -EALREADY;
> > +     }
> > +
> >       /* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
> >        * only RSA secure boot engine. Hence, the corresponding sfi file will
> >        * have RSA header of 644 bytes followed by Command Buffer.
> > @@ -947,7 +1005,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> >               if (err)
> >                       return err;
> >
> > -             err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> > +             err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
> >               if (err)
> >                       return err;
> >       } else if (hw_variant >= 0x17) {
> > @@ -968,7 +1026,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
> >                               return err;
> >
> >                       err = btintel_download_firmware_payload(hdev, fw,
> > -                                                             boot_param,
> >                                                               RSA_HEADER_LEN + ECDSA_HEADER_LEN);
> >                       if (err)
> >                               return err;
> > @@ -978,7 +1035,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
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
> > index 66ada8217797..c92060e7472c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2623,10 +2623,17 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
> > +                     err = 0;
> > +                     goto done;
> > +             }
> > +
> >               /* When FW download fails, send Intel Reset to retry
> >                * FW download.
> >                */
> > @@ -2817,8 +2824,15 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> >       set_bit(BTUSB_DOWNLOADING, &data->flags);
> >
> >       /* Start firmware downloading and get boot parameter */
> > -     err = btintel_download_firmware(hdev, fw, boot_param);
> > +     err = btintel_download_firmware(hdev, ver, fw, boot_param);
> >       if (err < 0) {
> > +             if (err == -EALREADY) {
> > +                     /* Firmware has already been loaded */
> > +                     set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
> > +                     err = 0;
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
>


-- 
Luiz Augusto von Dentz
