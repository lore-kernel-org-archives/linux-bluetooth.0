Return-Path: <cyrus@holtmann.org>
Message-ID: <1325613241.6454.0.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Don't mark non xfer isoc endpoint URBs with
 URB_ISO_ASAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Date: Tue, 03 Jan 2012 09:54:01 -0800
In-Reply-To: <1325588033-4831-1-git-send-email-wagi@monom.org>
References: <1325588033-4831-1-git-send-email-wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> [ 2096.384084] btusb_send_frame:684: hci0
> [ 2096.384087] usb 3-1: BOGUS urb flags, 2 --> 0
> [ 2096.384091] Bluetooth: hci0 urb ffff8801b61d3a80 submission failed (22)
> 
> According the documentation in usb_submit_urb() URB_ISO_ASAP
> flag is only allowed for endpoints of type USB_ENDPOINT_XFER_ISOC.
> 
> This reverts commit b8aabfc92249b239c425da7e4ca85b7e4855e984.
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
> 
> forgot the sign-off :)
> 
>  drivers/bluetooth/btusb.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


