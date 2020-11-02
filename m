Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108BBC00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970720756
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 21:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey8R9GBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBVH0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBVH0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 16:07:26 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90F2C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 13:07:25 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m8so10538857ljj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 13:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBLu0vM655XowNrIyRKKleuRbrL4Z0mxVWraxuQk1yA=;
        b=Ey8R9GBeMQRSQXCV7WOS0TyN0sjwxNl39cNnYamkmGtpS35j79toOPoLwxpel4OadD
         jQ2aDmeGzGRC0wjM/I2B4X1PzuorXgAT5gvr4CqTIJjsjyLpqKMr1biHUmB5HnATMN5G
         haCg3I7SjYEWB9/YF4ZNFr8axiHHTGjowSrhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBLu0vM655XowNrIyRKKleuRbrL4Z0mxVWraxuQk1yA=;
        b=i6fj2elJAZDHn6RI4kE72Viuh3247+Bp7yv2WXGAU6ohFHCIM70xkGscpx5wUrDRJI
         SHWk0tfC8ap40L9Kh9UnpRG6bVvkCX60smXHWicWlRpdz17F002JcHlEP2FeV90Rigx5
         RGwpvSBJYDqoKjX9KT7wqW8fqiV/RqQhges7kjb1Cw0aMMPk76vIQQdOeEM7jssrz7tb
         kyRtL0Vf9OSvZouxkYQo4fscU31y9g5+Xwmywt60vku9Y435p86Hwfg4bxUJp6ltaA4F
         nMAdzJcNOXHpmcHk9YM8VASbISLE7Kzcosm/dCgAXfxltYIyUtVoCjiITlbn3bGxk/9i
         KQEg==
X-Gm-Message-State: AOAM532Q8ogjqMusAupPpUtNYwhGolmTb1mPIVxM+LdebYBgZlDx7QZM
        p+JWGvuLEy8UvWDZlJEp0G5xHFhwLqTK+l68NHarPA==
X-Google-Smtp-Source: ABdhPJyk+Y1AidWbaoUrv1tOnX9D6xA5iSe7UzSinHn+89wgaa6Q4lvTCG8izIuq15OP/ngdK3KC/n+aUC1GCGoyW8I=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr7586111ljg.333.1604351244205;
 Mon, 02 Nov 2020 13:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20201030160833.BlueZ.v1.1.Ia45f3edc48142d9db0dc4b315c84ab60a149697f@changeid>
 <CABBYNZKck6MFew6r-pEJgh2CLWUNmrKf4KO5z-nzBVJUBVcSmQ@mail.gmail.com>
In-Reply-To: <CABBYNZKck6MFew6r-pEJgh2CLWUNmrKf4KO5z-nzBVJUBVcSmQ@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 2 Nov 2020 13:07:13 -0800
Message-ID: <CABmPvSHL=AMuvZuECQax3Jv3ds4NngVn_V_qcL0oxCwG424ByQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Fix a crash caused by lingering
 discovery client pointer
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, Oct 30, 2020 at 4:48 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao-chen,
>
> On Fri, Oct 30, 2020 at 4:13 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > This cleans up the lingering pointer, adapter->client, during powering
> > off the adapter. The crash occurs when a D-Bus client set Powered
> > property to false and immediately calls StopDiscovery() when there is
> > ongoing discovery. As a part of powering off the adapter,
> > adapter->discovery_list gets cleared, and given that adapter->client
> > refers to one of the clients in adapter->discovery_list, adapter->client
> > should be cleared along with it.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> >  src/adapter.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index c0053000a..74bfb0448 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -1507,8 +1507,10 @@ static void discovery_free(void *user_data)
> >                 client->discovery_filter = NULL;
> >         }
> >
> > -       if (client->msg)
> > +       if (client->msg) {
> >                 dbus_message_unref(client->msg);
> > +               client->msg = NULL;
> > +       }
>
> This shouldn't make any difference as the whole list is freed and so
> is the client.
Please see my below reply.
>
> >
> >         g_free(client->owner);
> >         g_free(client);
> > @@ -5301,6 +5303,19 @@ static void free_service_auth(gpointer data, gpointer user_data)
> >
> >  static void remove_discovery_list(struct btd_adapter *adapter)
> >  {
> > +       DBusMessage *msg;
> > +
> > +       if (adapter->client) {
> > +               msg = adapter->client->msg;
> > +               if (msg) {
> > +                       g_dbus_send_message(dbus_conn, btd_error_busy(msg));
> > +                       dbus_message_unref(msg);
> > +                       adapter->client->msg = NULL;
> > +               }
> > +
> > +               adapter->client = NULL;
>
> Shouldn't you call discovery_free as well here? Or perhaps we could
> move the lines above inside discovery_free so it detects if the
> adapter->client is pointing to a client that is being freed.
>
discovery_free are done in the following lines, so there is no need to
call discovery_free() for a referencing pointer, adapter->client. It's
a good point to move it so discovery_free() instead.
> > +       }
> > +
> >         g_slist_free_full(adapter->set_filter_list, discovery_free);
> >         adapter->set_filter_list = NULL;
> >
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz

Regards,
Miao
