Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEE224B01
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jun 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027850; cv=none; b=ImoW97DWTRFx4bYqIHbaH7Iw1Bo4ipR6hSJ3B8Sp8uQq31UkVExekKJDfj9E4CkITwLo1bWb0XLSAnoL93syOtW8warBfggZh0rGnm+LtC3eyiOZGOiJFaR/fxFMIfeS+FrfZOfQmfMRZxlEa0d3RZdZXZPewtagyWxLA9kYk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027850; c=relaxed/simple;
	bh=AogfzXuDey045VXDxgiFd8Hr0Kqk2qrnE3b2zhEdLAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV1FSVi8K3Dd4wJ9dd+IB6b/687HtprSe6D2Kz+quM4DvYzZVzIQyXdb/N3ogipGhSFpW22HrKdvYI/goaIz6uckE4mHPrHAJTt8EWV4OadoAwrTj8POXopvbggPN648cIQWdzUEpJknGBohT01r8Dy1IftKU6kKmQXqejTL5h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.0.1.b.8.8.6.e.3.0.e.e.8.5.9.9.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:9958:ee03:e688:b10f] helo=andrews-2024-laptop.sayers)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMk2U-003Kye-1v;
	Wed, 04 Jun 2025 10:04:02 +0100
Date: Wed, 4 Jun 2025 10:03:31 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi,
	frederic.danis@collabora.com
Subject: Re: [PATCH BlueZ 1/3] obexd: Pass at_(un)register value to logind
 callbacks
Message-ID: <aEAL4wsfqR44Z-Vt@andrews-2024-laptop.sayers>
References: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
 <20250603151651.1080923-2-kernel.org@pileofstuff.org>
 <CABBYNZ+FgroEZmbj1SoBGfJrMscMeAkC-Z9==h0H30mrFVk0GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+FgroEZmbj1SoBGfJrMscMeAkC-Z9==h0H30mrFVk0GQ@mail.gmail.com>

