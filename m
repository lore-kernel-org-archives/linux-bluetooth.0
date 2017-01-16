Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK-EfX=FkO9JSiQhE4WXeTTr3sw9WHDPVNr6pJmOXP1PgE0L5Q@mail.gmail.com>
References: <CAK-EfX=FkO9JSiQhE4WXeTTr3sw9WHDPVNr6pJmOXP1PgE0L5Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jan 2017 15:46:26 +0200
Message-ID: <CABBYNZK+jBHP959i-P+mQ2fX3p0fdFBYAxP8967BwEHnj=m-vQ@mail.gmail.com>
Subject: Re: GATT service blacklist
To: Vincent Scheib <scheib@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

On Sat, Jan 14, 2017 at 6:38 AM, Vincent Scheib <scheib@google.com> wrote:
> I just ran into this issue again (being blocked from accessing a standard
> GATT service) when using bluez. I had an application accessing GATT
> objects, and also the generic_access service. It's very odd that GATT
> operations to any service would be blocked unless there was a security
> reason to prevent them. Reading and writing the device name should just
> work. It doesn't make sense to write different code with a different API
> when the GATT API is already designed to provide access to this service.
>
> Is there a reason bluez can't allow access?

Well the general idea was to block access if there is a plugin already
handling a certain service. Now you seem to be claiming this shouldn't
be the case and any service can be accessed simultaneously by a plugin
running in daemon process and an application, but I don't think this
is always true and in some cases they may conflict, or just generate
duplicated traffic.

Perhaps for GAP service itself it is fine to allow applications to
access it, the problem is if we allow the application to set the name
like you want does it notifies that do the daemon as well? If it
doesn't then the daemon might only be able to detect the name has
changed once it connect again and attempt to read the name.
