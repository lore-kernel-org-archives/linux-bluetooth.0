Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ECA7E29.6080909@bmw-carit.de>
References: <4ECA7E29.6080909@bmw-carit.de>
Date: Tue, 22 Nov 2011 11:24:45 +0200
Message-ID: <CABBYNZJ38jvq+hicCwm+uJ1yL4R7J1eye=rmQYJdM-iBsXMLkw@mail.gmail.com>
Subject: Re: Proposal for major API changes in obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Nov 21, 2011 at 6:36 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> Hi all,
>
> I would like to propose some changes in obex-client's D-Bus API, refactoring
> parts of the existing API and rewriting others.
>
> The main goals would be the following:
>
>    - Higher level representation of devices and sessions, following the
> BlueZ style.

Im fine with the representation of sessions, device representation may
not be a bad idea but Im afraid this would not work very well for OPP
since it doesn't require pairing the device may not exist so we have
to support connecting by address anyway which defeats the purpose of
having a device. On the other hand if we start creating devices for
every device found that would solve the problem with OPP and we would
be able to have e.g. Connect method per interface like we have in
BlueZ.

>    - OPP operations wrapped into a specific session type, just like the
> rest.

It probably adds an extra round trip but it is much more clean that
the current methods we have, and we can separate it from the core
daemon and put it in a separate module.

>    - Transfer objects are created always, making the API more orthogonal.

Yep

>    - Content of the pulled files is written to a file, avoiding dbus
> overhead.

Yep

>    - Removal of agent, since all requests are locally initiated.

I guess it can be useful if someone wants to watch the progress of the
transfers.

>    - Transfer progress reported using unicast signals to transfer initiator.

Can be done, but I would like first to align the transfers with obexd.

-- 
Luiz Augusto von Dentz
