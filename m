Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B787C388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D5222384
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM5fPISi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbgKCVnO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgKCVnM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 16:43:12 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5122C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 13:43:12 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z16so12235689otq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 13:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWf2NZ99kOkbxYABqeVpLhtjgrRu45jhowcsEYogcsE=;
        b=WM5fPISiWUBn6cZeo9odQpFHEvi0x3TEJ6/L/R286zZrj8ewHzGwOKtRPQtsz5SRsL
         0qWnHj9kVe7ZnN+oKOl+A21d7RcJKawAts5J4s5B3cqa8nn+rxVqOzvFeRIc0GVvfj7T
         XCLQR//OBai4kNxKAu+zKvFoAFFvM+yNeO7O87Rm3xX54iStnL7tHEtXUHfcBWbi9FMv
         fFPpsTpI3HLLusylmRgNc7Xwe/CixrkoubS3YWuvUd/V1Uw1TADwYW7u/QUt6O3MoAnl
         u3iNX2a2E3lo/+3WuTtW7xux5je2CO382XuO4xhgXpGxAvXcEiLfF8mLVRKkeUqLxvUV
         7EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWf2NZ99kOkbxYABqeVpLhtjgrRu45jhowcsEYogcsE=;
        b=gOcHbbdLsxwjeiFuZwF+3Ga6WNr0y9Om9+HJsDCtdOXsxHr8BVo8fL7m1Md0f1k1js
         01zqSWv5v13GAzSEbZyw4ulAc0YFXQ6ouEzmWwJ/uQIETpwiyS3J6QDpjzmyJ8f1i96o
         fR9E7d418oKPKEHcvdUOoNoCPLiqV4+8Fuy/Nj8Jd1iF1Y52fz8y+cF82L7rtRTCLhg1
         TOHuvqahnsk13Ka4ON/fqub1KF0+JQRClEaCXtJnVXT97+BwlmZpKv9JDCNPZceFHOCT
         Yzz3T51+BtLyBDV4Av5wYnVK1Pshv6G2oAYY9jw+WOXpYC/+cEU2/unA4pH/otSC7qoY
         EW4Q==
X-Gm-Message-State: AOAM531XVqXtDPHkCr5N8IPBlUb7bv73NMVLgVuePubowSLyC+QpXZKv
        o4dE7s9nXW5Spn8VSOEiOZJeSfXD2O33VXkqZUQ=
X-Google-Smtp-Source: ABdhPJyeYC/ZTx6Cx5lHSwE2tAKd++IBVZRF9GTMsZU+cYIcVdDfAO1ZEHr4vUNY6aw3WrQjp4y+KtxLmlM5o097d5E=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr17218621otn.44.1604439792115;
 Tue, 03 Nov 2020 13:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20201102132733.GA77385@jimmy-ryzen-home>
In-Reply-To: <20201102132733.GA77385@jimmy-ryzen-home>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 3 Nov 2020 13:43:01 -0800
Message-ID: <CABBYNZJV_59_VqF_W5dOo9hQDAjv2T14wQQObwxd7AQ7o=G6qA@mail.gmail.com>
Subject: Re: [PATCH] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
To:     Jimmy Wahlberg <jimmywa@spotify.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jimmy,

On Mon, Nov 2, 2020 at 5:33 AM Jimmy Wahlberg <jimmywa@spotify.com> wrote:
>
> This test case is meant to verify that multiple
> unknown options is included in the response.
>
> Unknown options shall be in the response if
> they are not hints according to Bluetooth Core
> Spec v5.2. See chapter 4.5 L2CAP_CONFIGURATION_RSP

Can you add the HCI trace (btmon) with and without the patch. Also
perhaps we should have a comment why this is needed on the code:

  'On an unknown option failure (Result=0x0003), the option(s) that contain an
  option type field that is not understood by the recipient of the
  L2CAP_CONFIGURATION_REQ packet shall be included in the
  L2CAP_CONFIGURATION_RSP packet unless they are hints.'

> Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>
> ---
>  net/bluetooth/l2cap_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1ab27b90ddcb..16956f323688 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3627,7 +3627,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>                         if (hint)
>                                 break;
>                         result = L2CAP_CONF_UNKNOWN;
> -                       *((u8 *) ptr++) = type;
> +                       l2cap_add_conf_opt(&ptr, (u8)type, sizeof(u8), type, endptr - ptr);
>                         break;
>                 }
>         }
> --
> 2.25.1
>
> Hi,
>
> While running tests I encountered this one test that I could not pass. After some troubleshooting I landed in this patch. Please let me know what you think.
>
> Best regards
> Jimmy



-- 
Luiz Augusto von Dentz
