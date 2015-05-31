Return-Path: <cyrus@holtmann.org>
Date: Sun, 31 May 2015 09:55:05 +0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Add new method to DBus API: DiscoverServiceByUUID
Message-ID: <20150531025505.GA23991@t440s>
References: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
 <CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
 <CAD0=r8wDGKw4DRnEAsZqNvMc05CGnjz7HVFc6MTQZi74L9xC1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8wDGKw4DRnEAsZqNvMc05CGnjz7HVFc6MTQZi74L9xC1Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, May 28, 2015, Jakub Pawlowski wrote:
> > 1. Instead of just 1 method there is at least 2, but Connect depends
> > on what has been discovered first so you are adding a D-Bus round
> > trips.
> 
> Yes, I'm probably adding one round trip. It might hovewer be avoided.
> To avoid additional roundtrip there should be two methods:
> Connect() that just works right now, and ConnectToUUID(uuid) that
> would connect, and then do "Find By Type Value Request". I think that
> this solution wouldn't be that clean, and would be problematic to
> discover rest of services.

We already have this "ConnectToUUID" method in the form of
Device1.ConnectProfile, don't we? It was originally designed for BR/EDR,
but seems to have at least some code for LE as well. If it's not working
as desired for LE it's probably something worth fixing.

Johan
