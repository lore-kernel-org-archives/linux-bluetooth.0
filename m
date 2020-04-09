Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D808CC2BB55
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB922072F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHn6OwF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDIPKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:10:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38186 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgDIPKx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 11:10:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so8169032lfc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwKd9JsvEFqDXzEb7Wx30bWtDV3uG3GC4Hcn/AFJpJg=;
        b=mHn6OwF0F3cHOTFyFJciSNXJynjJy3uP2JtTIkJDXuxvjiZILdpeRh3mougkglsVHB
         whiz1ZLlJK+jgjQHHaNrKA9vmpASU48D597yBg9/xzPIZ3iB89kLAp38cJTp8LYrF8fU
         W3k9yYy0YDusOkNymU3tCoOq05eTJlw9RIZE+lpm8hRVER6VMenO7VbzwT26ODJtTWyp
         6ujcN3GTgFLU+MtyoUsh7+dCT6Z8Pk2lvXozy/M1kDhrv5mhH979g8wD5dic4oMGjR9u
         phatDUjfLVi3S4NRQ6qoE1BV3kyAUSJ1/+6CFiJ52cxLu+IG62uAXH85QFpBwbGDGm4g
         qQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwKd9JsvEFqDXzEb7Wx30bWtDV3uG3GC4Hcn/AFJpJg=;
        b=aZMk7GL8tHIIyDRhKsQMdNEtWvkNF1eJjNXPQI6xpuEKut7gqavfe2BaI3n1Nh5s94
         kurCSkedIcHuIKcE5ThfyFp0kD2P2lRHWx+BOElFUpEPgL7cB7txwcg0MpBf6vtkIDrm
         jtb699kzDHjL8U+vZCseDUVElOJS5qc0y3hMqfIX4WPWr+ZpPELmxkLbO1c1bOoNlxot
         F4rxXP07/dENmT4wF/OQIEwXBiYQ5QR48Lw2XbYM06CHhHUHalwwmhC75vQrTjkxwjYX
         s1YOKYFZjGTumAJOtOmBpkJ4YKJ+0Gsa9zsDHw9DsUkvLp5IM/IKxpeff2F2toxzIcQt
         IbMg==
X-Gm-Message-State: AGi0PuZrVwvQWEvlkj6709wyekYLpazX7GOTla5djino9XsaAQopiRHA
        sxFIMJK4h774qnUCR97dJ+rMUuMpK1zhYXBlGvJ0Fg==
X-Google-Smtp-Source: APiQypLzOr10Jw6JbAkRLG77MM9ELF47i7DMLcDJZDruzpUvHhMfE7UuPzX4DWNlluY83Ug+OagqK90fNQUQ0WPJftE=
X-Received: by 2002:a05:6512:3e2:: with SMTP id n2mr3379892lfq.129.1586445051526;
 Thu, 09 Apr 2020 08:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200409111829.9508-1-daniels@umanovskis.se>
In-Reply-To: <20200409111829.9508-1-daniels@umanovskis.se>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 9 Apr 2020 11:10:40 -0400
Message-ID: <CALWDO_Wkd_P5bz7P=UxG=VLQyuikPjbR5SPi7u7DdaB_7x=-ag@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: log advertisement packet length if it gets corrected
To:     daniels@umanovskis.se
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Daniels Umanovskis <du@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 9, 2020 at 7:28 AM <daniels@umanovskis.se> wrote:
>
> From: Daniels Umanovskis <du@axentia.se>
>
> The error could indicate a problem with the Bluetooth device. It
> is easier to investigate if the packet's actual length gets logged,
> not just the fact that a discrepancy occurred.
>
> Signed-off-by: Daniels Umanovskis <du@axentia.se>
> ---
>  net/bluetooth/hci_event.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0a591be8b0ae..af7fa7ef94ed 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5353,7 +5353,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>
>         /* Adjust for actual length */
>         if (len != real_len) {
> -               bt_dev_err_ratelimited(hdev, "advertising data len corrected");
> +               bt_dev_err_ratelimited(hdev, "advertising data len corrected %u -> %u",
> +                                      len, real_len);
>                 len = real_len;
>         }
>
> --
> 2.20.1
>

Reviewed-by: Alain Michaud <alainm@chromium.org>
