Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1440061390-32664-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZLp+iCpdshMBSCD8ndCPbeGezgLKrCd8-sqsCWp4B8c0g@mail.gmail.com>
In-reply-to: <CABBYNZLp+iCpdshMBSCD8ndCPbeGezgLKrCd8-sqsCWp4B8c0g@mail.gmail.com>
Subject: RE: [PATCH 1/2] test: Add sample media player properties
Date: Thu, 20 Aug 2015 18:31:38 +0530
Message-id: <004d01d0db48$6fe5be00$4fb13a00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Thursday, August 20, 2015 6:19 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH 1/2] test: Add sample media player properties
> 
> Hi Bharat,
> 
> On Thu, Aug 20, 2015 at 12:03 PM, Bharat Panda
> <bharat.panda@samsung.com> wrote:
> > Polulates media player properties with player name, type, sub-type and
> > features with sample values.
> > ---
> >  test/simple-player | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/test/simple-player b/test/simple-player index
> > a8ae0b1..a89767a 100755
> > --- a/test/simple-player
> > +++ b/test/simple-player
> > @@ -43,6 +43,10 @@ class Player(dbus.service.Object):
> >
> >                         self.properties = dbus.Dictionary({
> >                                         "PlaybackStatus" : "playing",
> > +                                       "DisplayName" : "SimplePlayer",
> > +                                       "Type" : "Audio",
> > +                                       "SubType" : "Audio Book",
> > +                                       "Features" :
> > + "0000000000b701ef0200000000000000",
> >                                         "LoopStatus" : "None",
> >                                         "Rate" : dbus.Double(1.0),
> >                                         "Shuffle" :
> > dbus.Boolean(False),
> > --
> > 1.9.1
> 
> This properties do not exist in MPRIS
> http://specifications.freedesktop.org/mpris-spec/latest/Media_Player.html,
> for DisplayName you can probably use Identity but for other we might have
> to infer based on the available MPRIS properties.
So except DisplayName, others(type, sub-type and features) will be inferred. How about building response for GetFolderItems, as it needs all these player properties to be filled in response PDU? What shall be filled in there?
> 
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Bharat

