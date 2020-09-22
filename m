Return-Path: <SRS0=LYTB=C7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8DEC4363D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 05:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCEA23A9C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 05:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xoq7Fsl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgIVFQ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgIVFQ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Sep 2020 01:16:57 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D7C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 22:16:57 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id k13so3851337oor.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 22:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjVaM5PSRHjTOEGeN+/MmSR4gTJjjQyWdg1LfaUxZTk=;
        b=Xoq7Fsl5Ruttj7LNNOXNKb3p/E+Oxahfj2BylqbhPV5/f9mT+xoJMj4U97w4Y5I12J
         2cvIV/7dC2UwYG9G1F3eHU42B+2KJX5D1zU436KsNV1Ir7ZvDJsVbacHwts8sVPgfqGR
         wj+Revga7umISYdcFAQ7DsJrXigI54R+1PmF0iONH3g6Su3U79FBKiOlnMt2+l5IYAQk
         UPQRAglU7RrlzZF6t76Dx1ys5yZnrnNVpl8WX88AxBgO6WfYaDU6CNn89RvptE4hUXfU
         JgwLAtH7gFORWTRGXBENM9VMOzenxJ2ro8a6FgC0W/CcxIbtYKGC+68aaGIKDIlwhTHW
         b4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjVaM5PSRHjTOEGeN+/MmSR4gTJjjQyWdg1LfaUxZTk=;
        b=YDbqpD4QX2ZXKx8FMgWW0r63oMoxbyKB1F6WTj0QrtTlGXgACN4i2WWz0JNxODZBkT
         T70/BuX4QCLlqJMtBuZ1AN348VekIpTUKp4jxrwFx335rdsulf6GxUHacdctS+Mlnu2K
         NXfOnEmpZZQo2iy1/FWewekFS0U4Y9oJvHaki+r0Ze1j2dFA5ItbUIdoilcwE0kOsqw/
         YYDdmlps1hqjZifxDh1zshIK+CaflA4RwmtEoc3p1EQ+1CP5hZpyvkkFl8fOTTAdq9u9
         AcUol39r8rCTwYGOovzm8uZpPbgG0MFU7cJa32wdae6F01aEd7fg1EJbzyzN3HAUXM6j
         noQQ==
X-Gm-Message-State: AOAM530VmILHgLSzaG63zApWA5leQLOoySYbQknqzSDIwCx7kmHe4VA6
        SEuuh353eBiX+Gj5vCa3WWEX1ln6Dqadi91dtTRNCP7j
X-Google-Smtp-Source: ABdhPJwZbchNvarGE+tn5W1qbKmV2AuWHV0nBacxCrD+AhaKVFFBQNggZIoMPLdbU7qqOlkUJ4NEI7pIfd4pi9Pz7u0=
X-Received: by 2002:a4a:bf12:: with SMTP id r18mr1876346oop.9.1600751816136;
 Mon, 21 Sep 2020 22:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <1600747219-11626-1-git-send-email-kiran.k@intel.com>
In-Reply-To: <1600747219-11626-1-git-send-email-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Sep 2020 22:16:44 -0700
Message-ID: <CABBYNZKTQeZZkVCGaCvnL661Qsxc1cFGNggEuM3pD7p0S8yRwQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix issue reported by static
 analysis tool
To:     Kiran K <kiraank@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com, dan.carpenter@oracle.com,
        Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Mon, Sep 21, 2020 at 9:03 PM Kiran K <kiraank@gmail.com> wrote:
