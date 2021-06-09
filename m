Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C1C48BCD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FE7613E3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFIWea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhFIWe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 18:34:29 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6CFC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jun 2021 15:32:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e10so37757686ybb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6+vDNoDJ300b0mDMbl4jt3FiXHpe2MEzvfPQdtKEks=;
        b=QSv/J8YZMdQojdNFnH4lTlCKO+RZmu36N1xe/mlSMcObKh2+2JlpqNkr32eVdTwBFq
         E+y6kbjNHAnyufwORUuWO6oJr/tpSP8VWym7G5fJfvUMM5H3YoJY00XVb5/nDN52Owar
         BABNHcya1Sb7BiOjdBP+jbSl1YbDetrumWAZg8NyXBi1lL+Tch/wyIANMCPmdkzRbqlO
         FoJL+tPDN8HvnMCqTsdc7KzMZM5C4v3Y7rOapFuNyoWTSH9u2NsZAJJfSyrXhCVrwHDf
         vpcfrAi7Xs5CcrRMDiQ1iwHZXi2xFJWQ4Ll3XWmoIU1dS8rFa3uCoxSiDukoYRfOq/F9
         5fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6+vDNoDJ300b0mDMbl4jt3FiXHpe2MEzvfPQdtKEks=;
        b=ItoJ/H6l9XWO/N8Ysl8CFawX3bl1801U55pqT3so0OTtTfMeG5iuLi52gmdl6GFREI
         PnvC2ZiIZpw9n4PT6NA4oolZiLubsz4/pTMnSOKkCG9F1fCVRwKwhiSWd4BVTjrvINU6
         EEe8YUgrj1mCw9vrv17TRlA7D3K+6pKxrehFP3n+0jrWVal+/2ioaauNAi8dACbZ9xSC
         R5zD6YNeHJpmK+5huM8iAZlOzF5i3T7rNlf7uDtaonWFwxwHrFw3zpbj4VHoeVNyWwWC
         tT/bKMj+N6sCeSDPyzbHITakw6Qw0YXduDbnqiPPepxx3Gn/dw7E4ZDevYyK8Uz+EDuu
         m2Mw==
X-Gm-Message-State: AOAM530UYE2bJc0A8w5jgZyINX+Qob69fxPTucWQmK5gsncbTahD/MmD
        SwRd7zbU+lI8bnex1TKMCEB1Z8fvrrJstNqd2Cw=
X-Google-Smtp-Source: ABdhPJxDaT4KqJw6fpGxqwNEqFQa+e3eWj3iNMU8rpjritx72x5zHeUXHvzbbuW4U1R72yeOeSyAd3F8XVJXnIdT7a8=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr3519777ybu.282.1623277942106;
 Wed, 09 Jun 2021 15:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210609114029.1656-1-kiran.k@intel.com> <E6C00EEB-8D02-4EF1-87FD-75E58023BA67@holtmann.org>
In-Reply-To: <E6C00EEB-8D02-4EF1-87FD-75E58023BA67@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Jun 2021 15:32:10 -0700
Message-ID: <CABBYNZKL73_Z7x2-by4cFbx4rHiyedsYQcfrO5a52BCy3ATt2g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Support Digital(N) + RF(N-1) combination
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Kiran K <kiran.k@intel.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Kiran,

