Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13FDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC07620DD4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xck8+ufY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgFSNuo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732879AbgFSNuo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 09:50:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984CCC06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 06:50:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so11564295ljh.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3yzZHNveLLaMTC7TQkPBlj9DDnRWHO4rYcE3FVmW81w=;
        b=Xck8+ufYn7gXA+pU02Ox5iOUzYkldKutTnbZRUA58Y6ghuJDZy8XUMXkVeIyoozzVy
         7NI7BT68YGl5McZs9BkeOqdEz7DZ5Onp7tvFelZvzf6B2Mb5tq2NccWjBCfCymn38C8h
         UaciIki3QtNstHRYtBRUowvGUh98mK4+Tp3HBAIgHFiI2fQ/h2rOw4mmFTOcCDUNSKJo
         2mxg5mVSr1tmeUdWeuxX1P7h5+W2AO118roK/ZqECTJ2exeWkzTp+8asqrPKh243JVM6
         FD31SVsNi2YW2tCXrL/f7uhWcwt3b1vVGD1RXL7JxnYNk4Kcf4xk2FEaPTn69QskDXE6
         RRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3yzZHNveLLaMTC7TQkPBlj9DDnRWHO4rYcE3FVmW81w=;
        b=UobPojBltD31SSIC/hhLN4DtCJfgD1H33AS9kvm1Bwt0vZdwbTZN4C185QcEDa39av
         HZcPKkAnFt1sbIQTI8R+ZYRvSjZw1a/HXshdXRvodMfsYqAjPr8OEYFymLrnG0IYlxlK
         BJKdkBvPjAuZmvn7meahlSxqp4G6IOwej8UHD6ZD7NrPbbKqAd+OoWII8hFiSujc8Sf8
         S9LjZQxPvb34xWy/AW90uJlwngWn5p4v96QCjJ0ut8TI4Z7Hc9xT1OK20Gnvd6jDfnsa
         maPystFsAIKBzDuJ5sLUu08ycl7WY6AkMjGWlIuo9LlmGKr+ylZNr4cYNkBJSjPZLSZf
         m1gA==
X-Gm-Message-State: AOAM530LP7BJ4+DRQ1M44adM8M+EMnUyzsfLOdDXDufSX09G6uUik2f4
        XvpQcUQYdYZ0exv+TTIAyvEvAe3eKWzNQ+0MlsJtVtg0
X-Google-Smtp-Source: ABdhPJx3/nVbEC5VAbcltt0fcAix68O+J98eSni4Fb1d1RKOs4IsFTaL4qhORfop0y58tR2DuRE/yS7pAIQSprN8Jmc=
X-Received: by 2002:a2e:890d:: with SMTP id d13mr1959225lji.75.1592574641747;
 Fri, 19 Jun 2020 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210659.142284-1-alainm@chromium.org> <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
In-Reply-To: <C5D30F5E-B50F-4DE7-A909-F48F6C555661@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 19 Jun 2020 09:50:30 -0400
Message-ID: <CALWDO_XLRELJhe1n9AVq2w9fQYkgGLC+bdXQ-1-M4f-cUfEwGQ@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth: use configured params for ext adv
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jun 19, 2020 at 3:46 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alain,
>
> please use =E2=80=9CBluetooth: =E2=80=9C prefix for the subject.

ack.
>
>
> > When the extended advertisement feature is enabled, a hardcoded min and
> > max interval of 0x8000 is used.  This patches fixes this issue by using
> > the configured min/max value.
> >
> > This was validated by setting min/max in main.conf and making sure the
> > right setting is applied:
> >
> > < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) ple=
n
> > 25                                          #93 [hci0] 10.953011
> > =E2=80=A6
> > Min advertising interval: 181.250 msec (0x0122)
> > Max advertising interval: 181.250 msec (0x0122)
> > =E2=80=A6
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
>
> The Reviewed-by lines go after your Signed-off-by.

ack.
>
>
> > ---
> >
> > net/bluetooth/hci_request.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 29decd7e8051..08818b9bf89f 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1799,8 +1799,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_r=
equest *req, u8 instance)
> >       int err;
> >       struct adv_info *adv_instance;
> >       bool secondary_adv;
> > -     /* In ext adv set param interval is 3 octets */
> > -     const u8 adv_interval[3] =3D { 0x00, 0x08, 0x00 };
> > +     /* In ext adv set param interval is 3 octets in le format */
> > +     const __le32 min_adv_interval =3D cpu_to_le32(hdev->le_adv_min_in=
terval);
> > +     const __le32 max_adv_interval =3D cpu_to_le32(hdev->le_adv_max_in=
terval);
>
> Scrap the const here.

I'd like to understand why it isn't prefered to use const when you
don't intend to modify it in the code.
>
>
> And it is wrong since your hdev->le_adv_{min,max}_interval is actually __=
u16. So that first needs to be extended to a __u16 value.

The macro actually leads to a function call that has a __u32 as a
parameter so the __u16 gets upcasted to a __u32 already.
>
>
> That said, if we have this in the Load Default System Configuration list,=
 we should extended it to __le32 there as well.

I agree, this means the range of default system configuration may not
be sufficient to accept all possible values that the newer command
supports, although I think this is a separate issue from what this
patch is trying to solve.
>
>
> >       if (instance > 0) {
> >               adv_instance =3D hci_find_adv_instance(hdev, instance);
> > @@ -1833,8 +1834,9 @@ int __hci_req_setup_ext_adv_instance(struct hci_r=
equest *req, u8 instance)
> >
> >       memset(&cp, 0, sizeof(cp));
> >
> > -     memcpy(cp.min_interval, adv_interval, sizeof(cp.min_interval));
> > -     memcpy(cp.max_interval, adv_interval, sizeof(cp.max_interval));
> > +     /* take least significant 3 bytes */
> > +     memcpy(cp.min_interval, &min_adv_interval, sizeof(cp.min_interval=
));
> > +     memcpy(cp.max_interval, &max_adv_interval, sizeof(cp.max_interval=
));
>
> This is dangerous and I think it actually break in case of unaligned acce=
ss platforms.

Since it is in le format already and the 3 bytes from the cmd struct
are raw, I'm not sure how this can be dangerous.  It effectively
yields the exact same results as your suggestions below.
>
>
> In this case I prefer to actually do this manually.
>
>                 /* In ext adv min interval is 3 octets */
>                 cp.min_interval[0] =3D cp.min_interval & 0xff;
>                 cp.min_interval[1] =3D (cp.min_interval & 0xff00) >> 8;
>                 cp.min_interval[2] =3D (cp.min_interval & 0xff0000) >> 12=
;
>
> Regards
>
> Marcel
>
