Return-Path: <tony@atomide.com>
Date: Mon, 6 Mar 2017 08:08:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] ARM: dts: N900: Add bluetooth
Message-ID: <20170306160841.GH20572@atomide.com>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170304115833.3538-3-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Sebastian Reichel <sre@kernel.org> [170304 04:00]:
> Add bcm2048 node and its system clock to the N900 device tree file.
> Apart from that a reference to the new clock has been added to
> wl1251 (which uses it, too).
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Picking this patch into omap-for-v4.12/dt thanks.

Regards,

Tony
