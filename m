Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE98C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17BE2075F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 21:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blYgDCu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgESVGZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVGY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 17:06:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7CC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 14:06:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x23so1068411oic.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYZs9vVfK/9C/8F6pJZgonzP0ZrfEanepES6iLnxknE=;
        b=blYgDCu0MdfUXUIigWpGh3hbZX/VyTTz8FUOwQ3RgXuvV1FsGXjHreypzufxqUcCII
         4lodG12aIRGWj6yVA6ENswI/YSgS8/QIk1KRu02r/Dedr0dgP6LlyqPICDs7XVpjKcK0
         08/sOWBaKdazBnXgqXOUW+r0TXywKJkNcbLWe7k5ESLy3p5Yea5XCA4gsW3SZ7XoTUfX
         XN5tqtc2YiHzdKy9klUu25aeCePpBJeNu/KKmIhq+NezUMPnKAh4yc4SGcGMyQMU12uM
         f1AvkzAdm1XxPgb4RFbKjd0isxxYW2EBx7obetb/1HtKPz7DFccoPc2Om0B4GFde8a1V
         ubFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYZs9vVfK/9C/8F6pJZgonzP0ZrfEanepES6iLnxknE=;
        b=Q45yC/9uPkHUiPasu5+XHGWiomK7UF4kS2K0S8rlfok+7PDq2WV7WGsj9NiXtaW98w
         MXS32e0k5Dc1+oXm9XRJiw+Tl9WqleZNrtGHKefbbt2T4iBC+phXW9H4h1DItMipI5T3
         HMBupjVW9QJrDkeAE4NOmMrmbTMcFMB/oYfwCdmMTrMF6pxMYXYlB9Vll5UulrHHJDx+
         a64yo3Q34b/nIV+dHkkxEom0ET0zBI+bfxSaxNP/Pb1AjQEtFy3oywbT385RfR/vxrzY
         raC3TtSHYDV7mNxMb6zTNSyAs+9R4OYHvd46EWDxyKq3pHmvv4n1oIgACR18iu8kPKBJ
         OUHg==
X-Gm-Message-State: AOAM532h7TnJ4NSnCkv/NkckP3kFjPbYMotYU9DR19YOtVV26qqIvkUE
        tOb/gIukDbtaJdEFoTYlipCbocGn+qqRaKi4LPsL4g==
X-Google-Smtp-Source: ABdhPJwAkypY15FoNpYTt2Gqh3UIjEMFM8oO7KvVy3uqBImP3Aj7nmcSz0q7NuD+NFtXt51YMLVwwF5/+6c7DeOTnAg=
X-Received: by 2002:aca:1b1a:: with SMTP id b26mr989715oib.82.1589922383667;
 Tue, 19 May 2020 14:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200519200345.217345-1-luiz.dentz@gmail.com> <5ec4441d.1c69fb81.6be43.3c0a@mx.google.com>
In-Reply-To: <5ec4441d.1c69fb81.6be43.3c0a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 May 2020 14:06:11 -0700
Message-ID: <CABBYNZ+j1a+dvaNj6+W4DDwed-1N5cXGXw7v9bGPVv1z8c+81g@mail.gmail.com>
Subject: Re: [v3,1/4] a2dp: Fix caching endpoints for unknown version
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, May 19, 2020 at 1:39 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
> Test Result:
> makecheck Failed
>
> Outputs:
> ./test-driver: line 107: 14841 Aborted                 (core dumped) "$@" > $log_file 2>&1
> make[3]: *** [Makefile:9726: test-suite.log] Error 1
> make[2]: *** [Makefile:9834: check-TESTS] Error 2
> make[1]: *** [Makefile:10228: check-am] Error 2
> make: *** [Makefile:10230: check] Error 2

Can you give a look why CI is core dumping here, also perhaps we
should inspect the test-suite.log when this happens.

-- 
Luiz Augusto von Dentz
