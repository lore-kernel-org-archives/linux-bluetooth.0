Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB4C282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 17:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799602173C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 17:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/cdAAnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfDERQs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:16:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38016 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDERQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 13:16:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so3416353pgl.5;
        Fri, 05 Apr 2019 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2nUGT7h1epN3yUMtyf2zrGKlYTbeZ28XBqknmfE/4U=;
        b=b/cdAAnFMXTYpnxLMLu9dPxT0YSJJLC5O4NAp1oM9I8ahYR26V8QWY6NaQjcOZn+lo
         8iP+lCJ9dSABdwB7kNHF1vE35PhbRME+Tb/iTkmLFrmcnRh5O5F2/LbJprUd/FSjuiVs
         rPnBRPUN1Zp41xzcdrlLwHdQDR+dH932pidIhbREkIPuOuZUAhN5cghqbYMJNnzJQBM2
         RvdncvpKH9N8wX5zUcj45RlZEkcKao5XxLcHtnW+bjEWX9G53KbGb6eKjGPqxSx+b8E2
         LSCQwVLy1M+aRx7DA95FzMJ/g1a23JNKB4TXpkaT6/I7mV3Drr3dn5e3VOBht6yImxVP
         zX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2nUGT7h1epN3yUMtyf2zrGKlYTbeZ28XBqknmfE/4U=;
        b=feVW43L8dm76xmm1CJpb0M31nmEhbbm4ioypADEXmaoetCDEz+LesMUR+dQJMmlizI
         gq1Ft8qC66LmkB26UMyZkRcbA15+3Pxgbcxi9XJhZ/bD7VoP17DAjolm9nofPt4WQoC8
         bqzNUYzfX597Mg758LXc6W1wOPXC6zz0jFtz4YYtVbGLkPKuBqJ4lcwrbjORbZBErTWL
         UE7XxbcGp7pIkwB/BmUTLBqKg2BJcffKbY/aIu7Husy4Aek1RXeN9bcpH1vhwYR8uMJY
         j2E6o7cicdWM9jbCbCyWAb4RC8fPmv0JZYsJPfpnFhDzW/icevOF+sMnImzfjr/L2ebL
         9HyA==
X-Gm-Message-State: APjAAAUH1d600nYWe2RScFbucVO3B0MQ1AOiN+VKhUW4uE9hGzdODn6V
        pX30lqRv5SG66hOtuksUklXv1cFqWkA5EJmj1F4=
X-Google-Smtp-Source: APXvYqzkWOIsFUpMaGgYU2kVFeV4tPaintTjEizB/fcqwNFg128RhxLWWNencvUgzbSFPNBXkw/2RMjCaReKSIwM7Os=
X-Received: by 2002:aa7:8d9a:: with SMTP id i26mr1790603pfr.220.1554484607578;
 Fri, 05 Apr 2019 10:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam> <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402195537.GF32613@kadam> <CAM_iQpU2qwezhk8XdnX+kvUi8Oi0mwNxRuFOo8uGvjZaPZGNWA@mail.gmail.com>
 <20190404080627.GG32590@kadam>
In-Reply-To: <20190404080627.GG32590@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 5 Apr 2019 10:16:34 -0700
Message-ID: <CAM_iQpXLoSU5f4tGtwDt9=+AQ==4CfYhnxcOmKkmvB+Yd0KNfw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 4, 2019 at 1:06 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Apr 03, 2019 at 03:55:20PM -0700, Cong Wang wrote:
> > I tried checkpatch.pl, it has no such a complain.
>
> Huh?

Huh +1?

>
> I sorry, I must have been very unclear if you're asking about
> checkpatch.  Checkpatch is a Perl script.  It's basically like grep.  It
> has no idea about fast paths or benchmarking.  Let me try explain
> better.

Sure, you said coding style, then I brought up checkpatch.pl.
If it hurts you, then I am sorry. How do you check your coding
style without checkpatch.pl? I am happy to learn. Personally I
just trust checkpatch.pl, because I don't want to waste my time
on coding styles, I never say I like it or not, I just need a tool.

Thanks for teaching me what checkpatch.pl is, although I have
been using it for so many years, it is really really helpful.


>
> The likely/unlikely annotations are there to help optimize branch
> prediction and make the code run faster.  In the real world if you can't
> benchmark or measure or detect a speed improvement then it's not a real
> speed improvement.


Personally I disagree with you on this point. You don't have to measure,
you just have to understand the code. In this case, bluetooth has linear
and sane skb's in _normal_ case, you don't disagree, do you?

So even _if_ likely()/unlikely() is only for telling which is the normal
case, it is still helpful. In this case, we want to tell non-linear skb's are
unlikely in bluetooth, you know this is true, as linear is always the case;
and, we want to tell ill-formatted skb's are unlikely too, and you know
this is also true.


>
> 1) HCI events don't happen often enough to where the speed can be easily
>    benchmarked.  In that situation, we just write the code as readably
>    as possible instead of trying to micro optimize it.

Same. It is not about benchmarking.

>
> 2) The compiler already does common sense branch prediction.  These
>    conditions look straight forward so it probably gets it right.  You

I'd be surprised if the compiler could know skb's are always linear
in this particular case.


>    should take a look at the object code.  The compiler probably gets
>    it right.  I bet that these annotations don't even affect the
>    compiled code let alone the benchmarking output.


If you are suggesting we should remove all likely()/unlikely()
from pskb_may_pull() callers, please go ahead to submit a patch
to remove them all, and see if David accepts it.


>
> I know this isn't explained in CodingStyle but some things are
> assumed.  In drivers/ about 1.5% of if statements have likely/unlikely
> annotations.  It really is not normal to add it to everything willy-nilly
> for no reason.

I don't know why you want to make the topic as broad as all
likely()/unlikely(), we are discussing likely()/unlikely() with
pskb_may_pull() together, and particularly in bluetooth.


Thanks.
