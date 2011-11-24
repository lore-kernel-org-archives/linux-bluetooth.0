Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Nov 2011 20:22:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Don't set LE flags in mgmt_start_discovery()
Message-ID: <20111124182222.GA23469@fusion.localdomain>
References: <1321991470-2201-1-git-send-email-andre.guedes@openbossa.org>
 <20111122215822.GA23550@fusion.localdomain>
 <70B35869-720B-4A42-8E3C-84679BE805FC@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70B35869-720B-4A42-8E3C-84679BE805FC@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Nov 24, 2011, Andre Guedes wrote:
> I think I do not quite understand this change in start discovery
> command. How should the command work now?
> 
> For instance, let's say we have the userspace always setting those bits
> (BR/EDR and LE). If the hardware doesn't support LE should the kernel
> return error?

No.

> Or do we expect it does a kind of "best effort" and runs the inquiry
> only?

Yes, I think that would make most sense from user-space perspective
"find all devices you can". As for BR/EDR specific discovery (with no LE
bits) or LE specific discovery (BR/EDR bit not set) if the hardware
doesn't support the request then in this case I think it would in fact
make sense to return an error.

Johan
