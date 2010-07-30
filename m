Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Jul 2010 16:01:02 +0200
From: Michal 'vorner' Vaner <vorner@ucw.cz>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem connecting headset with bluez >= 4.64
Message-ID: <20100730140102.GA5018@hydra.kolej.mff.cuni.cz>
References: <20100712124827.GA3012@hydra.kolej.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100712124827.GA3012@hydra.kolej.mff.cuni.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

On Mon, Jul 12, 2010 at 02:48:27PM +0200, Michal 'vorner' Vaner wrote:
> I have a bluetooth headset/headphones. However, I have a problem to connect to
> them on one of my machines (while other two machines work well). Downgrading to
> version 4.63 helps. In that case, bluetooth outputs something like this (this is
> for the HSP profile, the A2DP acts similarly):
>
> [ .... Deleted logs .... ]
> 
> I tried bisecting the sources and it seems the problem is introduced in commit
> aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security level
> MEDIUM". When I compile version with all commits up to master except this one,
> it works, so this confirms my problem comes from this commit.
> 
> A wild guess is that the machines differ in which adapter they have and that
> this one does not support something needed for the medium level security. The
> adaptor is "OMEGA MICRO BT140", while the other two computers are laptops and
> have some onboard usb connected adaptors (I do not know which ones). Is it
> possible? If so, is there a possibility forcing bluez not using the
> not-implemented function in a cleaner way than omitting the commit?

I found out that it works with different dongle on the same computer. Is it bug
in the dongle or something that could be fixed in software too?

Thanks

-- 
I've already told you more than I know.

Michal 'vorner' Vaner
