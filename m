Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E61FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiESULG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbiESULD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 16:11:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF437A9F
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:11:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w17-20020a17090a529100b001db302efed6so6167248pjh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqNnxwHUF2vIG80fm9H283NXSVlNrFJ9/fZa8sWn2Xg=;
        b=R8fgU3KdiaVJBbqUn+cONpWzaEx8TGxhLyWjB/40M61FQfHkWu6LuEOY5OXfQ5tKFF
         E/KACAQUWai6LJIkYkSkYfZc1h8xK3LyfYveJXiK83aVfJHeK1vb0Vx1oscEQRykoiNF
         Lj3qShFbEOT/5IpYKN8NvEY4rKXkwcKe/mr5n65Vw6xuMAQMyEBxjFr9xWnYr7AueG+l
         ZpVjfbvlF0i0LkktBvTPt28jiXmyQUEJ2K3u3Z3mL7pD5UU14VaAdapIhWHLo0UBdluR
         VN9U0Uhz+eb83I/mjwaJL2a+5jtjbofTJ/qv1+mbcD8wyi1hHaSmnpULXmuuZDvOmDfz
         bB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqNnxwHUF2vIG80fm9H283NXSVlNrFJ9/fZa8sWn2Xg=;
        b=L/2lDIZDGPjnbTrRqLAk9/YWv+ws9PP/t9tH9Lqd/OY8KNGX6uaVzRfSZ2PBnzAZrD
         6pZBs0cv22ayNMuxZmpFGkq4oonkWsQWd9Za4XzUYBK9biU0kbqARtSGawiAAHrCbYEl
         x/+L0z8eztCCaDeh7Dj0PF+ZpIZSl2SKqUpmqXrzGkKG55Jm4CmTRDvmdyIcm9MXJcLQ
         uEY1AgS9Btui5OBUuUM62fkyINsWZeLslzvexfxJk00vxT+OLT8DmtWmOZRddtFkrEeC
         pP5EOPTvb/3s3p8+43j7eviBccJTK51ijtoKSrEgdMvDNVcXmSKl8e7dqsmcUgkZpdJK
         6cEg==
X-Gm-Message-State: AOAM5333qXRM8xyAikD/XWub9ULAAO96j5jq/Pvxvi4XqOH+hOjEsHK/
        8l2ggL45R3Hd1d44KhxkbEUblLaelUXRwrFs6Zi6uJqR
X-Google-Smtp-Source: ABdhPJwlezn9AiB/O1v8UDhhXzRQMkz5dln9N3IrGMzKrrewODpyboX/G/dh+DLDpE/3l/GZpECFr5XsCa8ntr6LuY0=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr6445261plx.34.1652991061858; Thu, 19
 May 2022 13:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220513235125.1364692-1-luiz.dentz@gmail.com>
 <20220513235125.1364692-3-luiz.dentz@gmail.com> <6A7CED55-0DC1-48F1-95FF-A1B2ED3B280C@holtmann.org>
In-Reply-To: <6A7CED55-0DC1-48F1-95FF-A1B2ED3B280C@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 May 2022 13:10:50 -0700
Message-ID: <CABBYNZKFy3JqXBsvqu7jp+NuZ8riJWtsznNEiqJqGbkyvSOkVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, May 19, 2022 at 11:08 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > The handling of connection failures shall be handled by the request
> > completion callback as already done by hci_cs_le_create_conn, also make
> > sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> > don't actually call hci_conn_del to cleanup.
> >
> > Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_conn.c  | 5 +++--
> > net/bluetooth/hci_event.c | 8 +++++---
> > 2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 4a5193499b77..a36297368c58 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
> >
> >       bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
> >
> > -     if (!conn)
> > +     /* Check if connection is still pending */
> > +     if (conn != hci_lookup_le_connect(hdev))
> >               goto done;
> >
> > -     hci_le_conn_failed(conn, bt_status(err));
> > +     hci_conn_failed(conn, bt_status(err));
> >
> > done:
> >       hci_dev_unlock(hdev);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 0270e597c285..af17dfb20e01 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> >               status = HCI_ERROR_INVALID_PARAMETERS;
> >       }
> >
> > -     if (status) {
> > -             hci_conn_failed(conn, status);
> > +     /* All connection failure handling is taken care of by the
> > +      * hci_conn_failed function which is triggered by the HCI
> > +      * request completion callbacks used for connecting.
> > +      */
> > +     if (status)
> >               goto unlock;
> > -     }
> >
> >       if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
> >               addr_type = BDADDR_LE_PUBLIC;
>
> can apply this patch alone and push it to -stable?

Sure, but note that it is using bt_status so perhaps I can rebase it
to stop using bt_status first?

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
