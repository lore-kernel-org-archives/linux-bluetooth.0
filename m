Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141EAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD6364E85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 17:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBWR13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhBWR1Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 12:27:24 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B062FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 09:26:44 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l64so5615148oig.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGkbhy1ZsvlhP4cM2EPL2Jq+zKZZSmQ6RXilh0LVqgw=;
        b=rngk8atD1OgIFWTLkXXp3AoUy8MTIHr58xpuusFpkBcDjV5xiC9E02au6rYbdO3Eox
         8/WZKbBPu3XtgJgG3RyBmJZlNyYCu8OEXDq4Ygwt2TNndcyt7TpbDFfJ/ebDtu0a6NaI
         UzTQK0cZL0UF6PtchsWw+dJYMvWaWJ7qLqtlJElytXlgiRg2TT7mFQTnJ/vlbU80QUo1
         KUGs+STpyvV8PiJNKPY3thYOpUMTY+FANJLz8i+O3uYZdu8CHqRM+o+wLx3OgI4vY+dL
         Q2DQo33KZXX5MvYVQSkuaTgZwXVsoi0kZxodEkhA+54OqjrT5BY5ajKLBzlxjFJ8s3D8
         995g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGkbhy1ZsvlhP4cM2EPL2Jq+zKZZSmQ6RXilh0LVqgw=;
        b=hsYuSxEsv8LH6BHNh9j3zhNPiIxsxDDSExeoQ0wD4bCmY7YVNGPyBO4YRD6S7bL67C
         wO4Tnc5ATaKS0KgtgfGTqwMK8QwfCWggF7HNNfPRgnlxfWGyuy2W8G0I6NU+44QxMftB
         9MHeCQdxbXRDqfrnlcxb+l3WZdSsM+25AltYozZoRwkEWcqsn5gB3LrpyvCZt8g2HKzc
         yASK8izX0inTA4qkyVg8+BuUtPKHTBbtrdQ6uJPeBeo5pVBxJ/A7St1zjMH4PcbQZLXv
         FmW3sijD9VjddM0EmUxs5Mw2QWP4AfJWFa0h5sVdI3pZ0oksOvb9TS/RvujOhjDj/Z1I
         pnPA==
X-Gm-Message-State: AOAM532CtI2Aq9JMSvCjSQyHqk2m/cfk6Hq00//Q3wIzls1mNRLzcpqX
        VttpI5w9XzdBB2TVIBO02gGk74GaeYf7S3gM7IUr2UTj
X-Google-Smtp-Source: ABdhPJycaanqTNe03vHbSAj/BimFfZGA+AmCD1qyPdhyfMR96pLa8IgUW5h5egPHzlOXXUMOX4+C3I+gxYiJPzEH3Hk=
X-Received: by 2002:a54:468f:: with SMTP id k15mr19227793oic.58.1614101204157;
 Tue, 23 Feb 2021 09:26:44 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hpL36xwJ3zujD6DsRKzQw_54TucEif=icMgN1CUpk9TNA@mail.gmail.com>
 <CALaQ_hpGDdmLTrccsTDnquw-+5BVy2-c2nem_ncLHzF7k=ac-w@mail.gmail.com>
In-Reply-To: <CALaQ_hpGDdmLTrccsTDnquw-+5BVy2-c2nem_ncLHzF7k=ac-w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Feb 2021 09:26:33 -0800
Message-ID: <CABBYNZL=97WonEB++tgPLM9uUaRHkHc5b9ed2a6FSxCb1mRJCw@mail.gmail.com>
Subject: Re: avdtp.c:cancel_request Times Out, Plus Other Failures
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nathan,

On Tue, Feb 23, 2021 at 2:17 AM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> Just to put it out there, I switched back to my previous 5.8.7-dirty
> kernel and haven't had any issues.
> It's on the same upgraded system, but just the kernel was rolled back.
>
> On Mon, Feb 22, 2021 at 1:27 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
> >
> > System updated 2021-02-19
> > Previous update 2020-12-18
> >
> > Kernel:
> >     Current: Linux computerName 5.11.0-dirty #1 SMP PREEMPT Fri Feb 19
> > 06:30:22 CST 2021 x86_64 GNU/Linux
> >     Previous: 5.8.7
> >
> > Bluez:
> >     Current: 5.55-3
> >     Previous: 5.55-1
> >...

I would like to see the whole log, can you attach it?

-- 
Luiz Augusto von Dentz
