Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Nov 2010 19:08:48 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 00/20] Simple SMP Just Works implementation
Message-ID: <20101124210848.GC2592@vigoh>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
 <20101124054211.GI874@null>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101124054211.GI874@null>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2010-11-24 07:42:11 +0200]:

> Hi,
> 
> 
> On Tue, Nov 23, 2010 at 12:06:16PM -0300, ext Vinicius Costa Gomes wrote:
> > Hi,
> > 
> > This is an implementation of the Just Works SMP procedure, on top of the work
> > done by Ville (included in this series to give some context). The SMP stuff
> > starts at 11/20.
> > 
> > The most important thing about this series is the discussion that (I hope)
> > it will cause.
> > 
> > Some things that I would like to point (in no order):
> > 
> > - the SMP function names follow the spec nomeclature, would it be better to
> >   use more meaningful names?
> > 
> > - the crypto transform is allocated during the adapter registration, is this
> >   the best place to do this?
> > 
> > - renaming l2cap.c to l2cap_core.c was the only way we could find to keep the
> >   SMP implementation separated from the "core" l2cap.
> 
> Gustavo do you have something against this change?

I'm ok with this change.

-- 
Gustavo F. Padovan
http://profusion.mobi
