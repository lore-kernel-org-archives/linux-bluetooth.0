Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C64C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 02:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD41611F1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 02:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhGMCnO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbhGMCnO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 22:43:14 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4AC0613E9
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 19:40:24 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id d2so8062320uan.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wpdaNdu7YfD40JTAH6M6mghK1/KZJd+GmHkbLObt/ss=;
        b=E4y5GrpoghOgz59I9eY3Y/bE78Ag1dM94SRYCmTN/8LTCujqOwxDFrrv7lrKbk9DVs
         tjfvTG/7hyTI1X0GtIN8G9LiprJ2LJSdSCAWHFLpHs6rDxD14LcJBgB/kV547VzbIgem
         Xuqn4gk1Yv2pTB0dwrAXdZXR1Zma2vn+AgBFgH55lZNq9iY9qqEaKySpjlFIUWR86Ijg
         g8DPKNboIgtoduru5h24Wlj0ZXERF9xw3xAgEtCQJy2qOnBl8h6Y0SVzHyTV+TU0Xw8s
         F/HropF/FKp+8bYRFCwI/ZrYN1qEO9xD1MV5z1jqAIl2Z3MnkHeQr1T23vY0iSZ64wFq
         +EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wpdaNdu7YfD40JTAH6M6mghK1/KZJd+GmHkbLObt/ss=;
        b=GKJarAlMuoAXkk3KrVnoGQTlLM8K9b5M/vB8KlMFDwil7juxBs9/vKi00QukfVseqI
         3p6eSYycx/xWM558GKxUP41B1uM9FKurw4zHveqade9kEs0p78PhPtTpdmmm+THQenNe
         5qpPlPsHdkE6WgQrwlVHOS+3F/xFzaCgQMOTDCLRuSdS2v5Fj/btfgtaDrPnmGHIEN4h
         k8K/e2Qao7FBGYWn0QjrQy9esNtmTn/G0SxiPptkYlDomAFy72QsJaV3XgD5pZMFYl3+
         MZh9U5bKEJCj70Nt6TCuB539J5BwJvhGUj7dkBtfGbM5iq8GkNZdVji+XyMLWAyu8LQB
         W6Ng==
X-Gm-Message-State: AOAM533s9YQi4HOotE0J9FzkNzBLxDRFkbRGZ+V53zQQAsUJOLNPxh97
        neVYw8d8DbS4nfGRgWFjWTvRgypQbxMzoXhA5ljwHA==
X-Google-Smtp-Source: ABdhPJwGZDgLraK6juaQhwuFj1DcmcgkGEu9hv5eJXwmQ1i17FkAUZRaE8Gq4ForykIirwCnkSJ2SawfLU3E2Cg5mKc=
X-Received: by 2002:ab0:1367:: with SMTP id h36mr2790896uae.29.1626144023299;
 Mon, 12 Jul 2021 19:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210710030136.1567673-1-jun.miao@windriver.com>
In-Reply-To: <20210710030136.1567673-1-jun.miao@windriver.com>
From:   Joseph Hwang <josephsih@google.com>
Date:   Tue, 13 Jul 2021 10:40:06 +0800
Message-ID: <CAHFy419+zJG0KhS7TwD_JTV2YNJum=gCoCk=Vq49pwagz4kwYw@mail.gmail.com>
Subject: Re: [PATCH] [v2] Bluetooth: btusb: Fix a unspported condition to set
 debug features
To:     Jun Miao <jun.miao@windriver.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        kiran.k@intel.com, chethan.tumkur.narayan@intel.com,
        AyappadasX.Ps@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jun Miao:

  Thanks for the patch checking out the condition of debug features.
However, the patch is actually covered by two patches that are being
reviewed.

  - [v4,1/4] Bluetooth: btusb: disable Intel link statistics telemetry
events (https://patchwork.kernel.org/project/bluetooth/patch/20210618160016=
.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid/)
=E2=80=94 this patch disables the debug features by default to avoid overhe=
ad.

  - [v4,3/4] Bluetooth: set quality report callback for Intel
(https://patchwork.kernel.org/project/bluetooth/patch/20210618160016.v4.3.I=
50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid/)
=E2=80=94 this patch checks the condition of debug features and does some
other things.

Thanks and regards,
Joseph

On Sat, Jul 10, 2021 at 11:02 AM Jun Miao <jun.miao@windriver.com> wrote:
>
> When reading the support debug features failed, there are not available
> features init. Continue to set the debug features is illogical, we should
> skip btintel_set_debug_features(), even if checked by "if (!features)".
>
> Fixes: c453b10c2b28 ("Bluetooth: btusb: Configure Intel debug feature bas=
ed on available support")
> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> ---
>  drivers/bluetooth/btusb.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd561..20c804069991 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2907,10 +2907,11 @@ static int btusb_setup_intel_new(struct hci_dev *=
hdev)
>         /* Read the Intel supported features and if new exception formats
>          * supported, need to load the additional DDC config to enable.
>          */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> +       err =3D btintel_read_debug_features(hdev, &features);
> +       if (!err) {
> +               /* Set DDC mask for available debug features */
> +               btintel_set_debug_features(hdev, &features);
> +       }
>
>         /* Read the Intel version information after loading the FW  */
>         err =3D btintel_read_version(hdev, &ver);
> @@ -3003,10 +3004,11 @@ static int btusb_setup_intel_newgen(struct hci_de=
v *hdev)
>         /* Read the Intel supported features and if new exception formats
>          * supported, need to load the additional DDC config to enable.
>          */
> -       btintel_read_debug_features(hdev, &features);
> -
> -       /* Set DDC mask for available debug features */
> -       btintel_set_debug_features(hdev, &features);
> +       err =3D btintel_read_debug_features(hdev, &features);
> +       if (!err) {
> +               /* Set DDC mask for available debug features */
> +               btintel_set_debug_features(hdev, &features);
> +       }
>
>         /* Read the Intel version information after loading the FW  */
>         err =3D btintel_read_version_tlv(hdev, &version);
> --
> 2.32.0
>


--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
