Return-Path: <SRS0=6tYv=OT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04234C04EB8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Dec 2018 17:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A392082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Dec 2018 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsuWvruC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A392082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLJRmi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:42:38 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40838 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLJRmi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Dec 2018 12:42:38 -0500
Received: by mail-yw1-f67.google.com with SMTP id r130so4283556ywg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Dec 2018 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSpYpdzswhfp4WwsgF2r5oqMU8q48/dm77jqDgp8BRc=;
        b=GsuWvruCNLtYJ63Li2ml3g72qanjyrf+v9yarbMbJdQ45bmYYyYPqAQ28mhtLetr3W
         xikMWA36BrnM3xLXtKCpoDrv9Cz80yOoVfTMModyWaR2H+ywCvRIw3CPBZdCRapMXg4Z
         wEIePecMX5ZEG+LaCxuBmPSeVqjtrX0Bj2hqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSpYpdzswhfp4WwsgF2r5oqMU8q48/dm77jqDgp8BRc=;
        b=X0Gakhow8OzT872I5z0NKLF065EOddSGLg2vVna0PcA6zBHt6cxewgChpLwnTQBFWA
         9u56FtbAXqehVbDsx/9ndu1jCAbPdEeBELIDyoHcjVMvbczkRZwdsbZrC8HE744q278X
         SSVHQcuPGd2KpNFlStCiugIVmpHySwSzSSrQBpDYzVCRZd+JiTUx9LNjItKOmhtwH9GE
         w8nHBoPG7w/ZcYYZZzgeUaRkdbyZKiIeN1EG6IHFmm6MCNc+Fkp5o0+7G2hhNl2Fba73
         PhQQdqVLP0yryPLA/zN205OMkv9bgxaB4kKs4XxwOzZ3lUGQcmBJdpLVi4en052rtkJu
         m0uw==
X-Gm-Message-State: AA+aEWYN89jXQqSPQ8luGcsEI9Wz6zbOt1tT05itam8ilYKMbsCqtq1l
        OhkSJfi8+hHIivuD/0YTFhWd9SUGjtc=
X-Google-Smtp-Source: AFSGD/VUnHmJHdju58LELOT+bphW1QtJh+754BUePpXJNVvBabc9e/nH+8H5RPYDKv7Nhs9LJE1Gtg==
X-Received: by 2002:a81:c50d:: with SMTP id k13mr12843964ywi.42.1544463757171;
        Mon, 10 Dec 2018 09:42:37 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i2sm4197840ywc.59.2018.12.10.09.42.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:42:36 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id d2so848779ybs.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Dec 2018 09:42:35 -0800 (PST)
X-Received: by 2002:a5b:2cd:: with SMTP id h13mr12999317ybp.403.1544463755432;
 Mon, 10 Dec 2018 09:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20181105145619.6395-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105145619.6395-1-tiny.windzz@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 09:42:23 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLHyCWcoWq29MOSRFs298cA+EO=cfo2Hr7N=Hi7GxbLbQ@mail.gmail.com>
Message-ID: <CAGXu5jLHyCWcoWq29MOSRFs298cA+EO=cfo2Hr7N=Hi7GxbLbQ@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 5, 2018 at 6:56 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/bluetooth/l2cap_core.c  | 12 +-----------
>  net/bluetooth/rfcomm/core.c | 12 +-----------
>  net/bluetooth/rfcomm/sock.c | 12 +-----------
>  net/bluetooth/sco.c         | 12 +-----------
>  4 files changed, 4 insertions(+), 44 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d17a4736e47c..38d92ced5fb5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7615,17 +7615,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
>         return 0;
>  }
>
> -static int l2cap_debugfs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, l2cap_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations l2cap_debugfs_fops = {
> -       .open           = l2cap_debugfs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(l2cap_debugfs);
>
>  static struct dentry *l2cap_debugfs;
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index b98225d65e87..1a635df80643 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -2166,17 +2166,7 @@ static int rfcomm_dlc_debugfs_show(struct seq_file *f, void *x)
>         return 0;
>  }
>
> -static int rfcomm_dlc_debugfs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, rfcomm_dlc_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations rfcomm_dlc_debugfs_fops = {
> -       .open           = rfcomm_dlc_debugfs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(rfcomm_dlc_debugfs);
>
>  static struct dentry *rfcomm_dlc_debugfs;
>
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index d606e9212291..aa0db1d1bd9b 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -1020,17 +1020,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
>         return 0;
>  }
>
> -static int rfcomm_sock_debugfs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, rfcomm_sock_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations rfcomm_sock_debugfs_fops = {
> -       .open           = rfcomm_sock_debugfs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(rfcomm_sock_debugfs);
>
>  static struct dentry *rfcomm_sock_debugfs;
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 8f0f9279eac9..529b38996d8b 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1173,17 +1173,7 @@ static int sco_debugfs_show(struct seq_file *f, void *p)
>         return 0;
>  }
>
> -static int sco_debugfs_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, sco_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations sco_debugfs_fops = {
> -       .open           = sco_debugfs_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(sco_debugfs);
>
>  static struct dentry *sco_debugfs;
>
> --
> 2.17.0
>


-- 
Kees Cook
