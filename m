Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF13FC43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B33021734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEdwJbw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRWNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRWNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:13:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9665C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:13:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c13so8848655oiy.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WhB1J1H9Gun1aW5BMN2B4pl+dxsJznMXuc3BkdzdfY=;
        b=iEdwJbw9CcHWPxcbKxW3+i99lSL4qtUG1zrEP6DHiLH1QM+acnQgAjYb/w3XuPAWkS
         M2ym1HO5Adj7DIP/PPF7U38PeYcmuLxHQap2WaEADUvluwTpO7T4SYTZY9OoDcqRl1gn
         uXEth0OLSeMWpkp7CfT3rrRT1boU0TQTO52WYEONkdCO51WTXqjYMstpMfqUoZA4B8pj
         K5jajG35T8EucRwir6GPyv5MJsI92lI75FGMimcusMz0iSH/benvWZABevHLqJhim5dD
         G8g7JdYY6g3md2d1gcecpm3eo2O9iy9qGv4tS9cpOG+Ug+mhE5BexfmUPCuatZM/t8U6
         ci9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WhB1J1H9Gun1aW5BMN2B4pl+dxsJznMXuc3BkdzdfY=;
        b=oLUCJmT0wgKZ37twWu5QkGNzMNQLaYGNPBBHOW7sEQZgPTjybMeRoEqLTBvnTuU0K/
         Q6v5SNJbySUilH1OCYPaQk3GUBO+KvZazWTbyzMDQW2AY9TIN4qDlGIHlmZh27rRkn17
         PEKcFF6527ASW7fiRoTF3sA91mcaJ8IEDGiMyOBunSEenPOXMyKFGEeL7t3GmrXLeFzM
         xbBJFb9AsfddSpRz/fpaKLyX/iusK2dJqkTJjtn2G1BS/uXP8l1XDI/U4howFpQj+b/b
         xfm+DY1Dasjw+LM2SHBzGcmRSgLdHfO1d09uvAjDPoRXw3c/N30zvJwELkMg3zupjYqI
         DGRw==
X-Gm-Message-State: AOAM533VRDPrWJ5M9jAAdW66ghlQ7awMy1dZT1w06RE8lq3DPhdvdcmN
        F525MW/W8p8TJBAQtUHZGCIltXC/3KysPGf0wlc=
X-Google-Smtp-Source: ABdhPJwF6xRVrVHfC68waoK79wJ5SG5A87GNk5svVgZ0Ushk93m8fmIpkKXiU8ZKvTvnwn1tWN9AjbkMrGLFrF0CEVI=
X-Received: by 2002:aca:38d7:: with SMTP id f206mr10002631oia.48.1600467213164;
 Fri, 18 Sep 2020 15:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200918210846.37797-1-tedd.an@linux.intel.com> <20200918210846.37797-4-tedd.an@linux.intel.com>
In-Reply-To: <20200918210846.37797-4-tedd.an@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Sep 2020 15:13:22 -0700
Message-ID: <CABBYNZ+8-GsnTeJyCETo-3pGHSDxxDUS_6szMvbGfS8_ngyRVA@mail.gmail.com>
Subject: Re: [BlueZ v4 03/20] btio: Add SPDX License Identifier
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Sep 18, 2020 at 2:17 PM <tedd.an@linux.intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds SPDX License Identifier and removes the license text.
>
> -------------------------------------
>        License            COUNT
> -------------------------------------
>  GPL-2.0-or-later     :      2
>
> License: GPL-2.0-or-later
>    btio/btio.h
>    btio/btio.c
> ---
>  btio/btio.c | 15 +--------------
>  btio/btio.h | 15 +--------------
>  2 files changed, 2 insertions(+), 28 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index 844d6007f..c18b6a012 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

It still appears to be using C++ comment style.

>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> @@ -6,20 +7,6 @@
>   *  Copyright (C) 2009-2010  Nokia Corporation
>   *
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - *
>   */
>
>  #ifdef HAVE_CONFIG_H
> diff --git a/btio/btio.h b/btio/btio.h
> index 23e0ef72b..f0259cf1d 100644
> --- a/btio/btio.h
> +++ b/btio/btio.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
> @@ -6,20 +7,6 @@
>   *  Copyright (C) 2009-2010  Nokia Corporation
>   *
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - *
>   */
>  #ifndef BT_IO_H
>  #define BT_IO_H
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
