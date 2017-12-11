Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/4] Add LEAddressType property for Adapter1 and Device1 interfaces
Date: Mon, 11 Dec 2017 13:40:54 +0100
Message-ID: <7682133.nmmZL1UTJm@ix>
In-Reply-To: <CABBYNZKfjvPhOfb+f934JsD7xzHqZFEMwHhzzXEfynhQ63ML5g@mail.gmail.com>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl> <CABBYNZKfjvPhOfb+f934JsD7xzHqZFEMwHhzzXEfynhQ63ML5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Monday, 11 December 2017 12:59:18 CET Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Mon, Dec 11, 2017 at 8:38 AM, Szymon Janc <szymon.janc@codecoup.pl> 
wrote:
> > This provides information about LE Identity Address Type used. This
> > information is needed for L2CAP sockets and for PTS testing purposes.
> > ---
> > 
> >  doc/adapter-api.txt | 9 +++++++++
> >  doc/device-api.txt  | 9 +++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index d852aa6b9..b5abdda39 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -149,6 +149,15 @@ Properties string Address [readonly]
> > 
> >                         The Bluetooth device address.
> > 
> > +               string LEAddressType [readonly, optional]
> > +
> > +                       The Bluetooth device LE Identity Address Type.
> > This is +                       present only if LE is supported by
> > adapter. +
> > +                       Possible values:
> > +                               "public" - Public address
> > +                               "static" - Static Random address
> > +
> > 
> >                 string Name [readonly]
> >                 
> >                         The Bluetooth system name (pretty hostname).
> > 
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index 8b69c2ef3..dfeca305c 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -124,6 +124,15 @@ Properties string Address [readonly]
> > 
> >                         The Bluetooth device address of the remote device.
> > 
> > +               string LEAddressType [readonly, optional]
> > +
> > +                       The Bluetooth device LE Identity Address Type.
> > This is +                       present only if device supports LE.
> > +
> > +                       Possible values:
> > +                               "public" - Public address
> > +                               "static" - Static Random address
> > +
> > 
> >                 string Name [readonly, optional]
> >                 
> >                         The Bluetooth remote name. This value can not be
> > 
> > --
> > 2.14.3
> 
> Shouldn't we invest in a proper LE device interface then?

We could split Device1, although address type is stil needed for Adapter1.
And of course splitting interfaces is more work.

BTW after some more thinking I'd use "random" instead of "static" for address 
type.

-- 
pozdrawiam
Szymon Janc