>
> Smatch tool reported the below issue:
>
> drivers/bluetooth/btintel.c:490 btintel_read_version_tlv()
> error: 'tlv->len' from user is not capped properly
>
> Additional details in the below link
> https://www.spinics.net/lists/linux-bluetooth/msg87786.html
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 88ce5f0..47f2b3d 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -431,62 +431,99 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
>          * version field like hw_platform, hw_variant, and fw_variant
>          * to keep the existing setup flow
>          */
> -       while (skb->len) {
> +       while (skb->len >= sizeof(struct intel_tlv)) {
>                 struct intel_tlv *tlv;
>
>                 tlv = (struct intel_tlv *)skb->data;
> +               if (struct_size(tlv, val, tlv->len) > skb->len)
> +                       goto failed;
> +
>                 switch (tlv->type) {
>                 case INTEL_TLV_CNVI_TOP:
> +                       if (tlv->len < sizeof(u32))
> +                               goto failed;
>                         version->cnvi_top = get_unaligned_le32(tlv->val);
>                         break;
>                 case INTEL_TLV_CNVR_TOP:
> +                       if (tlv->len < sizeof(u32))
> +                               goto failed;
>                         version->cnvr_top = get_unaligned_le32(tlv->val);
>                         break;
>                 case INTEL_TLV_CNVI_BT:
> +                       if (tlv->len < sizeof(u32))
> +                               goto failed;
>                         version->cnvi_bt = get_unaligned_le32(tlv->val);
>                         break;
>                 case INTEL_TLV_CNVR_BT:
> +                       if (tlv->len < sizeof(u32))
> +                               goto failed;
>                         version->cnvr_bt = get_unaligned_le32(tlv->val);
>                         break;
>                 case INTEL_TLV_DEV_REV_ID:
> +                       if (tlv->len < sizeof(u16))
> +                               goto failed;
>                         version->dev_rev_id = get_unaligned_le16(tlv->val);
>                         break;
>                 case INTEL_TLV_IMAGE_TYPE:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->img_type = tlv->val[0];
>                         break;
>                 case INTEL_TLV_TIME_STAMP:
> +                       if (tlv->len < sizeof(u16))
> +                               goto failed;
>                         version->timestamp = get_unaligned_le16(tlv->val);
>                         break;
>                 case INTEL_TLV_BUILD_TYPE:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->build_type = tlv->val[0];
>                         break;
>                 case INTEL_TLV_BUILD_NUM:
> +                       if (tlv->len < sizeof(u32))
> +                               goto failed;
>                         version->build_num = get_unaligned_le32(tlv->val);
>                         break;
>                 case INTEL_TLV_SECURE_BOOT:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->secure_boot = tlv->val[0];
>                         break;
>                 case INTEL_TLV_OTP_LOCK:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->otp_lock = tlv->val[0];
>                         break;
>                 case INTEL_TLV_API_LOCK:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->api_lock = tlv->val[0];
>                         break;
>                 case INTEL_TLV_DEBUG_LOCK:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->debug_lock = tlv->val[0];
>                         break;
>                 case INTEL_TLV_MIN_FW:
> +                       if (tlv->len < 3)
> +                               goto failed;
>                         version->min_fw_build_nn = tlv->val[0];
>                         version->min_fw_build_cw = tlv->val[1];
>                         version->min_fw_build_yy = tlv->val[2];
>                         break;
>                 case INTEL_TLV_LIMITED_CCE:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->limited_cce = tlv->val[0];
>                         break;
>                 case INTEL_TLV_SBE_TYPE:
> +                       if (tlv->len < sizeof(u8))
> +                               goto failed;
>                         version->sbe_type = tlv->val[0];
>                         break;
>                 case INTEL_TLV_OTP_BDADDR:
> +                       if (tlv->len != sizeof(version->otp_bd_addr))
> +                               goto failed;

Do we really want to fail here? The advantage of using a TLV is that
we can skip if the type is not understood or is malformed but with
this checks the length becomes useless since the types will always
have a fixed value, also we cannot extend the types later on since it
would not be backward compatible if we maintain such strict checks.

>                         memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
>                         break;
>                 default:
> @@ -499,6 +536,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
>
>         kfree_skb(skb);
>         return 0;
> +
> +failed:
> +       kfree_skb(skb);
> +       return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
>
> --
> 2.7.4
>


-- 
Luiz Augusto von Dentz
