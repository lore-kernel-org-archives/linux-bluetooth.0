Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:26:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH] Bluetooth: Don't mark non xfer isoc endpoint URBs with
 URB_ISO_ASAP
Message-ID: <20120108202604.GB16731@x220.P-661HNU-F1>
References: <1325588033-4831-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325588033-4831-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Jan 03, 2012, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
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

The patch has been applied to my bluetooth-next tree. Thanks.

Johan
