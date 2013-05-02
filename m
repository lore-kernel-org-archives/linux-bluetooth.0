Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 May 2013 09:05:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 01/16] attrib: Get rid of gint
Message-ID: <20130502060551.GA2813@x220.P-661HNU-F1>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
 <20130501061016.GA13611@x220.P-661HNU-F1>
 <CAKi4VA+SATC3_SU+jyBsRzUW=+WOh9Tkizu0EhmZ99nApWHUdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VA+SATC3_SU+jyBsRzUW=+WOh9Tkizu0EhmZ99nApWHUdg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, May 01, 2013, Lucas De Marchi wrote:
> On Wed, May 1, 2013 at 3:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Lucas,
> >
> > On Wed, May 01, 2013, Lucas De Marchi wrote:
> >> Use plain int instead of gint. In glib gint is always a typedef to int,
> >> so it's safe to use it even for callbacks with glib.
> >> ---
> >>
> >> v2: Fix commit message
> >>
> >>  attrib/gatt-service.c | 2 +-
> >>  attrib/gatt.c         | 2 +-
> >>  attrib/gattrib.c      | 6 +++---
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > All patches in this set have been applied. Thanks.
> >
> > Johan
> 
> Did you forget or you didn't apply the gchar->char patch set before
> this one on purpose?

I just missed the other one. It's now also pushed upstream.

Johan
