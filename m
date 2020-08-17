Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D0F2072E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLqHppGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHQXf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgHQXf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 19:35:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BEC061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:35:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so13784391edb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlqDKlV9jk1FHSuh4MPTcik7VEPdRAvdq288sP9/ibE=;
        b=QLqHppGVp1eQojtphbbWnTL+NThZ2dTAOnw8dw+kLbnpLGSQhbXbu1S9k0T42YIUYm
         x2hMFwL5FTnuiDuVu9aW/BRG/PDe+YEk1UaQtCQRsbbh01n8kfM5JXsek9UNceDPmEWQ
         w0Wu8RtVjn56eUD5fCxTIDgFd44USnDwsR29iWlJ7/zAzcOibxlzk76xOzDX8SCe2meX
         TZPPk7T7VyUPgmLgMf6WSdr4kcv1uPPuGrdZzSsPegXFqtSxI5GL0Wkjycp9EQKepmyO
         6GsTLELkUpalyjfAV9TRK2VDQAH/eQSQnvRzsIgBWBj5Q3Qwso6bHLVjNLUHoU0MjGzI
         KNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlqDKlV9jk1FHSuh4MPTcik7VEPdRAvdq288sP9/ibE=;
        b=a/c8W+ywDdGwTz+6fTSlqCzWr+99F4Yo/uWwOqQG8fZgyASfrD1NRKCG1ILvE7XU77
         XGtJgWUIFX+LDPJD3apxh++VYN2JBNfI63ULfU/CEeQtY7oXK0qOjy2o11235ICmE4cx
         0VmVF3dS5zrWOSG4BdUJZMlPUYBmRFTXnYnzmmKnO8UY6+KRA9mCv+7bTzOR7IVfObIK
         857ECAGg745L7wH1isTZf7fTq5nVFf2hbRu7Df7XAz7XniblzhcVjt8HzRYazg2wigK1
         PC2msDwO+nSHmr5nnSBXlLBJspS4Np5dJ/sOyzeq6O72wWBQv5WEwEen1u0220zxklJC
         KiXQ==
X-Gm-Message-State: AOAM531l3O8u2cqEX2k/45nwC3jevZvqKlhWNYo6tCLZCrlKCDyO+wi0
        jfs/OK7USFnH6fluC66PCVpWrzKBaZWLyxaJpHhfFg==
X-Google-Smtp-Source: ABdhPJwwzR52dwG2cjBebBxbWrvOkLGkq6YWfROFyioEv8L87Dr2d6AkQSyWh9QA1SY+iQqjDA79hfi/DK7hPEEUH6U=
X-Received: by 2002:a50:af83:: with SMTP id h3mr17386293edd.139.1597707323481;
 Mon, 17 Aug 2020 16:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200817135606.Bluez.v2.1.I21d21871d85db48b07ba847742c7cb933024307c@changeid>
 <CABBYNZLfmuLHvvMUwz_-Lg=q5aFYt6S3UEV-SA--ESmRMX4DVQ@mail.gmail.com>
In-Reply-To: <CABBYNZLfmuLHvvMUwz_-Lg=q5aFYt6S3UEV-SA--ESmRMX4DVQ@mail.gmail.com>
From:   Yu Liu <yudiliu@google.com>
Date:   Mon, 17 Aug 2020 16:34:47 -0700
Message-ID: <CAHC-ybx8QNsTy=_5OfMoVMRersd-YFscQAi+nvL=2rqhgWMeRA@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] adapter- Device needs to be in the temporary
 state after pairing failure
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

that could be a reason and a potential fix, we remove the temp flag in
dev_connect and pair_device very early on, but i suspect changing that
would potentially have bigger impact and needs more due diligence and
testing.

On Mon, Aug 17, 2020 at 4:24 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yu Liu,
>
> On Mon, Aug 17, 2020 at 4:04 PM Yu Liu <yudiliu@google.com> wrote:
> >
> > This caused the device hanging around as a discovered device forever
> > even if it is turned off or not in present.
> >
> > Reviewed-by: sonnysasaka@chromium.org
> >
> > Signed-off-by: Yu Liu <yudiliu@google.com>
> > ---
> >
> > Changes in v2:
> > - Fix title length and format issue
> >
> > Changes in v1:
> > - Initial change
> >
> >  src/device.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index bb8e07e8f..93e71850c 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -6008,6 +6008,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
> >
> >         if (status) {
> >                 device_cancel_authentication(device, TRUE);
> > +
> > +               // Put the device back to the temporary state so that it will be
> > +               // treated as a newly discovered device.
>
> Use C style comments /* */ above.
>
> > +               if (!device_is_paired(device, bdaddr_type))
> > +                       btd_device_set_temporary(device, true);
>
> Hmm, are we perhaps removing the temporary flag too early? Or this is
> a result of calling Connect which clears the temporary flag? Then
> perhaps we should at least if the upper layer has marked the device as
> trusted as it should indicate the device object should be kept even if
> not paired.
>
> >                 device_bonding_failed(device, status);
> >                 return;
> >         }
> > --
> > 2.28.0.220.ged08abb693-goog
> >
>
>
> --
> Luiz Augusto von Dentz
