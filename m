Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Aug 2010 23:11:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, arunkr.singh@stericsson.com
Subject: Re: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <20100827201132.GA14223@jh-x301>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1282911133.835.30.camel@localhost.localdomain>
 <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
 <20100827124524.GA9484@jh-x301>
 <99B09243E1A5DA4898CDD8B7001114480976E15A78@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480976E15A78@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Fri, Aug 27, 2010, Waldemar.Rymarkiewicz@tieto.com wrote:
> However, I would appreciate any comments to the changes as I'm not
> sure what was originally assumed for the high security level.

Your assumptions were more or less correct. Additionally there should be
the check for encryption key size (to fulfill SAP requirements), though
that'd require at least a 3.0 capable controller if for the standardized
HCI command.

> What's more, I'am not happy that the link key request and the pin code
> request are handled in bluez. It makes that bluez need to pass it to
> the kernel as it's needed there. I used ioctl for that. Some comments
> on this?

I'm not happy with it either. In fact, the arbitrary split of security
logic between kernel and userspace has caused us lots of grief,
especially with SSP. Because of this, the plan for BlueZ 5.x is to move
most security related logic to the kernel side. The only thing remaining
in userspace is security policy requiring user interaction (e.g.
answering user confirmation requests) and persistent link key storage
(runtime storage will be added to the kernel side). The promiscuous HCI
socket will go away from bluetoothd so the daemon doesn't always wake up
when there's some HCI traffic.

To make all this possible we're designing a new protocol between kernel
and userspace. Hopefully we'll get the first bits, at least a
preliminary specification, upstream within the next month or so. Because
of this I'm wondering if the new ioctl that you're adding is really
worth it. Maybe we should just wait for BlueZ 5.x with this. That'd also
give us the possibility of adding a new parameter to
Agent.RequestPinCode since we need to break the agent API anyway (e.g.
add an incoming just-works pairing callback).

Johan
