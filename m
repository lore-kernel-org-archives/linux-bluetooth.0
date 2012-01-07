Return-Path: <cyrus@holtmann.org>
Message-ID: <1325970290.6454.127.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: dtl1: Fix memleak in probe()
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sat, 07 Jan 2012 13:04:50 -0800
In-Reply-To: <1325945981-11330-5-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
	 <1325945981-11330-5-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> We currently leak the driver info structure if dtl1_config fails. If we add a
> kfree() to dtl1_release to fix this, then dtl1_release and dtl1_detach are
> identical so this merges both functions.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/dtl1_cs.c |   20 +++-----------------
>  1 files changed, 3 insertions(+), 17 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


