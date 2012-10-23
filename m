Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Oct 2012 23:59:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/7] Bluetooth: Disallow LE scanning and connecting in
 peripheral mode
Message-ID: <20121023205923.GA15410@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
 <1351011241-32515-4-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_PXwxZ1cyCd=2g170AYx7yjx24cHmksJCTbkxtxyOV4-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_PXwxZ1cyCd=2g170AYx7yjx24cHmksJCTbkxtxyOV4-g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 23, 2012, Anderson Lizardo wrote:
> This will conflict with an Observer role running on the same device.
> Multiple roles are allowed to run concurrently if supported by the
> controller. From Core spec page 1639:
> 
> A device may operate in multiple GAP roles concurrently if supported
> by the Controller. The Host should read the supported Link Layer
> States and State combinations from the Controller before any
> procedures or modes are used.
> 
> Do you propose SET_LE to become a bitfield to support concurrent
> roles?  I.e. Broadcaster/Observer.

See the other email I sent about this. If peripheral mode is enabled I
don't see how we could simultaneously allow another LE GAP mode based on
the restrictions of the core spec. And yes, we could make set_le a bit
field, but peripheral will probably still remain mutually exclusive with
any other LE GAP mode.

Johan
