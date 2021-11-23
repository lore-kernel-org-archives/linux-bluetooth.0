Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 23:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhKWXzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbhKWXzv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 18:55:51 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BADC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:52:43 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id w23so1309042uao.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYsbf/DbetuEgkYRA437NnHJkIPA+MlmOGf3hNYi6Is=;
        b=lVziHJkbLxZLnsPf9JgmmE2LbOf/Hwy/1mYC29BsKQVW6pZzBx4ZZxf2drTyPvZyDG
         yhahVoK+utHzSEWe+ea3qVwwop7xT/d/bUHkdUWfL4lLllgH+K0tA1JhawyGx7pLjoDz
         8VyNHz2b9oKSAK01VffGVYG2ystXvThwgEwXk77gKXzGJ9jgs0Rh8c8NQ5ENRnPFKWFx
         M895qcwt+rP3olB4nfDP4vaqXipGy0pJc8eOFgdqBLi8XCCwLGH75VPkXo+rv6Hr1+MD
         ci++styggv0M+atllaatlVwuWSoVedzj0ZgP7jFFS7FBTiOrR0JIYHS8XW+ocmJC4Mw7
         nsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYsbf/DbetuEgkYRA437NnHJkIPA+MlmOGf3hNYi6Is=;
        b=5znqTU7Zm1nS2STB8RaVObgKCOesVUpSfs4pSVtM6wNilMbfPjbSiHdYyDHNndm6NH
         JFlJ20y9Ir7NnEJU9iex78vTbdmE8pxEaNbpWpV/EMHIIHSM5Z+ftfVEysQQxknfhSVn
         C/GvF0x/OcbdmyJCZyAzINH2hsnDFS2TNhDyLXvxCBqDD0WAXM3BGaybrnT5jDxPCzKV
         4q/DHTxwVAcI4Sd/B9fHE+3qbBtKTgcpGM6Jd0Tcrz15WHNeZhR6K+ZgSRhFEFk0Wwy0
         MYXsQFMWxF9s7gyWFXORI+2ksaOtSzYhqMFQvkrmfW+bRN/mZB8STqjgsSs+Kz32Rajn
         mtMA==
X-Gm-Message-State: AOAM530Ad7PDALJ020c4erMdWwRQQU5yKRk9z3Sv/mirePDZVW24C7b/
        ITEXXKSL1Psbur0vxfwPIj9pGAfRNaUsKJF4YLo=
X-Google-Smtp-Source: ABdhPJyaq5FGoZAl2x+U0+w6ATTnApPm6Ne22UTuSUsVSjEem1v05NiXdWv9R8TbjsY93ZGSggYhs8m8X0ozeY6mTKc=
X-Received: by 2002:a67:6ac5:: with SMTP id f188mr15596635vsc.61.1637711561836;
 Tue, 23 Nov 2021 15:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20211119082027.12809-1-kiran.k@intel.com> <20211119082027.12809-6-kiran.k@intel.com>
In-Reply-To: <20211119082027.12809-6-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Nov 2021 15:52:31 -0800
Message-ID: <CABBYNZ+9k60YTUsg1F_k2UgVz=9YixoQS5nwBrdJRjL+HOkPig@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] Bluetooth: Remove unused member in struct hci_vnd_codec_v2
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
> Remove unused "u8 id" member in struct hci_vnd_codec_v2. Vendor codec
> is identifiable by Company Id and Vendor Id fields.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  include/net/bluetooth/hci.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e52fd2f1e046..54fae19f3758 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1395,7 +1395,6 @@ struct hci_std_codecs_v2 {
>  } __packed;
>
>  struct hci_vnd_codec_v2 {
> -       __u8    id;
>         __le16  cid;
>         __le16  vid;
>         __u8    transport;
> --
> 2.17.1

Not following this change, afaik LC3 for example should be id 0x06
cid/vid 0x0000 as that is not a vendor, or this is never used for
codecs defined in the spec?


-- 
Luiz Augusto von Dentz
