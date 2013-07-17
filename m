Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"martin.xu@linux.intel.com" <martin.xu@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] obex/session: Redefine session target property
Date: Wed, 17 Jul 2013 09:17:14 +0000
Message-ID: <29981E9CC6590A438DB8A519AEB0053010D42F63@SHSMSX103.ccr.corp.intel.com>
References: <1374030053-1305-1-git-send-email-martin.xu@linux.intel.com>
 <CABBYNZJfVhu4W2PVvb0qTFvOtmJq5pCfxUa4+DCa0a6yKQzu1g@mail.gmail.com>
In-Reply-To: <CABBYNZJfVhu4W2PVvb0qTFvOtmJq5pCfxUa4+DCa0a6yKQzu1g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz:
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Wednesday, July 17, 2013 16:08
> To: martin.xu@linux.intel.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v2] obex/session: Redefine session target property
> 
> Hi Martin,
> 
> On Wed, Jul 17, 2013 at 6:00 AM,  <martin.xu@linux.intel.com> wrote:
> > From: Martin Xu <martin.xu@linux.intel.com>
> >
> > The definition of Target should be the same with Target parameter of
> > CreateSession.
> >
> > And add TargetUUID for the external profile that can't be shown from
> > Target
> > ---
> >  doc/obex-api.txt |   18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> >  Changelog:
> >  v2: Add description why we need add TargetUUID property
> >
> > diff --git a/doc/obex-api.txt b/doc/obex-api.txt index
> > 22449c4..924df2f 100644
> > --- a/doc/obex-api.txt
> > +++ b/doc/obex-api.txt
> > @@ -68,7 +68,23 @@ Properties   string Source [readonly]
> >
> >                 string Target [readonly]
> >
> > -                       Target UUID
> > +                       The currently supported targets are the
> following:
> > +
> > +                               "ftp"
> > +                               "map"
> > +                               "opp"
> > +                               "pbap"
> > +                               "sync"
> > +
> > +               string TargetUUID [readonly]
> > +
> > +                       The UUID of target
> > +
> > +                       TargetUUID is useful when the target is from
> > +                       external profile and can't be exported from
> > +                       Property Target
> > +
> > +                       Opp doesn't have Target UUID, and is optional
> > + here
> >
> >                 string Root [readonly]
> >
> > --
> > 1.7.10.4
> 
> You still didn't address any of my concerns, neither of these
> properties is supposed to be show to the user, which probably don't
> know what those names mean, and any logic to match session type don't
> need to check both friendly name _and_ UUID, the latter should be
> enough even for proprietary/non-standard ones. The documentation of
> CreateSession is the one that needs adjustment, it should clearly state
> Target is a UUID and friendly names can be use for convenience but I
> expect them to be used just in scripts because application should
> really be using UUIDs anyway as in org.bluez.Device1.UUIDs, their
> friendly names are never exposed in any of our APIs.
I am ok with it, but OPP target head is not used, so user can't get
Target if it is OPP session. Which may confuse user.

Or can we just use the profile uuid instead of Target head UUID?
Thanks!

