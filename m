Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar HJALMDAHL" <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: Re: [PATCH 2/2] mach-ux500: Add CG2900 devices
Date: Wed, 23 Mar 2011 17:13:40 +0100
Cc: "Greg Kroah-Hartman" <gregkh@suse.de>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
	Lee Jones <lee.jones@linaro.org>
References: <1300888803-26474-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com> <201103231542.28311.arnd@arndb.de> <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE937@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA334C4DE937@EXDCVYMBSTM005.EQ1STM.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103231713.40311.arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 23 March 2011, Par-Gunnar HJALMDAHL wrote:
> I will see how I can fix this. I'm not 100% how I will solve the
> "asking the hardware" part, but as you say we might be able to do
> this in a better way by doing it from the main staging driver instead.

The easiest way to do this would be to have separate board files for
devices with and without cg2900 and identify the hardware based on the
board number. If all ux500 boards have a cg2900, that would be trivial ;-)

	Arnd
