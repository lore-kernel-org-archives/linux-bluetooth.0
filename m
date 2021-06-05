Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D12C4743D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A8360E0B
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFEAdl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:33:41 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:36816 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFEAdk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 20:33:40 -0400
Received: by mail-yb1-f180.google.com with SMTP id s107so16106197ybi.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSMV+sMomjroZF0377wvSmU+pcLLvt39YLDOpyFW3Ac=;
        b=TXH0cX+y0stI012pk6ScmrMzc57a0ZMv4pcSzmm/E8bKQ3HShiOW5qQ7q4X2DZdwyo
         nsJg+UURMlD9VAmtYYjdnX+7pKFVqamAiuitZpCN0AW/kNooWkxd4WjP5vNxPXltGkth
         av0347xYZQpGvleeRkxxFsTzV2x1Maa/9+G1hyBVMD283xgtvUQ1b5I5uU1GKHBIis5P
         eIMjsKmu02i4oFfvRHoGNDJYBZordS/GNJMT7VIunVtwXfYAaYZgqB+4aYGKxm+HX5EV
         uRWWhOWYVmFQJbYTF1cHyCcw6iEz9JyI6cGJ3DwSaTlXWN5PX5KMampDQU9Vpwxt/f+4
         C2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSMV+sMomjroZF0377wvSmU+pcLLvt39YLDOpyFW3Ac=;
        b=dxp+BXHGv3oFIBWd97U7AQaj9wzOOaTbUgnDyStu7Bi7AdKW97H2Jf9wzWa6Ez58qi
         R4PAG7bSe+kpKuvn9+bO9gitjw33Yn5426UH+7ucFisyLylMKb5F8+IjvwcdP3D2WIJe
         gNBMOwVKoARbmsOsQX5H20Yqt5aTnwUOzMFWEJs8stEjoVKr5vuPwFGZdTE46hbYIS1e
         ZHyrx5nJ9U3M4GTIvQIca+PIZMyw9iAexlMIUDoJ6bskGdhaH8suc7L0NZKEjhvQEqpq
         ePfmsYvWJuroHvaKx8NBeXnfssW6zcPIQr+SVc/0OxyEUC73VZZ2N0/KA3zL11/lOHpB
         lRKQ==
X-Gm-Message-State: AOAM5336VEQekvYtEkhkRiZG+iHggOc58vajdeIPWd/5m9WvuYgKhgJ1
        o9ziXXZ8jsEG+ygYfla46zTkHgxDO0H60pdTU4c=
X-Google-Smtp-Source: ABdhPJxYPCwslcWrroa8X6y8EKjFR1xHGUg1MI3KMCypu5xIjOVZlzjsa/OpxMKDINS75TO6FpVIWWJrJhQbftr142g=
X-Received: by 2002:a25:4048:: with SMTP id n69mr9032893yba.91.1622853040390;
 Fri, 04 Jun 2021 17:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210604175913.256979-1-inga.stotland@intel.com> <5d31aebb39bc10584a71df894908e16104980985.camel@intel.com>
In-Reply-To: <5d31aebb39bc10584a71df894908e16104980985.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Jun 2021 17:30:29 -0700
Message-ID: <CABBYNZKYfzpqXUJB02-zSfsPjrD81MwcDuUYRjEeYqU_WD--_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] tools/mgmt-tester: Fix expected HCI command accounting
To:     "An, Tedd" <tedd.an@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Fri, Jun 4, 2021 at 12:30 PM An, Tedd <tedd.an@intel.com> wrote:
>
> Hi Inga,
>
> On Fri, 2021-06-04 at 10:59 -0700, Inga Stotland wrote:
> > This fixes test condition count in the expected HCI command
> > callback.
> >
> > When the expected HCI opcode is detected, mark the condition
> > as done. Any subsequent HCI commands are ignored.
> >
> > Without this fix, in couple of test cases where the expected HCI
> > command is detected more than once, the test may be erroneously
> > reported as a failure or prematurely declared as a success before
> > waiting on an expected MGMT event condition.
> >
> > The test cases where this behavior is fixed:
> > Remove Ext Advertising - Success 1
> > Remove Ext Advertising - Success 2
>
> Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> > ---
> >  tools/mgmt-tester.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> > index c5073fe2b..6109883ad 100644
> > --- a/tools/mgmt-tester.c
> > +++ b/tools/mgmt-tester.c
> > @@ -52,6 +52,7 @@ struct test_data {
> >       uint16_t mgmt_index;
> >       struct hciemu *hciemu;
> >       enum hciemu_type hciemu_type;
> > +     bool expect_hci_command_done;
> >       int unmet_conditions;
> >       int unmet_setup_conditions;
> >       int sk;
> > @@ -7021,9 +7022,11 @@ static void command_hci_callback(uint16_t opcode, const void *param,
> >
> >       tester_print("HCI Command 0x%04x length %u", opcode, length);
> >
> > -     if (opcode != test->expect_hci_command || data->unmet_conditions <= 0)
> > +     if (opcode != test->expect_hci_command || data->expect_hci_command_done)
> >               return;
> >
> > +     data->expect_hci_command_done = true;
> > +
> >       if (test->expect_hci_func)
> >               expect_hci_param = test->expect_hci_func(&expect_hci_len);
> >
>
> Regards,
> Tedd

Applied, thanks.

-- 
Luiz Augusto von Dentz
