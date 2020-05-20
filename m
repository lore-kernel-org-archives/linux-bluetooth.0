Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9A2070A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fAyRfNb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETQXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgETQXl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:23:41 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C596C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:23:41 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id t4so260270vsq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7mARV1yPP/qXrJMMDnEokZ3kiyUwRYK/mNQT36eOco=;
        b=fAyRfNb95x+2C9UkDgxrgJ+2lRUqPSsq/EqvVaHtZcgDRuSJ4AVO1tOojZ7L7M5oee
         PJ19BSq+PWwPTGauHBWmMqmfgWYFAMZBdlhkELdpnwYAran/Ew78PDWvdwKPRXji8poi
         JPDWrRFNlWNHnC0rEE8vD7lbrX16HvSp5dYqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7mARV1yPP/qXrJMMDnEokZ3kiyUwRYK/mNQT36eOco=;
        b=GVhRkYuknZdSFhMouQIFe8VvH6YQKfYXB2lL14d6WNt/kXYyRNC1/jrnykXt3MHCNo
         gBd/XHVSNHTxQXnMuXJ6ZjbYNrHRe8IWYV1UYJ40gA+sMdKa1MQP//dCEOdVaX+3xmdY
         1E0nbXm3gPgWX9tXpG/rjB8VXfYLyDrupIg/uRFjI5Ss4i2VvPLrraKATP9zb6byeTjd
         wbACJGlSKYBfnNbxp8lrvCV3AYvYwvQOeuH/Mqsk+XmW8ZX5avBPYCw6i0FcbUhq35OI
         405epjTcLIcZWnYo7cFuRns50VnNGw3b4zUmPxzP1/Zoe/0aH8/9G2on15eUXQEyE46e
         RK+w==
X-Gm-Message-State: AOAM533+CX4+l2BlCAUesBh03uhRGEOJkbAeR5JlwB5PVVFbB8BJdY1K
        XygNd8JS+bxzwoW3O4tEH+jnxPEbEvzPZSlR4b5JFQ==
X-Google-Smtp-Source: ABdhPJzqpGeUqkRilDoDaFV4rk2i7l40sm0ByZIKKDRyWWEpAwoUglt1xhEbXoyUjaPjI1EgaAJohcKBwgb9PGvMkHg=
X-Received: by 2002:a05:6102:209b:: with SMTP id h27mr4257860vsr.71.1589991820474;
 Wed, 20 May 2020 09:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200520120510.GF172354@mwanda>
In-Reply-To: <20200520120510.GF172354@mwanda>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 20 May 2020 09:23:28 -0700
Message-ID: <CANFp7mWsg5suwOPRvz1VCncztikah3VPpj5QEG-Heb_-TVQ6aA@mail.gmail.com>
Subject: Re: [bug report] Bluetooth: hci_qca: Enable WBS support for wcn3991
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the heads-up Dan. Patch incoming to fix this.

Abhishek

On Wed, May 20, 2020 at 5:07 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Abhishek Pandit-Subedi,
>
> The patch a228f7a41029: "Bluetooth: hci_qca: Enable WBS support for
> wcn3991" from May 14, 2020, leads to the following static checker
> warning:
>
>         drivers/bluetooth/hci_qca.c:1960 qca_serdev_probe()
>         error: uninitialized symbol 'hdev'.
>
> drivers/bluetooth/hci_qca.c
>   1948          }
>   1949
>   1950          if (power_ctrl_enabled) {
>   1951                  hdev = qcadev->serdev_hu.hdev;
>                         ^^^^
> hdev is only initialized here.
>
>   1952                  set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>   1953                  hdev->shutdown = qca_power_off;
>   1954          }
>   1955
>   1956          /* Wideband speech support must be set per driver since it can't be
>   1957           * queried via hci.
>   1958           */
>   1959          if (data && (data->capabilities & QCA_CAP_WIDEBAND_SPEECH))
>   1960                  set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>                                                                       ^^^^
> Potentially uninitialized here.
>
>   1961
>   1962          return 0;
>   1963  }
>
> regards,
> dan carpenter
