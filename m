Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7032C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727EA20767
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLXnp58D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgFVT2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVT2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 15:28:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73024C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:28:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t25so16676011oij.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nITZWK1n0LKPk3x5RqeDfZR3MGOdty/EBCvI+cFvcro=;
        b=JLXnp58D0a4gNZWvsukg3L+vIpRR/lPfglrj/E/5H7sKN1M6DU0D3dwYs+9BykGAlp
         P3fcVKUlmgigbn51HJwyeskqLbCWcb2xyRrSVWNuNMt0sbZWk8L0w/LWxRiUR8Wak7LK
         foKwdHa1m12m/qziXOM/RX/zLqp/zg5VjYChJivc2JK2GIYCdr+0IAbiTk5+UWOFjsF5
         GpmJ2ciblNJwjIufYmLFkx88qxgVq96EQACSIH+OoxADnL3YUzM2Nbsb1vch4G5+4+1b
         YA0ywpMbtsWcz6qOAJ1WGL04Ph0r8am50LBCUmBmQ+FjPj65qwiQRn3yxArOecCr+He4
         q9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nITZWK1n0LKPk3x5RqeDfZR3MGOdty/EBCvI+cFvcro=;
        b=BSThvxGJ1HaNGl6Mmf/97K/LmYB47ig1nUUA2dKDm5iyG5MWehPN2xDq5KYBxdJ1Wy
         Kv3O5MltTIfTeWh8WWxTPHkS6l6DZhMjWbUpXcKbVY8FmpCNff4C+vzKmOeSXnQTsgWB
         Dgv3tn436Skev8Af66zNm2DYQ4hf1+tRjQhpYhFFtxBMKeqfebCFOGaooq9lGYEpVwSr
         j5lZRou+RNoJNY8tTi1GNGhi4sbryWWewbVJr2ORvT8VM+BRFYVr/8roJ+YLNJuX9cgb
         aBoUp/XAAnTedLqgGNkD7oX6fHih0+EUocKHVH62LE2IjEdMMHD2NUcp4jGlsSEl/VqK
         yURw==
X-Gm-Message-State: AOAM531k+ar/7yLiaUpazWypcSuD7doszF0TPz47owM2d59rUFJGq+K1
        qTrfazDqQtmptaLMP2GwPAcRF0aamRDazU0UROaexw==
X-Google-Smtp-Source: ABdhPJzTXsH0Hr5oxcKHx8ukLJIZhsFil5Zwq2iSwxa9X1EilId24mhhK3D70raPaRgPjljiO1NDYLIZ+vUcenZZvxA=
X-Received: by 2002:aca:568c:: with SMTP id k134mr12919791oib.48.1592854117718;
 Mon, 22 Jun 2020 12:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200622171817.144830-1-tedd.an@linux.intel.com>
In-Reply-To: <20200622171817.144830-1-tedd.an@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Jun 2020 12:28:26 -0700
Message-ID: <CABBYNZ+1oQ-jq6nf3VeyKrEgKG+t0EfTdTgPuT5T1VB=5aia3A@mail.gmail.com>
Subject: Re: [PATCH V2] checkpatch: Add configuration for checkpatch
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Jun 22, 2020 at 10:22 AM <tedd.an@linux.intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch adds a configuration with basic rules for checkpatch.
> ---
>  .checkpatch.conf | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 .checkpatch.conf
>
> diff --git a/.checkpatch.conf b/.checkpatch.conf
> new file mode 100644
> index 000000000..419733832
> --- /dev/null
> +++ b/.checkpatch.conf
> @@ -0,0 +1,14 @@
> +--no-tree
> +--no-signoff
> +--summary-file
> +--show-types
> +--max-line-length=80
> +
> +--ignore COMPLEX_MACRO
> +--ignore SPLIT_STRING
> +--ignore CONST_STRUCT
> +--ignore FILE_PATH_CHANGES
> +--ignore MISSING_SIGN_OFF
> +--ignore PREFER_PACKED
> +--ignore COMMIT_MESSAGE
> +--ignore SSCANF_TO_KSTRTO
> --
> 2.25.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
