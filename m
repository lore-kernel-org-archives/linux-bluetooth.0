Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170306160841.GH20572@atomide.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-3-sre@kernel.org>
 <20170306160841.GH20572@atomide.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 7 Mar 2017 10:31:47 -0600
Message-ID: <CAL_JsqKJO6aGwv-fWzvHrbc5n6rdjtZ9Zn9Jg7r1L8-yP2JbSQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] ARM: dts: N900: Add bluetooth
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 6, 2017 at 10:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Sebastian Reichel <sre@kernel.org> [170304 04:00]:
>> Add bcm2048 node and its system clock to the N900 device tree file.
>> Apart from that a reference to the new clock has been added to
>> wl1251 (which uses it, too).
>>
>> Signed-off-by: Sebastian Reichel <sre@kernel.org>
>
> Picking this patch into omap-for-v4.12/dt thanks.

The binding is not yet settled.

Rob
