Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12D25C6F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383133; cv=pass; b=k+fcnl18SNc38cAApCJuBXSldVnJzjYqPAAHLXtkYKRdGcUieB8b8meU/BRqax9JEY2zcwyBAccUJE8u2hxGw6bDmJS1xZSMyhJaa5xXQbqG4bZ9vbg9Lekqx8yZsAQvWZCOQ8QRPGv0rX95k5Rr821omAXYWf9N7RwdLEsogx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383133; c=relaxed/simple;
	bh=P+vX2P8lPJdnNF9chZAbE7BbVeTgr9H4HyMe6lq/7Yw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClNfsTpps/Yk9tn8N530RjC5MjOS2gLX/YYX4Anex/LOr/0+VPGbxP9HLmlg6OyIPi1iCHJa+b8oD8MH+1BtgOV/u7R/Vn9Defoj6+C9kk3dl/1dcl3XjVY4iCTZLBA8jmWufWmaoxomkkDmyGvMV9fvX5eUWsaLilXLXajPefg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=JOQxCTV1; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="JOQxCTV1"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YtQzP4ywqz49PsT;
	Wed, 12 Feb 2025 19:58:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739383122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fj4F6rNdyM/SDo1ggxnNtIWAr2K2zVNgQ0Ras0J+Yq4=;
	b=JOQxCTV1P4Iej8jN7ZNSIqVI4Q4jZBROXL0UJ5QKAJ01g1KkmDrkfmReCDpQooqqj8UUb3
	X44NxAtSdPc8f7nQK1giiTpp7GXXF3GCg0iRLfTZ/lhQ9DhWbuielKZbr1ZnCQFlFpjY5D
	GDXMAkVpxTDAiLEwc+RcxBLMYYh5knVVup5r24ef41Yd1imrM9E4KEr9eB1Rkg8GXd/qYm
	msMiIyXA/uTaIHv5r1CJa5vGQbf6hjrSoKLS/WTm8LeXq4QYbVWmxEiH/aSfb32LKIibMP
	/XEQZP0frKOT+UtyfgP0rVuTfZUCdDAQNEQcWrqwK77WkBkAOSBknKzbOG2ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739383122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fj4F6rNdyM/SDo1ggxnNtIWAr2K2zVNgQ0Ras0J+Yq4=;
	b=L5+AxnTKvEdWUyIS4lPzGMv5qWR7m6gZHNV2xhUZfyqvQLm7h1uFf8PrvpLm9k0Qya6cct
	X1sGQt2rVmTd7sB3a5vG4UVieR7pCIH5YDw47vUNZz2ZqKvAnvbk2M+x/xtSb6T1UxtCSl
	flNfvw74muPy2X4lR7b41Ptu1OenbCGy6Wcz2dClF9R3CQXAtPLS5a3v8H1kMoPOrBChYI
	sYk5m8In6XPtdwBdfgnl67M1HrMXlx0xsRA0Zo6dyJ6NR092lwWssGwWtAQyRelZjTPp1V
	3FJ+R/7JF/uQUfpmiRb3x8yrfs9sltAa9QsrYN/2NrLti3fm2dk1WQAPvBAfSg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739383122; a=rsa-sha256;
	cv=none;
	b=LWtpgsl8dsVuk4tla69+OnjF+RNHOatuTnKFjzSEOKqvvMTSQwPe4jl9DRrXio0/x7AHYk
	YzyqyMJXYGwZOZjleN9FpPPz51BCJUa3oiNmzyiM+D2qJeX82e37rIvMDJ/oaiE9OOi3ag
	Io5ItOEH3VVgoy0Hv9IQBBr3AMwuizKKISfn3SXNj3HhmhWyGGjC5zW/Jq/Ao0Lipl24sZ
	sSOmb+HmUnFWmvsg3imZ9J6EqhiCYP5LnC3wmCA3eOrbjjYVWivw4EIPIjZsgm7SEjkwx8
	X52hIRKw7aQG7RJg0+/YCbikDMuTMHJlQJZ7JeF6QKp1lSNYofRCmK+PH3y4Hg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <061979dbf449e194965c284ad02ad5a686bcd58f.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with
 TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 12 Feb 2025 19:58:41 +0200
In-Reply-To: <CABBYNZ+TVD7a9+OnN5UjsJHOqvurP3rh4LAYr6NuePfpZiq18g@mail.gmail.com>
References: <cover.1739097949.git.pav@iki.fi>
	 <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
	 <CABBYNZJccrs7n4mK1YYF+SyKG46d2mkmcem_Ayg77nm3FtJ93w@mail.gmail.com>
	 <102f133fbd176f8c4eacc02d837c1ff075648236.camel@iki.fi>
	 <CABBYNZ+TVD7a9+OnN5UjsJHOqvurP3rh4LAYr6NuePfpZiq18g@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-02-10 kello 13:33 -0500, Luiz Augusto von Dentz kirjoitti:

[clip]
> > It's not possible to disable wakeups on POLLERR & POLLHUP:
> >=20
> > https://man.archlinux.org/man/poll.2.en
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/eventpoll.c?h=3Dv6.13&id=3Dffd294d346d185b70e28b1a28abe367bbfe53c04#n23=
91
>=20
> Ah, so that means POLLERR and POLLHUP are always enabled together?

I think the exact statement is that both POLLERR and POLLHUP are always
enabled, no way to disable kernel issuing wakeup on either condition.

