Return-Path: <SRS0=W+hJ=YV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2868CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBC520873
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Oct 2019 06:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCMgTKes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfJ1GGN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:06:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45059 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfJ1GGM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Oct 2019 02:06:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id q70so7435735qke.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Oct 2019 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+Fhg+v7Co8FLBaMi34ODbkbcqHsITz8R4IHJPT4mF8=;
        b=hCMgTKeswwsrM5fBT0gSBzBt2w4Ypqzo7AbQWOpLTAQJpdouE4jCe5NLjogbBhbWIk
         dOIRk35SlWhULjwpR+KgHGZTP1OIsHBsIC4rweLr+bux86Nc7pDniE6HBZSiMeC8YihY
         2340rrMeiuvWbuo1hGADV8r0byEZBNzwF1uexq0039mrSlrzhlVmwh1exsjYBso2P7o9
         3iwKAHcUQ0OVU1lTvIsGm7wRgLB7lqD/N9AZ96BRbMCYhaYTUISdDQeqRvHatqJ8PBsN
         Vz0T+0PxQBERi1JUx0Yi1S+3VQQwXcAQkjM4IovEtBeEXHjD/GOgFYODeUudyPZeiU5Z
         KhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+Fhg+v7Co8FLBaMi34ODbkbcqHsITz8R4IHJPT4mF8=;
        b=J5SuaaQ53A3MdazO9GUfi3fgzcgAgHQBFpwNTfTSZc0KM++Z6Lw+gzHZl1SjOY6lov
         +NyrDSPcq07H4AfLfUwlC27h8NUuU0VwI/2p7cWGBOOE/N/d2+Ce806BMhZ1CCnA8WCf
         mVRerYHHNiq6pfGT0fj7qWMCaUl4+9BUgARptqRS1MfEKQ/2DjCh98bJfFt9IeNZ29WN
         gompqJXjFFJURhZew7PkrmwB5E8SC+iIwRF/tYAAPVK6AlVf/RlD9JqgHwVrY3bzMAzX
         mOnx1MbWfLbWjr/2GAIyTGr+yp2aGYsPrabagegPgp/eKND7Y/d/kfIxRbpXkq4BWVop
         xUiA==
X-Gm-Message-State: APjAAAWJy4iEzx7etutwKZxBPNVKr3Rz4LW9YcikJw37YQ+icabp5/vV
        jPNUraMk0sm+JcxgsmfVL3yuMMIqQpw0vlBBYUzFTQ==
X-Google-Smtp-Source: APXvYqxPqPqjUlFOU4A57l9D3lwa3YZKonKhYHJES1uj4ZJFyMF7SJkQGLWZpEi6jQ3gt/oqdDZBnsnvo80FGulvtsk=
X-Received: by 2002:a05:620a:2191:: with SMTP id g17mr14537095qka.247.1572242771858;
 Sun, 27 Oct 2019 23:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
 <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org> <CAJzH+bqLK1aohAE3f5-4Xfhz1Gq05URFgZf9yFPAeBF2ekfmQw@mail.gmail.com>
 <368BD38D-6FFB-412D-A6A9-364B3B5374F0@holtmann.org>
In-Reply-To: <368BD38D-6FFB-412D-A6A9-364B3B5374F0@holtmann.org>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Mon, 28 Oct 2019 11:35:59 +0530
Message-ID: <CAJzH+brQ6vu-o6a7iAmpBT+cbrdGHP3XNfUk61UPyS2D6bwGDQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Always set scannable for Adv instance 0
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Oct 26, 2019 at 11:02 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jaganath,
>
> >>> By default for instance 0, local name will be added for scan rsp
> >>> data, but currently the property is set as non scannable and hence
> >>> Set Adv parameter fails with Invalid parameter.
> >>
> >> can you be a bit more specific why this is the correct behavior. We must have documented in mgmt-api.txt somewhere, right? Or is this something that used to be correct, but we broke it with adding extended advertising?
> >
> > It seems to be functionally broken in legacy adv as well as we set scan rsp
> > for instance 0 always but Adv Properties is set to non connectable (if
> > connectable
> > is not set). Even we need to fix mgmt-api.txt as well as you pointed out.
> >
> > But in legacy case commands do not fail as  scan rsp can be set even before
> > Set Adv Param where as in extended case Adv param for an Adv set has to be set
> > first before sending Scan rsp and other commands for that particular Adv set.
>
> how does this intersect with the patches that Luiz was sending earlier?
>
I think Luiz patches covers both the issues.

Thanks,
Jaganath
