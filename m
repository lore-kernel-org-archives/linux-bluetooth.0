Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 20:09:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: can adapters have a say in automatic setup procedure?
Message-ID: <20110728170926.GA5426@dell.Elisa>
References: <CABUK1ahn-HxWWwaqO=eeYUvLoJcBRLeg1Z+sPikRTbg=zimYWQ@mail.gmail.com>
 <20110728084948.GA13243@dell>
 <CABUK1aiSG4JHMEB-EB+Po_oTWTpAvYPvW1Ku8rn2R=96DKnrdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABUK1aiSG4JHMEB-EB+Po_oTWTpAvYPvW1Ku8rn2R=96DKnrdA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Thu, Jul 28, 2011, Pavan Savoy wrote:
> would a patch like this work ? where in each adapter can have the
> AUTO_ON or some better name like MGMT feature required or not....
> I kind of understand why this one's required, but what would be the
> effects of not having this for an adapter ?

As I mentioned a user-space that only uses the management interface
would never know that the adapter exists in this case and would thereby
be unable to switch it on. If we keep the model that an adapter exists
(through the management interface) only when it has been initialized for
the first time then we'd still need the kernel to trigger the very first
power-on. The only idea that comes to mind for this is to have the
kernel detect somehow when user-space is available and then proceed with
doing the initial power-on (thereby letting user-space know about
available adapters).

Johan
