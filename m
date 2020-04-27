Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC28C4CECD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8A62168B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588010831;
	bh=xpvswZoT3/5BPe21vNik55GkjAcyfPOh7gG/Z8+TIs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OrFw5PAbMs3HJkQBXCXugT41jZUFmY0T+m/Y3QQ73vB9laP5cLnC+UEOzVpxA/aEz
	 u8qmooL5L/6RFSTNLUdTYWItR2KYy/EJDRpbYMwlYJ1ack/rtz9dim58lRS35ZDZ0y
	 Jw5DdKtkDKF0vwcgWP4vN0dPRWiv8I2nBHxpuUQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgD0SHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0SHK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 14:07:10 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDACC206D4;
        Mon, 27 Apr 2020 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588010830;
        bh=xpvswZoT3/5BPe21vNik55GkjAcyfPOh7gG/Z8+TIs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlKgsMUHbRF1+5wF/f4ooPfogNSO86P8Hirrdi2G7A3h3O2RBmBlT2046Emo2YMGR
         UhliW6vqaRgZANd0yDj17sZbyYjs87MU3O7v3cOy+hxAInJCOhVquGeEiCvbjCswGH
         HJMB/tN0HxCx1MimNJ048JS4h0YyEIOX6VvFUpaQ=
Received: by pali.im (Postfix)
        id C971E8A8; Mon, 27 Apr 2020 20:07:07 +0200 (CEST)
Date:   Mon, 27 Apr 2020 20:07:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] device: Fix calling DisconnectProfile DBus call with
 disconnected profile UUID
Message-ID: <20200427180707.62igtkaz255viyj6@pali>
References: <20200426210202.700-1-pali@kernel.org>
 <CABBYNZKJUw2PL3vK5xLq9RDQ+V8sW4D9dP-Eh9m=0SXgChcagQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKJUw2PL3vK5xLq9RDQ+V8sW4D9dP-Eh9m=0SXgChcagQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 27 April 2020 09:37:39 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Sun, Apr 26, 2020 at 2:05 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > When DisconnectProfile is called with disconnected UUID, bluetooth daemon
> > often returned error "Operation already in progress". This change fixed it
> > and no error message is returned for this case.
> > ---
> >  src/device.c  | 5 +++++
> >  src/service.c | 3 ++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 149c45160..229579378 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -2054,6 +2054,9 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
> >         if (dev->disconnect)
> >                 return btd_error_in_progress(msg);
> >
> > +       if (btd_service_get_state(service) == BTD_SERVICE_STATE_DISCONNECTED)
> > +               return dbus_message_new_method_return(msg);
> > +
> >         dev->disconnect = dbus_message_ref(msg);
> >
> >         err = btd_service_disconnect(service);
> > @@ -2065,6 +2068,8 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
> >
> >         if (err == -ENOTSUP)
> >                 return btd_error_not_supported(msg);
> > +       else if (err == -EALREADY)
> > +               return dbus_message_new_method_return(msg);
> >
> >         return btd_error_failed(msg, strerror(-err));
> >  }
> > diff --git a/src/service.c b/src/service.c
> > index c14ee0aca..e4d747a6e 100644
> > --- a/src/service.c
> > +++ b/src/service.c
> > @@ -281,8 +281,9 @@ int btd_service_disconnect(struct btd_service *service)
> >         case BTD_SERVICE_STATE_UNAVAILABLE:
> >                 return -EINVAL;
> >         case BTD_SERVICE_STATE_DISCONNECTED:
> > -       case BTD_SERVICE_STATE_DISCONNECTING:
> >                 return -EALREADY;
> > +       case BTD_SERVICE_STATE_DISCONNECTING:
> > +               return 0;
> 
> Have you checked if there are no side effects of this change? Since
> you have a call to btd_service_get_service I wonder if this is really
> necessary or you want to change the behavior to not return an error
> even in case of disconnecting state? But even in that case you are
> checking if for -EALREADY and returning no error.

Same logic is used in btd_service_connect() function. When service is in
disconnecting state then it will receive state change to disconnected.
So returning zero is should same as issuing disconnect request again.

> >         case BTD_SERVICE_STATE_CONNECTING:
> >         case BTD_SERVICE_STATE_CONNECTED:
> >                 break;
> > --
> > 2.20.1
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
