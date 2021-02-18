Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 01:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FF564E2E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 01:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBRB3G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBRB3F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 20:29:05 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931DC061794
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 17:28:14 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id e4so490465ote.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 17:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIHIKQkC8DB2zJQvYoets5QnIvc1FDX490MjOJHjfN0=;
        b=cARyuHQCDN+9glHUctmbFNIssE8tHWQaxPzvYj9ZQbAJ4qHNIdDNpVr2ySK2l/kS4d
         mlne+tRtBw6OXE39HBIOPwEQd6MfeUTj69HwRUQ/iQNEiCprHp+kw1v4pKMI8yN7Em61
         K8hFLxWOgbjGtlBNecywGVSBucaCB1tkOnLFbfHbzkvlmKFdc21riYpr1NBSXFs2OX3t
         BGxfuKgW+t9XVDOFy/+JVUxlNw2lNlaeksamXX9kJPPLMrf7OiXyWE/f2mqf1+GJsQdY
         HkophZK2evvm7QjySnzSOx6QZeB2Uab756VCREHg/nL4qNcS3UUL0sS9t8W8ja/eGVCR
         REbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIHIKQkC8DB2zJQvYoets5QnIvc1FDX490MjOJHjfN0=;
        b=GRCy0M6QdAw89DOS9HhnY1ZKW2M1pkofWtf3lSwbQJoiJbt2Su2OuAgYGZmX/rfU6p
         BoydsXc3LvBAIIYKHnsAkN5jZ6LGwCuBYiUMiQiNSMTlg/zcFO1+lS8gjwp8QvJm5ck6
         BLirF3M53NEtTlB0acp73k9D3hsnYcdp2TDI4onhoLSyk1HtqRw4S0gQKn7I/cRNmPe+
         Tu4NKUF66JTyVifGv+UGvsey/WJkUaMnPEyxBcpqkldTj8DlF9IxBv/IGyiRg3YOIqZP
         h1YQQWaBaKMdu7gQ87lIkeOfnuK7z1x0g7Q1heroCh+veujg0NI481Qg8Gv+ESQkD1+m
         ZvCw==
X-Gm-Message-State: AOAM532eI2Z28oomjT39m8utdjnCQeblF6K+8hWFemTTQP0LnpVs72UN
        TzAECTmyULEg9WURuZuLQX9S9lNgk9M7WS+Oj4rwq57PplA=
X-Google-Smtp-Source: ABdhPJwsLlaOXI/Ytrsk0F2GEsQ1cQP+ySI7FQMJgX0UnPGkSqiBnhO7mT4U2WNUNfmp3dN5BGmaQR1Lq82oshZMEp8=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr1291515ota.44.1613611694054;
 Wed, 17 Feb 2021 17:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20210216233337.859955-1-luiz.dentz@gmail.com> <602c5bd2.1c69fb81.cf0ee.0856@mx.google.com>
 <CABBYNZKnft35iJNnKRQp1N=X319m1VY7Ne2SJ9pGKWOGbbpXvg@mail.gmail.com>
 <CABmPvSHz8bG9X0zUt3DNo2m+6Pn+wHo182EnYsh8mAm+LvHeAw@mail.gmail.com> <CABBYNZKBW+Faraq_Ljj7_WT9HdEZgL19g2-r59T66wxmPt8kEA@mail.gmail.com>
In-Reply-To: <CABBYNZKBW+Faraq_Ljj7_WT9HdEZgL19g2-r59T66wxmPt8kEA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Feb 2021 17:28:03 -0800
Message-ID: <CABBYNZKMd4_rX5LWTBZPGp6a=zWz+QtQTPkfRu5ZejR_cRn7jw@mail.gmail.com>
Subject: Re: [BlueZ,1/3] avdtp: Fix setting disconnect timer when there is no
 local endpoints
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Feb 17, 2021 at 1:24 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Wed, Feb 17, 2021 at 12:37 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > I was testing before seeing your email. Please take a look at my
> > comment on the last commit of the series.
> > Although this commit doesn't affect the symptom we observed (it was
> > IDLE state which triggers the disconnection of IO), the change makes
> > sense.
>
> Yep, this doesn't actually make any difference on the matter of
> freeing avdtp session when the adapter is removed but as you said it
> makes sense on it own given that local endpoints can be unregistered.
>
> > On Wed, Feb 17, 2021 at 11:45 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Miao,
> > >
> > > On Tue, Feb 16, 2021 at 3:57 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434305
> > > >
> > > > ---Test result---
> > > >
> > > > ##############################
> > > > Test: CheckPatch - PASS
> > > >
> > > > ##############################
> > > > Test: CheckGitLint - PASS
> > > >
> > > > ##############################
> > > > Test: CheckBuild - PASS
> > > >
> > > > ##############################
> > > > Test: MakeCheck - PASS
> > > >
> > > >
> > > >
> > > > ---
> > > > Regards,
> > > > Linux Bluetooth
> > >
> > > Can you give this set a try with the use case you had? I tested with
> > > unplugged use case and it now seems to trigger session_cb immediately
> > > so it should work for your case as well.
> > >
> > > --
> > > Luiz Augusto von Dentz
> > Thanks,
> > Miao
>
>
>
> --
> Luiz Augusto von Dentz

Pushed.



-- 
Luiz Augusto von Dentz
