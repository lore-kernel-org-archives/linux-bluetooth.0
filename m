Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+XVXfeMqXxAxb1sP7Bp=iQRsEVaF6E39k-wDTbVZQADOswvAQ@mail.gmail.com>
References: <1322850850-18019-1-git-send-email-anderson.lizardo@openbossa.org>
	<CA+XVXffynitA+JYzRnqiRJPQyyrTh+HMNUWQgb0LzD4iowoxpg@mail.gmail.com>
	<CAJdJm_MXwG0vicPL1zPDBYKj-GXRgacvyg9wqpe5OAhey5q4VA@mail.gmail.com>
	<CA+XVXfeMqXxAxb1sP7Bp=iQRsEVaF6E39k-wDTbVZQADOswvAQ@mail.gmail.com>
Date: Thu, 2 Feb 2012 09:07:17 -0400
Message-ID: <CAJdJm_P2nKg9EWCyX4T1qG6zcOtggb-GqueaF4worq6dfbw2_Q@mail.gmail.com>
Subject: Re: [PATCH RFC BlueZ 0/5] Time Profile (server) improvements
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Feb 2, 2012 at 8:19 AM, Arik Nemtsov <arik@wizery.com> wrote:
> Does this mean the server-application operating over D-Bus would be
> able to register read/write callbacks on specific attributes?

Actually the API will be more high level, and hopefully Profile
agnostic, so it can be reused between profiles.

> It would be nice to get a sense of the API soon. We're planning on
> implementing several GATT servers. Namely - ANS, PASS, IAS, LLS and
> TPS. This can obviously effect the design.

It would be interesting for us to cooperate on this then. IAS/LLS/TPS
are implemented on BlueZ upstream already (check proximity/* files).

ANS and PASS have skeleton code and initial implementation (which I
will send soon to the list once I clean it up) on my development tree
(warning: it is currently messy and outdated, and needs cleanup):

git://gitorious.org/~lizardo/bluez/lizardo-bluez.git (branch
for-upstream-phone-alert)

Our current design is to have both ANS and PASS grouped into a
altert/* directory.

>> We will send a RFC for this Time Agent API real soon. Please comment :)
>
> Will do. I am interested in adding an implementation of an NDCS server
> to the BlueZ time server. It would be nice if you take this into
> account in the Time Agent API (updating the DST offset from D-Bus).
> The same is also required for the Local Time Information characteristic in CTS.

Indeed the Time Agent API is supposed to handle that as well.

I plan to send initial "dummy" implementations of NDCS and Local Time
Information as well, but if you already have them implemented, feel
free to send at least some RFC here.

But you can extend with further functionality after we have the
initial services upstream.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
