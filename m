Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Mar 2010 00:50:14 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix using invalid data from previous headset connection
Message-ID: <20100304035014.GA26956@jh-x301>
References: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
 <20100303033233.GA20411@jh-x301>
 <2d5a2c101003030025v40b2ca4ma985e5a544d7e707@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101003030025v40b2ca4ma985e5a544d7e707@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 03, 2010, Luiz Augusto von Dentz wrote:
> > First of all could we just call a "session" what the HFP spec calls it,
> > i.e. a Service Level Connection, e.g. hs->slc? Or do you have some
> > better suggestion?
> 
> I suggested session since it represents the connection itself, even
> the at comands buffer is in the new structure so I guess it doesn't
> really represents slc, maybe connection is more suitable since there
> could be only one.

True, though "connection" is longer than "session" and we should try to
use something that's short and clean. IMHO "slc" isn't totally bad even
though the data is already used before the SLC establishment is fully
completed. You could think of it as "data needed for SLC establishment
and state handling" in which case the name would be kind of justified.

> > Secondly you need to be careful when doing one-to-one replacements of
> > existing hs->foo statements with hs->session->foo statements. What if
> > hs->session is NULL? Are there some valid use cases when a function that
> > can access hs->session could get called while hs->session is NULL?
> 
> Afaik no there aren't, the session represent the lifetime of the
> rfcomm connection and the only thing that are accessible are the gains
> via dbus interface but we protect them by checking the state and if by
> some reason we don't have a session then there is probably a bug so
> checking hs->session would probably hide those.

There's also the telephony driver that can call into headset.c. However,
I suppose that case could also be considered a bug in the driver if it
does these calls while there's no connection. It's probably still a good
idea to check if the current drivers (particularly telephony-maemo.c) do
anything like this.

Johan
