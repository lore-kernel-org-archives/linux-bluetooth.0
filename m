Return-Path: <cyrus@holtmann.org>
Message-ID: <1357615440.1806.21.camel@aeonflux>
Subject: Re: [PATCH 1/2] audio: Replace g_hash_table_contains() with
 g_hash_table_lookup()
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	Ludek Finstrle <luf@pzkagis.cz>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 07 Jan 2013 19:24:00 -0800
In-Reply-To: <CABBYNZ+0H3t-jwbp_-iUeFw2NOqXuWmwBiw8xjqP5bx6D7gomQ@mail.gmail.com>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
	 <20130107131215.GC914@pzkagis.cz>
	 <39D5295DD81346F9A6FC2AFB8D19919F@sisodomain.com>
	 <CABBYNZ+0H3t-jwbp_-iUeFw2NOqXuWmwBiw8xjqP5bx6D7gomQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

<snip>

> > I think
> > return g_hash_table_lookup(mp->settings, property->name) ? TRUE : FALSE;
> > would be better?
> 
> Shorter form is  != NULL, so lets go with it, still haven't figure out
> why we didn't bring back glib-compat for such functions, when we
> finally upgrade it will take much more time to revert this one by one.

we could bring glib-compat back, but right now I do not want to
introduce more autoconf magic to do so.

I would require the latest GLib version (or at least a bit newer one) if
they wouldn't just start introducing new dependencies all the time.

Regards

Marcel


