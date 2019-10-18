Return-Path: <SRS0=NsPc=YL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CD1CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 22:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E9420679
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 22:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr2swjmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394973AbfJRWjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:39:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfJRWjV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Oct 2019 18:39:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so3503464plr.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2019 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2im9WWFUcoDI14VxL9RhlaxhC4Tk4lRtwhBBOgvO6gE=;
        b=Dr2swjmW1Qij3ZEtoaloyH6sTnBBnKVzElbT496exetTLoYIZbTREZeLwtKy4ZeD5C
         Tqb+JzRUTslIAXPuKoX5z9XOD9ECMs1M/oBEF4gsnEfUW4rZokfVCss9BKG28O8bLofm
         EZD2x+vyDh2kyOVpaSoGh4lDxyK6H8+9N9ukL8nB2b65GTSVAx0OmlpqK0ZmSwWjAOny
         uZRsyl9euNi5IayvDlOlXzQPdnODFiw615cQXy6VH8UhlWnGtT3StVVty7jIDTuxQaIL
         kwoIZvRZOf8lzQbvHmetIH/znFO5M34f6Ntz2Pg0UFJOqI1dxgz0dlvhfqMBUruB7A1j
         XNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2im9WWFUcoDI14VxL9RhlaxhC4Tk4lRtwhBBOgvO6gE=;
        b=gTbJllZlu6JHsxp35krkrcSZyiAXMhooVWnZ9z4eIrxSAkI1PPaWLAjt8FbqArTC6Q
         xu2hNWCAT/shqa8/QNlKW/T8G1gAuWKwIYLm63oYTtSeFqx+/OiTHcvt6Lvt8Lx+AadB
         8XpNWrOTNelX/rI1f5nV25/CP1NFbJuGr/kK5/lNnyt6nQZvSG4OCI1Cx+l9iQwsfrbm
         7YjiZspuDLn0qHx7T0vCf92NYpani+m0YPWS3En6r7PEY/T24t8XanazMXwrCA+3vLOS
         HwHDFi+Y33kRpcCouYHLdKQOdM2zF5cnqYujAf7/h+72ecYf37TOAigHF4iIz/ESQ3rG
         ThPQ==
X-Gm-Message-State: APjAAAXU9K1WJen1jhITXbFjKJMlzcWhAui87xLaDwdZH6PHdwceWYGa
        vkjJALNwKuTZvMV8mG0lVbONv5iQor5NRt6WiSOaDA==
X-Google-Smtp-Source: APXvYqxF16peaaVh1XBZwzYs9HxAGFTtsMCh9agFYtQKE0FF3sk37xMA6iBw1VH0DnXWpZJNz1MK9UQBpGlvjhmz4mc=
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr12178257plp.223.1571438360183;
 Fri, 18 Oct 2019 15:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191018111343.5a34ee33@canb.auug.org.au> <20191018222924.49256-1-natechancellor@gmail.com>
In-Reply-To: <20191018222924.49256-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 15:39:08 -0700
Message-ID: <CAKwvOdnycftgCanEt_BpUOB9Uo0sderk1HZp3H4EQ8drAmjohA@mail.gmail.com>
Subject: Re: [PATCH -next] Bluetooth: btusb: Remove return statement in btintel_reset_to_bootloader
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Oct 18, 2019 at 3:29 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with Clang and CONFIG_BT_INTEL unset, the following error
> occurs:
>
> In file included from drivers/bluetooth/hci_ldisc.c:34:
> drivers/bluetooth/btintel.h:188:2: error: void function
> 'btintel_reset_to_bootloader' should not return a value [-Wreturn-type]
>         return -EOPNOTSUPP;
>         ^      ~~~~~~~~~~~
> 1 error generated.
>
> Remove the unneeded return statement to fix this.
>
> Fixes: b9a2562f4918 ("Bluetooth: btusb: Trigger Intel FW download error recovery")
> Link: https://github.com/ClangBuiltLinux/linux/issues/743
> Reported-by: <ci_notify@linaro.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/bluetooth/btintel.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index d2311156f778..a69ea8a87b9b 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -185,6 +185,5 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
>
>  static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
>  {
> -       return -EOPNOTSUPP;


The existing structure of this code is fishy, but I see what is going on with:
 65 #if IS_ENABLED(CONFIG_BT_INTEL)
drivers/bluetooth/btintel.h

Thanks for the patch
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  }
>  #endif

-- 
Thanks,
~Nick Desaulniers
