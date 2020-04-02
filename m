Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94B0C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DBD20719
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 07:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOCQkXiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbgDBHzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:55:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39262 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387599AbgDBHzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 03:55:43 -0400
Received: by mail-il1-f195.google.com with SMTP id r5so2691823ilq.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2020 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA3S/DF/tIo6k1ooptSuMP1zDHNEY7uAXFfjKrD4uyE=;
        b=VOCQkXiSKlFEl5yU+Uw9/eNG4JKkGsPDY0mDHoS1bJtbda3I3CPMM3df6YaN/10Lz/
         VwwuAq9P0Ya9+42dLhbIatH77H/suPG+exFWTAFwjOAwYkIyEz3FxM8I3RXXKl4L4+V+
         6MPbnfmfM+7xhvm14gKYHqxMzrExRFgXAWnTeO/lbQAgyrF45z6YsdW+kwS+ND9PibAS
         fJUvBjRA++ukEkGS7asbAN/KXEOgIM13rwkdqvu78yDeHCLosyXTpVHTzPNBc/58RaEc
         uBxtLhYzpD/jOkj9ykklDyOhr+/W0dgaKG8gma1p6fCKxmT/PKQ0QKQVwTdCJ++OqlMf
         +zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA3S/DF/tIo6k1ooptSuMP1zDHNEY7uAXFfjKrD4uyE=;
        b=tN7QOdrWERKnU/eB6/LDBjuHKPzCvEK0d2X91pZbOqHuxqlqJYxKGqHuDu5wWIc1y/
         EvURjEmAe+ONsNdqLbSZj10Ap0jLp2hXueu86uu02IWHP4xzjGipD4ODiDgnqCPrwgAC
         oDxZD4lOKOWH7CTB+WNirL0A2ud/nertFgwChxPs+RER7yoYBQSqeBhz1XPg0a8x4JIE
         +r03gvfKNHuOk921zg2GoGxwtKjrNismokYzb8GahnJ29DcpLglf2LyL+s7Drdo4ORf+
         nfV3iLSA6ugY8tM7acnlpzSiWYbAhQIkhkeCO2CF/Vctirwvekj5ifgBcTTO7hbI15pp
         a1AA==
X-Gm-Message-State: AGi0PubTf2S+IrxIteVLTLmGEFZQui/8ZAUTEwMFfXBv0KruvWfuqyvW
        ohwFeY/gzpmW42qrjZ2Mtw/E3dvRbnZ8rHgiYh0=
X-Google-Smtp-Source: APiQypJDqIFJ/2+NS8zz2oI3dMu6wPcoyxCdN1Miti6ZnAgenZqQWy+YLzplJnClshbu3q/L+T1gPvoLdFV0jSQUJK8=
X-Received: by 2002:a92:9fd0:: with SMTP id z77mr1992287ilk.257.1585814142421;
 Thu, 02 Apr 2020 00:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191129121042.3311-1-sathish.narasimman@intel.com> <D31F831A-84EE-4678-A1C6-421BEB8D1244@holtmann.org>
In-Reply-To: <D31F831A-84EE-4678-A1C6-421BEB8D1244@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 2 Apr 2020 13:25:30 +0530
Message-ID: <CAOVXEJ+1AJm7krA-nFwK50aWnkM+zT+Y7H+Z4pahzO7ayP=9=w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] bluetooth: add support to notify SCO air mode
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Sat, Jan 4, 2020 at 3:38 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Satish,
>
> > notifying HCI_NOTIFY_CONN_ADD for SCO connection is generic in
> > case of msbc audio. To differnetiate SCO air mode audio introducing
> > HCI_NOTIFY_SCO_CVSD and HCI_NOTIFY_SCO_TRASP.
> >
> > Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> > ---
> > include/net/bluetooth/hci.h      |  3 +++
> > include/net/bluetooth/hci_core.h |  3 +++
> > net/bluetooth/hci_conn.c         | 19 +++++++++++++++----
> > net/bluetooth/hci_event.c        |  9 +++++++++
> > 4 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 5bc1e30dedde..bfaaef1aa4d6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -52,6 +52,9 @@
> > #define HCI_NOTIFY_CONN_ADD           1
> > #define HCI_NOTIFY_CONN_DEL           2
> > #define HCI_NOTIFY_VOICE_SETTING      3
> > +#define HCI_NOTIFY_ENABLE_SCO_CVSD   4
> > +#define HCI_NOTIFY_ENABLE_SCO_TRANSP 5
> > +#define HCI_NOTIFY_DISABLE_SCO               6
> >
> > /* HCI bus types */
> > #define HCI_VIRTUAL   0
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index b689aceb636b..9258e19f8cc5 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> > #define SCO_AIRMODE_CVSD       0x0000
> > #define SCO_AIRMODE_TRANSP     0x0003
> >
> > +#define SCO_CODED_CVSD         0x02
> > +#define SCO_CODED_TRANSP       0x03
> > +
>
> why is this needed. And more important, what is wrong with SCO_AIRMODE_CVSD above?
>
AFAIK the above is voice settings param (core spec 5.0, Vol 2, Part E,
6.12) which is used to set the sco pkt type.
This patch is to notify the btusb layer. when we receive
sync_conn_complete_evt based on the AIR_MODE we receive
SCO_CODED_CVSD and SCO_CODED_TRANSP are used to choose alt_setting.
air_mode value we receive are 1 byte
whereas voice setting param is 2 bytes and are different for CVSD

> > #endif /* __HCI_CORE_H */
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 87691404d0c6..097a179418d6 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -122,8 +122,13 @@ static void hci_conn_cleanup(struct hci_conn *conn)
> >
> >       hci_conn_hash_del(hdev, conn);
> >
> > -     if (hdev->notify)
> > -             hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> > +     if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_DISABLE_SCO);
> > +     } else {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
> > +     }
> >
> >       hci_conn_del_sysfs(conn);
> >
> > @@ -561,8 +566,14 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> >       hci_dev_hold(hdev);
> >
> >       hci_conn_hash_add(hdev, conn);
> > -     if (hdev->notify)
> > -             hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
> > +
> > +     /* As HCI_NOTIFY_ENABLE_SCO_CVSD & HCI_NOTIFY_ENABLE_SCO_TRANSP is
> > +      * used to notify SCO connections during sync_conn_complete event
> > +      */
> > +     if (conn->type != SCO_LINK && conn->type != ESCO_LINK) {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
> > +     }
> >
> >       hci_conn_init_sysfs(conn);
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index c1d3a303d97f..ecad696db139 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
> >               break;
> >       }
> >
> > +     BT_DBG("sco connected with air mode: %02x", ev->air_mode);
> > +     if (ev->air_mode == SCO_CODED_CVSD) {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
> > +     } else if (ev->air_mode == SCO_CODED_TRANSP) {
> > +             if (hdev->notify)
> > +                     hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
> > +     }
> > +
>
> You are however forgetting the old hci_conn_complete for legacy SCO setup.
Will fix this and update in next version
>
> Regards
>
> Marcel
>
