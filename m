Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CADBC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3F5206D5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iing8MJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404106AbgKXSQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404088AbgKXSQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 13:16:45 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E4C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:16:44 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id v185so1775645vkf.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H7YZt+SIVZ8fNuzxOL22q/NTOOeRlk0eFuJ0xh27rQw=;
        b=iing8MJc1IzsGKQB+rPDQGbxz2pI4Hu0FazXqi9mtRhoLdrp09bkYI+LxCyzkr3qYv
         e6G9Z+teCTXSle2dQXp5Wl5VZBoM30QTLNzPxGB4t4zxgxHEK+6jGnzMUf+2WmnUJOe2
         7idc1JhxoP2nh6KItotQZT0sGkSb82WD6ZTB0DQ/hEDnHLpZ0evsT1XWn3T9m22bdASn
         mKr8awFassQIBdhCueKtZ2EDXIKuOw/FWFfkZafrw6JT+aD74swKnqiqebfolUT5ngs4
         v/X5NyQmgL2YCRSQg/XK+yREvZ6Ig3aXf6lBGQY+HctRgKlFx3L2ALl2rYbNvviHFMzf
         2ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H7YZt+SIVZ8fNuzxOL22q/NTOOeRlk0eFuJ0xh27rQw=;
        b=WpKgGjiDTem8Aq4gE+rkJTMYzDHOG+TicHD0C1TOvGNKrYveTA6NDzN1tJFheROCCs
         iJt09KGdAjUG/YSU1HQfXNqTNQmqFh7vynudF755HOWeq1LM/0cTB7thuwCvezJHa4V4
         lyFYhzfipwepSUlefcn9c6WEHdP+pUbYcGDagYRyDxpG1LNYCLAI7bAi7D/NwXCjN+5+
         bbU2k4YcQLTA+dRf3nf+SSfVbxpSd6n2WR3f907uczjlsdBV4YCGVD4JPqKrjhNnR2ZM
         DJPGHQ/gAjN7kjZSV9fmZ6pjpw5Dtrd67hPYglGfCnvXKymx+0pX4qKTCpWLrg+xfR6f
         eGZA==
X-Gm-Message-State: AOAM531Q3XAjCieY3yvOqlWQ0HkNQlCFuNrJDSy2xVowZFAMLt4uqDBy
        OI6NHSYkwy4IgAr9e19Q9M0MIt8n8gsIApYUyCwrgbrcCFJDJA==
X-Google-Smtp-Source: ABdhPJxcskeYst6Nf8PFKOIYR2tVoiK61sNlALZ76Vh4YwV7knbgmC0uW39jv/214TCQNxlwQs9mg5XWF/K2/NgqJT8=
X-Received: by 2002:a1f:2817:: with SMTP id o23mr5284254vko.2.1606241803885;
 Tue, 24 Nov 2020 10:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
 <20201029160317.Bluez.v6.3.Iabfcf7ec8ac293130a7d903ee8094414256799b3@changeid>
 <263DCED1-D5D0-4ABD-A6C9-5A4ACA45458E@holtmann.org>
In-Reply-To: <263DCED1-D5D0-4ABD-A6C9-5A4ACA45458E@holtmann.org>
From:   Daniel Winkler <danielwinkler@google.com>
Date:   Tue, 24 Nov 2020 10:16:32 -0800
Message-ID: <CAP2xMbstBAHK1Q35VEaeuhdobY6baRyKwcj=u68GDW=WTVmz=w@mail.gmail.com>
Subject: Re: [Bluez PATCH v6 03/10] doc/mgmt-api: Update controller
 capabilities MGMT command in mgmt-api
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Marcel,

As I understand, Luiz accepted this series already. I will upload a
new patch to fix this wording, thanks for catching it!

Best,
Daniel

On Mon, Nov 9, 2020 at 4:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Daniel,
>
> > This patch changes Read Security Info MGMT to be called Read Controller
> > Capabilities Command
> >
> > ---
> >
> > Changes in v6: None
> > Changes in v5: None
> > Changes in v4:
> > - mgmt-api: Move Controller Capabilities MGMT doc into new patch
> > - mgmt-api: Tx Power range put into single capabilities entry
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> > doc/mgmt-api.txt | 21 +++++++++++++++------
> > 1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 7c899a8fe..1aa43d6c3 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3110,19 +3110,19 @@ Set Wideband Speech Command
> >                               Invalid Index
> >
> >
> > -Read Security Information Command
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Read Controller Capabilities Command
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >       Command Code:           0x0048
> >       Controller Index:       <controller id>
> >       Command Parameters:
> > -     Return Parameters:      Security_Data_Length (2 Octets)
> > -                             Security_Data (0-65535 Octets)
> > +     Return Parameters:      Capabilities_Data_Length (2 Octets)
> > +                             Capabilities_Data (0-65535 Octets)
> >
> > -     This command is used to retrieve the supported security features
> > +     This command is used to retrieve the supported capabilities
> >       by the controller or the host stack.
> >
> > -     The Security_Data_Length and Security_Data parameters provide
> > +     The Capabilities_Data_Length and Capabilities_Data parameters pro=
vide
> >       a list of security settings, features and information. It uses
> >       the same format as EIR_Data, but with the namespace defined here.
> >
> > @@ -3131,6 +3131,7 @@ Read Security Information Command
> >               0x01            Flags
> >               0x02            Max Encryption Key Size (BR/EDR)
> >               0x03            Max Encryption Key Size (LE)
> > +             0x04            Supported Tx Power (LE)
>
> make this =E2=80=9CSupported Min/Max TX Power=E2=80=9D. Otherwise looks g=
ood and ready for Luiz to apply.
>
> Regards
>
> Marcel
>
