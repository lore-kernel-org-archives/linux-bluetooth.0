Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 May 2010 22:42:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add blacklist support for incoming
 connections
Message-ID: <20100517204234.GA6418@jh-x301>
References: <1274109587-26638-1-git-send-email-johan.hedberg@gmail.com>
 <AANLkTil3cZu0tfsemxC2DrXTW7gmXU8-MXYKeWyS9t0M@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTil3cZu0tfsemxC2DrXTW7gmXU8-MXYKeWyS9t0M@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Mon, May 17, 2010, jaikumar Ganesh wrote:
> Is there any use case for this that we are trying to solve i.e why are we
> maintaining the list at the baseband level itself rather than reject it
> somewhere in the upper layers or in the app that uses Bluez?

E.g. in the case that some device keeps spamming us with pairing
requests it's good to be able block them on a low level. Also this way
there doesn't need to be duplicate code in each application to handle
misbehaving devices. Furthermore, applications would probably want to
keep serving legitimate devices while dealing with rogue devices at the
same time. This feature allows the applications to simply shut out the
misbehaving device on a low level and not worry about it after that
(which in turn should hopefully simplify the application logic).

End user and application concerns aside, what I'm personally looking
forward to using this feature for is at the UPF's. It has happened quite
often that platforms (particularly car kits and headsets) forget to
delete our bdaddr after the test session and keep spamming us with
connect requests throughout the rest of the event. This kind of behavior
makes testing more difficult and messes up HCI traces, so having a
simple switch to block out a device will be nice.

Johan
