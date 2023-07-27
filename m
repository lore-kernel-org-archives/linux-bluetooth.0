Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A9C001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 17:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjG0RcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjG0RcJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 13:32:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1642D76
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 10:32:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so3944901fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690479126; x=1691083926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3ATJWt8vV8tm0SBHmbtqJd3LPMyRhEBIbA2a/rURVY=;
        b=kh7yn67nBng3Hn15lwHDDj3fP+4fARDPizqhwgm5Yti7Arz3d8vepO5nswrwG8Bb7c
         9h/pWtJgtgXKwkkH8mwERtKkzG7Jz/EnvttgGa3bVsbDR0lSSsLCX8Xmex0Kk9yZvcRC
         ae1umJSY8BKse828iJ8iiUtVcwDe0my+aJ4eCLji5Id3yqpLEhShL5zLNBH3WOe77chl
         Cfb9F77Ze181fl8KKQWD3Zg3GQBOhbGc6Aifnu43Ak26C69/Dd0k1VFCdRf8oDtaHIW7
         hQBcX+SEO73CUJXZ3Ue60Q1wGHf1Wp8DOTg0Kzfu0pZepIiyWgFTKSM6gKVBun3Zhbka
         7gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479126; x=1691083926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3ATJWt8vV8tm0SBHmbtqJd3LPMyRhEBIbA2a/rURVY=;
        b=bpiL48wS7o6xIAj/OlrAcWlqcdIpDKQiE8QPcPioU8w+cvlXEnqs7digitdNpyuB7y
         bvsFyf301c5BQng4hrG/REpFx5k3AFcLyUOrGB8D+Uo2kkarTE0gQSEIbHAxCprylxO7
         FZpWuRBZPjHDCj+w7dt7rA9Wb0xaHPtWxYus6WGFhdI/MqCoRI0WBqWtXUbVdvyswIaG
         tBYeuyssEmArhVfsq4pL5S8zm0b3rSQ4rSeWe4RlKmSinApP71LQD1WvNKM1/vFKcvBD
         F2d/kqwhsI5ZgvsPhTCZ4G+gbl/cj8/r9jtywl+IDM1Y7oc1b++3RoqJfQiroDQdynZF
         6BJw==
X-Gm-Message-State: ABy/qLau9GNQM5p0HfjDMNzZTBI3hO8x0qbc9rerwb8sWk8f/+nFWy2/
        eXnpSLdnKqVOPvtmTI9oIfFh7PTU3QtfSHBrSmkrmWsc
X-Google-Smtp-Source: APBJJlFjHSG3kD8ncET3XLWhoImZL6CWkxlL8SUyCMI+yZIbhallZyW4Fsb1FpI6RvQtnbzD0YWcBYYCzxG6AGC+Sl8=
X-Received: by 2002:a2e:b60a:0:b0:2b6:d137:b61c with SMTP id
 r10-20020a2eb60a000000b002b6d137b61cmr2248967ljn.39.1690479125908; Thu, 27
 Jul 2023 10:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvW=MyYArpr-bpiHkHjrqmkGsiSpMqyAivbMCLepV1HajyAzA@mail.gmail.com>
 <CABBYNZ+Keecvkfzf4+m+e3M5ohc6rGHrFs_wYEYzSV9fSt-aZA@mail.gmail.com> <CAAvW=MzR_h2sYxz-wRWeBoP1QoQGaP11sm+TrGxq5Drat7-uXg@mail.gmail.com>
In-Reply-To: <CAAvW=MzR_h2sYxz-wRWeBoP1QoQGaP11sm+TrGxq5Drat7-uXg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 10:31:53 -0700
Message-ID: <CABBYNZ+Rs8XLy9=BSJfTUPeJe69Fw0bVCpb1KQmNw305ATH-0w@mail.gmail.com>
Subject: Re: Bluetooth for hearing aids support (ASHA)
To:     Stefnotch <brandmairstefan@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefnotch,

On Wed, Jul 26, 2023 at 6:13=E2=80=AFAM Stefnotch <brandmairstefan@gmail.co=
m> wrote:
>
> Hello Luiz,
>
> On Tue, Jul 25, 2023 at 8:07=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Stefnotch,
> >
> > On Tue, Jul 25, 2023 at 6:49=E2=80=AFAM Stefnotch <brandmairstefan@gmai=
l.com> wrote:
> > >
> > > Hello
> > >
> > > I have hearing aids, which can be connected to devices that support
> > > the Bluetooth ASHA protocol.
> > > https://source.android.com/docs/core/connect/bluetooth/asha
> > > That protocol is open and somewhat well documented. However, it is
> > > only supported on Android devices at the moment. BlueZ on Linux does
> > > not appear to support it.
> > >
> > > The idea is with Bluetooth ASHA, one can stream audio from a computer
> > > directly to a pair of hearing aids. Without Bluetooth ASHA, I'm
> > > limited to using a battery powered, clumsy accessory from Cochlear.
> > >
> > >  I was wondering if it would be worthwhile to support that in BlueZ.
> > >
> > > For the record, this has been requested in the past, but hasn't
> > > progressed any further.
> > > https://www.reddit.com/r/linuxquestions/comments/l54zku/accessibility=
_for_the_deaf/
> > > https://github.com/bluez/bluez/issues/481
> >
> > Don't think there is any objection to having support for ASHA, the
> > problem is that most of the companies contributing to BlueZ are
> > focusing on LE Audio which supersedes ASHA, so the challenge is to
> > find someone to support this feature.
> >
> > --
> > Luiz Augusto von Dentz
>
> Glad to hear that I found the right place to ask about this. Do you
> think it would be worthwhile to try to find someone to support this
> feature, or is the Bluetooth team usually very short staffed?

There are not so many people dedicated to upstream full time, besides
normally for big features like this we normally rely on companies
interested in the feature to support the work upstream.

> From a user-perspective, I think that a number of existing hearing
> aids support ASHA, and might never receive a firmware update for any
> newer Bluetooth Audio Standards. For example, the Cochlear Nucleus 7
> supports ASHA, however it has been superseded by the Cochlear Nucleus
> 8. I really don't know if companies have much incentive to update old
> devices that many people rely on.
> Considering the price tag on some of those hearing aids, I fear that
> this ASHA support request might still be relevant in 10 years.

Well you could consider asking the manufacturer, or google, to support
Linux in general, but I'm afraid they might push back saying they
support just the major OSes.

> If it is indeed worthwhile to try and find someone to support this
> feature, is there anything I could do to support this?
>
> --
> Stefnotch



--=20
Luiz Augusto von Dentz
