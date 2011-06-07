Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 00:02:02 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 06/11] Bluetooth: Advertising entries lifetime
Message-ID: <20110607150202.GA1952@dell.ccr.corp.intel.com>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
 <1305936645-15007-6-git-send-email-andre.guedes@openbossa.org>
 <BANLkTin3Q1cO0-q50fEye7=7KHxTgKmhTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTin3Q1cO0-q50fEye7=7KHxTgKmhTg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jun 07, 2011, Luiz Augusto von Dentz wrote:
> Maybe we should not trigger the timer if the we are connected to the
> device, this would be very convenient if a disconnect happen for
> unknown reason e.g. bug or crash so we can quickly reconnect without
> having to scan again, once disconnected then we start the entry timer,
> what do you think?

Initially this sounds like a good idea, however almost all of the
devices we've tested with automatically disable advertising when
connected so an immediate reconnect attempt like that would fail in most
cases.

Johan
