Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D5C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE087205F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SD8DE+rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCKQkk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:40:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39843 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKQkk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 12:40:40 -0400
Received: by mail-io1-f65.google.com with SMTP id x3so4601207ior.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnWR9XdAzDJau/P+RPluhiIPXMOfoTJA7PthoEMDEI0=;
        b=SD8DE+rWSiMENaYTpCh0nTISgXHLno6A/1lgq7qavstPHNCTT+CBc0y7Ce2zU9GxAH
         68OBkyHTcuVsWR6d7CcYQU/JZ7QCgWmVEPrxUsK5caTsOyQELHMV7aFEjijFYQPSCkmI
         lzAS0PPVJ1QqVBuNSrzpM1oqXwW61h9nL2RkSeFmexxzu5hU1t+1S3Mfso+ROrXpwObi
         64QkvMlzcbCktQcd7dVzG1VGkmjhL/2Us7MNWiVoXfJGHJ8WjwyS9j1s57orUqn8L6jt
         ajraQGxLzp55PB5VyhiejyZuGXJr7ANhsSNcjS6iBIVPHDUCbLG91UpsdhvmqOhEHFhw
         vcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnWR9XdAzDJau/P+RPluhiIPXMOfoTJA7PthoEMDEI0=;
        b=baL5eW53OfaQnNsQgcBezwLaqSLytoPDsuJ2KLqAlce5OoWInpLeYSziEYum0MZj3T
         1FVY/5g+Jgos7hQ8IoYofhvBMfED/C+KBaoTjA+4KhAzjj9hBst9Usz66AhRDssaFEhD
         y7GFUzf+2RK0LHywVTnVcPV2bFRMuj1lQfagqELyL7UjyaQbP4UDiXEjNOwl0a+zdz9C
         pNg9IQQuIhGEUThz2oRYSkS3Crem35YozwmmrKtz7QwpDBlK44ZPjdiE2jb6XQTyrWm/
         3K5iOY650YKexsRWF5sWvSf1O19ZwMlDoJbz5OxlDy+H+ST/wrSlNmNhlBVvjwcBDN4P
         E/aA==
X-Gm-Message-State: APjAAAVkUF4GwzEtU1DbM/R3TMisvjOMfMZ+/rk71WEQBvYm6kVsb9CT
        xhHOb+VMC1jwr88LMmXgTxu7+ahXrhL7fI1UMHFEhA==
X-Google-Smtp-Source: APXvYqyiiprpPOJpi1vicGhZLoaPK0/DtSewvRD97f9oncxOkYVRUb3dMcKPIyDsgOTHa/7U3n8cliTJ6lnD665+YbM=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr16400555ior.271.1552322438687;
 Mon, 11 Mar 2019 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000032b7f0583d16e0e@google.com> <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
In-Reply-To: <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 17:40:27 +0100
Message-ID: <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>
Subject: Re: general protection fault in skb_put
To:     James Smart <james.smart@broadcom.com>
Cc:     syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Johan Hedberg <johan.hedberg@gmail.com>, jsmart2021@gmail.com,
        keith.busch@intel.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Mar 11, 2019 at 5:20 PM 'James Smart' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 3/11/2019 6:20 AM, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 97faec531460c949d7120672b8c77e2f41f8d6d7
> > Author: James Smart <jsmart2021@gmail.com>
> > Date:   Thu Sep 13 23:17:38 2018 +0000
> >
> >     nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
> >
> > bisection log:
> > https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
> > start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute
> > to ..
> > git tree:       linux-next
> > final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
> > kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
> > userspace arch: amd64
> > syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
> >
> > Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com
> > Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc
> > transport device")
>
> can someone contact me as to what this thing is doing and how to
> interpret all the logs.  nvme_fc isn't remotely in any of the logs and
> doesn't use skb's unless the underlying udev_uevents are using them.

Hi James,

What exactly is unclear/needs interpretation? syzbot did what is
commonly known as kernel/git bisection process. This is a new feature
so there can be some rough edges. Hopefully we can improve the
representation together.

Thanks
