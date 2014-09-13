Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <25587ECB-CBF8-4E5C-9E86-63CACCFD1A0D@holtmann.org>
References: <1410614483-8462-1-git-send-email-dh.herrmann@gmail.com>
	<25587ECB-CBF8-4E5C-9E86-63CACCFD1A0D@holtmann.org>
Date: Sat, 13 Sep 2014 21:11:40 +0200
Message-ID: <CANq1E4ShytEnUq-U+cK9i+qjHoyMUK0DChEb9FExGdDEOpX1SA@mail.gmail.com>
Subject: Re: [PATCH] core: fix unbound watchdog-notify for timeouts <2s
From: David Herrmann <dh.herrmann@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Michael Biebl <mbiebl@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Sat, Sep 13, 2014 at 6:54 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> while setting WatchdogSec=1 is pretty insane interval anyway, this now also means that setting it that low will cause a race condition between systemd's watchdog killing us and we are able to be quickly enough to respond with a keep alive message.

Whoops, indeed. The patch is stupid. And yes, WatchdogSec=1 is insane,
but I guess we should at least have a sane behavior. I mean, it's
user-config so someone will (and currently is!) trigger this.

> I get the feeling that if > 2s, then we should use g_timeout_add_seconds to get the advantage of being woken up with all other timeouts in our daemon. And when it is <= 2s, then we better use a high precision g_timeout_add.

This sounds actually good. I will do that in v2.

Thanks
David

> One alternative is to actually use timerfd natively here and use kernel based range timers.
>
> Regards
>
> Marcel
>
