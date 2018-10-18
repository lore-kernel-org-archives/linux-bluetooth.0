Return-Path: <SRS0=YCPJ=M6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D05ECDE43
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 16:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301F92145D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWQpMRiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeJSANf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:13:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42860 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeJSANf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Oct 2018 20:13:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id s10-v6so22983855lfc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Oct 2018 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JSJp0T5pCI+R/k5vreTsAVoRo0UWQmw+/g+Am6MQLlM=;
        b=bWQpMRiTctgAx8DDtYjhz+m/f/NT2x5yy31r0aa01bhHz9yfjGDmd61mJnIK4aTkLu
         ThqVEkks6UQNOu+i4uZb/b6M7820UAcne1n7NzwDRkadIg/RTNY9Wljpf1utzfOfrQaI
         CkxdA/j4XwFRSt0g10Ma4QaGOgToI5EIrU2cQJA8UxldiYmKlr7rvNJGB4CQmdnEb9hk
         UUtBZmg1RuuXfbEKr9pe0HIn4FqehPipp/GpJUiV6rzSukzR57l3yubCG/fOxvseAsba
         yiAMroD0QLh13/NpF+WhDnupb9REviDH2K4gfn+QIQd/AA0JkNl/A16xQoVKNzRPQmG/
         ECpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JSJp0T5pCI+R/k5vreTsAVoRo0UWQmw+/g+Am6MQLlM=;
        b=eoWxA7x155gfBE9jbXzkEdd2ToEAkeVQ7uWf+GBPqWcO4BnaFvOH0CGf3kuXwbgz5H
         /5QnlGvVnXtW6vMkfHkUvD9lxV8ewQzX/UKK9HljoVZkaV6PTgdAi/mtN8KAbaiOarVW
         UnDmzxBM3/yp8x3aFN5BRp1Kv9l9YU2cH5PwIHRS9XwH0ePkaXkMX+rSpQwQNF/k7B3C
         uTpP+Z7AeRxf2UsaR19TPElSW3Xjc0DAqoD72s6FTbvKLJSeded3WuO8sigsJ19gGeyf
         Y1XSE4QC6NIssi7jszB/PBdDl3THm5M+C1Yt0Tquhjoliwqg5R7yHzg83y8YNt42u545
         MH7g==
X-Gm-Message-State: ABuFfohz0YNe4FK8VzVcYYa0pmYckwOEfhjfLky0KIbhfNxrBeiYj0h/
        J8uGa8+wnaz3Cn+XAHZrWFk=
X-Google-Smtp-Source: ACcGV63I40zO5Pr0/yEtK5PrCIi7VP7KCSvMq8NTHOpgbJUAMI2rSQfWMT5Fy4lY1/QVyoCS8CZ+eQ==
X-Received: by 2002:a19:111b:: with SMTP id g27mr591105lfi.135.1539879112866;
        Thu, 18 Oct 2018 09:11:52 -0700 (PDT)
Received: from x1c.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id d19-v6sm2478499lfb.62.2018.10.18.09.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:11:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 19:11:49 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/12] btmon: multiple memory management vulnerabilities
 fixed
Message-ID: <20181018161149.GA11513@x1c.home>
Mail-Followup-To: Matias Karhumaa <matias.karhumaa@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20181016201908.GA84982@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016201908.GA84982@Matias-MacBook-Air.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

On Tue, Oct 16, 2018, Matias Karhumaa wrote:
> Multiple different memory management vulnerabilities were discovered in
> btmon while fuzzing it with American Fuzzy Lop. Purpose of this fuzzing
> effort was to find some bugs in btmon, analyse and fix them but also try
> to exploit them. Also goal was to prove that fuzzing is low effort way
> to find bugs that could end up being severe ones.
> 
> Most common weakness appeared to be buffer over-read which was usually
> caused by missing boundary checks before accessing array. Integer
> underflows were also quite common. Most interesting bug was simple
> buffer overflow that was actually discovered already couple years ago
> by op7ic: https://www.spinics.net/lists/linux-bluetooth/msg68898.html
> but it was still not fixed. This particular vulnerability ended up being
> quite easily exploitable if certain mitigation technics were disabled.
> 
> Matias Karhumaa (12):
>   btmon: fix segfault caused by buffer over-read
>   btmon: fix segfault caused by buffer over-read
>   btmon: fix segfault caused by buffer over-read
>   btmon: Fix crash caused by integer underflow
>   btmon: fix stack buffer overflow
>   btmon: fix multiple segfaults
>   btmon: fix segfault caused by integer underflow
>   btmon: fix segfault caused by integer undeflow
>   btmon: fix segfault caused by buffer over-read
>   btmon: fix segfault caused by buffer overflow
>   btmon: fix segfault caused by integer underflow
>   btmon: fix segfault caused by buffer over-read
> 
>  monitor/packet.c     | 56 +++++++++++++++++++++++++++++++++++++++++---
>  monitor/sdp.c        | 21 ++++++++++++++++-
>  src/shared/btsnoop.c |  5 ++++
>  3 files changed, 78 insertions(+), 4 deletions(-)

All patches in this set have been applied. Thanks!

Johan
