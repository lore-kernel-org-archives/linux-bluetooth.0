Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BCC04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7CE20879
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM413cLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfEMRjL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 13:39:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36192 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEMRjK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 13:39:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so10015383oia.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2019 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvsQmtpKUA2whoH0ahqZser2m4MwngopDjqludd7rpY=;
        b=QM413cLcl/FtcJ7vowCn7sJo8Sv1UpL1Jji9qC9Tm1cKvqN1A9XXw4CON/q+6xkoE+
         UEZX8BjbwdSRglJdnjeKQl6GV1yuSnI+Cdgzzn2MwsNI/CRY5Q14+TtoT+oJJrE8EbEK
         k/id63RSd61mBLTLZiKWbH2q5XvlL0aVq8HBaV3XLCLrKFClL3/m9yUhcCulRKHS7UqG
         J33HUnfLg7QD78+nC2RHK0pwEXpPKoCwm/gAZs91NdTiSSYmZxYqtAE2ORZZqAhZ+F79
         pUsinJFkEx6MvZ43u0yqS+dWG5JoqAtOPbfc0VWhV+vhfuycVE1tR6Hon0YBKe7d8jn8
         OUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvsQmtpKUA2whoH0ahqZser2m4MwngopDjqludd7rpY=;
        b=ggnDfYo0PMo0FfF0yEI4elG5uT4DvG7T/ML85W+fq5qKUHcTp4WSHUZad/53vX6q5z
         eEZZw0Itijx+oIzRyXx1mATSwQK5qsWmk107knvN7Ei9Fh7cQpbDAP7WYb7fqeFME0En
         KQla3S0ftzRz3jpRCH9Wy7CQ1X6ODDpDyDT0RbH8RzJ9hHEyC1/ArQRo/YI/VEhJdL97
         8hBC3jBRylPaQlX8fVfjjaa8RdktByoJtbvQNKa4MysgLqHw5nFyxw/o9LOb7ekEonJY
         CPphuMs5KB2R9/wAToqYlOam1Kgc0ofFIo4+hBr2xrc8+IiQdryCsCGJ4SYivI7kQ1Ds
         +xVQ==
X-Gm-Message-State: APjAAAWUdigxiRvqUoZHWVURoJKxTdj1HMuq7Oy23pegDXBhJxFomOk7
        W9zLT6Aov1svDHSwcBAfuNIzE2rUr3y2kq6JrjgOEB77SVo=
X-Google-Smtp-Source: APXvYqxxV7QtQSy4Y8Wlw+5Rvb0GtIqcTcuiA1ozZwGEbK8uD2AOdZFZiQxCj3SSbTeaUYqkRISBM5QPhQ/qTT8xgvI=
X-Received: by 2002:aca:5704:: with SMTP id l4mr204905oib.21.1557769149385;
 Mon, 13 May 2019 10:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190509123746.8396-1-hadess@hadess.net>
In-Reply-To: <20190509123746.8396-1-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 May 2019 20:38:55 +0300
Message-ID: <CABBYNZK=U6xCfdKV6LHCZEmJTz+tfwq97MGCAxoXrO_o2DjTyw@mail.gmail.com>
Subject: Re: [PATCH 1/8] build: Add a few default configure options
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Thu, May 9, 2019 at 3:40 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> Add 3 optional features that are currently used and distributed in
> the Fedora packages to the default build configuration.
>
> The additional build time is minimal, and it ensures that the build
> gets maximum coverage.
> ---
>  bootstrap-configure | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/bootstrap-configure b/bootstrap-configure
> index cc44ae74f..2d6231f39 100755
> --- a/bootstrap-configure
> +++ b/bootstrap-configure
> @@ -26,4 +26,7 @@ fi
>                 --enable-mesh \
>                 --enable-btpclient \
>                 --enable-logger \
> +               --enable-pie \
> +               --enable-cups \
> +               --enable-library \
>                 --disable-datafiles $*
> --
> 2.21.0

Applied, thanks. I skipped patches 2 and 5 since I want to check what
can be done regarding of usage of pragma.


-- 
Luiz Augusto von Dentz
