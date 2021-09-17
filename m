Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 19:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA29611C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 19:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhIQT6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhIQT6D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 15:58:03 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62398C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 12:56:41 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id v9so6796571uak.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuqyQxvKLXvItamRaNmZW+CCpwuCp0uNC4Ly+uIlvdQ=;
        b=ik6QA5uZ2u3kBc9l6AkEIGPKjYWNMeCntkxioG/aVehz8CbGJCLgeLtj/ZSRoI6JsV
         3y29Kx2O9Xz3HQCVffx2GwurQEMmECee6xqVGBLgh35Hk/nRcF3nkYXcEYHPms/1zJ00
         pcvQjsfkizwR62HOB5bwa0fbda/sJSM2QC5xeEayGt5ZyGqfQIkY35xg9VOnG+YfXYwy
         vQbiG8Z5xXbRmxi3JaCOdNmjJelx0mmD2DANm6SmfpnnHuv+lw/QjHm4Aoo7w74VDdlk
         9NqgxBOnCJARXLb6p50W7ER5Pas+1GreoVjaNDYQpxVL8dr5jFw6fPVbecBkwrxFxjn+
         vTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuqyQxvKLXvItamRaNmZW+CCpwuCp0uNC4Ly+uIlvdQ=;
        b=anYcwvXhmxzo2Jb6Gty+0ZwkwfMB7VactwQl9mMHS7SW4yGDit+8nUGVIRvLIUMRZR
         1CHe6IZZixxR2LFNQnT2JwDWYW07mgl7BpPiUxzYbausH9Mk+tbytiu/3s+AJBfq1DL4
         8k7znJROPQUBFItEEb3NuWcaoCkanefkgOpuHuFvwyCgpwfuAOyzv/zF0uWuRhStLqH/
         px+rO76f4AZXHZebFcp79XqAr1snB47Q3RHpJeIFSfbtNkRPEQ01noc5yWBXtQRWvECQ
         3lyHWv8ETj8oXgfBLyyU9BHVZ0T3Q1IGLyqn5Du46jCqln3pfQaij7ghhtri1H0DXh4x
         rCWQ==
X-Gm-Message-State: AOAM5329iscjKfGcTm7tZv88pkWbyeeu4tztIRgMKzyHiIKpgM6ONhfj
        Mc+fOqsR7sWpRCbwmL7pze/LJhCgv4cCt9QmKOg=
X-Google-Smtp-Source: ABdhPJwkPA+hf/hNkkLbh5FFbbCy3FBm7BXrPPGMlXCWXNmhPZd9Enh6SZKsWgqFDVjHPv3KmFYbvRUKDpstYyfPqKE=
X-Received: by 2002:ab0:3766:: with SMTP id o6mr6245020uat.102.1631908600270;
 Fri, 17 Sep 2021 12:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831162546.3643599-1-pab@pabigot.com>
In-Reply-To: <20210831162546.3643599-1-pab@pabigot.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Sep 2021 12:56:29 -0700
Message-ID: <CABBYNZJqA8=b_SaDAR+ivePdUeyUrv8=ZukB1QDNEDmCY41FpA@mail.gmail.com>
Subject: Re: [PATCH] lib: fix variable-length array declarations in hci structures
To:     "Peter A. Bigot" <pab@pabigot.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Tue, Aug 31, 2021 at 9:30 AM Peter A. Bigot <pab@pabigot.com> wrote:
>
> Use of zero as the size for arrays as the last element of a structure
> is a GNU C extension, which as of GCC 10 produces diagnostics when
> values in the extended array are referenced.  Switch to the C99
> standard idiom for flexible array members, already in use in a few
> other headers.
>
> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
> ---
>  lib/hci.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/lib/hci.h b/lib/hci.h
> index 3382b87bf..a61568bce 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -729,7 +729,7 @@ typedef struct {
>  typedef struct {
>         uint8_t         flt_type;
>         uint8_t         cond_type;
> -       uint8_t         condition[0];
> +       uint8_t         condition[];
>  } __attribute__ ((packed)) set_event_flt_cp;
>  #define SET_EVENT_FLT_CP_SIZE 2
>
> @@ -2135,7 +2135,7 @@ typedef struct {
>  #define EVT_LE_META_EVENT      0x3E
>  typedef struct {
>         uint8_t         subevent;
> -       uint8_t         data[0];
> +       uint8_t         data[];
>  } __attribute__ ((packed)) evt_le_meta_event;
>  #define EVT_LE_META_EVENT_SIZE 1
>
> @@ -2159,7 +2159,7 @@ typedef struct {
>         uint8_t         bdaddr_type;
>         bdaddr_t        bdaddr;
>         uint8_t         length;
> -       uint8_t         data[0];
> +       uint8_t         data[];
>  } __attribute__ ((packed)) le_advertising_info;
>  #define LE_ADVERTISING_INFO_SIZE 9
>
> @@ -2246,7 +2246,7 @@ typedef struct {
>  typedef struct {
>         uint16_t                total_num_blocks;
>         uint8_t                 num_handles;
> -       cmplt_handle            handles[0];
> +       cmplt_handle            handles[];
>  }  __attribute__ ((packed)) evt_num_completed_blocks;
>
>  #define EVT_AMP_STATUS_CHANGE                  0x4D
> @@ -2264,7 +2264,7 @@ typedef struct {
>  #define EVT_STACK_INTERNAL             0xFD
>  typedef struct {
>         uint16_t        type;
> -       uint8_t         data[0];
> +       uint8_t         data[];
>  } __attribute__ ((packed)) evt_stack_internal;
>  #define EVT_STACK_INTERNAL_SIZE 2
>
> @@ -2407,19 +2407,19 @@ struct hci_dev_req {
>
>  struct hci_dev_list_req {
>         uint16_t dev_num;
> -       struct hci_dev_req dev_req[0];  /* hci_dev_req structures */
> +       struct hci_dev_req dev_req[];   /* hci_dev_req structures */
>  };
>
>  struct hci_conn_list_req {
>         uint16_t dev_id;
>         uint16_t conn_num;
> -       struct hci_conn_info conn_info[0];
> +       struct hci_conn_info conn_info[];
>  };
>
>  struct hci_conn_info_req {
>         bdaddr_t bdaddr;
>         uint8_t  type;
> -       struct hci_conn_info conn_info[0];
> +       struct hci_conn_info conn_info[];
>  };
>
>  struct hci_auth_info_req {
> --
> 2.25.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
