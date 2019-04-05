Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89375C282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AC621852
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iod0rX8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfDER1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:27:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33868 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDER1B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 13:27:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so3433384pgq.1;
        Fri, 05 Apr 2019 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilboDT2/8Gu498fPkRpXSukNdx46dV57KWBPcj/H03Q=;
        b=Iod0rX8nF2SoZRj+MECvgno+tud0JMquvbNLPaif52ULJxhk4p+MkP7GQcFk+vXame
         0HqZvVL+liWI5QDpnIuLOkuEwIUr9sIkJGusp4TCPEgJ/H/YZakADkJhyVDyFtj7yMnI
         Y313Ezg2kCOvbrk6LydK7sq2kDH2P57vwcUQcorgpPWmbbvSdt6g0APuAmdZLnIhZCQ8
         O2HRUj9CGd8GFbOWWlplziRWq5up6j34SG8l9TL3FZ2vTOo96RQY8zdYr88b3Nw7Svaj
         5XskD7y3juuDDgocckk7zpoGExI9zxwAUAUmhcwqqU1yKIHOEKB+vP80LEaE8kScg8Ix
         hgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilboDT2/8Gu498fPkRpXSukNdx46dV57KWBPcj/H03Q=;
        b=Zi23OX5InEqgrFIdet107BGDN8c2FMG5VRPK76uqOHq7voKaLCDC3KV1uL8uANteip
         NdHTHBYWGJWYzrfztirNyPX66nA2uX/AhoQV5bPugBJqcZvtUPsEALSaf2Cq40ON+tQd
         YmDczf5YPyDeY6RQydwlYCtMuh/8tTaa4XJMKgmhG0bc35Gl0UnC2dPX6/aOdZwAECjg
         3dDmTXabs4I1DqVr28q1AA0Q/mb/31I5ltMLqpgRLN8g0zGAnvcihLeDrh3ZuN7yWP0i
         rDD3XjiY9avmfyHiLButh1qQpU9rWUuEAZdGSGEpUFHn1UDlZg1mgS6+gYTgJx8OEpog
         /Ihw==
X-Gm-Message-State: APjAAAWDpJOPg40TkfENBzUL4jlbdvAX36hXADg7pdDEijXU4h/cwwiC
        VTxtYzpd9me0vvxAJDMdg1up36oZAEsgZ71+cgk=
X-Google-Smtp-Source: APXvYqzgQPZ8jfAm4AYfvCkgTRCOAsUVTl5o079HDnymRFemo7byXHLJ7rbqwbAJET4n7DmNkMRoNuSYQJJCfyNlxKE=
X-Received: by 2002:a63:c40c:: with SMTP id h12mr2222886pgd.39.1554485220853;
 Fri, 05 Apr 2019 10:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
 <20190403230835.1174-3-xiyou.wangcong@gmail.com> <20190404083449.GL32613@kadam>
In-Reply-To: <20190404083449.GL32613@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 5 Apr 2019 10:26:49 -0700
Message-ID: <CAM_iQpXnPyqGxgPF19CA9n=DGYmJ9d-Vn4fvu1kKunonPKpW6A@mail.gmail.com>
Subject: Re: [Patch net v2 2/3] bluetooth: validate HCI_EV_LE_META packet carefully
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Apr 4, 2019 at 1:35 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Apr 03, 2019 at 04:08:34PM -0700, Cong Wang wrote:
> >  static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> > -     u8 num_reports = skb->data[0];
> > -     void *ptr = &skb->data[1];
> > +     unsigned int len;
> > +     u8 num_reports;
> > +
> > +     if (unlikely(!pskb_may_pull(skb, 1)))
> > +             return;
> > +     num_reports = skb->data[0];
> > +     len = 1;
> >
> >       hci_dev_lock(hdev);
> >
> >       while (num_reports--) {
> > -             struct hci_ev_le_ext_adv_report *ev = ptr;
> > +             struct hci_ev_le_ext_adv_report *ev;
> >               u8 legacy_evt_type;
> >               u16 evt_type;
> > +             u8 ev_len;
> > +
> > +             if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev))))
> > +                     break;
> > +             ev = (void *)skb->data + len;
> > +             ev_len = ev->length + 1;
>
> The "+ 1" is a bug.  It was discussed in a different thread.  Jaganath
> says he has sent a patch to fix it already.
>
> Probably it worked in testing because the num_reports was always 1, but
> now when we add this condition with the "+ 1" bug at the start of the
> loop the the the num_reports == 1 case will be broken as well.

It could be, at least it is not a bug introduced by my patch therefore
I have no obligation to fix it?

I am happy to rebase if that fix is merged before mine, like for any other
changes, if this is what you are trying to say.

>
> Tomas and I should get Reported-by tags for parts of this patch.


Sure, sorry for missing it, as I got reports from syzbot directly and
before you reported it. Will add it in v3.

Thanks.
