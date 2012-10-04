Return-Path: <cyrus@holtmann.org>
Message-ID: <1349370976.8332.21.camel@novo.hadess.net>
Subject: Re: [PATCH BlueZ] core: Fix walking the list while removing elements
From: Bastien Nocera <hadess@hadess.net>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 04 Oct 2012 19:16:16 +0200
In-Reply-To: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-10-04 at 14:07 -0300, Lucas De Marchi wrote:
> -       for (l = device->profiles; l != NULL; l = g_slist_next(l)) {
> +       for (l = device->profiles; l != NULL; l = next) {

+       for (l = device->profiles; l != NULL; l = l->next) {

>                 struct btd_profile *profile = l->data;
>                 GSList *probe_uuids;
>  
> +               next = l->next; 

Remove.

