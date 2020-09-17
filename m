Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3DCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036DC206CA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHzsCq6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgIQRKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgIQRGe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 13:06:34 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E0C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:06:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z26so3248280oih.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEgouR3aTTkFIdM4Xvtxuyazd73zVsUgCpq6GdG2H78=;
        b=gHzsCq6Od2+sEboslx74I8Q6Pr9LR3f/79iJgY3oTzc42b9CN+yrZFDWEU1474nl10
         drjJ+yfxEGtGLIAzTDzA/kvtPQeZBCNmyWSZIsa1CHxmKuNh3OLOC5MTHc1PKI/R21E2
         BSl6s9ZgOg6jghOhIgU3n/aMIof0F9mTLef4dg1kapxqi701iPZOkspnSnCenHfFy+u7
         MXvapWwAz+rYNOvIRBcKbQh+PdoBNi5QRbk2IfnlTTCMiwQYi3+TF2NRxu8vImv22MUw
         nPDpe4guXj3A78dS6Lb+CgFOa52nWckGl1cQtN7k+vFUvNHYcXFChEycHKCHrTwxGRQq
         aLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEgouR3aTTkFIdM4Xvtxuyazd73zVsUgCpq6GdG2H78=;
        b=D3NWtDP4G5aowDw1xysHWBO3rZwzIVw7qOrJr2SsxkcZ2Kz9JHFzo8a8cSJ46SFmbt
         ifDrtdBNIBGVyrlGEYvml80wRfYY5EtgKpROm3nx+XU+uvrfKkfwRCYf4L5Cw4MPmDmb
         072yDiInt9CjpiBAgp41j9jMRgQW+6iFZlbN1Ob10/J5w62BeeGUrDvYkmXmKPzbHujR
         A+6O2QEdRJtPdZnwyyEk9r1pCOaXHHydRP5ZxPInTzBIuZDwW8ddnzKnusL6IXe3vLTH
         9ntXNGfx8DrrC41WzMgC19tfVM+/jZV/0DY7qeHTtoW/EdXmjgsPDn3Mkf5MEnYttKL3
         1hMg==
X-Gm-Message-State: AOAM532Cwy/Az6QdOOY64MAxT8wRfr/64BMVQ/egD4MloFz4ViivhRWT
        8LYWLByX5nfnX+EFyOAPIMNVtresH0dXeI2VAsQ=
X-Google-Smtp-Source: ABdhPJx3Y2WJ3B+7PpdUg/QF9BIgzwfGATccvsB36Zf8jd1+k7xQALiMwweE+DyWdE5gg7A2cMLfcOKaEa2Dq0jv7xA=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr7172607oib.137.1600362392923;
 Thu, 17 Sep 2020 10:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821061643.16278-1-sonnysasaka@chromium.org> <CAO271m=UWgjM1nLWzrwfvG4r3V7c6wdPDJk7EvRtW4cgsLXqhg@mail.gmail.com>
In-Reply-To: <CAO271m=UWgjM1nLWzrwfvG4r3V7c6wdPDJk7EvRtW4cgsLXqhg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Sep 2020 10:06:21 -0700
Message-ID: <CABBYNZLwa74_xP_98vD6SvDu1d+YJ3yC=NxrPLB+SLy5AfwmDw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gatt: StartNotify is not allowed when device is disconnecting
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Joseph Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Sep 16, 2020 at 3:40 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Dear BlueZ maintainers,
>
> Friendly ping to review this patch. Thanks!
>
>
> On Thu, Aug 20, 2020 at 11:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > From: Joseph Hwang <josephsih@chromium.org>
> >
> > This patch fixed a bluetoothd crash in register_notify_cb(). The
> > crash is incurred by an exception that under some situation, a
> > characteristic may be freed when register_notify_cb() is invoked.
> >
> > When a device is disconnecting, the device interface would hold valid
> > for a while until the disconnection procedure between the client and
> > the server is completed. If another process happens to request to start
> > notification of a characteristic on the disconnecting device, it may
> > incur a problem. In this case, the client would still send the
> > StartNotify request since the characteristic object is still valid.
> > However, the characteristic may be freed soon and become invalid
> > when the corresponding callback function is invoked later. This
> > leads to the bluetoothd crash due to the segmentation fault.
> >
> > To handle the exception, if another process requests to start
> > notification when the device is disconnecting, it should reject the
> > request.
> >
> > Tested on Chrome OS that this patch fixes bluetoothd crash in
> > register_notify_cb().
> >
> > ---
> >  src/gatt-client.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > index 20c3fbec2..c706307c7 100644
> > --- a/src/gatt-client.c
> > +++ b/src/gatt-client.c
> > @@ -1545,6 +1545,12 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
> >         const char *sender = dbus_message_get_sender(msg);
> >         struct async_dbus_op *op;
> >         struct notify_client *client;
> > +       struct btd_device *device = chrc->service->client->device;
> > +
> > +       if (device_is_disconnecting(device)) {
> > +               error("Device is disconnecting. StartNotify is not allowed.");
> > +               return btd_error_not_connected(msg);
> > +       }
> >
> >         if (chrc->notify_io)
> >                 return btd_error_not_permitted(msg, "Notify acquired");
> > --
> > 2.26.2
> >

Applied, thanks.


-- 
Luiz Augusto von Dentz
