Return-Path: <tony@atomide.com>
Date: Tue, 7 Mar 2017 08:37:43 -0800
From: Tony Lindgren <tony@atomide.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/10] ARM: dts: N900: Add bluetooth
Message-ID: <20170307163743.GT20572@atomide.com>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-3-sre@kernel.org>
 <20170306160841.GH20572@atomide.com>
 <CAL_JsqKJO6aGwv-fWzvHrbc5n6rdjtZ9Zn9Jg7r1L8-yP2JbSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqKJO6aGwv-fWzvHrbc5n6rdjtZ9Zn9Jg7r1L8-yP2JbSQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Rob Herring <robh+dt@kernel.org> [170307 08:34]:
> On Mon, Mar 6, 2017 at 10:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Sebastian Reichel <sre@kernel.org> [170304 04:00]:
> >> Add bcm2048 node and its system clock to the N900 device tree file.
> >> Apart from that a reference to the new clock has been added to
> >> wl1251 (which uses it, too).
> >>
> >> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> >
> > Picking this patch into omap-for-v4.12/dt thanks.
> 
> The binding is not yet settled.

Oh sorry I thought the binding was already done. Will revert.

Regards,

Tony
