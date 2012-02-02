Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXfeyCUMP0V02N7VQ-KOchTOKptTCYa1kbeue_+OO-ybB9A@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
	<CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
	<CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
	<CA+XVXfeMqXxAxb1sP7Bp=iQRsEVaF6E39k-wDTbVZQADOswvAQ@mail.gmail.com>
	<CAJdJm_P2nKg9EWCyX4T1qG6zcOtggb-GqueaF4worq6dfbw2_Q@mail.gmail.com>
	<CA+XVXfeyCUMP0V02N7VQ-KOchTOKptTCYa1kbeue_+OO-ybB9A@mail.gmail.com>
Date: Thu, 2 Feb 2012 10:06:05 -0400
Message-ID: <CAJdJm_MJn-U1C0NHR1Tu8mON7qCwSB_2T1zGkm3BSs4xmHghPQ@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Feb 2, 2012 at 9:32 AM, Arik Nemtsov <arik@wizery.com> wrote:
> On Thu, Feb 2, 2012 at 15:07, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Arik,
>>
>> On Thu, Feb 2, 2012 at 8:19 AM, Arik Nemtsov <arik@wizery.com> wrote:
>>> Does this mean the server-application operating over D-Bus would be
>>> able to register read/write callbacks on specific attributes?
>>
>> Actually the API will be more high level, and hopefully Profile
>> agnostic, so it can be reused between profiles.
>
> Maybe you have some preliminary suggested documentation? It would be
> interesting to take a look

Sure, Claudio is "taking care" of this document, and will send you
soon for early comments. But we want to send to the list ASAP as well.
There is draft documents for PhoneAlert/AlertNotification as well.

>>> It would be nice to get a sense of the API soon. We're planning on
>>> implementing several GATT servers. Namely - ANS, PASS, IAS, LLS and
>>> TPS. This can obviously effect the design.
>>
>> It would be interesting for us to cooperate on this then. IAS/LLS/TPS
>> are implemented on BlueZ upstream already (check proximity/* files).
>
> It would indeed be nice to cooperate :)
> As for IAS/LLS/TPS - I think maybe a rewrite using the higher-level
> gatt_service_add() API is in order.

Indeed. Feel free to send patches for those :)

For Time/Phone Alert/Alert Notifications services, we will already
send using the gatt_service_add() API.

>
> For IAS/LLS the notification to an upper-level app is missing
> (something the new D-Bus API will probably address).

Correct. The Proximity Reporter API is already documented in
docs/proximity-api.txt, but needs to be implemented.

> For TPS,
> returning the RSSI is missing (in a read_cb).

I thinki this is on purpose. Are you aware that there is ongoing
discussions on BT SIG to avoid this "RSSI polling" altogether on
future Core spec revision? The plan is then to completely avoid
exposing this information at the moment because it may not be more
available on future revisions.

But feel free to send proposals on how to handle this. We may have
issues with too much polling and overhead if RSSI values are sent over
D-Bus too often.

>> ANS and PASS have skeleton code and initial implementation (which I
>> will send soon to the list once I clean it up) on my development tree
>> (warning: it is currently messy and outdated, and needs cleanup):
>>
>> git://gitorious.org/~lizardo/bluez/lizardo-bluez.git (branch
>> for-upstream-phone-alert)
>
> It seems I can't get to gitorious right now (seems to be some planned
> maintenance). I'll definitely take a look once I can.

Ok. As I said the code is messy, so I expect comments only for the
patches I'll send here :) But feel free to take a look.

>
> NDCS adds very little code. My main concern here is updating the
> DST-change time periodically from the server-app.
> Seems to me it's better to wait for your proposed skeleton implementations.

No problem. I agree the most tricky part will be on properly handle
notifications.

I plan to only handle the "easy" part now , so at least we can work
with Time clients which may want to interact with this service.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
