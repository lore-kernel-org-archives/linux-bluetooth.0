Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhKWXxC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhKWXw4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 18:52:56 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C860BC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:49:47 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id n6so1347440uak.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQf7RHBq+QRg6eT+9Ryq0B4KvQZbmWNHFk1MEGnsVpA=;
        b=Ss7Kd5eBF7CnnN40DZb6F+Y7eZJKKXLLAtdTLeRtJ6vQWskNEKyeLDyVQ3NCUbEAXZ
         gCtwAGQV0p4rkvEXhLcZsg7EnK5b5qVdxjpTP1O9qQyyvAT9z61gCQ1gXi/tZxy/m0xl
         DLeJObkP3f7wsBkkXaEAIp4cHnYqX3QMtcJmaJD8TxxvG6wZRigxYA1ZW25WGYL7PHoq
         AWqwpczoeuRH9+1j9rxF7jTTwfPZ0HSe38jKg2TyPggbKgB6We4t5RGlqpRPH8NhRPNI
         yUZxsYi3xFP0VZ6dxF6O7e/M6qt0n5eJCqAUHuu5GAy/Sw+R4tqCpATN/NB/4/DV2M7U
         rCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQf7RHBq+QRg6eT+9Ryq0B4KvQZbmWNHFk1MEGnsVpA=;
        b=xnPqGxEx5d0j4EDQDvYDxIelAYXBk1bwceex+/8GeSsYv8/oCt2pOV3jgRMb9UetB7
         PPzl0GMaGQllCk7mQ0CxaeHTLmfJDCSNXE1YPn1rFAEp/uXjF0JPcKjXMVMSYMEVhOaA
         RbXciu7dz9HaSq3K/6qVTzxO8yD1DEHbYlaKZU0V0zljnQJPrTwqDAaq/tlZWQMoofAQ
         xY5CmTl9jFJZf3Fa4lkvUBrHGlFb1fwRDTIjzt64o0pczwklKwkA7dYeFuC37ZxIJsmE
         uh+kxLVao2DpcEnkCnIfXbhE2jtP6M18IEi6AansCUUzLS7SaKRnYFG+jXJ9/D/9Ful/
         ZEXQ==
X-Gm-Message-State: AOAM530EsZ7m21xsZpsE0xRDt/KyL8Xz6/ON+S0o+EzJpxxRSdLsVoDp
        N4FTdd/bUKQ5bGcYFNZfEfbrI3wjaruoBzYSQKw=
X-Google-Smtp-Source: ABdhPJyppO658WXKqJ1Psm2RaJZNchDpAsC0vi7twYxuRuSwwD0Yo8xWKHcxuQ+gICqwh7ILXdRQ2Rj9MNYFz1EUvts=
X-Received: by 2002:a67:fd90:: with SMTP id k16mr14641366vsq.39.1637711386883;
 Tue, 23 Nov 2021 15:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20211119082027.12809-1-kiran.k@intel.com> <20211119082027.12809-5-kiran.k@intel.com>
In-Reply-To: <20211119082027.12809-5-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Nov 2021 15:49:36 -0800
Message-ID: <CABBYNZ+M_LixdS9p=BBiuSR1NvbUpp8HGTxEX_Npgf7UsjeB8A@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] Bluetooth: btintel: Add support to fetch data
 path id for a2dp offload
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Fri, Nov 19, 2021 at 12:16 AM Kiran K <kiran.k@intel.com> wrote:
>
> During *setup*, when configuring offload, set get_data_path_id callback
> function and support fetching of data path id for a2dp offload use case.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 4b6d7ea08425..1501376ccf72 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2214,16 +2214,30 @@ static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 transport,
>  {
>         struct btintel_data *intel_data;
>
> -       if (transport != HCI_TRANSPORT_SCO_ESCO)
> +       if (transport != HCI_TRANSPORT_SCO_ESCO &&
> +           transport != HCI_TRANSPORT_ACL) {
> +               bt_dev_err(hdev, "Invalid transport type %u", transport);
>                 return -EINVAL;
> +       }
>
>         intel_data = hci_get_priv((hdev));
>
> -       if (intel_data->use_cases.preset[0] & 0x03) {
> -               /* Intel uses 1 as data path id for all the usecases */
> -               *data_path_id = 1;
> -               return 0;
> +       switch (transport) {
> +       case HCI_TRANSPORT_SCO_ESCO:
> +               if (intel_data->use_cases.preset[0] & 0x03) {
> +                       *data_path_id = 1;
> +                       return 0;
> +               }
> +               break;
> +       case HCI_TRANSPORT_ACL:
> +               if (intel_data->use_cases.preset[0] & 0x08) {
> +                       *data_path_id = 1;
> +                       return 0;
> +               }

I would suggest adding the bits of use_cases as defines using BIT
macro, it may also be a good idea to check if the preset should
actually be a bitmap and then use the likes of test_bit, etc.

> +               break;
>         }
> +       bt_dev_err(hdev, "Required preset is not supported 0x%02x",
> +                  intel_data->use_cases.preset[0]);
>         return  -EOPNOTSUPP;
>  }
>
> @@ -2262,6 +2276,10 @@ static int btintel_configure_offload(struct hci_dev *hdev)
>                 hdev->get_codec_config_data = btintel_get_codec_config_data;
>         }
>
> +       /* supports SBC codec for a2dp offload */
> +       if (use_cases->preset[0] & 0x08)
> +               hdev->get_data_path_id = btintel_get_data_path_id;

This seems to be checking only for one of the use cases. How about
SCO/ESCO, doesn't that use get_data_path_id as well?

>  error:
>         kfree_skb(skb);
>         return err;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