> > You could use EPOLLET to only wake up once per event -- but bluez would
> > then still wakeup on the 7.5ms interval. Glib also doesn't use epoll(),
> > so there's more parts of GSource to reimplement, need to poll from
> > separate thread etc., so the implementation gets more complex than
> > here.
> >=20
> > To get something better than the timer-polled version, I think you'd
> > need to add some new flag to kernel for this.
>=20
> Yeah, well I guess that would be even harder if we need to a new flag
> since that would mean we would need to update glib to understand it
> and then bump the dependency of it, or we would have to reimplement
> the whole IO handling to use the non-glib version, the glib way will
> most likely make releases adding a hard dependency for distros and
> reimplementing the whole IO will probably require a lot of work, that
> said Id welcome if we could work in that direction otherwise we need
> another way to track the disconnection of ISO and A2DP streams.

Another alternative here is to go with socket option etc., which we
tried so that works, but maybe needs buy-in from netdev people.

> > > > +       if (watch->tag)
> > > > +               cond =3D g_source_query_unix_fd(&watch->source, wat=
ch->tag);
> > > > +       else
> > > > +               cond =3D 0;
> > > > +
> > > > +       if (cond =3D=3D G_IO_ERR) {
> > > > +               int err, ret;
> > > > +               socklen_t len =3D sizeof(err);
> > > > +
> > > > +               ret =3D getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, =
&len);
> > > > +               if (ret =3D=3D 0 && err =3D=3D 0) {
> > > > +                       g_source_remove_unix_fd(&watch->source, wat=
ch->tag);
> > > > +                       watch->tag =3D NULL;
> > > > +
> > > > +                       /* io_err watches all wake up at the same t=
ime */
> > > > +                       if (!io_err_watch_wakeup)
> > > > +                               io_err_watch_wakeup =3D g_get_monot=
onic_time()
> > > > +                                                               + t=
imeout;
> > > > +
> > > > +                       g_source_set_ready_time(&watch->source,
> > > > +                                                       io_err_watc=
h_wakeup);
> > > > +                       return TRUE;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (g_source_get_ready_time(&watch->source) !=3D -1) {
> > > > +               g_assert(!watch->tag);
> > > > +               io_err_watch_wakeup =3D 0;
> > > > +               watch->tag =3D g_source_add_unix_fd(&watch->source,=
 fd,
> > > > +                                                       watch->even=
ts);
> > > > +               g_source_set_ready_time(&watch->source, -1);
> > > > +       }
> > > > +
> > > > +       cond &=3D watch->events;
> > > > +
> > > > +       if (cond)
> > > > +               return func(watch->io, cond, user_data);
> > > > +       else
> > > > +               return TRUE;
> > > > +}
> > > > +
> > > > +static void io_err_watch_finalize(GSource *source)
> > > > +{
> > > > +       struct io_err_watch *watch =3D (void *)source;
> > > > +
> > > > +       if (watch->tag)
> > > > +               g_source_remove_unix_fd(&watch->source, watch->tag)=
;
> > > > +
> > > > +       g_io_channel_unref(watch->io);
> > > > +}
> > > > +
> > > > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > > > +                                       GIOCondition events,
> > > > +                                       GIOFunc func, gpointer user=
_data,
> > > > +                                       GDestroyNotify notify)
> > > > +{
> > > > +       static GSourceFuncs source_funcs =3D {
> > > > +               .dispatch =3D io_err_watch_dispatch,
> > > > +               .finalize =3D io_err_watch_finalize,
> > > > +       };
> > > > +       GSourceFunc callback =3D (void *)func;
> > > > +       struct io_err_watch *watch;
> > > > +       gint fd;
> > > > +       guint id;
> > > > +
> > > > +       g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
> > > > +       g_return_val_if_fail(events, 0);
> > > > +       g_return_val_if_fail(func, 0);
> > > > +
> > > > +       fd =3D g_io_channel_unix_get_fd(io);
> > > > +
> > > > +       watch =3D (void *)g_source_new(&source_funcs,
> > > > +                                       sizeof(struct io_err_watch)=
);
> > > > +
> > > > +       watch->io =3D g_io_channel_ref(io);
> > > > +       watch->events =3D events;
> > > > +       watch->tag =3D g_source_add_unix_fd(&watch->source, fd, eve=
nts);
> > > > +
> > > > +       g_source_set_name((void *)watch, "io_glib_err_watch");
> > > > +       g_source_set_callback(&watch->source, callback, user_data, =
notify);
> > > > +
> > > > +       if (priority !=3D G_PRIORITY_DEFAULT)
> > > > +               g_source_set_priority(&watch->source, priority);
> > > > +
> > > > +       id =3D g_source_attach(&watch->source, NULL);
> > > > +       g_source_unref(&watch->source);
> > > > +
> > > > +       return id;
> > > > +}
> > > > +
> > > > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, G=
IOFunc func,
> > > > +                                                       gpointer us=
er_data)
> > > > +{
> > > > +       return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, e=
vents,
> > > > +                                                       func, user_=
data, NULL);
> > > > +}
> > > > diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
> > > > new file mode 100644
> > > > index 000000000..1db6fd468
> > > > --- /dev/null
> > > > +++ b/src/shared/io-glib.h
> > > > @@ -0,0 +1,20 @@
> > > > +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> > > > +/*
> > > > + *
> > > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > > + *
> > > > + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserve=
d.
> > > > + *
> > > > + *
> > > > + */
> > > > +
> > > > +#include <glib.h>
> > > > +
> > > > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
> > > > +                               GIOFunc func, gpointer user_data);
> > > > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > > > +                               GIOCondition events, GIOFunc func,
> > > > +                               gpointer user_data,
> > > > +                               GDestroyNotify notify);
> > > > +
> > >=20
> > > Hmm, I think it is probably not a good idea to start using headers
> > > like this, I'd consider just making it return 0 for non-glib.
> >=20
> > Ok.
> >=20
> > > > +bool io_set_use_err_watch(struct io *io, bool err_watch);
> > > > --
> > > > 2.48.1
> >=20
> > --
> > Pauli Virtanen
>=20
>=20
>=20

