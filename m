Return-Path: <cyrus@holtmann.org>
Message-ID: <1349371812.8332.22.camel@novo.hadess.net>
Subject: Re: [PATCH BlueZ] core: Fix walking the list while removing elements
From: Bastien Nocera <hadess@hadess.net>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 04 Oct 2012 19:30:12 +0200
In-Reply-To: <CAKi4VALw4TTh0z3Yppov71Anf4g1sNPnRYaQPouaaiYcEb79_g@mail.gmail.com>
References: <1349370439-6345-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1349370976.8332.21.camel@novo.hadess.net>
	 <CAKi4VALw4TTh0z3Yppov71Anf4g1sNPnRYaQPouaaiYcEb79_g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-10-04 at 14:21 -0300, Lucas De Marchi wrote:
> On Thu, Oct 4, 2012 at 2:16 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Thu, 2012-10-04 at 14:07 -0300, Lucas De Marchi wrote:
> >> -       for (l = device->profiles; l != NULL; l = g_slist_next(l)) {
> >> +       for (l = device->profiles; l != NULL; l = next) {
> >
> > +       for (l = device->profiles; l != NULL; l = l->next) {
> 
> nops. you can't access "l" if it was deleted from the list

Right.

