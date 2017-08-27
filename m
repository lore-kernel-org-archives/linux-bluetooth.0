Return-Path: <stefan.wahren@i2se.com>
Date: Sun, 27 Aug 2017 11:54:24 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Loic Poulain <loic.poulain@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, devicetree@vger.kernel.org
Message-ID: <123116901.43777.1503827664160@email.1und1.de>
In-Reply-To: <9BD5C644-6B89-496C-B442-F276D7A99102@holtmann.org>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <20170822074726.e424lflqxn6mb4xd@flea.lan>
 <f2fcf522-cd1e-e748-0ee7-ad28bbf8ae5d@i2se.com>
 <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
 <9BD5C644-6B89-496C-B442-F276D7A99102@holtmann.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 broadcom-bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 23. August 2017 um 16:19 geschrieben:
> 
> 
> Hi Loic,
> 
> >>> Thanks a lot for working on that, I've made a similar attempt a few
> >>> weeks ago but didn't manage to get it to work.
> >>> 
> >>> The way it's hooked in our boards is a bit more complex though, even
> >>> if it could be because we're using a different part.
> >>> 
> >>> In order to get it running we need:
> >>>   - two clocks, called in the broadcom datasheets lpo and tcxo.
> >>>   - three GPIOs, device wakeup, host wakeup and a shutdown GPIO (which
> >>>     might be the BT_ON you were discussing about)
> >>>   - two regulators called vbat and reg-en for us (I guess they're
> >>>     meant to power the chip, and its registers >>
> >>> Do you know if you're also using those? Or could it be that it's just
> >>> hardwired to some non-gatable crystal / regulator on the RPI?
> > 
> > Not on Pi3, but the three gpios and the clock are pretty common for
> > Broadcom bt controller (cf v4 of dt-bindings patch).
> 
> once we get the GPIO expander driver upstream, I think we also need this for RPI 3 and Zero W. Right now we can just not do anything about this.

AFAIK the Zero W doesn't have this GPIO expander. Would it be easier for you?
