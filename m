Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C1C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 01:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522FE60FC1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 01:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbhH0B3J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 21:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbhH0B3J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 21:29:09 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A42C061757;
        Thu, 26 Aug 2021 18:28:20 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e9so3447719vst.6;
        Thu, 26 Aug 2021 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eojL+CWYVkbXeDacbojpALaYys7Gf6X7mCAj9i6PgeY=;
        b=XIHjwB7yhPrtlB0C4InUgaZWjxpYRSVVIc27vDUVU65q4gu9fduks6wBc3kr7onySw
         NMFdLlgtH9bLy/VSYY6HmHHA1C9jBe03g6tQy5hWSO5VJUn3Uu6vSQVs5NxG2plJTdt/
         tthZ8aFnrwrUDpRqkTHHK8Jz4RZmXD2E6TyL5EL4djeAu9NEcBs2+0IgnT8bRysYAkbz
         DF7MiELE4D9E5z9lpOzGOnHlZP/z4wltx+tzAtJOH5rz3tEOcnOXmjo6PpgVC4jeK1wQ
         U69y1828em49SAc7+608LVXCiZZ2PjS3aQLMxnF2yoX/+9KyIN3vth99y2S8CflVoDV5
         plGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eojL+CWYVkbXeDacbojpALaYys7Gf6X7mCAj9i6PgeY=;
        b=Zlj7YOnmVuKdhz9LEsO3nFnc6cxBMBYpU/1ECTE75DBbQTKYIqrRQMm3ZAX9hc+wxi
         ZctugvQLvWbamBRhLWvr2W6TKYnN9QROaw0TxnFom1E1AHKXfCexhLupKrG1f5YnZQZD
         MCeFnjq7QqTlVzqyvjQZ/PnKpQdxq9Fw162mOIjuOLDgzenw2imSyBQm0+a8ck5Jm/yW
         lO8qZ+FMO9BtrvCmoVv/KyM5ODrqlqiIuowD8M1dWaRBR8FUG5s2ROZ+FmekhM3xGfC0
         tlE52QrdFybF1LAsW7TZhZ9KQP4opf90CNYV8k+mH9h+0kl9sjgPFNtGwpv+gfrILI91
         8USQ==
X-Gm-Message-State: AOAM533/i5xIP/MlUWrqli77utPkvCiTngRzo3xPQnXdjCFXSkXkdu+R
        tTeOO2G4wF4yb4kg3nZo8zrcesNohKg1imstv6buFYDk
X-Google-Smtp-Source: ABdhPJybVLyee+lXB4edK51zGY1t+HPu1iQFjYuk4eoCiOaxNrdHKe+HbDvG6EJHRBw0fcAEma/dfbrw5ozczWRfyrk=
X-Received: by 2002:a67:fa19:: with SMTP id i25mr5426127vsq.7.1630027699947;
 Thu, 26 Aug 2021 18:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <s5hv9418mjk.wl-tiwai@suse.de> <s5hk0k8wlfn.wl-tiwai@suse.de>
In-Reply-To: <s5hk0k8wlfn.wl-tiwai@suse.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Aug 2021 18:28:09 -0700
Message-ID: <CABBYNZ+1=k2eQ4u1WWdj9JcBaB3HmjXzv8rVhQ89gwHDf4YHTg@mail.gmail.com>
Subject: Re: CVE-2021-3640 and the unlimited block of lock_sock()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Takashi,

On Thu, Aug 26, 2021 at 3:29 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 19 Aug 2021 17:46:39 +0200,
> Takashi Iwai wrote:
> >
> > Hi,
> >
> > it seems that the recent fixes in bluetooth tree address most of
> > issues in CVE-2021-3640 ("Use-After-Free vulnerability in function
> > sco_sock_sendmsg()").  But there is still a problem left: although we
> > cover the race with lock_sock() now, the lock may be blocked endlessly
> > (as the task takes over with userfaultd), which result in the trigger
> > of watchdog like:
> >
> > -- 8< --
> > [   23.226767][    T7] Bluetooth: hci0: command 0x0419 tx timeout
> > [  284.985881][ T1529] INFO: task poc:7603 blocked for more than 143 seconds.
> > [  284.989134][ T1529]       Not tainted 5.13.0-rc4+ #48
> > [  284.990098][ T1529] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  284.991705][ T1529] task:poc             state:D stack:13784 pid: 7603 ppid:  7593 flags:0x00000000
> > [  284.993414][ T1529] Call Trace:
> > [  284.994025][ T1529]  __schedule+0x32e/0xb90
> > [  284.994842][ T1529]  ? __local_bh_enable_ip+0x72/0xe0
> > [  284.995987][ T1529]  schedule+0x38/0xe0
> > [  284.996723][ T1529]  __lock_sock+0xa1/0x130
> > [  284.997434][ T1529]  ? finish_wait+0x80/0x80
> > [  284.998150][ T1529]  lock_sock_nested+0x9f/0xb0
> > [  284.998914][ T1529]  sco_conn_del+0xb1/0x1a0
> > [  284.999619][ T1529]  ? sco_conn_del+0x1a0/0x1a0
> > [  285.000361][ T1529]  sco_disconn_cfm+0x3a/0x60
> > [  285.001116][ T1529]  hci_conn_hash_flush+0x95/0x130
> > [  285.001921][ T1529]  hci_dev_do_close+0x298/0x680
> > [  285.002687][ T1529]  ? up_write+0x12/0x130
> > [  285.003367][ T1529]  ? vhci_close_dev+0x20/0x20
> > [  285.004107][ T1529]  hci_unregister_dev+0x9f/0x240
> > [  285.004886][ T1529]  vhci_release+0x35/0x70
> > [  285.005602][ T1529]  __fput+0xdf/0x360
> > [  285.006225][ T1529]  task_work_run+0x86/0xd0
> > [  285.006927][ T1529]  exit_to_user_mode_prepare+0x267/0x270
> > [  285.007824][ T1529]  syscall_exit_to_user_mode+0x19/0x60
> > [  285.008694][ T1529]  do_syscall_64+0x42/0xa0
> > [  285.009393][ T1529]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  285.010321][ T1529] RIP: 0033:0x4065c7
> > -- 8< --
> >
> > Is there any plan to address this?
> >
> > As a quick hack, I confirmed a workaround like below:
> >
> > -- 8< --
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2628,7 +2628,7 @@ void __lock_sock(struct sock *sk)
> >               prepare_to_wait_exclusive(&sk->sk_lock.wq, &wait,
> >                                       TASK_UNINTERRUPTIBLE);
> >               spin_unlock_bh(&sk->sk_lock.slock);
> > -             schedule();
> > +             schedule_timeout(msecs_to_jiffies(10 * 1000));
> >               spin_lock_bh(&sk->sk_lock.slock);
> >               if (!sock_owned_by_user(sk))
> >                       break;
> > -- 8< --
> >
> > .... but I'm not sure whether it's the right way to go.
>
> Does anyone has an idea?

It seems that we need to rework some code so the functions affected by
userfaultfd are not used with sock_lock held.

-- 
Luiz Augusto von Dentz
