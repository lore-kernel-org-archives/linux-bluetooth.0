Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454D8C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B82613B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCUUx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCUUw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 16:20:52 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4BBC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jun 2021 13:19:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i4so10603876ybe.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jun 2021 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeToTYTazLvHmRb6ZL1ityfovSTI5TzbiAWt+Ij9l2g=;
        b=ckCX7a9kGjGCaGDS4JvekwLI+UmUpqMfPJG7TVmYXBqXcvWZqA7ihrKK/yfhiwS7xc
         ybqx1oV2Tj156BG7G8SAuQQWpfutd1sDOFYLpPyWLjViJ4tyeobaPYgZY/iVzR8CxtBe
         r5UZ5wzRV9ix6acZGBUnq3jR+NWA5k/9GxGlg7Fvi0BI9hUWtS8rH3mY/9wQRF59mC2i
         t3azDtYIM4KB+n6UjpFOLUVtoWqAUdVCDUCM0s/ePb2DciLMpfxBkQZR5KS9oX8mAX3i
         3QmXGgUek7hU3+YJ/6LtpvptcHU4h8wUanI0Rt7VLRh+lsbzTptE3hjPgZyrjsqWqT7y
         CD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeToTYTazLvHmRb6ZL1ityfovSTI5TzbiAWt+Ij9l2g=;
        b=E+Ldf4yZ4S6kvoQhDz6OP2fpWZH1/wu5KinDE+LXh5TTNN20Z12jPsl2+AKnMhzvVV
         /oLywyXoQ/2LVjyRFxBf/BHXjoTHySz0YS6UK591OdaSJh/HbmbdTBrIrvFXrIlTeS2n
         UYcha8A4BUNPiqcHwm1+fC2KJDtKqIA8kGyz6oI0NygLueHZRxjNJwdU13MRsMjf2uPT
         Ne+Y4hGdypAJNswdeidmOeTqeIN9A8TAFV2xIWcNSDe0vOLU+9zM5mNHeiXk9UCJxAX2
         UCqWe3ArmzCmsy7MhXN1cfyX53GUMu0M8KFRkF3UvF6AGJzEUXEi4eL1Jx9vsLK6HyqB
         XBBA==
X-Gm-Message-State: AOAM530JXtZRyq3e/GkgSy910m+WCs+KGAkKVKJEltuu3/BfkVpDlNum
        RVIamUYXICA+NBLf73SXh/9tWi1a9U+74FmzKoc=
X-Google-Smtp-Source: ABdhPJwLcsPe6UQ8SAhq6PU7NxpmRdKfQE1rVMJLUGUZ4hblvRZ9t4kbJ5zKzNuF8NU6Vp35QwzraFlDAjhEl7aPjVM=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr382628ybn.440.1622751544330;
 Thu, 03 Jun 2021 13:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210603000416.171392-1-inga.stotland@intel.com> <358e08e9ef4c4e9a0cf21dcf02dda74755384b76.camel@linux.intel.com>
In-Reply-To: <358e08e9ef4c4e9a0cf21dcf02dda74755384b76.camel@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Jun 2021 13:18:53 -0700
Message-ID: <CABBYNZKhPBLyzCuxjsw4FZ2FmFakxC_t5FonuczC_6BYinCe7Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] tools/mgmt-tester: Adjust test setup complete check
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     Inga Stotland <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Thu, Jun 3, 2021 at 12:38 PM Tedd Ho-Jeong An
<tedd.an@linux.intel.com> wrote:
>
> Hi Inga,
>
> On Wed, 2021-06-02 at 17:04 -0700, Inga Stotland wrote:
> > This changes check for setup complete in client_cmd_complete() callback
> > from tester_setup_complete() to test_setup_condition_complete(). This
> > allows for combining setup conditions when setup_bthost() is called.
>
> Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> > ---
> >  tools/mgmt-tester.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> > index 4dd3490c2..657b7aaa0 100644
> > --- a/tools/mgmt-tester.c
> > +++ b/tools/mgmt-tester.c
> > @@ -5831,7 +5831,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
> >       if (status)
> >               tester_setup_failed();
> >       else
> > -             tester_setup_complete();
> > +             test_setup_condition_complete(data);
> >  }
> >
> >  static void setup_bthost(void)
> > @@ -5842,6 +5842,7 @@ static void setup_bthost(void)
> >
> >       bthost = hciemu_client_get_host(data->hciemu);
> >       bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
> > +     test_add_setup_condition(data);
> >
> >       if (data->hciemu_type == HCIEMU_TYPE_LE ||
> >               test->client_enable_adv) {
>
> Regards,
> Tedd
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
