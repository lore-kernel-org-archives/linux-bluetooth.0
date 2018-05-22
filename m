Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALevQMbBpXQ351j0u2=iSUMidkpPxnBaBHGNXZxfmaoJzyDBJg@mail.gmail.com>
References: <20180516135538.7817-1-grzegorz.kolodziejczyk@codecoup.pl>
 <CABBYNZ+5jm-PM=bxsCzROaAR2MED9+NUrxvEsynbKb62jPZ-+w@mail.gmail.com> <CALevQMbBpXQ351j0u2=iSUMidkpPxnBaBHGNXZxfmaoJzyDBJg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 22 May 2018 11:01:55 +0300
Message-ID: <CABBYNZJ+L_hR=HUJrv5RY3d5-SOQGoqGUcEAUoPP9WfSZpSX7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/5] doc/gatt-api: Add authorization options for attributes
To: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, May 22, 2018 at 10:33 AM, Grzegorz Ko=C5=82odziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> Hi Luiz,
> pon., 21 maj 2018 o 11:44 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> napisa=C5=82(a):
>
>> Hi Grzegorz,
>
>> On Wed, May 16, 2018 at 4:55 PM, Grzegorz Kolodziejczyk
>> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
>> > This patch adds authorization property for attributes and prepare writ=
e
>> > request for authorization option for write request. This is require to
>> > handle correctly prepare writes, which may response with insufficient
>> > authorization error.
>
>> I noticed there also a new error that we should document.
>
> You mean "org.bluez.Error.NotAuthorized" for WriteValue ? If so, it's
> already documented as possible error for WriteValues.

Nevermind, I thought InvalidValueLength was not documented but it is.

>> > ---
>> >  doc/gatt-api.txt | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> > index 0f1cc9029..7d8c427cd 100644
>> > --- a/doc/gatt-api.txt
>> > +++ b/doc/gatt-api.txt
>> > @@ -85,6 +85,8 @@ Methods               array{byte} ReadValue(dict
> options)
>> >                         Possible options: "offset": Start offset
>> >                                           "device": Device path (Serve=
r
> only)
>> >                                           "link": Link type (Server
> only)
>> > +                                         "authorize": boolean Is
> authorization
>> > +                                                      request
>> >
>> >                         Possible Errors: org.bluez.Error.Failed
>> >                                          org.bluez.Error.InProgress
>> > @@ -251,6 +253,12 @@ Properties string UUID [read-only]
>> >                                 "secure-read" (Server only)
>> >                                 "secure-write" (Server only)
>> >
>> > +               boolean Authorize [read-only, optional] (Server only)
>> > +
>> > +                       True, if authorization is required for attribu=
te
>> > +                       operations. By default this valuie is set to
> false for
>> > +                       attribute.
>> > +
>> >  Characteristic Descriptors hierarchy
>> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > @@ -284,6 +292,8 @@ Methods             array{byte} ReadValue(dict
> flags)
>> >                         Possible options: "offset": Start offset
>> >                                           "device": Device path (Serve=
r
> only)
>> >                                           "link": Link type (Server
> only)
>> > +                                         "authorize": boolean Is
> authorization
>> > +                                                      request
>> >
>> >                         Possible Errors: org.bluez.Error.Failed
>> >                                          org.bluez.Error.InProgress
>> > --
>> > 2.13.6
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>> --
>> Luiz Augusto von Dentz
>
> Grzegorz Ko=C5=82odziejczyk



--=20
Luiz Augusto von Dentz
