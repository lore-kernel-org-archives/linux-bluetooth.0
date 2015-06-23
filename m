Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1433517215-25516-1-git-send-email-bharat.panda@samsung.com>
 <011401d0aa74$b1661550$14323ff0$@samsung.com>
 <CABBYNZJ4f_g+cr=FfwU+1awY4xnKSm3upUvAMYLywCODFzqC9A@mail.gmail.com>
In-reply-to: <CABBYNZJ4f_g+cr=FfwU+1awY4xnKSm3upUvAMYLywCODFzqC9A@mail.gmail.com>
Subject: RE: [PATCH ] AVRCP: Handle Total Number Of Tracks metadata
Date: Tue, 23 Jun 2015 17:04:39 +0530
Message-id: <016c01d0ada8$a28a0690$e79e13b0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Tuesday, June 23, 2015 2:09 PM
> To: Bharat Bhusan Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] AVRCP: Handle Total Number Of Tracks metadata
> 
> Hi Bharat,
> 
> On Fri, Jun 19, 2015 at 12:45 PM, Bharat Bhusan Panda
> <bharat.panda@samsung.com> wrote:
> > ping
> >
> >> -----Original Message-----
> >> From: Bharat Bhusan Panda [mailto:bharat.panda@samsung.com]
> >> Sent: Thursday, June 11, 2015 11:14 AM
> >> To: 'linux-bluetooth@vger.kernel.org'
> >> Cc: 'cpgs@samsung.com'
> >> Subject: RE: [PATCH ] AVRCP: Handle Total Number Of Tracks metadata
> >>
> >> ping
> >>
> >> > -----Original Message-----
> >> > From: linux-bluetooth-owner@vger.kernel.org
> >> > [mailto:linux-bluetooth- owner@vger.kernel.org] On Behalf Of Bharat
> >> > Panda
> >> > Sent: Friday, June 05, 2015 8:44 PM
> >> > To: linux-bluetooth@vger.kernel.org
> >> > Cc: cpgs@samsung.com; Bharat Panda
> >> > Subject: [PATCH ] AVRCP: Handle Total Number Of Tracks metadata
> >> >
> >> > Total Number of Tracks was not displayed, coz "Number of Tracks"
> >> > was not handled in metadata parser.
> >> > ---
> >> >  profiles/audio/media.c | 3 +++
> >> >  tools/mpris-proxy.c    | 3 +++
> >> >  2 files changed, 6 insertions(+)
> >> >
> >> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
> >> > f12569e..8e7e1a3 100644
> >> > --- a/profiles/audio/media.c
> >> > +++ b/profiles/audio/media.c
> >> > @@ -1510,6 +1510,9 @@ static gboolean parse_player_metadata(struct
> >> > media_player *mp,
> >> >             } else if (strcasecmp(key, "xesam:trackNumber") == 0) {
> >> >                     if (!parse_int32_metadata(mp, "TrackNumber",
> >> > &var))
> >> >                             return FALSE;
> >> > +           } else if (strcasecmp(key, "xesam:totalTracks") == 0) {
> >> > +                   if (!parse_int32_metadata(mp, "NumberOfTracks",
> >> > &var))
> >> > +                           return FALSE;
> >> >             } else
> >> >                     DBG("%s not supported, ignoring", key);
> >> >
> >> > diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c index
> >> > 693055e..5749427
> >> > 100644
> >> > --- a/tools/mpris-proxy.c
> >> > +++ b/tools/mpris-proxy.c
> >> > @@ -1261,6 +1261,9 @@ static int parse_track_entry(DBusMessageIter
> >> > *entry, const char *key,
> >> >     } else if (strcasecmp(key, "TrackNumber") == 0) {
> >> >             if (!parse_int32_metadata(&var, "xesam:trackNumber",
> >> > metadata))
> >> >                     return -EINVAL;
> >> > +   } else if (strcasecmp(key, "NumberOfTracks") == 0) {
> >> > +           if (!parse_int32_metadata(&var, "xesam:totalTracks",
> >> > metadata))
> >> > +                   return -EINVAL;
> 
> I remember not finding any documentation for xesam:totalTracks do you
> have a link for it? If you could you please add to the description.
I don’t have any xesam or freedesktop reference for "xesam:totalTracks ", but I tried with "xesam:totalTracks" to get NumberOfTracks parsed and it works well to get it displayed.
> 
> >> >     } else if (strcasecmp(key, "Item") == 0) {
> >> >             if (!parse_path_metadata(&var, "mpris:trackid", metadata))
> >> >                     return -EINVAL;
> >> > --
> >> > 1.9.1
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe
> >> > linux-bluetooth" in the body of a message to
> >> > majordomo@vger.kernel.org More majordomo info at
> >> > http://vger.kernel.org/majordomo-info.html
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

--
Regards
Bharat

