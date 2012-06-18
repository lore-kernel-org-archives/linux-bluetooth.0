Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jun 2012 17:34:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: add macro for methods marked as NOREPLY
Message-ID: <20120618143417.GA12325@x220.P-661HNU-F1>
References: <1337612075-2697-1-git-send-email-lucas.demarchi@profusion.mobi>
 <CAMOw1v4bP74N9ugbQ5RuFbnw_k8JUp7fRkQ+79TvQa0qpRN-ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMOw1v4bP74N9ugbQ5RuFbnw_k8JUp7fRkQ+79TvQa0qpRN-ZA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, May 23, 2012, Lucas De Marchi wrote:
> On Mon, May 21, 2012 at 11:54 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
> > ---
> >
> > This one is not used in BlueZ, but it was necessary for other projects using
> > gdbus. It's better to keep them in sync.
> >
> >  gdbus/gdbus.h |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> > index e2e160d..0a8a27c 100644
> > --- a/gdbus/gdbus.h
> > +++ b/gdbus/gdbus.h
> 
> This one is still missing in BlueZ, neard and ConnMan.

Applied to bluez.git and obexd.git.

Johan
