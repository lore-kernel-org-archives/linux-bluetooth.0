Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Nov 2011 13:44:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mika Linnanoja <mika.linnanoja@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Radoslaw Jablonski <radoslawjablonski@gmail.com>,
	michalski.raf@gmail.com
Subject: Re: [PATCH obexd 1/1] Fix missing URL vCard's field with OTHER
 subtype
Message-ID: <20111110114425.GA10257@fusion.localdomain>
References: <1320415251-10350-1-git-send-email-radoslawjablonski@gmail.com>
 <1320415251-10350-2-git-send-email-radoslawjablonski@gmail.com>
 <CAFy0spsO_9khjOA=-KYxhZBAwJya_bAYx4jqVf=f=fJxD+hRcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAFy0spsO_9khjOA=-KYxhZBAwJya_bAYx4jqVf=f=fJxD+hRcA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mika,

On Thu, Nov 10, 2011, Mika Linnanoja wrote:
> On Fri, Nov 4, 2011 at 4:00 PM, Radoslaw Jablonski
> <radoslawjablonski@gmail.com> wrote:
> > From: Rafal Michalski <michalski.raf@gmail.com>
> >
> > Previously URL vCard's field (imported with default OTHER subtype) was
> > missing after pulling entire phonebook or single vCard (for phonebook
> > and each call history as well).
> > This patch fixes that issue by adjusting queries to URL field.
> > ---
> >  plugins/phonebook-tracker.c |   10 ++++------
> >  1 files changed, 4 insertions(+), 6 deletions(-)
> 
> Anybody any comments to this patch? It's well tested to work (is
> anything else using phonebook-tracker than N9?).

I had just missed it. It has now been pushed upstream. Thanks.

Johan
