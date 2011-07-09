Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 18:32:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add Proximity API
Message-ID: <20110709153159.GC9576@dell.ger.corp.intel.com>
References: <1309982546-24830-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309982546-24830-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jul 06, 2011, Claudio Takahasi wrote:
> Covers the Proximity Monitor for Link Loss, Tx Power and Immediate
> Alert services. This first proposal considers that the connections
> will be managed by the bluetoothd core based on the registered
> connection callbacks.
> 
> Only one instance of Immediate Alert service is allowed, "Alert Level"
> characteristic of this service is used by Find Me and Path Loss. Note
> that "Alert Level" for Path Loss is a LOCAL property written in the
> Immediate Alert service when the threshold is reached. For Find Me
> the user/application needs to actively enable the alert in the Immediate
> Alert service. Link Loss has it's own instance of Alert Level
> characteristic.
> ---
>  doc/proximity-api.txt |   78 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
>  create mode 100644 doc/proximity-api.txt

Pushed upstream. Thanks.

Johan
