Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:54:39 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2] Bluetooth: bcm203x: Fix race condition on disconnect
Message-ID: <20111031195439.GJ10164@joana>
References: <1319619883.15441.256.camel@aeonflux>
 <1319620393-11127-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319620393-11127-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-26 11:13:13 +0200]:

> When disconnecting a bcm203x device we kill and destroy the usb-urb, however,
> there might still be a pending work-structure which resubmits the now invalid
> urb. To avoid this race condition, we simply set a shutdown-flag and
> synchronously kill the worker first.
> 
> This also adds a comment to all schedule_work()s, as it is really not clear
> that they are used as replacement for short timers (which can be seen in the git
> history).
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> V2: Remove memory barriers
> 
>  drivers/bluetooth/bcm203x.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
