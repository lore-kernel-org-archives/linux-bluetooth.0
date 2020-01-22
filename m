Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD6AC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCD24676
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaRUjWG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVVsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:48:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46062 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVVsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 16:48:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so728463lfa.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 13:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5Sz7EqZLbE5bYM+ruj7y71TMbLOZjDdOvlsnEAIcmQ=;
        b=BaRUjWG3pZHzDumabTR/IL0OCvIcF95oUItdxzpzvGlsPvagr+LVsxf++ZpQdBiNeO
         EOszYLcb5irv9Whmlw4qib+kBvwk7GHOT9tQZG0l07ba61Whg6/9zBYo3lw+6y4cEXc4
         CEX/XZZ7NpY47CDm8wmGpGcq4HY4UactALoEF/Oo8ZvlXLlnhaDx4xNzE8it8rljSon6
         o03eHqG9mJatCDx5ls+A2T8zW//jBA9Uk8G0RQOU9dl+tl9DCCeuRsqratMqW/bs4pxX
         Z8XJHPRL5kjN5Vd0A/3Ov5itp6NQ6o4TNlOODWUx0dtD6QM507GZK1vp/XMOUB+iDBWx
         +6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5Sz7EqZLbE5bYM+ruj7y71TMbLOZjDdOvlsnEAIcmQ=;
        b=g+cDQoczfin1sydoKnqRL0FFNV/xGZRH1SsvhSaaDRdfggUjx7d8rysRupoQOwu0tz
         ZiuubNsc0zw3M5nmDoxQi+xMHHyv5zdRNB6qqEtlElL2WOupjZQTWXTJUkZqARyNo2y7
         en6k7Z+F8GrpgcmTAlgwqY23en9gCwlxBxMHEnfp/C80Qh4lX9lhfhBxyFzzTV91oclh
         r28fwNpo9NvMTgEILVAx8Wq20SbiRVKB0WLdDCnmJ+Xp8uG9ZMCHoZL8mcfEx5MLeFKT
         0pzvWZB+8VRuv52em2PIJASltzg1ng4aXkF+US+UBOpar98UfTUMuGt3aZFfT1QqSlR7
         hy2w==
X-Gm-Message-State: APjAAAVUcz3FDPhT9ia4euATeNot6bYyQIVNe2oM6B2Q1u+HxaJFmWHn
        ib8hzcNXbiLosLXu+WmInMRviFCo2ogGG1Y7A7TkqQ==
X-Google-Smtp-Source: APXvYqy20a69i+BpPxU22vNAN6Ow/iCv2hG7u//urlA+8eN4PaoM9U9nR7m07JtRO0nxUEQqts9xmvPk3rhYQwJXF6I=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr2957693lff.142.1579729723499;
 Wed, 22 Jan 2020 13:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com> <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
In-Reply-To: <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 22 Jan 2020 16:48:32 -0500
Message-ID: <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for your patience.  After further research dynamic_debug is not
available on retail chromium os user systems for a variety of reasons,
some of which you can find in this trail:
https://bugs.chromium.org/p/chromium/issues/detail?id=188825.

Given we need to be able to diagnose things in the field, this is not
a good option for this.

I hope this helps explain or justify the need for this interface.

Thanks!
Alain

On Tue, Jan 21, 2020 at 1:37 PM Alain Michaud <alainmichaud@google.com> wrote:
>
> Thanks, we'll check it out, please consider this patch as abandoned for now.
>
> On Tue, Jan 21, 2020 at 1:33 PM Johan Hedberg <johan.hedberg@gmail.com> wrote:
> >
> > Hi Alain,
> >
> > On 21. Jan 2020, at 20.25, Alain Michaud <alainmichaud@google.com> wrote:
> > > I'm not familiar with the dynamic_debug feature.
> > >
> > > On ChromiumOS, the interface proposed here is used by the user
> > > feedback system to allow the collection of BT_DBG output when the user
> > > is trying to send us feedback.  If there is a better way to do this,
> > > we can certainly use that. but may need to be pointed in the right
> > > direction.
> >
> > I think Marcel is referring to this:
> >
> > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
> >
> > Johan
