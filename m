Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: bcm203x: Fix race condition on disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 26 Oct 2011 11:16:37 +0200
In-Reply-To: <1319620393-11127-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319619883.15441.256.camel@aeonflux>
	 <1319620393-11127-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319620598.15441.257.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

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

looks good to me now.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


