Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 13:29:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Add Property Changed callbacks to btd_device
Message-ID: <20120329102913.GA24543@x220>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Mar 28, 2012, chen.ganir@ti.com wrote:
> Add a callback mechanism for the btd_device, allowing other parts of
> the bluez stack to receive notifications for device properties which
> are changed. This mechanism is based on the D-BUS API for Device
> PropertyChanged.
> 
> Chen Ganir (4):
>   Add property changed callback
>   Centralize property changed events
>   Use macros instead of strings
>   Call registered callbacks
> 
>  src/device.c |  223 +++++++++++++++++++++++++++++++++++++++++++++++++---------
>  src/device.h |   93 ++++++++++++++++++++++++
>  2 files changed, 281 insertions(+), 35 deletions(-)

I don't think all this extra code is necessary for exposing a single
device parameter like you described in the use case that you need this
for.  Instead we could consider introducing a callback specific to this
very information.

If some time in the future the amount of similar callbacks grows for
various device parameters we could consider creating something more
generic for them however even then that wouldn't be based on top of
D-Bus properties (the inverse might be possible though: handling the
D-Bus property signals using this generic framework).

Johan
