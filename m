Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DAEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 08:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFDC6108B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 08:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhHRIFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbhHRIDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 04:03:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21DC0617A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 01:02:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gr13so3223596ejb.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mZorCO9dHkK9Z+tLmMENe4sm60DKPCbLZG525gkchFY=;
        b=q6tSnI/hcRssEOPOa+x3Tf6o11TQuaH2Vap6Kz/BOFM9d8cBeudswn2ue6jCVrUA4S
         42aKPQUMpoBdV2RXEgmBUIuk69wyU09Q4FQn03q87aSLbbeEY54b2aoOEervw8/Vx+Ze
         RCJDnJWxh+ehYx2l3x9QePYppFzgIhAk9I8Ez1Ui/r1WtLXPhmjlzTE3HypQH/Fmpzd7
         SjM0w8dE0TQs34HsvUHqSMipeoMFYXXws5EnPFxxmOIzbHU88B37Y4hS/JToPTiLOeXH
         AyFYW4fBlKR+vnJPKKKZP7U495i7gia5DqO5LG6OjQ4IZEWUmmQmIn1+olH/pn0q4YR7
         i/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZorCO9dHkK9Z+tLmMENe4sm60DKPCbLZG525gkchFY=;
        b=ll6LyX3YrrfSe+B8hhqTaWH54UelQJ8VWbHbiHxUper6TeHO/OJNh60mp6ze8Pmb57
         /YnaxHPx8/pyrLIwzA0e3MrrWfY9XoFSx/OfD7AmgZVrua8TLQfFjVnQSqz/5Z1s4nWw
         Mn8AQ1FDApAjeglI+TAfBlQTV08eBJQ2lQvFkuRt28Sd7yFRNCC10mVv8EfcDDL1JEfw
         oMhkRASqJJ2PIZBArJr/PC5Lhj6Y7J+VCQfMo3Q1FvHgJne7cQlNFDFghO/VZVsYl3rs
         DHPMs7JkWVDQNDg/io6M1fyKkF2FMfcuvkl4ri0W8DVw6oCnbirJ3jERMje46giFiONN
         Qzwg==
X-Gm-Message-State: AOAM532Cwk7nJM1ZC9IHiPTLSBNOXhH160HaMsKnNBucMZTtCAQzDzmv
        yFgoKhEY/9k/Sx5l6bR9X7h+sA==
X-Google-Smtp-Source: ABdhPJx/EKzaFi+cRnqWvYi6W0WthKoTJQPIJ62VMOaDiheyKphteFXp8M2RNgE7IjrEAbkEAeFxvw==
X-Received: by 2002:a17:906:c1da:: with SMTP id bw26mr8561207ejb.253.1629273767444;
        Wed, 18 Aug 2021 01:02:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id c25sm2185584eds.93.2021.08.18.01.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:02:47 -0700 (PDT)
To:     syzbot <syzbot+7b938780d5deeaaf938f@syzkaller.appspotmail.com>,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, mathew.j.martineau@linux.intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000012030e05c9c8bc85@google.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [syzbot] KFENCE: use-after-free in kvm_fastop_exception
Message-ID: <58cef9e0-69de-efdb-4035-7c1ed3d23132@tessares.net>
Date:   Wed, 18 Aug 2021 10:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <00000000000012030e05c9c8bc85@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On 18/08/2021 00:21, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit c4512c63b1193c73b3f09c598a6d0a7f88da1dd8
> Author: Matthieu Baerts <matthieu.baerts@tessares.net>
> Date:   Fri Jun 25 21:25:22 2021 +0000
> 
>     mptcp: fix 'masking a bool' warning
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122b0655300000
> start commit:   b9011c7e671d Add linux-next specific files for 20210816
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=112b0655300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=162b0655300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
> dashboard link: https://syzkaller.appspot.com/bug?extid=7b938780d5deeaaf938f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157a41ee300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f78ff9300000

I'm pretty sure the commit c4512c63b119 ("mptcp: fix 'masking a bool'
warning") doesn't introduce the reported bug. This minor fix is specific
to MPTCP which doesn't seem to be used here.

I'm not sure how I can tell syzbot this is a false positive.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
