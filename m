Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 May 2009 00:25:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brock Denson <Brock.Denson@csr.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez 4.x questions, SCO stops
Message-ID: <20090507212508.GA23276@jh-x301>
References: <79DD16001F75DB4EB7DE37CDD687BB2001B7238D@dalamsexb02.AMERICAS.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <79DD16001F75DB4EB7DE37CDD687BB2001B7238D@dalamsexb02.AMERICAS.ROOT.PRI>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brock,

On Thu, May 07, 2009, Brock Denson wrote:
> I am having a problem with SCO stopping after 1 minute that I would
> really appreciate some help with.  I can connect to the headset, query
> responses, etc, but when I start sco either via a dbus-send command or
> with the test-telephony play <> command then after 30 seconds I get a
> dbus timeout and then 30 more seconds later the SCO will stop.  I have
> air-traced the session and can see that the host is sending silence
> while SCO is being transmitted, so it seems functional, but I am sure I
> am missing something.  I have included just about everything I can think
> of below in the hopes that someone has a few minutes to point out the
> problem.  Distribution is FC10.

You've got several occurences of the following in the logs:
bluetoothd[25721]: connect(): Connection timed out (110)

I'm pretty sure that's coming for the SCO socket and I recall there being
a related kernel bug which got fixed some time back. You might want to try
with the latest 2.6.30-rc kernel or one of Marcel's git trees (e.g.
bluetooth-testing). Those should have the issue fixed.

Johan
