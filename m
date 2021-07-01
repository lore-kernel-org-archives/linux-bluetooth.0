Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C65C11F67
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69ABD61410
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jul 2021 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhGAVbh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhGAVbh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jul 2021 17:31:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA7C061762
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jul 2021 14:29:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o139so13116210ybg.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jul 2021 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3Ax5KiANODXeQnoi1N71FszccMTTaw457fOL3jT5rQ=;
        b=Yu/MffwZh6m96npORDDwFKW66aEHqyDh4mg9nih2kbHrtc4A7G7bGgsU3CJVXNvynH
         ndbIn4ImBbH+UGs7sYA1DR31yZx7uhl8WoFJshd2vF0idYV6ked3h2ZSN1ChwfoMj9Ho
         kOyR91CsSV+bz/+uEdQh5U6EtB1vIUcugCubiYTE8TIq+AJEs3l6of5ALMvxSqTFWAd8
         dHITQ6pT/SqW7Emye+/k0W5EV48AQRP1SK2zDn3cZV1/6PFyIaxKDX1+ZeHnzbJrbQW1
         o7oiGWsqZhZFceXU50M+RzPDuTcYne/rfKhIS1X5TXD6j6XAFJGxE54uzQmvPEBdTA5z
         xU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3Ax5KiANODXeQnoi1N71FszccMTTaw457fOL3jT5rQ=;
        b=VBvWigCFDV6mQJ29A0mj93/Q56qd9XXr+81bIIb6ADKKV3+X46LtJH36swFViT5lmu
         5WpHOyBnlQGs5pwdOwZNVvPfLEykTVnrOvbMcB53kxcOab8PVJJ+DvhpsVaxK8AJTUOg
         0iKAtQVEqi3R7QMoG9W7YmqbDZuq1u3ocxYcOUbVrxRSrNeBAbhvnBXtyXq3hkfAhRC5
         k8xzYN9tUGokR4RTDiOzEj8qZqFAD1uveOmGdv/aekNO6MeTEwICExDHCEkRnvSeHvlw
         oaHxCQagyoZgtQrWJmNH5okT2IUTECfaV9Bo6SAud++Gwyp534VcwnnbTbQUeWRGSnqC
         XwOw==
X-Gm-Message-State: AOAM531Q9sRiOl1Ef3+4CIf0LbLKhkgNmIlU0xFGERCon4NxcaR5Ogmq
        MrxnEJ61k1e7GrFKghPftgPPMsqauwhX7iFlSr8=
X-Google-Smtp-Source: ABdhPJy4lknegznkNhrVi7O4HwIJauAsP03KOHOHu0+sFELLmwCEDX6IGtANPYuVPp7wZvo9brZMvHYt2G1Ljo4jPYA=
X-Received: by 2002:a25:8205:: with SMTP id q5mr2399909ybk.440.1625174944198;
 Thu, 01 Jul 2021 14:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210626063010.152987-1-hj.tedd.an@gmail.com> <20210626063010.152987-2-hj.tedd.an@gmail.com>
In-Reply-To: <20210626063010.152987-2-hj.tedd.an@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 1 Jul 2021 14:28:53 -0700
Message-ID: <CABBYNZLqprh1nZmz9Pjk4bW1+V0nZaUaOJvVzxw_Z8hgLwMUyw@mail.gmail.com>
Subject: Re: [RFC BlueZ PATCH v4 2/3] emulator/btdev: clean up the queue
 before closing the test
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Jun 25, 2021 at 11:31 PM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch clean up the queue for connection before closing the test to
> prevent the potential memory leak.
>
> ==50== 32 bytes in 1 blocks are definitely lost in loss record 18 of 32
> ==50==    at 0x483A809: malloc (vg_replace_malloc.c:307)
> ==50==    by 0x14A37E: btd_malloc (util.c:33)
> ==50==    by 0x149D9D: queue_new (queue.c:47)
> ==50==    by 0x13B3C0: btdev_create (btdev.c:6042)
> ==50==    by 0x13178E: create_vhci (hciemu.c:229)
> ==50==    by 0x13178E: hciemu_new_num (hciemu.c:403)
> ==50==    by 0x130E2C: read_index_list_callback (mgmt-tester.c:357)
> ==50==    by 0x14AD91: request_complete (mgmt.c:264)
> ==50==    by 0x14BD34: can_read_data (mgmt.c:356)
> ==50==    by 0x14E794: watch_callback (io-glib.c:157)
> ==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ==50==    by 0x48B5B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ==50==    by 0x48B5E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ==50==
> ==50== 32 bytes in 1 blocks are definitely lost in loss record 19 of 32
> ==50==    at 0x483A809: malloc (vg_replace_malloc.c:307)
> ==50==    by 0x14A37E: btd_malloc (util.c:33)
> ==50==    by 0x149D9D: queue_new (queue.c:47)
> ==50==    by 0x13B3C0: btdev_create (btdev.c:6042)
> ==50==    by 0x1318F7: hciemu_client_new (hciemu.c:332)
> ==50==    by 0x1318F7: hciemu_new_num (hciemu.c:412)
> ==50==    by 0x130E2C: read_index_list_callback (mgmt-tester.c:357)
> ==50==    by 0x14AD91: request_complete (mgmt.c:264)
> ==50==    by 0x14BD34: can_read_data (mgmt.c:356)
> ==50==    by 0x14E794: watch_callback (io-glib.c:157)
> ==50==    by 0x48B578E: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ==50==    by 0x48B5B17: ??? (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ==50==    by 0x48B5E32: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.6400.6)
> ---
>  emulator/btdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 202fc7996..75cca7549 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -624,8 +624,10 @@ static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
>         conn2->link = NULL;
>  }
>
> -static void conn_remove(struct btdev_conn *conn)
> +static void conn_remove(void *data)
>  {
> +       struct btdev_conn *conn = data;
> +
>         if (conn->link) {
>                 struct btdev_conn *link = conn->link;
>
> @@ -6056,6 +6058,7 @@ void btdev_destroy(struct btdev *btdev)
>         bt_crypto_unref(btdev->crypto);
>         del_btdev(btdev);
>
> +       queue_destroy(btdev->conns, conn_remove);
>         queue_destroy(btdev->le_ext_adv, le_ext_adv_free);
>
>         free(btdev);
> --
> 2.26.3

Ive pushed this one.


-- 
Luiz Augusto von Dentz
