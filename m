Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D03C55179
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B06B20782
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+pUw3gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJ2AVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390904AbgJ2AVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 20:21:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA0C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 17:21:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so849287ots.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTdRXkU1iOmXfsen+GUO474+B7vMyiAcNtBhZvZXNeY=;
        b=C+pUw3gsPkjm66Cc7MTOxVoH54wFIaZflNx05BqZ+CXSKCznZMOwb670d8vAq5mM/j
         Ipe23ttHepklJmbL3+GFWYIPjOTFHmlHDU1J9sc9U2eAxImThwipaqS/h29HFG6Y/4cr
         8Aw2WeDssVeT7ZmKzyf7RvF/2HsKvUxwXzxIEh8GM6AIsR5xWQhbvrcN63BiQUSP00JF
         5s+VD4dHs+nblui9ERGKq2CgBvNVKiVuu8QK6dVZ8QDI+xQSRFGpBhmDtF7tNDKLSrcU
         LslyxdIEYY5CbnJf2WB59qFi+dyO0/dBwP2ePAnLdL7JnwX9bCgL1erqwKPsFx5S4gAY
         kmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTdRXkU1iOmXfsen+GUO474+B7vMyiAcNtBhZvZXNeY=;
        b=I+Rxf6uOZOwzdI36wedKOCR5wkjpk1wHEBEqoWYHy+wVBAFPuBLTSkjT/XSWkRlnjb
         vB38hvC9xvN5Jj62pPWrJt5h8X9fcp0pWUY7rvKUNQRlGh3gj3JyTD/7DVYcR8mOvJDy
         ESdop66f3XhP8p0Tht0PaHRKWQr/XsGJggtrAgrLAHw6GRHoTeKWwCESkXiM38v7biE+
         clJrit59hfCFWJFsPArxp+vqM1OuuzqcsvjZlPFUjgnliQuHJ8mEIJh/vGrLXpWQfrAS
         fpGUSye3lgkZv9wd018QWGFonlFIo1ysJbzbC0rZ+4w5PIxLsT8YXHKGmoma7RMNDz4r
         Eohw==
X-Gm-Message-State: AOAM532nK1PB9/7FsapmKn6FAJ538uLi0HEOE4vSBFdcGyrMmvS/Zs/z
        TkV7EPksyB9ndVsTZuFkrZnXwTlkIpSXuFSpA5A=
X-Google-Smtp-Source: ABdhPJwsS2W2a5TuiOzqd0RHkPc9LXQE6YHcj0RscSIAbjsqPmBGCKQIfpv71GUK+oTq7Z6UEfbmZyIjN01WMdYQjOQ=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr1396613otn.44.1603930868932;
 Wed, 28 Oct 2020 17:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201022082304.31757-1-sathish.narasimman@intel.com>
In-Reply-To: <20201022082304.31757-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Oct 2020 17:20:58 -0700
Message-ID: <CABBYNZ+1E3oVAKkHJTZqCR+KXWBvB7jBDvmoPJmaYAK7kr_r-w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Thu, Oct 22, 2020 at 2:04 AM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> When adding device to white list the device is added to resolving list
> also it has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
> HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
> to resolving list. use_ll_privacy macro is used only to check if controller
> supports LL_Privacy.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=209745
>
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  net/bluetooth/hci_request.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 6f12bab4d2fa..610ed0817bd7 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -698,7 +698,8 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
>                    cp.bdaddr_type);
>         hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
>
> -       if (use_ll_privacy(req->hdev)) {
> +       if (use_ll_privacy(req->hdev) &&
> +           hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
>                 struct smp_irk *irk;
>
>                 irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
> @@ -732,7 +733,8 @@ static int add_to_white_list(struct hci_request *req,
>                 return -1;
>
>         /* White list can not be used with RPAs */
> -       if (!allow_rpa && !use_ll_privacy(hdev) &&
> +       if (!allow_rpa &&
> +           !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>             hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
>                 return -1;
>         }
> @@ -750,7 +752,8 @@ static int add_to_white_list(struct hci_request *req,
>                    cp.bdaddr_type);
>         hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
>
> -       if (use_ll_privacy(hdev)) {
> +       if (use_ll_privacy(hdev) &&
> +           hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
>                 struct smp_irk *irk;
>
>                 irk = hci_find_irk_by_addr(hdev, &params->addr,
> @@ -812,7 +815,8 @@ static u8 update_white_list(struct hci_request *req)
>                 }
>
>                 /* White list can not be used with RPAs */
> -               if (!allow_rpa && !use_ll_privacy(hdev) &&
> +               if (!allow_rpa &&
> +                   !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>                     hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
>                         return 0x00;
>                 }
> --
> 2.17.1
>

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

-- 
Luiz Augusto von Dentz
