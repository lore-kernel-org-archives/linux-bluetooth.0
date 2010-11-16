Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
Date: Tue, 16 Nov 2010 11:12:05 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com> <201011150954.23553.szymon.janc@tieto.com> <AANLkTik+LOzvJMG=of7cwrQ3j2a0mDvN4Rnq_d4rtwKB@mail.gmail.com>
In-Reply-To: <AANLkTik+LOzvJMG=of7cwrQ3j2a0mDvN4Rnq_d4rtwKB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011161112.05202.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> >> Why are we enforcing this limitation ?
> >
> > Spec requires that each hash&randomizer values should be used only for one OOB
> > transfer. Implementation enforces that by allowing only one active OOB plugin
> > at time and DBUS OOB plugin only 'expose' plugin API over DBUS. So this
> > limitation is a consequence of that.
> 
> I don't think the spec says that. It just says every single time the
> call to read the local adapters hash
> and randomizer is done you get new values. You can use the value that
> you have obtained for as many OOB pairings
> as you wish.

Please see note in Vol2. Part E. 7.3.60:

	"Each OOB transfer will have unique C and R values so after each OOB
	transfer this command shall be used to obtain a new set of values for the next
	OOB transfer."


-- 
Szymon Janc
