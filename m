Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e588afc974278375a48bf57177858b9a@labapart.com>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com> <e588afc974278375a48bf57177858b9a@labapart.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Mon, 17 Jul 2017 16:59:33 +0200
Message-ID: <CAO1O6sdSR_0CVqAKgdPFGP+3KRk3+m-+GTSURMaxjQVtmV2TvQ@mail.gmail.com>
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
To: Olivier MARTIN <olivier@labapart.com>
Cc: Jonah Petri <jonah@sense.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-bluetooth-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2017-07-17 16:07 GMT+02:00 Olivier MARTIN <olivier@labapart.com>:

> When I started to do the same exercise last week, I exposed two different MTUs: GATT Server MTU (in GATT Manager DBUS API) and GATT Client MTU (in Device DBUS API) as I had the impression they were different.
> Instead of only exposing the negociated MTU I also exposed the current MTU (ie: the value before being negociated). The idea was to send a DBUS Signal when a new MTU was negociated to tell DBus-based applications a new MTU has been negociated.


As you can read in the standard (Core 5.0) at Vol 3, Part F, Chapter 3.4.2.2,
"If a device is both a client and a server, the following rules shall apply:
1. A device's Exchange MTU Request shall contain the same MTU as the
device's Exchange MTU Response (i.e. the MTU shall be symmetric).
3. It is permitted, (but not necessary - see 2.) to exchange MTU in both
directions, but the MTUs shall be the same in each direction (see 1.)"

So for a given link, the MTU is same for both being a client and server.

Also make sure there are no race conditions in the way that an app
sends some value with the wrong MTU since it is just being updated.
(There is a large list of "gotchas" in 3.4.2.2 as well as in figure
3.1).
