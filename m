Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
	<CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
Date: Wed, 1 Feb 2012 19:12:27 -0400
Message-ID: <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Wed, Feb 1, 2012 at 6:48 PM, Arik Nemtsov <arik@wizery.com> wrote:
> Hey Anderson,
>
> On Fri, Dec 2, 2011 at 20:34, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> This series implements two new features for GATT Time Profile (server role):
>>
>> * Reference Time Update Service (RTUS), with two drivers (called "providers"
>>  here): dummy (for testing) and timed (for N9/harmattan)
>> * Support for current time notifications
>
> This series looks good overall. Are you planning to go ahead with it
> (with a non-RFC series)?

Sure. This will happen in the very near future (at most next week).
But for now we will drop the "providers" patches, because we are about
to also send D-Bus API that implements the functionality externally.

But even with the initial implementation, most Time clients will be
supported just fine. They will just not be able to update the phone's
own time or be notified of manual changes to the phone time (this will
be supported with the D-Bus API).

>> We are aware of the current plan of moving platform specific code out of BlueZ
>> (to agents communicating over D-Bus). Is it feasible to be done now for GATT
>> servers as well?
>
> It seems this is handled well in your series. Or did you want to move
> some more functionality to D-Bus?

We plan to have everything which was in "providers" implemented on
external a Agent which communicates over D-Bus. This is necessary to
avoid introducing extra dependency on BlueZ for each platform we may
support.

We will send a RFC for this Time Agent API real soon. Please comment :)

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
