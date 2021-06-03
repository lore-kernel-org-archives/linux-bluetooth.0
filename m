Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A748DC47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8010361008
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCUG0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:06:26 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:42766 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCUGZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 16:06:25 -0400
Received: by mail-yb1-f171.google.com with SMTP id x6so10488945ybl.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jun 2021 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGAu4RK1+bPr/qDz/fldKm03YL7PhSciYtK65EU2YWY=;
        b=ab4j7/sz5br46xOBQLeYdiclXky1JXTCpUYhSLwu31dfgR4kuCmeHtBYwDZagXBY3l
         NxOsoDiQMCvxzUG5ZCclYZKVg95zmsdLcAepuomcwxvIG0g9L8tNdgZlJg/7BwImmML+
         ETGRS9HNalKrm03bWfz2bxj5wnPXJ2z6V9UqwacwG6W0lr54mnjqmmou/wnXUzltBGOc
         pY97rnz2SXzw0LUp4rVImle0wCSQCzuOBd+9PR7AFsDpjqF/P5GMxe4rppP5drCRQuIp
         IniFhJI2uYpiKARIRxtJ8qTtQ1tmQkvCQKSUPhkv9t6pFXU/4COJ3gNGzefFvTCcRWGP
         4xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGAu4RK1+bPr/qDz/fldKm03YL7PhSciYtK65EU2YWY=;
        b=n+p22P1x4rnWLy3ZM6gJZezrVYO26K9iVN3Y/d/f723BjdOOHCj6j1L/Uw0+Zbdg1l
         iZqVNpyANveYTNorMeT0yCBQN6H575gYHiHibWz+4AB2cv8lQ+0qkIot8TchCmrVy1jY
         yA87REcHPBYHozXqzBKJsre1jf0CA1l0jeKiMVRaz+xGhn5BKXO5/+j4RgZKWHWpti9p
         YMbNobkhp52bMUSoZNDwur8FRUEHh02NbIWaxdQxhmvzov6D5rOZ8xMYZ1z/0O9Em+Lv
         xO8UNkQpIG0k/zYxvlfS+SrA1vXf9uV0Wl3hZfx8tAHXAETlkxE9plrOjZO1o9VWLGey
         bgCw==
X-Gm-Message-State: AOAM530f43ID/WiZXtbtw7Tzw+TA7IJ+dd5rWTg1eGwZBleogF8VhO46
        izJFQt5IW6ASdBgOGZjC9GRDIhF+yngRCo2w8QCHfT8O
X-Google-Smtp-Source: ABdhPJwWXQESQc73irZB3Wr3W2PDfmYsZTBOu2x2hRiblxBDwGnQCaQmNGfsLeFxHOALPRTNvF1atx//UXDFjRg5RTc=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr295257ybn.440.1622750620237;
 Thu, 03 Jun 2021 13:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210603192026.185625-1-marcel@holtmann.org>
In-Reply-To: <20210603192026.185625-1-marcel@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Jun 2021 13:03:29 -0700
Message-ID: <CABBYNZ+YTevbqingXfJ=sTX=G10pGjRwRi+8TEnHa1RSETHAZg@mail.gmail.com>
Subject: Re: [PATCH 5.13-rc4] Bluetooth: Fix VIRTIO_ID_BT assigned number
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Jun 3, 2021 at 12:22 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> It turned out that the VIRTIO_ID_* are not assigned in the virtio_ids.h
> file in the upstream kernel. Picking the next free one was wrong and
> there is a process that has been followed now.
>
> See https://github.com/oasis-tcs/virtio-spec/issues/108 for details.
>
> Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/uapi/linux/virtio_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f0c35ce8628c..4fe842c3a3a9 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -54,7 +54,7 @@
>  #define VIRTIO_ID_SOUND                        25 /* virtio sound */
>  #define VIRTIO_ID_FS                   26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM                 27 /* virtio pmem */
> -#define VIRTIO_ID_BT                   28 /* virtio bluetooth */
>  #define VIRTIO_ID_MAC80211_HWSIM       29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_BT                   40 /* virtio bluetooth */
>
>  #endif /* _LINUX_VIRTIO_IDS_H */
> --
> 2.31.1

Applied to bluetooth.git, thanks.

-- 
Luiz Augusto von Dentz
