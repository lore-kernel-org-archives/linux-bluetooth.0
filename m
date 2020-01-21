Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59539C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292DE24125
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcIEItJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSht (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:37:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41688 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUSht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 13:37:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so3142433lfp.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIwXVu0R9ALG2fglnSR3AYD4b1IHaEMtLsVLEn9dx6I=;
        b=mcIEItJoRBoLqsMQoWEA2ygOZ3q3/Z8Cn92NevXNw3lTtns6iGzx7LtDNaturo1S6I
         i1VDnuHDTyYayzi22RuZWFcWF+REq4ZlF2Wr2Go67IYTV3oOevORV9nM9OvEv2L3hhJl
         KXGwoRlqLb7igG1SmwTwwEuETRZZ7KGP4eSb9u/M9wp4xTj4JGpJd7DNiprMNnEoT+Rz
         MqvYauZ9Mv91tnGeS3RQaAPKmzxZyLyry98GWuzNnhy1EZXCWxukhpzDz2Z5OK+iGDCM
         42C06rAZj6hUGe3L3LiUvXQDLClSZb8YRmhcK4Dn0ev1+AyyaX9PM17CKhO7Udv1xlC5
         M72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIwXVu0R9ALG2fglnSR3AYD4b1IHaEMtLsVLEn9dx6I=;
        b=Vo3smB6vW9Lo4yiokEDLEXdPan2dbbB6cSddX/KfiQGe+pXix3BrGGow/9rbj1vjzH
         JPfKB4K6/R3oc9LHHcy8npk5hb/Muk8J0kINBjA/1CX6ZuIKttGJmb4326/gjBVZNTlo
         9WDybXQmTDWsZcsFrUWYSxUdRc+XXbaH9ZF7yQebNR55HfYamUmgIkBphiqvuIEpV/Py
         NDgFd0wU1hDsTo3VoL2bcSD4mput8E5LC1uScAzLzZ5u1MmfMb1kzo4FuFoIpVqgUrZS
         m7dSMi/9iup4796hrzflC+8c9VdAGc3Hzb8FBk03f0Y42iIKA53ibh2pPSMCbvoPHVJx
         hozg==
X-Gm-Message-State: APjAAAVX4fghnSy+Dnre37FXTAQoja0VoPJJubdnRKOjyQ8eg3EwlCSj
        1wuLBe1L9/QF+2HXXJcUrTn8ZTIc1gAcoAqxzhnx9w==
X-Google-Smtp-Source: APXvYqwRJ9b+DfStyeZmRYL/jVIbg6lMpIUZU7Cl1Kz0UnCNO1sQkqtR4h/+AendrKL/5Xubwj1mxFm0o4wqF4pk+v8=
X-Received: by 2002:a19:7401:: with SMTP id v1mr3522362lfe.129.1579631867322;
 Tue, 21 Jan 2020 10:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com> <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
In-Reply-To: <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 21 Jan 2020 13:37:35 -0500
Message-ID: <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
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

Thanks, we'll check it out, please consider this patch as abandoned for now.

On Tue, Jan 21, 2020 at 1:33 PM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Alain,
>
> On 21. Jan 2020, at 20.25, Alain Michaud <alainmichaud@google.com> wrote:
> > I'm not familiar with the dynamic_debug feature.
> >
> > On ChromiumOS, the interface proposed here is used by the user
> > feedback system to allow the collection of BT_DBG output when the user
> > is trying to send us feedback.  If there is a better way to do this,
> > we can certainly use that. but may need to be pointed in the right
> > direction.
>
> I think Marcel is referring to this:
>
> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>
> Johan
