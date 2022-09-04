Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE5C38145
	for <linux-bluetooth@archiver.kernel.org>; Sun,  4 Sep 2022 02:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIDCVH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 22:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIDCVG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 22:21:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962A474D7
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Sep 2022 19:21:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so5411316plb.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Sep 2022 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=lnOYFop6nDe6Di7kJuCsUPPcQ6Qykx7nWA9Dngo7JWw=;
        b=LlhRKtSE4ukyK5c3S+0h0jmC+oHpfgACLSS1e4fU+2uOpiiZDV+LSetVEcuYg2ZPr5
         XD7ATm8Ry/s5zf5VvTNNXobfYNjXXK3LuxTHgfGq+T+nSRYSB6W/9Uk9eFbDFUtjOOu0
         AU9ci+BO0uK/dJ91cS6G5xTMTXk51AdRz9WlRusOoPY9icQ/w06mjv8GYfb1y5s5Og79
         MpHQ1+QuiOYjj+MswyU5LtvEJ5R+lpEfSu0gluRPTSPDoTtsOazyeLWiluhiS0sqyjP+
         g9HvVI+3g3jM5Am1TAF+YHfo+FDnJ5eH7Od7aDC7zzjAx1jGe200OSyXNV3BOXuPo04+
         Uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lnOYFop6nDe6Di7kJuCsUPPcQ6Qykx7nWA9Dngo7JWw=;
        b=o1KPIG3CqNSF0JOlMyFQV8+kscC56PtbeK/Rr3AY34UxKaz4LXxXGeLgQXlU4gtGqo
         cVeht56D4fY/+jGX7p4ht/7B86QsVEiWGzdrs7GDFGwUgV3dAQKm+sHtUUHBeAji1ifA
         TDrqhAvg6szAafdFIQTXldVlz0BdHii1cyD4NTwGdlOwWMnB4TaUBgUySI35sWpA5lHt
         m5pJ4nNd0sLhIudZ60Ysc62tCftuV6Ysp0LpT9BVSnvP8gsbAwdS5a2nmBqqgESxt8Ec
         2A2tDUV5cPIe1sfhrzSFfQGO4xO+aMObwVpse6uwuNTi3qRj9kIZBbiA5M7RPV9eJgy8
         e9Mw==
X-Gm-Message-State: ACgBeo14ZzhY0MtIm4ctTRdltu7FB2bR0oo6EPom+YkWEqQLzwx/K+ne
        Q79Ku+ebJO3xsS3Xm9Jxhho=
X-Google-Smtp-Source: AA6agR4kR5v3f2tOiWXNNT48mOD8InKRH1TpAw8lb3EIKnMMmi4Qbr2LMSHSbrxgL1vjaWJm6CtuaA==
X-Received: by 2002:a17:902:a384:b0:173:4085:23d8 with SMTP id x4-20020a170902a38400b00173408523d8mr41725872pla.143.1662258060924;
        Sat, 03 Sep 2022 19:21:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:8793])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b002004380686bsm356432pjh.46.2022.09.03.19.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 19:21:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 3 Sep 2022 16:20:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Schspa Shi <schspa@gmail.com>,
        syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works
Message-ID: <YxQLig28YbtjCVH+@slm.duckdns.org>
References: <00000000000016512d05e76bd837@google.com>
 <733e6931-aa66-5295-d8a8-49063b7347f1@I-love.SAKURA.ne.jp>
 <CABBYNZLByK9M_eP_xCbVfGCSAuNOF6n+eUE4E=3hur-+bXdN4g@mail.gmail.com>
 <CABBYNZKv=dMHuHyOSxpqgG2G1je+xnRc8oM+juAQ0HzdfbBzKw@mail.gmail.com>
 <289ba1a9-e4f7-d0b5-545e-a98dcf365c68@I-love.SAKURA.ne.jp>
 <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKdgsh5S7LkR8Gk2xW7EJnje5B_iYQoNw3h6SQEh311Jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

On Sat, Sep 03, 2022 at 07:11:18PM -0700, Luiz Augusto von Dentz wrote:
> And we can check for __WQ_DRAINING? Anyway checking

Please don't do that. That's an internal flag. It shouldn't be *that*
difficult to avoid this without peeking into wq internal state.

Thanks.

-- 
tejun
