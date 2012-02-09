Return-Path: <cyrus@holtmann.org>
Message-ID: <1328815127.28848.36.camel@aeonflux>
Subject: Re: [PATCH 0/3] Advertising cache locking code refactoring
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Andre Guedes <aguedespe@gmail.com>,
	linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Thu, 09 Feb 2012 20:18:47 +0100
In-Reply-To: <CAA37ikZVxFvCjSbNcpA5_XSK7mLj3M6uZyqYGDOJhhmT9Y8t_g@mail.gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
	 <1328795351.28848.17.camel@aeonflux>
	 <CAA37ikZVxFvCjSbNcpA5_XSK7mLj3M6uZyqYGDOJhhmT9Y8t_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> >> This patch series does some code refactoring in advertising cache locking
> >> related code. This work is a small effort to improve locking usage in
> >> Bluetooth subsystem.
> >>
> >> BR,
> >>
> >> Andre
> >>
> >> Andre Guedes (3):
> >>   Bluetooth: Add prefix "__" to advertising cache functions
> >>   Bluetooth: Create thread-safe advertising cache functions
> >>   Bluetooth: Use advertising cache thread-safe functions
> >>
> >>  include/net/bluetooth/hci_core.h |    4 +++
> >>  net/bluetooth/hci_conn.c         |    2 +-
> >>  net/bluetooth/hci_core.c         |   51 +++++++++++++++++++++++++++++++------
> >>  net/bluetooth/hci_event.c        |    6 +---
> >>  4 files changed, 48 insertions(+), 15 deletions(-)
> >
> > so I looked through this patch series and the only useful patch is 1/3
> > and even that one is kinda questionable. However if people in general
> > find this a bit clearer that we prefix unlocked hdev functions with __,
> > then I would be fine is it. Opinions anybody?
> 
> Not sure if you saw my replies. I said this series is not needed at
> all IMO. And if we want to prefix unlocked hdev functions with __ then
> we better change all of them to have everything consistent. And I'm
> really against adding locked versions if we're not really using them.

I agree, no locked versions if we don't need them. We can add them
always later when we do.

And I am fine with __ prefixes for all unlocked functions, but yes, we
should be 100% consistent then.

Regards

Marcel


