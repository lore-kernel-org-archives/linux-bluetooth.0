Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: AVRCP 1.4 : Future on Target Role
From: Sander van Grieken <sander@outrightsolutions.nl>
Date: Tue, 19 Oct 2010 11:47:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201010191147.34241.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 19 October 2010 10:31:33 Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Oct 19, 2010 at 9:16 AM, Shivendra Agrawal
> <ag.shivendra@gmail.com> wrote:
> > Hi All,
> >
> > I have been looking at AVRCP 1.4 in BlueZ and intending to
> > enhance/develop this profile for the target role. I have been
> > following the discussion initiated by Sander van Grieken earlier last
> > month, and as I understand, they are premitive and has scope for
> > further enhancements.
> 
> Joao Paulo also did some work in this area using MPRIS, I guess he
> even publish his tree somewhere.

Yes, it's at git://git.profusion.mobi/users/jprvita/bluez.git

> > In the current BlueZ implementation, control-api.txt mentions few
> > methods e.g. SendVendoeDependent, ChangePlayback..., that are not
> > referred/implemented in the code, or I may be unable to find at right
> > place.

Yes, the document is more like a proposal, than a description of the actual 
implementation.

> > Further, there are some more AVRCP 1.4 TG specific Notify and Browsing
> > commands that can be added.
> 
> I would suggest you to take a look at media-api.txt, this is what we
> area planning to use for streams and we should probably add support
> for metadata and browsing (those 2 seems to be the most asked features
> from avrcp nowadays). Actually metadata seems to fit nicely there, we
> just need another interface to receive stream metadata, now browsing
> is probably not so easy.
> 
> > I am willing to define some preliminary interface APIs for Target
> > Media Applications to register itself with BlueZ, and would come back
> > with some idea proposal for your suggestions on improvements.
> 
> If media players all agree on using MPRIS than we probably don't need
> to have them registering to us, in the other hand Im not sure if MPRIS
> API do cover everything in terms of avrcp, maybe you can figure this
> out.

I am very much in favor of not directly depending on MPRIS, but instead letting 
applications registering themselves as a target. For two reasons:

- AVRCP seems to be a superset of MPRIS (which is very limited IMO), and might have 
different semantics, especially w.r.t. event notifications. So we would limit ourselves to 
the intersecting subset of both technologies.
- A separate AVRCP/TG <-> MPRIS bridge agent would still allow controlling all MPRIS-
enabled players, so we can have both full implementation of the AVRCP spec, AND generic 
MPRIS support.

> > I am keen to receive your feedback with some ideas and thoughts to put
> > my effort in right direction.
> >
> > Question:
> > Is anyone working on AVRCP 1.4 Target role profile development?
> 
> Joao Paulo (http://jprvita.wordpress.com/2010/07/22/avrcp-metadata/)

Actually, the metadata work is not part of v1.4 of the spec, but 1.3

Second, I have already added some boilerplate stuff (like a DBUS Connect method for RCP and 
some fixes for CT commands), but I've based on Joao's branch, so I have to wait until his 
stuff gets merged. Alternatively, I could rebase that stuff on HEAD, but that would overlap 
and conflict with Joao's stuff, so I'm hesitant to go there.

Shivendra, before you start, let's sync so we don't duplicate efforts

grtz,
Sander
