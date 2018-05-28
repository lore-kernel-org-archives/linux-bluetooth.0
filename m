Return-Path: <grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
References: <20180525091541.4688-1-grzegorz.kolodziejczyk@codecoup.pl> <487AACC5-DA1A-4CCA-B5F7-E762CBCABC90@holtmann.org>
In-Reply-To: <487AACC5-DA1A-4CCA-B5F7-E762CBCABC90@holtmann.org>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= <grzegorz.kolodziejczyk@codecoup.pl>
Date: Mon, 28 May 2018 10:01:07 +0200
Message-ID: <CALevQMaHo4pVhL0sbKS-Cf2yBuYON1FcLM-hdS8KmYsT7KszgA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 1/4] doc/gatt-api: Add authorization options for attributes
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
sob., 26 maj 2018 o 18:13 Marcel Holtmann <marcel@holtmann.org> napisa=C5=
=82(a):

> Hi Grzegorz,

> > This patch adds authorization property for attributes and prepare write
> > request for authorization option for write request. This is require to
> > handle correctly prepare writes, which may response with insufficient
> > authorization error.
> > ---
> > doc/gatt-api.txt | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> >
> > diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> > index 0f1cc9029..6b1487254 100644
> > --- a/doc/gatt-api.txt
> > +++ b/doc/gatt-api.txt
> > @@ -85,6 +85,9 @@ Methods             array{byte} ReadValue(dict
options)
> >                       Possible options: "offset": Start offset
> >                                         "device": Device path (Server
only)
> >                                         "link": Link type (Server only)
> > +                                       "prep-authorize": boolean Is
prepare
> > +                                                         authorization
> > +                                                         request
> >
> >                       Possible Errors: org.bluez.Error.Failed
> >                                        org.bluez.Error.InProgress
> > @@ -250,6 +253,7 @@ Properties        string UUID [read-only]
> >                               "encrypt-authenticated-write"
> >                               "secure-read" (Server only)
> >                               "secure-write" (Server only)
> > +                             "authorize"
> >
> > Characteristic Descriptors hierarchy
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -284,6 +288,9 @@ Methods           array{byte} ReadValue(dict flags)
> >                       Possible options: "offset": Start offset
> >                                         "device": Device path (Server
only)
> >                                         "link": Link type (Server only)
> > +                                       "prep-authorize": boolean Is
prepare
> > +                                                         authorization
> > +                                                         request

> lets use =E2=80=9Cprepare-authorize=E2=80=9D and not shortcut things for =
no good reason.

Ok.
> Regards

> Marcel


Regards,
Grzegorz
