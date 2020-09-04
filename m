Return-Path: <SRS0=2wua=CN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323FC43461
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Sep 2020 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3102100A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Sep 2020 22:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIOreoCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgIDWgL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgIDWgL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Sep 2020 18:36:11 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34175C061244
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2020 15:36:08 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a2so7270308otr.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2020 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NleXdVdbpx9b00tfVBJqgckh877rdnwVriN+/Ekhxw=;
        b=OIOreoCoXSdHZQi8zB1BiO680FlVNsumY5Hylh8Xzh9Z0HCv62gBs4vZf4zm9Eio0M
         NviNXDOZlehUi/N0mPVuwnVLOP/AZKfUMAsn1N2HGHGc+3zCn60s8bG5GnUWa1iYgSke
         doxuezLKFy2T2pu1yY5o+AQW7/S+HPb7UcTozMKl1R4FsI4DPNFnVdnM6P/zw46nfkNB
         QnQZtsHbRPvYrz0ImGRzVwAVLbnYg19f+2UmXRvfU6Nzftw7jNmy1ls3XX2w6P/52Jos
         0UcjSnsf0YKekdavDTLmQz8+gH0mpAf3Q9CpVmhRP9Vvk17kke01sTigfyZXJkYNv3ax
         GO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NleXdVdbpx9b00tfVBJqgckh877rdnwVriN+/Ekhxw=;
        b=eVr8Cek17CO/NhSpylYpOdjcPBcD6wuoOYS1C0CpO3L39ABAF4WHd7AByAuOvYUcta
         L6kqaNut3hjX9gjQYdnnM21zjmzSgZOUTnNJqwjrLaOeeFjfz96bqM4cLHdam4Wdu67m
         dzExLmJtMMNUbuKm0XQNL171B6+9TjC1R+DVRrf8ITPXZdL/bDLzGxGEQAfc/0RrU5Jq
         PdzYmpzBoFUK+JUcsWjxzpqbG9SfNmdCtnUSh4id5ySCaSEalj+6UJnYUvTOlm0J9V2T
         WnmW3MoEq+IqZZC3jeTN/WwfNTHAI+G+Dixyn6h3K5l4vIKOmdxeamtaeqzc5AkqjdFt
         8qdQ==
X-Gm-Message-State: AOAM5309mbd9U9JQ6Wn5xRbahpMCupMjww2Gn8eeKki1OxjApWLlnPu5
        3Oz5ma3v70CHjGcB7JUQ5UCZxTdtx5oCvK1l9X0=
X-Google-Smtp-Source: ABdhPJywT5Btr2LUWf8mkdAXicgmQyZz89ZI4VDzln6AxZWvamghCN1nDuveORmpQ3TF3O5SAb5CbcIo7ol+FGVqsp4=
X-Received: by 2002:a9d:429:: with SMTP id 38mr6743513otc.88.1599258967511;
 Fri, 04 Sep 2020 15:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200903115020.Bluez.v3.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
In-Reply-To: <20200903115020.Bluez.v3.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Sep 2020 15:35:53 -0700
Message-ID: <CABBYNZL4wN0mNhSqmCevGnOcFsgbh+FhFrrZLRtkGh97sZhckQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/2] doc/media-api: Add Press/Hold/Release
 methods for MediaPlayer1
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Sep 2, 2020 at 8:50 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This allows us to send any passthrough command. The button can also
> be held for an extended amount of time.
>
> Reviewed-by: Michael Sun <michaelfsun@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> * Add Hold and Release methods
>
>  doc/media-api.txt | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index dabc69936..e98573157 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -199,6 +199,35 @@ Methods            void Play()
>                         Possible Errors: org.bluez.Error.NotSupported
>                                          org.bluez.Error.Failed
>
> +               void Press(byte avc_key)
> +
> +                       Press a specific key to send as passthrough command.
> +                       The key will be released automatically. Use Hold()
> +                       instead if the intention is to hold down the key.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.NotSupported
> +                                        org.bluez.Error.Failed
> +
> +               void Hold(byte avc_key)
> +
> +                       Press and hold a specific key to send as passthrough
> +                       command. It is your responsibility to make sure that
> +                       Release() is called after calling this method. The held
> +                       key will also be released when any other method in this
> +                       interface is called.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.NotSupported
> +                                        org.bluez.Error.Failed
> +
> +               void Release()
> +
> +                       Release the previously held key invoked using Hold().
> +
> +                       Possible Errors: org.bluez.Error.NotSupported
> +                                        org.bluez.Error.Failed
> +
>  Properties     string Equalizer [readwrite]
>
>                         Possible values: "off" or "on"
> --
> 2.28.0.402.g5ffc5be6b7-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
