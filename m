Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
References: <20180507161403.14181-1-luiz.dentz@gmail.com> <EF92087E-6EF8-403F-803C-A912DCF50A07@holtmann.org>
In-Reply-To: <EF92087E-6EF8-403F-803C-A912DCF50A07@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 08 May 2018 09:26:21 +0000
Message-ID: <CABBYNZJK9nHb1HQFEVgiC5roPRtcU59JWV+Q2gVgbZcfwUtfUw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
On Tue, May 8, 2018 at 10:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Luiz,

> > This adds Flags which the application can use in case it want to set
> > it own flags.
> >
> > Note: This would allow for example an application to advertise as
> > discoverable even if the adapter is not discoverable which may be
> > required by dual-mode as it may not require BR/EDR to be discoverable.
> > ---
> > doc/advertising-api.txt | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> >
> > diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> > index eef98ad91..4e015f282 100644
> > --- a/doc/advertising-api.txt
> > +++ b/doc/advertising-api.txt
> > @@ -78,6 +78,21 @@ Properties string Type
> >                               <Transport Discovery> <Organization
Flags...>
> >                               0x26                   0x01
0x01...
> >
> > +             array{byte} Flags [Experimental]
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

> I think this is the wrong approach. Exposing this low-level part is just
giving an API to circumvent and violate the Bluetooth spec. You are
inviting apps to create bad advertising data. So NAK.

Then we should find some alternative, perhaps only allow certain flags to
be set this way or change the property to just Discoverable.

> Regards

> Marcel



-- 
Luiz Augusto von Dentz
