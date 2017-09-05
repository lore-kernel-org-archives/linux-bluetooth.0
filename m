Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504607866.6911.1.camel@hadess.net>
Subject: Re: [PATCH 4/9] plugins/sixaxis: Move device discovery to shared
 header
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date: Tue, 05 Sep 2017 12:37:46 +0200
In-Reply-To: <CAAEJBhJpr_shNrShELVqATj3aiPQTV+saTY=cDXetYn87PQghw@mail.gmail.com>
References: <20170904181212.5639-1-hadess@hadess.net>
         <20170904181212.5639-4-hadess@hadess.net>
         <1504602205.5928.5.camel@hadess.net>
         <CAAEJBhJpr_shNrShELVqATj3aiPQTV+saTY=cDXetYn87PQghw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-09-05 at 11:13 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> On 5 September 2017 at 11:03, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Mon, 2017-09-04 at 20:12 +0200, Bastien Nocera wrote:
> > > <snip>
> > > +
> > > +inline CablePairingType
> > > +get_pairing_type(uint16_t   vid,
> > > +              uint16_t   pid,
> > > +              char     **name,
> > > +              uint16_t  *source,
> > > +              uint16_t  *version)
> > 
> > I have a slightly updated version of that section. "static" is
> > missing
> > in front of the inline function for use with RPM build's strict
> > linker
> > settings, and I'm sure the indentation police would like to see
> > that
> > function return type and name on the same line ;)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> I'm not sure why this is in header in first place ?

It should become clear if you look at the rest of the patchset.

As we discussed in Juha's version of this patchset, we want to share
this code between the sixaxis plugin, and the input profiles code. A
code header is the easiest way to do this without getting into build
conditionals.
