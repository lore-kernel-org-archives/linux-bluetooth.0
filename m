Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856AC282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 01:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7658218D2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 01:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlHXeh5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfDXBgw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:36:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfDXBgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 21:36:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so8414144pfr.4;
        Tue, 23 Apr 2019 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gtAH4rRjypw/uGBI7Ljb169Am6pDVVgTFmtzsAmosY=;
        b=RlHXeh5UrxSSLxuuTkiLse2Tozcv+BJ0e+krfN7pcojbzqXvUBfGbiWiCUiVRB/kLF
         0/w/j6QfOaUAXqysQ82gP50lW3TUajAzXbzXFHSaWDuxlhm730mIMcVpMKDx0FjF03ah
         PX/ZVyUDWSasUMz5DGvgknZrrht4TgPXMHCumDfqd2tJeAzJIQdQjO4aZFjBGEpi9qBC
         BgFO/72R6+AAkIFVz1b+NFEk+h/KdSMpNEqePwOy2MPYdRf0UZTGW60oZ3G+po1Rjop7
         atC2Bh4P2YLQUHq1D26zLbGzxZPiFDpe3j8u/xKJi8KTK6udrtzUPRP+Cmm3VOf0oBAD
         Z/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gtAH4rRjypw/uGBI7Ljb169Am6pDVVgTFmtzsAmosY=;
        b=QTYzBrmuNw/YtLUm54AwFn88ak2cIMrFaxekFKOhSH9oQCzKsfcWoRUGLf1kB7lteh
         9x44UbFcrfTQiAN4kcpzjzp4uICRQra3RpNQn6DSIlyyCbNq8dlX1VNMYJPzoZWpnDzl
         P1busPlsvm8LDYOomtPm3JCHzyhg6ZWlwMfoeH9rbbiUw53spepwmRvNq/aHTvLIg+1V
         ETryo23ZA189dr5EUh5T84xWbCdykehGnqzlCfqdn2kKMOK/cNr8T+geSen8JvpTo3gl
         hNzmlaaFVau3QiaCa0FKeH/a4xHatvfTExL6wA1Xusz7XpmuV1hj3zgfTb19aw8OOhUE
         hSUQ==
X-Gm-Message-State: APjAAAXQJLOkPyliJGeO0wd1kwsP72tQytI/d6gMcWUiy9/fdk93e5W+
        M7qH18CB00jNHUsCRxVAcmj+cFaPGrTFKxkiuS4=
X-Google-Smtp-Source: APXvYqwdkCx8NOrGQjEqo4YEYpELP9FHaHR+PHGwOBRwxWLT1UMVSewkFQQcW22WnQnJZSNpIf+GWAstFKbnjnFhk2U=
X-Received: by 2002:a62:a515:: with SMTP id v21mr30879035pfm.41.1556069811284;
 Tue, 23 Apr 2019 18:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
 <20190403230835.1174-2-xiyou.wangcong@gmail.com> <5F6E057E-4897-4F74-9FA4-0CB41222DB5F@holtmann.org>
In-Reply-To: <5F6E057E-4897-4F74-9FA4-0CB41222DB5F@holtmann.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 23 Apr 2019 18:36:39 -0700
Message-ID: <CAM_iQpVyFCAa8rbCJY-PNgY9XwBRjV4N2WAwtV1d4z=UG0afCg@mail.gmail.com>
Subject: Re: [Patch net v2 1/3] bluetooth: validate HCI_EVENT_PKT packet carefully
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        syzbot <syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com>,
        syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 23, 2019 at 12:42 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Cong,
>
> > hci_event_packet() blindly assumes all packets are sane, at least
> > for packets allocated via vhci_get_user() path this is not true.
> > We have to check if we access skb data out-of-bound with
> > pskb_may_pull() before each skb->data dereference on RX path.
> >
> > Reported-and-tested-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
> > Reported-and-tested-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> > net/bluetooth/hci_event.c | 262 +++++++++++++++++++++++++++++++-------
> > 1 file changed, 218 insertions(+), 44 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 609fd6871c5a..2fef70c0bffe 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2331,10 +2331,13 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
> >
> > static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > {
> > -     __u8 status = *((__u8 *) skb->data);
> >       struct discovery_state *discov = &hdev->discovery;
> >       struct inquiry_entry *e;
> > +     __u8 status;
> >
> > +     if (unlikely(!pskb_may_pull(skb, 1)))
> > +             return;
> > +     status = *((__u8 *)skb->data);
> >       BT_DBG("%s status 0x%2.2x", hdev->name, status);
> >
> >       hci_conn_check_pending(hdev);
> > @@ -2391,14 +2394,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > {
> >       struct inquiry_data data;
> > -     struct inquiry_info *info = (void *) (skb->data + 1);
> > -     int num_rsp = *((__u8 *) skb->data);
> > +     struct inquiry_info *info;
> > +     int num_rsp;
> >
> >       BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
> >
> > +     if (unlikely(!pskb_may_pull(skb, 1)))
> > +             return;
> > +     num_rsp = *((__u8 *)skb->data);
> >       if (!num_rsp)
> >               return;
> >
> > +     if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
> > +             return;
> > +     info = (void *)(skb->data + 1);
> > +
> >       if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
> >               return;
>
> this really looks like we better create a macro for this. It is repetitive code that can be turned into just a macro usage.

Hmm, I have no idea on how to make a macro for this, any hints?

By the way, we use the similar pattern in networking code, I am not
aware of any macro there.

Thanks.
