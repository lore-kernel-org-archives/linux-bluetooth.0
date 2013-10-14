Return-Path: <cyrus@holtmann.org>
Message-ID: <1381773779.21482.37.camel@nuvo>
Subject: Re: [PATCH] Allow using obexd without systemd in the user session
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Giovanni Campagna
 <scampa.giovanni@gmail.com>, "linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>, Giovanni Campagna
 <gcampagna@src.gnome.org>
Date: Mon, 14 Oct 2013 20:02:59 +0200
In-Reply-To: <CABBYNZJt2n_DZmR2SQk8HvgkRgf4yuPJnYr=HFxqb3H-Y0mQyw@mail.gmail.com>
References: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com>
	 <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
	 <1381595148.21761.0.camel@nuvo>
	 <CABBYNZJt2n_DZmR2SQk8HvgkRgf4yuPJnYr=HFxqb3H-Y0mQyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2013-10-14 at 18:02 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Sat, Oct 12, 2013 at 7:25 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Sat, 2013-10-12 at 18:08 +0200, Marcel Holtmann wrote:
> >> Hi Giovanni,
> > <snip>
> >> that is something your distro specific package should be fixing if
> >> that is needed. The focus is on integration with systemd and nothing
> >> else. You can use --disable-systemd and provide your own set of D-Bus
> >> service files.
> >
> > There aren't any distributions that ship systemd for user sessions
> > though.
> 
> How far we are with this? If that will take a while perhaps we should
> support the old D-Bus service too.

It's planned for GNOME 3.12 for GNOME, so in about 6 months time
(April-ish release date).