On Tue, Jun 03, 2025 at 12:01:08PM -0400, Luiz Augusto von Dentz wrote:
> Hi Andrew,
> 
> On Tue, Jun 3, 2025 at 11:17 AM Andrew Sayers
> <kernel.org@pileofstuff.org> wrote:
> >
> > Logind (un)registers callbacks that it calls when the user's state changes.
> > Callbacks may also be called during (un)registration.
> > Clients may need to handle those initial/final calls specially.
> >
> > Pass an argument indicating whether this is being called during
> > (un)registration, and modify existing callbacks to ignore that argument.
> >
> > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > ---
> >  obexd/client/pbap.c       |  6 ++++--
> >  obexd/plugins/bluetooth.c |  6 ++++--
> >  obexd/src/logind.c        | 14 +++++++-------
> >  obexd/src/logind.h        |  8 ++++----
> >  4 files changed, 19 insertions(+), 15 deletions(-)
> >
> > diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> > index 51b523592..64bb8ff72 100644
> > --- a/obexd/client/pbap.c
> > +++ b/obexd/client/pbap.c
> > @@ -1455,8 +1455,9 @@ static struct obc_driver pbap = {
> >         .remove = pbap_remove
> >  };
> >
> > -static int pbap_init_cb(void)
> > +static int pbap_init_cb(gboolean at_register)
> >  {
> > +       (void)at_register;
> >         int err;
> >
> >         DBG("");
> > @@ -1482,8 +1483,9 @@ static int pbap_init_cb(void)
> >         return 0;
> >  }
> >
> > -static void pbap_exit_cb(void)
> > +static void pbap_exit_cb(gboolean at_unregister)
> >  {
> > +       (void)at_unregister;
> >         DBG("");
> >
> >         g_dbus_remove_watch(system_conn, listener_id);
> > diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> > index 7ff27a8a8..ad37e636d 100644
> > --- a/obexd/plugins/bluetooth.c
> > +++ b/obexd/plugins/bluetooth.c
> > @@ -427,8 +427,9 @@ static const struct obex_transport_driver driver = {
> >
> >  static unsigned int listener_id = 0;
> >
> > -static int bluetooth_init_cb(void)
> > +static int bluetooth_init_cb(gboolean at_register)
> >  {
> > +       (void)at_register;
> >         connection = g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
> >         if (connection == NULL)
> >                 return -EPERM;
> > @@ -439,8 +440,9 @@ static int bluetooth_init_cb(void)
> >         return obex_transport_driver_register(&driver);
> >  }
> >
> > -static void bluetooth_exit_cb(void)
> > +static void bluetooth_exit_cb(gboolean at_unregister)
> >  {
> > +       (void)at_unregister;
> >         GSList *l;
> >
> >         g_dbus_remove_watch(connection, listener_id);
> > diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> > index a0eb62b1e..b4279b209 100644
> > --- a/obexd/src/logind.c
> > +++ b/obexd/src/logind.c
> > @@ -43,13 +43,13 @@ static void call_init_cb(gpointer data, gpointer user_data)
> >  {
> >         int res;
> >
> > -       res = ((struct callback_pair *)data)->init_cb();
> > +       res = ((struct callback_pair *)data)->init_cb(FALSE);
> >         if (res)
> >                 *(int *)user_data = res;
> >  }
> >  static void call_exit_cb(gpointer data, gpointer user_data)
> >  {
> > -       ((struct callback_pair *)data)->exit_cb();
> > +       ((struct callback_pair *)data)->exit_cb(FALSE);
> >  }
> >
> >  static int update(void)
> > @@ -229,7 +229,7 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
> >         struct callback_pair *cbs;
> >
> >         if (!monitoring_enabled)
> > -               return init_cb();
> > +               return init_cb(TRUE);
> >         if (callbacks == NULL) {
> >                 int res;
> >
> > @@ -237,23 +237,23 @@ int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
> >                 if (res) {
> >                         error("logind_init(): %s - login detection disabled",
> >                                 strerror(-res));
> > -                       return init_cb();
> > +                       return init_cb(TRUE);
> >                 }
> >         }
> >         cbs = g_new(struct callback_pair, 1);
> >         cbs->init_cb = init_cb;
> >         cbs->exit_cb = exit_cb;
> >         callbacks = g_slist_prepend(callbacks, cbs);
> > -       return active ? init_cb() : 0;
> > +       return active ? init_cb(TRUE) : 0;
> >  }
> >  void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
> >  {
> >         GSList *cb_node;
> >
> >         if (!monitoring_enabled)
> > -               return exit_cb();
> > +               return exit_cb(TRUE);
> >         if (active)
> > -               exit_cb();
> > +               exit_cb(TRUE);
> >         cb_node = g_slist_find_custom(callbacks, init_cb, find_cb);
> >         if (cb_node != NULL)
> >                 callbacks = g_slist_delete_link(callbacks, cb_node);
> > diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> > index eb3ff8d7b..3cdb03338 100644
> > --- a/obexd/src/logind.h
> > +++ b/obexd/src/logind.h
> > @@ -8,8 +8,8 @@
> >   *
> >   */
> >
> > -typedef int (*logind_init_cb)(void);
> > -typedef void (*logind_exit_cb)(void);
> > +typedef int (*logind_init_cb)(gboolean at_register);
> > +typedef void (*logind_exit_cb)(gboolean at_unregister);
> >
> >  #ifdef SYSTEMD
> >
> > @@ -22,12 +22,12 @@ int logind_set(gboolean enabled);
> >  static inline int logind_register(logind_init_cb init_cb,
> >                                         logind_exit_cb exit_cb)
> >  {
> > -       return init_cb();
> > +       return init_cb(TRUE);
> >  }
> >  static inline void logind_unregister(logind_init_cb init_cb,
> >                                         logind_exit_cb exit_cb)
> >  {
> > -       return exit_cb();
> > +       return exit_cb(TRUE);
> >  }
> >  static inline int logind_set(gboolean enabled)
> >  {
> > --
> > 2.49.0
> 
> This is not going very well in my opinion, it looks like we missed the
> opportunity to integrate the logind directly into obc_driver so we
> don't have to duplicate code for each coded, so we keep just doing
> plugin_init->obc_driver_register/plugin_exit->obc_driver_unregister
> and that internally can detect when it shall be registered with the
> Bluetoothd, etc, plugin_exit->obc_driver_unregister can actually be
> assumed to be exit rather than just D-Bus unregister which happens
> when seat is not longer active.
> 
> -- 
> Luiz Augusto von Dentz
> 

If I understand correctly, you want something like this:

 static struct obc_driver pbap = {
 	.service = "PBAP",
 	.uuid = PBAP_UUID,
 	.target = OBEX_PBAP_UUID,
 	.target_len = OBEX_PBAP_UUID_LEN,
 	.supported_features = pbap_supported_features,
 	.probe = pbap_probe,
 	.remove = pbap_remove,
+ 	.seated = pbap_seated,
+ 	.unseated = pbap_unseated
 };

That's fine, but it sounds like version 2.  Would it be better to get this
bugfix ready to commit first, then talk about architecture in another thread?
I only see a couple of mistakes from bluez test bot (both "mixed declarations
and code"), but the new architecture will take a lot of work and may not be
right first time.  Having a commit with no known bugs will make bisecting
easier, and having a fix out sooner will help users.

As an example of the problems to discuss in version 2 - bluetooth.c uses
obex_transport_driver instead of obc_driver, so the changes would need to go there too.  
Getting that right will take more time and discussion, and could lead to some knock-on
change that adds more again.
