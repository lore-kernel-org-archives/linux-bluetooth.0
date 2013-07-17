Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"martin.xu@linux.intel.com" <martin.xu@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Obex/Session: Redefine session target property
Date: Wed, 17 Jul 2013 06:20:58 +0000
Message-ID: <29981E9CC6590A438DB8A519AEB0053010D42E47@SHSMSX103.ccr.corp.intel.com>
References: <1373854203-3338-1-git-send-email-martin.xu@linux.intel.com>
 <CABBYNZKwZK6DQOYf-yd76KD3on0dcpXe4VoPg2iNwWvQD+F7mg@mail.gmail.com>
In-Reply-To: <CABBYNZKwZK6DQOYf-yd76KD3on0dcpXe4VoPg2iNwWvQD+F7mg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz:
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Tuesday, July 16, 2013 19:37
> To: martin.xu@linux.intel.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Obex/Session: Redefine session target property
> 
> Hi Martin,
> 
> On Mon, Jul 15, 2013 at 5:10 AM,  <martin.xu@linux.intel.com> wrote:
> > From: Martin <martin.xu@linux.intel.com>
> >
> > The definition of Target should be the same with Target parameter of
> > CreateSession.
> >
> > And add TargetUUID to save the Obex service UUID
> > ---
> >  doc/obex-api.txt |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/doc/obex-api.txt b/doc/obex-api.txt index
> > 22449c4..ad03690 100644
> > --- a/doc/obex-api.txt
> > +++ b/doc/obex-api.txt
> > @@ -67,7 +67,15 @@ Properties   string Source [readonly]
> >                         Bluetooth channel
> >
> >                 string Target [readonly]
> > +                       The currently supported targets are the
> following:
> > +
> > +                               "ftp"
> > +                               "map"
> > +                               "opp"
> > +                               "pbap"
> > +                               "sync"
> >
> > +               string TargetUUID [readonly]
> >                         Target UUID
> >
> >                 string Root [readonly]
> > --
> > 1.7.10.4
> 
> I wonder what is the benefit of yet another property, would the UI
> double check if the UUID matches the friendly name? I like to see the
> use case in the description so we really tell how it is going to be
> used, otherwise Target is fine. Btw, for OPP there is as actually a
> UUID as well:
> 
> static struct obc_driver opp = {
> .service = "OPP",
> .uuid = OPP_UUID,
> .probe = opp_probe,
> .remove = opp_remove
> };
The target head of OPP is not used see
SIG OBJECT PUSH PROFILE v.12 Section 5.4. At this situation it is not
Proper for UI to decide the session type by Can't the TargetUUID. 

Furthermore, we need to make Target comply with that in CreateSession target parameter
And it is friendly to UI to get the session type, otherwise, UI needs to check the UUID.

Of course we need to use TargetUUID on external profile.
