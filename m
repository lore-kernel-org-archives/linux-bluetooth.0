Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
 <CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com> <CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 2 Feb 2012 14:19:37 +0200
Message-ID: <CA+XVXfeMqXxAxb1sP7Bp=iQRsEVaF6E39k-wDTbVZQADOswvAQ@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 2, 2012 at 01:12, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>> This series looks good overall. Are you planning to go ahead with it
>> (with a non-RFC series)?
>
> Sure. This will happen in the very near future (at most next week).
> But for now we will drop the "providers" patches, because we are about
> to also send D-Bus API that implements the functionality externally.

Does this mean the server-application operating over D-Bus would be
able to register read/write callbacks on specific attributes?

It would be nice to get a sense of the API soon. We're planning on
implementing several GATT servers. Namely - ANS, PASS, IAS, LLS and
TPS. This can obviously effect the design.

>
> But even with the initial implementation, most Time clients will be
> supported just fine. They will just not be able to update the phone's
> own time or be notified of manual changes to the phone time (this will
> be supported with the D-Bus API).

Ok.

> We plan to have everything which was in "providers" implemented on
> external a Agent which communicates over D-Bus. This is necessary to
> avoid introducing extra dependency on BlueZ for each platform we may
> support.
>
> We will send a RFC for this Time Agent API real soon. Please comment :)

Will do. I am interested in adding an implementation of an NDCS server
to the BlueZ time server. It would be nice if you take this into
account in the Time Agent API (updating the DST offset from D-Bus).
The same is also required for the Local Time Information characteristic in CTS.

Regards,
Arik
