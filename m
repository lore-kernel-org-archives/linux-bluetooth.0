Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 10:01:39 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ and Android - question
Message-ID: <20131016070137.GI2861@aemeltch-MOBL1>
References: <CAGXs5wXGtexDMRmVNA64bMrHt4ZW3pB6SwZA7K9c_5qQkGh6GA@mail.gmail.com>
 <20131015134354.GH2861@aemeltch-MOBL1>
 <CAGXs5wU-L=Khuto4SJfYE4QqRZNWL2RAc-hjxqLEEE1aU6aC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXs5wU-L=Khuto4SJfYE4QqRZNWL2RAc-hjxqLEEE1aU6aC-w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

On Tue, Oct 15, 2013 at 06:00:19PM +0300, Kevin Wilson wrote:
> Andrei,
> Thanks a lot for the Quick response.
> Can you please provide a link for the alternative for Bluetooth stack in
> Android or specify its name ?  I did not know about it.

The alternatives seems to be:

1) backport old BlueZ + Bluetooth framework from Android 4.1.2
https://gitorious.org/android-bluez

2) The new project with the latest BlueZ and Android:
http://code.google.com/p/android-bluez/
(this is initial phase)

3) You can also use Bluedroid with BlueZ kernel drivers via CHANNEL_USER

Best regards 
Andrei Emeltchenko 

> 
> Best Regards,
> Kevin
> 
> On Tue, Oct 15, 2013 at 4:44 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
> > Hi Kevin,
> >
> > On Tue, Oct 15, 2013 at 04:16:45PM +0300, Kevin Wilson wrote:
> >> Hello all,
> >> I have a question:
> >>
> >> I saw in several places on the web text which says, in some
> >> variations,  that "BlueZ has been removed starting from Android  4.2
> >> and the  Broadcom-supplied Bluetooth stack (bluedroid) has replaced
> >> it. It says also that the bluedroid
> >> stack relies on HAL-loading like most other hardware types.
> >>
> >> On the other hand I see in the official page,
> >> http://www.bluez.org/
> >> something which I am not sure how to interpret.
> >>
> >>
> >> I want to resolve my confusion.
> >> So here is my question:
> >> In Android 4.2 and above - is the BlueZ removed ?
> >
> > Yes
> >
> >> is the BlueDroid
> >> used instead ?
> >
> > Yes
> >
> >>or are they both used?
> >
> > No.
> >
> > Now there is a project to provide alternative for Bluetooth stack in
> > Android.
> >
> > Best regards
> > Andrei Emeltchenko
> >
