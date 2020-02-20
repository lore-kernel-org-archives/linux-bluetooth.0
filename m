Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824D7C11D00
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 08:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8024672
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1p6DOgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgBTIBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:01:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35237 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTIBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 03:01:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id b18so26698580oie.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2020 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LD998h2IWdu5aq+JNuGMG/AJkcgIqqf6dSEUP+iywDA=;
        b=X1p6DOgIKa92nyeufTz7R2CO3VxH0mzXplxk3tfzOa9+fgCHTnJXpCNkUcQf7M5SpI
         IzdHB7qKdnAJOgRx3HUWB8df8dSpv836syu0sy9uwanXCHAXyfNe6DMie7uHswX2JwJI
         L4Uy5NUPvkQx5y0ifq15xlw3fgQ8S/tu47EXpj1mlMCg+pUYrsmJPA/BdJpZ6MAo92Go
         1VswtPVB4AQTaNM5m2vcCSAt+hlXMd9b/a3helxh2ykowrmHIDWUFHWu5cZ/n4UN9IpE
         0MRkafSnAqmUCDQU6cwv8/umPz3WiyOvEJU2kAjx2yJzuxzdGC9r+VtcKJdwOIJrzoCW
         b8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LD998h2IWdu5aq+JNuGMG/AJkcgIqqf6dSEUP+iywDA=;
        b=GWlzDkNlW8zu6CzFV6b3vHy4oBTCjLvicO29zqRVlYvwaYYwOpDTQRYm4pkojZAYIh
         8LBWkeo5a6DLMxu/qNN9BrIZk2WQ9NqcIMLx+htRYr618gA6blg4m+m2bNA3WrlfqkGG
         nQpMID4Cfyck2v8vY7P7qFQEdI5cZt5pCfksVhNqRy9KUK+D8ZDVukLZ0heJf5yb0zJS
         RYEVwFutiEIKV4gzyrAH16aKgC+baeptvaOLbgsqlKr7BD+E4gE4eEJyX4FxbzHZZXfo
         EglTYBhglXm6bGpqd9UU6i/tT9iV/WO1qBG0WJ7cXMKTVud016+JdWB56Ehy1BLCMg1n
         rxVw==
X-Gm-Message-State: APjAAAW+ZniXk2cl+y9pd4iZ5aXMYXSBGK4ge6ang9C9826e3OIw57yU
        8kVFNgzbt4Q8sBa7h4f877p0g7PpQQ4ZbaeVRhPUWgGY
X-Google-Smtp-Source: APXvYqw6uL3F2QQo+bAo4vfqSBuUwokaYyyUIaJpx7NtHLlbQitOeHCSZDTB0+zJDvG9RCpiVwrnw5YC5Haa2/p/X9c=
X-Received: by 2002:aca:d610:: with SMTP id n16mr1162242oig.108.1582185682580;
 Thu, 20 Feb 2020 00:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20200220010328.10132-1-luiz.dentz@gmail.com> <A50805F7-FFAC-4B0A-B918-E1EA24B115F0@holtmann.org>
In-Reply-To: <A50805F7-FFAC-4B0A-B918-E1EA24B115F0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Feb 2020 00:01:11 -0800
Message-ID: <CABBYNZ+q70NxjP5p2+FUb0KdG2zGu7keC5mro6gOmQAWJjfbOQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix crash when using new BT_PHY option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Feb 19, 2020 at 10:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This fixes the invalid check for connected socket which causes the
> > following trace due to sco_pi(sk)->conn being NULL:
> >
> > RIP: 0010:sco_sock_getsockopt+0x2ff/0x800 net/bluetooth/sco.c:966
> >
> > L2CAP has also been fixed since it has the same problem.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/l2cap_sock.c | 2 +-
> > net/bluetooth/sco.c        | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 9fb47b2b13c9..305710446e66 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -605,7 +605,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> >               break;
> >
> >       case BT_PHY:
> > -             if (sk->sk_state == BT_CONNECTED) {
> > +             if (sk->sk_state != BT_CONNECTED) {
> >                       err = -ENOTCONN;
> >                       break;
> >               }
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 29ab3e12fb46..c8c3d38cdc7b 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -958,7 +958,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> >               break;
> >
> >       case BT_PHY:
> > -             if (sk->sk_state == BT_CONNECTED) {
> > +             if (sk->sk_state != BT_CONNECTED) {
> >                       err = -ENOTCONN;
> >                       break;
> >               }
>
> is there something wrong with your mailer? I have this patch 3 times and already applied one of them to bluetooth-next. Is the one incorrect?

It appears my outbox had the same patch multiple times, sorry about
that the intention was to to send the RFCOMM change and these got in
the way, so please disregard this one.

-- 
Luiz Augusto von Dentz
