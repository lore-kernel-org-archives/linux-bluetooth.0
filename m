Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90054C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D81611EE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhEEQIl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhEEQIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 12:08:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A736C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 09:07:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o27so2002441qkj.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIiJfW9zZM/AzeFGOLYj4IPsxMiQz+BDB9ZjjXfBkQg=;
        b=eiPygUvDSy+tt7Q68C4IwCtPn3u3etglOU2Lj3/XPV2WCLKTiYUDg7KUMBcCfFl9IG
         aQqjjmrQajgC3PPVD7KyMJ9r2lgUlsZOGUj7R2QBwet72Rl4O4JQZbh7HdWS9JzTa7Hx
         gs0EircnFraMMBg4grZST1Kk2o0lV0JQO0LMwzoFqd9fhjro6hp1WbC8k89wb/GpH7B3
         0OFh72FgwpJWrKgKa1qgFsYPunm9Un9i4T/+478/CS30+46afps/0ZIskp5qvsMvw+2Y
         qUBgM0eR43ghQ11+GbHJl2Yqr9ewCZTDXzpgdLDEv40MXoM6s9XB8I/a38oT+gaQ9Ss3
         OMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIiJfW9zZM/AzeFGOLYj4IPsxMiQz+BDB9ZjjXfBkQg=;
        b=O167hQJIvNkfOFdV3Wrn7bpt07YfieVbvnC8rndhFP6jp8agj4Q4Vq7F0tXk+ZOVKJ
         28ZULl1IdGwi6av0duTevD+Y5hrOgC63lM+TQTsdIn3J0RvwXZ1xr7A0EaFrsTx0ORsp
         hLttkNUXiI/yni+1K0M2TgSlBKhJlugt037w2DkewoASxKSrLubvG6BLnlMDn12xKIeb
         S1T4A5l8nO1O3nwwOwd/8hCYskAy021nrfMMC1O03J1uudRsf5GLIACbW6q3O3MEREJh
         4fyNLlQf/1S0TYef0XLzfJiCwSFgGAyYCg3JSO8CxVibTMYSou7G+E+9Vb3+sS9kTomo
         xHww==
X-Gm-Message-State: AOAM5300pw3ZoPf6Q6acpdrc5SebzOB8Oio+p7uNuQe93N7InvkbZ2yo
        fr2s7OTZHV4srfAbnvH0OzhloEGg5D7Kfmsm7iIhJvZOUOo=
X-Google-Smtp-Source: ABdhPJx3Vz8XUjrWDlXiIUh/Sh4atHIziC30URMIPubkhKz+5T3UAZ0DDID19/ktekugrogcEAwFldQ15Ey/0DQ5z+w=
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr18710509qkk.186.1620230862131;
 Wed, 05 May 2021 09:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210429103751.v1.1.Ic231ad3cfa66df90373578777cf7cdc7f0e8f2ae@changeid>
In-Reply-To: <20210429103751.v1.1.Ic231ad3cfa66df90373578777cf7cdc7f0e8f2ae@changeid>
From:   Yu Liu <yudiliu@google.com>
Date:   Wed, 5 May 2021 09:07:06 -0700
Message-ID: <CAHC-ybzmwCSbYXRAvUEih6C+H7obkD64OS72QXaOfS_MPOpDDQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add a new MGMT error code for 0x3E HCI error
To:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ping for attention.

On Thu, Apr 29, 2021 at 10:38 AM Yu Liu <yudiliu@google.com> wrote:
>
> This is to enable us to retry the pairing in the user space if this
> failure is encountered
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
>
> Changes in v1:
> - Initial change
>
>  include/net/bluetooth/mgmt.h | 1 +
>  net/bluetooth/mgmt.c         | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index a03c62b1dc2f..78b94577a7d8 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -45,6 +45,7 @@
>  #define MGMT_STATUS_RFKILLED           0x12
>  #define MGMT_STATUS_ALREADY_PAIRED     0x13
>  #define MGMT_STATUS_PERMISSION_DENIED  0x14
> +#define MGMT_STATUS_CONNECT_NOT_ESTD   0x15
>
>  struct mgmt_hdr {
>         __le16  opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b44e19c69c44..9e44c04d4212 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -271,7 +271,7 @@ static const u8 mgmt_status_table[] = {
>         MGMT_STATUS_INVALID_PARAMS,     /* Unsuitable Connection Interval */
>         MGMT_STATUS_TIMEOUT,            /* Directed Advertising Timeout */
>         MGMT_STATUS_AUTH_FAILED,        /* Terminated Due to MIC Failure */
> -       MGMT_STATUS_CONNECT_FAILED,     /* Connection Establishment Failed */
> +       MGMT_STATUS_CONNECT_NOT_ESTD,   /* Connection Establishment Failed */
>         MGMT_STATUS_CONNECT_FAILED,     /* MAC Connection Failed */
>  };
>
> --
> 2.31.1.527.g47e6f16901-goog
>
