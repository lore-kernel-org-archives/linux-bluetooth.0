Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_P2nKg9EWCyX4T1qG6zcOtggb-GqueaF4worq6dfbw2_Q@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
 <CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
 <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
 <CA+XVXfeMqXxAxb1sP7Bp=iQRsEVaF6E39k-wDTbVZQADOswvAQ@mail.gmail.com> <CAJdJm_P2nKg9EWCyX4T1qG6zcOtggb-GqueaF4worq6dfbw2_Q@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 2 Feb 2012 15:32:01 +0200
Message-ID: <CA+XVXfeyCUMP0V02N7VQ-KOchTOKptTCYa1kbeue_+OO-ybB9A@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 2, 2012 at 15:07, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> On Thu, Feb 2, 2012 at 8:19 AM, Arik Nemtsov <arik@wizery.com> wrote:
>> Does this mean the server-application operating over D-Bus would be
>> able to register read/write callbacks on specific attributes?
>
> Actually the API will be more high level, and hopefully Profile
> agnostic, so it can be reused between profiles.

Maybe you have some preliminary suggested documentation? It would be
interesting to take a look

>
>> It would be nice to get a sense of the API soon. We're planning on
>> implementing several GATT servers. Namely - ANS, PASS, IAS, LLS and
>> TPS. This can obviously effect the design.
>
> It would be interesting for us to cooperate on this then. IAS/LLS/TPS
> are implemented on BlueZ upstream already (check proximity/* files).

It would indeed be nice to cooperate :)
As for IAS/LLS/TPS - I think maybe a rewrite using the higher-level
gatt_service_add() API is in order.

For IAS/LLS the notification to an upper-level app is missing
(something the new D-Bus API will probably address). For TPS,
returning the RSSI is missing (in a read_cb).

>
> ANS and PASS have skeleton code and initial implementation (which I
> will send soon to the list once I clean it up) on my development tree
> (warning: it is currently messy and outdated, and needs cleanup):
>
> git://gitorious.org/~lizardo/bluez/lizardo-bluez.git (branch
> for-upstream-phone-alert)

It seems I can't get to gitorious right now (seems to be some planned
maintenance). I'll definitely take a look once I can.

>
> Our current design is to have both ANS and PASS grouped into a
> altert/* directory.

Sounds good.

> I plan to send initial "dummy" implementations of NDCS and Local Time
> Information as well, but if you already have them implemented, feel
> free to send at least some RFC here.
>
> But you can extend with further functionality after we have the
> initial services upstream.

NDCS adds very little code. My main concern here is updating the
DST-change time periodically from the server-app.
Seems to me it's better to wait for your proposed skeleton implementations.

Regards,
Arik
