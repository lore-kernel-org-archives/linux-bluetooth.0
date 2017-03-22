Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170321223216.11733-9-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org> <20170321223216.11733-9-sre@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 Mar 2017 16:04:57 -0500
Message-ID: <CAL_Jsq+CqrfK=ANLR5mt4F5sb8-0Q3=GNfZA80EJq_2oYCBXmA@mail.gmail.com>
Subject: Re: [PATCHv2 08/11] dt-bindings: net: bluetooth: Add nokia-bluetooth
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Add binding document for serial bluetooth chips using
> Nokia H4+ protocol.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv1:
>  * change compatible strings
>  * mention active high/low state for GPIOs
> ---
>  .../devicetree/bindings/net/nokia-bluetooth.txt    | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt

Acked-by: Rob Herring <robh@kernel.org>
