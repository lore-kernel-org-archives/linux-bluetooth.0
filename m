Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B415C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 18:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhLUS4z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbhLUS4z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 13:56:55 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDCC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 10:56:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g17so41413102ybe.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTp+gKI09ItTX62WF9a29scRtdfiwZ7+1XQOds887iI=;
        b=ZKL1lvByZvrsd6a2Wi7oq03KrJTOs9EH5urveL3EYTtBpXfuOAo/M4ODJ2ifV5dpp3
         ZJdl9vaQ3xGUBckq/JBM+z4ZeD3pnHSeHIO/ijKC7/31Cw+IHHQh6qsUPOxuPBMYfpo3
         4VqNcfzj5MtScjunsu4ri2zgLe7tygJVpzuASH1P6DiGD82BRv0QwhaUBCMEmHIqyJWF
         1mPbK238RJlUy8m1ncajC1SYUv5t7JwlSKJ3mXl6PImgZQ4Ga1Ane8Ja5ItdJkNZwWtw
         M9kN5KgTzuXgp2TKB2UqIgHt+ZVBJRmqdlInXMFpl9v/xxub56GQ+0lf6nA8i3q8bXMS
         TBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTp+gKI09ItTX62WF9a29scRtdfiwZ7+1XQOds887iI=;
        b=roVW7Clck4mmuwv8dyblzXMaPqodiBTp99BUnbJGWSn1iN7G0ml6xvetCORupjk/nD
         ANFW4VlG+4EDWpH2crR/kZRzthA+PUcgFNNH9zd73jluAAvYeOf/0HMa0fjIvjO2sr4V
         KqNm1hQFQvnnVBE9QYEbjdoF95hzCHa5Wot4lWvA14i7CofiKN6Gl+FV0rNaQOZU6CR0
         pfgx9SZfuLIGpdm2Z3s2J+KyumtrkPefZwdwwG+MsOH8fiSotiYpLeoCZ1hQQ17C0I4/
         3+7DQYPl4i33JPQJMX1EaeD899hT0vIAdo/SeT6NJ/wCX28X2A2+us0KoLVxNoDhozN8
         eVxg==
X-Gm-Message-State: AOAM530kgWlQuOlDU/A3dkrpvUxXoTwFCkmbMzVHiFwd+HGbYaXwc2ou
        NR99ZwODWffVqJ53esNcJMcVDibaoCTrTIfOL+g6O6rh
X-Google-Smtp-Source: ABdhPJx7SChK/EXOBclxnlXbMwcDiIiE1gzA68zA01HfSGrjW/zWggtGxJfti9FBLNOcowpJpJcoTkKbf0SRuCT/06g=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr6309739ybo.398.1640113014164;
 Tue, 21 Dec 2021 10:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20211221034246.2416-1-kiran.k@intel.com>
In-Reply-To: <20211221034246.2416-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Dec 2021 10:56:43 -0800
Message-ID: <CABBYNZ+ON-jVfM_g4T-sXaPY-7n0mv4JTvvpH88GNwdPoVs=Pw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix MSFT extension support for
 Intel controllers
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Dec 21, 2021 at 1:49 AM Kiran K <kiran.k@intel.com> wrote:
>
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> For ThP2/JfP2/HrP2 and CcP2 Intel controllers, MSFT extension
> opcode was not set in operational mode.

You should probably add a Fixes for the original patch that introduces
this problem.

> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e1f96df847b8..0dd389746439 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2549,10 +2549,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>                 if (INTEL_HW_VARIANT(ver_tlv.cnvi_bt) == 0x18)
>                         set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>
> -               /* Setup MSFT Extension support */
> -               btintel_set_msft_opcode(hdev,
> -                                       INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
> -
>                 err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
>                 break;
>         default:
> @@ -2560,6 +2556,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>                            INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
>                 return -EINVAL;
>         }

Please add a comment stating why it is correct to do it here instead.

> +       /* Setup MSFT Extension support */
> +       btintel_set_msft_opcode(hdev, INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
>
>  exit_error:
>         kfree_skb(skb);
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
