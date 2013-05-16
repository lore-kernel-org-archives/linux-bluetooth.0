Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHKzcENFNqJ3iyd1V7YBaE=7j5aUY8rkFUW8VdUz=oKiCfrUNg@mail.gmail.com>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org> <5135D965.8020604@tieto.com>
 <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org> <513703AA.2090206@tieto.com>
 <514021F5.1040005@tieto.com> <20130508074138.GA11502@x220> <CAHKzcENFNqJ3iyd1V7YBaE=7j5aUY8rkFUW8VdUz=oKiCfrUNg@mail.gmail.com>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Date: Thu, 16 May 2013 14:22:28 +0200
Message-ID: <CAHKzcEObFct5DLh+FKYvNNxF8QHcdkRN9KgYxetZJvaVPwfyzQ@mail.gmail.com>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
To: johan.hedberg@gmail.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Are you still working on this? Seems this discussion was forgotten or
> just abandoned.

I've been focused on something else, but nice to see you are still
interested in.

> Apparently it was never a requirement to be able to enable/disable this
> an arbitrary amount of times during the watcher life time, and instead
> just leave it disabled or enabled until the watcher gets unregistered?
>
> Also, do you think there will be UIs that will refuse to work if a
> device does not support intermediate measurement or that any UI that is
> interested in intermediate measurement will forgive devices that do not
> support it and simply get on with working without it being enabled? If
> the latter ilds true then why not make an API which allows requesting
>
> "register watcher and enable intermediate measurement if it's
> supported". In such a case you wouldn't need a separate property and the
> registration would succeed even if intermediate measurement isn't
> supported. Thoughts?


 Well, I believe any app will always be interested in getting intermediate
 results if possible, but it would be nice to notify (property, signal) the
 app if it's not possible.
 Just to give a chance to handle user experience in nice way. It can take a
 while between start of measurements and the final results event.

 From the other hand, the app by default can assume there is no intermediate
 results ( (however API will not require that if there is no property)) and
 can handle this time properly. In case, when it starts receiving
 intermediate results it will start display it immediately.

 Thanks,
 /Waldek
