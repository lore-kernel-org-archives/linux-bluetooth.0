Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180507082409.30018-1-luiz.dentz@gmail.com> <3965092.rnYZXRLaLl@ix>
In-Reply-To: <3965092.rnYZXRLaLl@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 07 May 2018 09:29:53 +0000
Message-ID: <CABBYNZ+oZGmADEysZq0QzByPfZ7P--61GkJmgnC5mwsidLfQ4w@mail.gmail.com>
Subject: Re: [RFC] doc/advertising-api: Add Flags property
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,
On Mon, May 7, 2018 at 11:33 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:

> Hi Luiz,

> On Monday, 7 May 2018 10:24:09 CEST Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds Flags which the application can use in case it want to set
> > it own flags.
> >
> > Note: This would allow for example an application to advertise as
> > discoverable even if the adapter is not discoverable which may be
> > required by dual-mode as it may not require BR/EDR to be discoverable.
> > ---
> >  doc/advertising-api.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> > index eef98ad91..234f9c2f2 100644
> > --- a/doc/advertising-api.txt
> > +++ b/doc/advertising-api.txt
> > @@ -78,6 +78,21 @@ Properties string Type
> >                               <Transport Discovery> <Organization
Flags...>
> >                               0x26                   0x01
0x01...
> >
> > +             byte Flags [Experimental]
> > +
> > +                     Advertising Flags to include. When present this
will
> > +                     override existing flags such as Discoverable.
> > +
> > +                     Note: This property shall not be set when Type is
set
> > +                     to broadcast.
> > +
> > +                     Possible value:
> > +                             bit 0 - LE Limited Discoverable Mode
> > +                             bit 1 - LE General Discoverable Mode
> > +                             bit 2 - BR/EDR Not Supported
> > +                             bit 3 - Simultaneous LE and BR/EDR
(Controller)
> > +                             bit 4 - Simultaneous LE and BR/EDR (Host)
> > +
> >               array{string} Includes
> >
> >                       List of features to be included in the advertising

> I'd make Flags array{byte} (just like Flags in Device1) to keep it future
> proof.

Yep, good catch.

> --
> pozdrawiam
> Szymon Janc




-- 
Luiz Augusto von Dentz
