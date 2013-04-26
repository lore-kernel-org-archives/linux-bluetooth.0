Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1366957043-2383-13-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1366957043-2383-13-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 26 Apr 2013 07:48:32 -0400
Message-ID: <CAJdJm_OqM0w78sFzVtS5aOcvRDS0jZp9G2TqWVw3OHX=jGjETw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 12/27] device: Use btd_service to represent profiles
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Apr 26, 2013 at 2:17 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
> +{
> +       GSList *l;
> +
> +       for (l = list; l != NULL; l = g_slist_next(l)) {
> +               struct btd_service *service = l->data;
> +
> +               if (btd_service_get_profile(service) == p)
> +                       return l;

Why you don't return service directly here? It should avoid the caller
having to do "service = l->data;".

Another option: you could try using g_slist_find_custom() on the
callers and turn this into a comparison callback for it.

> +       }
> +
> +       return NULL;
> +}

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
