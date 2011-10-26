Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: bcm203x: Use GFP_KERNEL in workqueue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 26 Oct 2011 10:54:10 +0200
In-Reply-To: <1319570016-7439-2-git-send-email-dh.herrmann@googlemail.com>
References: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
	 <1319570016-7439-2-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319619251.15441.250.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> A workqueue is allowed to sleep so we can safely use GFP_KERNEL instead of
> GFP_ATOMIC. This is still legacy code when the driver used timer BHs and not a
> worqueue.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/bcm203x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

good catch here. We should not use GFP_ATOMIC until we have to.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


