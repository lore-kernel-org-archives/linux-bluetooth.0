Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883ECC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5172861969
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Jun 2021 20:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhFYUf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Jun 2021 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFYUf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Jun 2021 16:35:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DEEC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 13:33:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t8so6547937ybt.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fGkK1JlKkNHp7k8PKQamfzB/GU60+BlwTdAJV/LyG8=;
        b=q4VsIRAODc/7c56XT8lDWgVi7f0nUX2LGSIrzlVmb/Do5YZ9jnNCHWK3aQkN2akXFQ
         uF/7ChUtugdwhSDUUr31EieKutZpDk2KmCkdg6umaBSC8IKztOggeCmlGv+GdBFySoPr
         eVZK25EBsCiNuKUqQH4CpIJzfADXRVUR7JNY2MqOjw5rblIM3kqXKR/QhY2PJU/6kl9t
         HXjLLGWcLzHG/T8rbh94d2ROSKk555nNgnY0jlx/figTiyji5BBesF+eTo+CYQAfKHOP
         ADacxKYOOJ4/+N2/+/XhAUSVdj3lGVA+jYX16bHdoXc21n3f+qI2tmayXCjS8vyNVhaH
         apOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fGkK1JlKkNHp7k8PKQamfzB/GU60+BlwTdAJV/LyG8=;
        b=r0fl6/eDxJIy/gU/PyZtSLAVIUhH4xKzHl6XpmmZH2dNp3MYqzOPw7ZRsS9/v/Ho4U
         FT1FD4hgJSw9EjbEPSJTqd0k8+1jWkjH2o/xf0399LMThkvCVeausPznJSaUlrIzyrUg
         J8pDuLmcuTIeNmIaPaoQcbq2n6oVLrbUQh8vMCFwMcyk1uyfzXlZNjik1ysuUaogLsWl
         Rx24xibMuj/q4FquzNTME6H3CbhRNrUAVBtr5oGWDP4I1tsY66lSyLc+JWi1pB5CFFL5
         ZmCEt1ogmRFtyTTykdOSaC0upTh3LK4RbSo4JcplPr439YlnC/36v53DJAMLvmFZ8zH0
         Fmuw==
X-Gm-Message-State: AOAM530I6XU7OX5w2lqHydg7rDyvgREWp7/XD3d8AiiSjC9mq3tg8H25
        cmL4jx9QUdowhka7fQNNJ7sEgwblk0MnNTB+JpM=
X-Google-Smtp-Source: ABdhPJyTPPh9/XQA5nwDEMLSyMuxEbXTDv2omXzLR7dubQa7daJf26q50SlnH16yYJbTWEKtv5CyWGg0p7IxvSpLwOI=
X-Received: by 2002:a25:acdf:: with SMTP id x31mr15468114ybd.222.1624653213943;
 Fri, 25 Jun 2021 13:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <YNXveZZwzS3crmHH@mwanda> <60d60196.1c69fb81.dc5c5.0cf5@mx.google.com>
 <20210625195924.GM1983@kadam>
In-Reply-To: <20210625195924.GM1983@kadam>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Jun 2021 13:33:23 -0700
Message-ID: <CABBYNZJoP5_d-K1hUt+G3N3KhgXoaokFRu_FQrrbYKctAqFhrg@mail.gmail.com>
Subject: Re: Bluetooth: sco: prevent information leak in sco_conn_defer_accept()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "An, Tedd" <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Fri, Jun 25, 2021 at 1:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Jun 25, 2021 at 09:17:26AM -0700, bluez.test.bot@gmail.com wrote:
> > ##############################
> > Test: CheckPatch - FAIL - 0.59 seconds
> > Run checkpatch.pl script with rule in .checkpatch.conf
> > Bluetooth: sco: prevent information leak in sco_conn_defer_accept()
> > WARNING: Unknown commit id '2f69a82acf6f', maybe rebased or not pulled?
>
> I double checked the commit and it's correct.  It's from 2013 so it's
> not clear how the bot got confused.

Yep, Ive seen this before with my own patches, perhaps there is
something with the CI tree which prevents checkpatch to locate the
commit id or something like that, @An, Tedd please have a look at CI
environment what could be causing this problem.

-- 
Luiz Augusto von Dentz