On Wed, Jun 9, 2021 at 12:15 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Kiran,
>
> > New generation Intel controllers(N) need to support RF from (N-1)
> > generation. Since PID comes from OTP present in RF module,
> > *setup* function gets mapped to BTUSB_INTEL_NEW instead of
> > BTUSB_INTEL_NEWGEN. This patch checks generation of CNVi in
> > *setup* of BTUSB_INTEL_NEW and maps callbacks to BTUSB_INTEL_NEWGEN
> > if new generation controller is found and attempts *setup* of
> > BTUSB_INTEL_NEWGEN.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 119 ++++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btintel.h |  10 +++
> > drivers/bluetooth/btusb.c   |  45 +++++++++++++-
> > net/bluetooth/hci_core.c    |   5 +-
> > 4 files changed, 177 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index e44b6993cf91..1d9ecc481f14 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -483,6 +483,85 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
> > }
> > EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> >
> > +void btintel_parse_version_tlv(struct hci_dev *hdev, struct sk_buff *skb,
> > +                            struct intel_version_tlv *version)
> > +{
> > +     /* Consume Command Complete Status field */
> > +     skb_pull(skb, sizeof(__u8));
> > +
> > +     /* Event parameters contatin multiple TLVs. Read each of them
> > +      * and only keep the required data. Also, it use existing legacy
> > +      * version field like hw_platform, hw_variant, and fw_variant
> > +      * to keep the existing setup flow
> > +      */
> > +     while (skb->len) {
> > +             struct intel_tlv *tlv;
> > +
> > +             tlv = (struct intel_tlv *)skb->data;
> > +             switch (tlv->type) {
> > +             case INTEL_TLV_CNVI_TOP:
> > +                     version->cnvi_top = get_unaligned_le32(tlv->val);
> > +                     break;
>
> I think we already had this issue that you need to check that enough data is actually in the SKB.
>
> > +             case INTEL_TLV_CNVR_TOP:
> > +                     version->cnvr_top = get_unaligned_le32(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_CNVI_BT:
> > +                     version->cnvi_bt = get_unaligned_le32(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_CNVR_BT:
> > +                     version->cnvr_bt = get_unaligned_le32(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_DEV_REV_ID:
> > +                     version->dev_rev_id = get_unaligned_le16(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_IMAGE_TYPE:
> > +                     version->img_type = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_TIME_STAMP:
> > +                     version->timestamp = get_unaligned_le16(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_BUILD_TYPE:
> > +                     version->build_type = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_BUILD_NUM:
> > +                     version->build_num = get_unaligned_le32(tlv->val);
> > +                     break;
> > +             case INTEL_TLV_SECURE_BOOT:
> > +                     version->secure_boot = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_OTP_LOCK:
> > +                     version->otp_lock = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_API_LOCK:
> > +                     version->api_lock = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_DEBUG_LOCK:
> > +                     version->debug_lock = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_MIN_FW:
> > +                     version->min_fw_build_nn = tlv->val[0];
> > +                     version->min_fw_build_cw = tlv->val[1];
> > +                     version->min_fw_build_yy = tlv->val[2];
> > +                     break;
> > +             case INTEL_TLV_LIMITED_CCE:
> > +                     version->limited_cce = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_SBE_TYPE:
> > +                     version->sbe_type = tlv->val[0];
> > +                     break;
> > +             case INTEL_TLV_OTP_BDADDR:
> > +                     memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
> > +                     break;
> > +             default:
> > +                     /* Ignore rest of information */
> > +                     break;
> > +             }
> > +             /* consume the current tlv and move to next*/
> > +             skb_pull(skb, tlv->len + sizeof(*tlv));
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_parse_version_tlv);
> > +
> > int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
> > {
> >       struct sk_buff *skb;
> > @@ -595,6 +674,46 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
> > }
> > EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
> >
> > +int btintel_generic_read_version(struct hci_dev *hdev,
> > +                              struct intel_version_tlv *ver_tlv,
> > +                              struct intel_version *ver, bool *is_tlv)
> > +{
> > +     struct sk_buff *skb;
> > +     const u8 param[1] = { 0xFF };
> > +
> > +     skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> > +                        PTR_ERR(skb));
> > +             return PTR_ERR(skb);
> > +     }
> > +
> > +     if (skb->data[0]) {
> > +             bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> > +                        skb->data[0]);
> > +             kfree_skb(skb);
> > +             return -EIO;
> > +     }
> > +
> > +     if (skb->len < sizeof(struct intel_version))
> > +             return -EILSEQ;
> > +
> > +     if (skb->len == sizeof(struct intel_version) &&
> > +         skb->data[1] == 0x37)
> > +             *is_tlv = false;
> > +     else
> > +             *is_tlv = true;
> > +
> > +     if (*is_tlv)
> > +             btintel_parse_version_tlv(hdev, skb, ver_tlv);
> > +     else
> > +             memcpy(ver, skb->data, sizeof(*ver));
> > +
> > +     kfree_skb(skb);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_generic_read_version);
> > +
>
> I have the feeling that we are falling back to a patch that I already rejected.
>
> > /* ------- REGMAP IBT SUPPORT ------- */
> >
> > #define IBT_REG_MODE_8BIT  0x00
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index d184064a5e7c..366cb746f9c4 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -175,6 +175,10 @@ int btintel_read_debug_features(struct hci_dev *hdev,
> >                               struct intel_debug_features *features);
> > int btintel_set_debug_features(struct hci_dev *hdev,
> >                              const struct intel_debug_features *features);
> > +int btintel_generic_read_version(struct hci_dev *hdev,
> > +                              struct intel_version_tlv *ver_tlv,
> > +                              struct intel_version *ver,
> > +                              bool *is_tlv);
> > #else
> >
> > static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> > @@ -307,4 +311,10 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
> >       return -EOPNOTSUPP;
> > }
> >
> > +static int btintel_generic_read_version(struct hci_dev *hdev,
> > +                                     struct intel_version_tlv *ver_tlv,
> > +                                     struct intel_version *ver, bool *is_tlv)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > #endif
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index a9855a2dd561..15d91aae52cc 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -583,6 +583,9 @@ struct btusb_data {
> >       unsigned cmd_timeout_cnt;
> > };
> >
> > +static int btusb_setup_intel_newgen(struct hci_dev *hdev);
> > +static int btusb_shutdown_intel_new(struct hci_dev *hdev);
> > +
> > static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
> > {
> >       struct btusb_data *data = hci_get_drvdata(hdev);
> > @@ -2842,6 +2845,18 @@ static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
> >       return err;
> > }
> >
> > +static bool btintel_is_newgen_controller(struct hci_dev *hdev, u32 cnvi)
> > +{
> > +     switch (cnvi & 0xFFF) {
> > +     case 0x400: /* Slr */
> > +     case 0x401: /* Slr-F */
> > +     case 0x410: /* TyP */
> > +     case 0x810: /* Mgr */
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> > static int btusb_setup_intel_new(struct hci_dev *hdev)
> > {
> >       struct btusb_data *data = hci_get_drvdata(hdev);
> > @@ -2851,6 +2866,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> >       char ddcname[64];
> >       int err;
> >       struct intel_debug_features features;
> > +     struct intel_version_tlv ver_tlv;
> > +     bool is_tlv;
> >
> >       BT_DBG("%s", hdev->name);
> >
> > @@ -2864,12 +2881,38 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> >        * is in bootloader mode or if it already has operational firmware
> >        * loaded.
> >        */
> > -     err = btintel_read_version(hdev, &ver);
> > +     err = btintel_generic_read_version(hdev, &ver_tlv, &ver, &is_tlv);
> >       if (err) {
> >               bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> >               btintel_reset_to_bootloader(hdev);
> >               return err;
> >       }
> > +     if (is_tlv) {
> > +             /* We got TLV data. Check for new generation CNVi. If present,
> > +              * then map the callbacks to BTUSB_INTEL_NEWGEN and attempt
> > +              * setup function again
> > +              */
> > +             if (btintel_is_newgen_controller(hdev, ver_tlv.cnvi_top)) {
> > +                     hdev->send = btusb_send_frame_intel;
> > +                     hdev->setup = btusb_setup_intel_newgen;
>
> So this is a clear no, your are not changing hdev->setup within hdev->setup.
>
> > +                     hdev->shutdown = btusb_shutdown_intel_new;
> > +                     hdev->hw_error = btintel_hw_error;
> > +                     hdev->set_diag = btintel_set_diag;
> > +                     hdev->set_bdaddr = btintel_set_bdaddr;
> > +                     hdev->cmd_timeout = btusb_intel_cmd_timeout;
> > +                     return -EAGAIN;
> > +             }
> > +
> > +             /* we need to read legacy version here to minimize the changes
> > +              * and keep the esixiting flow
> > +              */
> > +             err = btintel_read_version(hdev, &ver);
> > +             if (err) {
> > +                     bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> > +                     btintel_reset_to_bootloader(hdev);
> > +                     return err;
> > +             }
> > +     }
> >
> >       err = btintel_version_info(hdev, &ver);
> >       if (err)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 1eb7ffd0dd29..8e407bad0e31 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1496,8 +1496,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> >
> >               hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> >
> > -             if (hdev->setup)
> > +             if (hdev->setup) {
> >                       ret = hdev->setup(hdev);
> > +                     if (ret && ret == -EAGAIN)
> > +                             ret = hdev->setup(hdev);
> > +             }
>
> NO. Please stop hacking here. I think you need to take a whiteboard and draw how our controllers are initialized.

+1

It is already strange that we have mixed generation, besides we never
really did a good job tracking the generation properly, but with this
it seems we are attempting to mix generations so we no longer can
detect them based on USB PID/VID but need to dig into the version
information at runtime, so imo we should either detected based on USB
PID/VID or if that is not possible then switch it to be runtime only
and not try to do both as it should be clear by now that will just
make the code really hard to follow.

-- 
Luiz Augusto von Dentz
