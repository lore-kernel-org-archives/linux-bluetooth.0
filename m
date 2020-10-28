Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B9C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6720724
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC8ILkXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgJ1XmV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgJ1Xlu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:41:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:41:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 15so803692pgd.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztIBTxTOCqVSao9pMJM3OJrR4WGp4y7BufKyjyEK6BY=;
        b=GC8ILkXtp+MRlJWpDOA/BSY4ey3n/pFoVmRRfZMmevVIsg6CkGqxBV+3mnUgSDtT12
         FbMTwWc94OveYhP+nORDTYgNV/wtIgAGGoURDw5UcPn2xHi9H317N3rjdXI44TAJxHYh
         QGxd2STPBJBNNjs+h2bVYgzOlAVCJcfHU57J5rKs8XzgaFUdbBz5EdvGK4QETOrcn1N6
         gP7q2HicU28fk05VtOU/KNa1eTAYidHPgS9uWcoa7KSvIJlRAngheHzcdPtKxG+aKIVq
         +HI89U8XQJe+mfpBPzWj1d4qSX4puMCmwfIbBtdENbSYd5rQVgzyks1GTsv9w/bnoAPn
         yGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztIBTxTOCqVSao9pMJM3OJrR4WGp4y7BufKyjyEK6BY=;
        b=h5ma2mfREnKZVccAb2qiHRpTq3tn1P1wewUw3bh0hAArW3zhk1JZ+oko2AFkz87YP9
         79J+SI0/pcQt0iHMugTOS2vsHUtFPDDAsIuuLEwAq0467JYlqMcC5DKIwEKQZ4etLF39
         YoiR9tWRkm3p7su4hvWCYlqUT3zWrsPFAuJ7nTqhKnPydeSHd71PqoY7LU0t30ktP21l
         RXgVkw+FX+sgvI9PZBfkIIwJ7958RrBzHObMkNyyK+Bz5pNcZ52PCWMMh9P0VUYlbTls
         CHmW/UNbWfE+AWFnzHVT6l1/HrcLLdqpfQxOd/KyiiiIXYN8krtp/3x52EbqW9hd7LvJ
         +vaw==
X-Gm-Message-State: AOAM533YzDy5JicPSqwfjAM5FivMzSQqUHUQcjd1kypcoJBLqsYud1SR
        U1jumTgTDEnDGNShUH75qK2dFBM0Bes+wrr9AdlMy9OyVAC0Rg==
X-Google-Smtp-Source: ABdhPJzchCZ3oPRe21STUr3D4O/c38z1LuUQPqkyPQZyrbQnCkhMqE9s2/QKjAeMOklv1Mx7R9EGhrrSx7VMQdyC6hI=
X-Received: by 2002:a6b:f610:: with SMTP id n16mr4960911ioh.103.1603863062431;
 Tue, 27 Oct 2020 22:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201022082304.31757-1-sathish.narasimman@intel.com>
In-Reply-To: <20201022082304.31757-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 28 Oct 2020 11:00:51 +0530
Message-ID: <CAOVXEJL1qCPmpY-jGW8AsycxGytCzuJQR4hv-bXPPSNyO=5GZQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On Thu, Oct 22, 2020 at 1:47 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
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


Gentle reminder.
Seems Many devices are failing to reconnect after every on 5.9 kernel

This patch will FIX the issue

Regards
Sathish N
