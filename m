Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DF6C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364CA206E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtX3Rz5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIS3Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:29:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41462 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIS3Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 14:29:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so698695oia.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXEvyJEU4M+7ZN2pxt7VC+CwjuWU8Rr2NjYDwMUQU6A=;
        b=FtX3Rz5/R0K4oBzZlF4P3KsDx/XcH5e8DRuzqWQbORvCsXwhkeIOhSa6BkJGmqVRp9
         oLJwUqqxDJMrV84fsElYaZvI08Sl/rXzOdNe3bosTU7RhTC5zvMrMMlgOjMb8/AXUlly
         SPJpmFQV2WKVh1cv+2yisVOskhQp4Kjzui9MxsSxDuuzJ8sjAOYg+uyZKfkS/B1edPYV
         QYMTRylaZgyyucI9FPq/maG2sWMt1SY4jceSmC+zlOfX41P2ZNWS5zXJynzi4i/SWBos
         0rY+ly3PwhOox0rj4M8EGg2H0JAr7FI08rSn7CkV1vcEYTW+slMB9QmYSrKZaELDbQP+
         3FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXEvyJEU4M+7ZN2pxt7VC+CwjuWU8Rr2NjYDwMUQU6A=;
        b=ssLKgPeKKihjsHyKAw8i3+QzIlQbg1HORQ2If2p+nRgrP52jxwUe6hKf/3lVPueQhk
         RbHacPWa/Eyz5JWtWOV3fzqMlIsPhzziM9xT62SETfXLsR80gSI3ByGedgnmIL1eZwiI
         lQBaBpdQIMeLVLbHioOvGJDGsowKIKxYBFd6CRUL8Uegvqk9SMFnUHc2rXfRsVOJ05X0
         mzrL1xDpvNDbSXyoU2G1FUHJ1wE+5EH5zlPc5qfevDpqqAPcZOqV3p4YpbyqyzEP1jxl
         OKzQblHLXRBMwANJKqGNfiVziZnFO6vx+KG9LpIa+1pv1tz4swmkbKujmT6SYZ+dZLhX
         Ye6w==
X-Gm-Message-State: AGi0PuaDqxAFO15gPsmiH8vQ6r5jIRtpv1cgjLp2zOTgCaUEJuNcNXkR
        3EEd89b8qwvOxoUAZv1GxRXuk+wcQkvyzYWChSnzWeTn
X-Google-Smtp-Source: APiQypLj8NBJeGeLxuwhsi+errZHUiqmY6HwIxl9ag5bU3FiOwRq772/XxNJC1ftDMJyhEb2s1jdS0QRhixvnrJvHj0=
X-Received: by 2002:aca:b602:: with SMTP id g2mr553708oif.82.1586456962053;
 Thu, 09 Apr 2020 11:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200409103035.96589-1-szymon.janc@codecoup.pl>
In-Reply-To: <20200409103035.96589-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Apr 2020 11:29:10 -0700
Message-ID: <CABBYNZKj4kjCBtdads6ntBRs9F9hYiV9o8ACp4Fby3NSmv8M0g@mail.gmail.com>
Subject: Re: [PATCH] test/example-advertisement: Fix advertising when discoverable
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Thu, Apr 9, 2020 at 3:33 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> If adapter is discoverable (or LE-only) advertising was failing due
> to too big adv data being set. Make sure there is enough space left
> for flags if needed.
> ---
>  test/example-advertisement | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/example-advertisement b/test/example-advertisement
> index 88a27ab34..f116893b6 100755
> --- a/test/example-advertisement
> +++ b/test/example-advertisement
> @@ -142,7 +142,7 @@ class TestAdvertisement(Advertisement):
>          Advertisement.__init__(self, bus, index, 'peripheral')
>          self.add_service_uuid('180D')
>          self.add_service_uuid('180F')
> -        self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
> +        self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03])
>          self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
>          self.add_local_name('TestAdvertisement')
>          self.include_tx_power = True
> --
> 2.25.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
