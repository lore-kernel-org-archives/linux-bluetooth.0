Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 10 Oct 2011 18:03:01 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btusb: hide more usb_submit_urb errors
Message-ID: <20111010210301.GB6936@joana>
References: <1318155142.1903.24.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318155142.1903.24.camel@x61.thuisdomein>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paul,

* Paul Bolle <pebolle@tiscali.nl> [2011-10-09 12:12:22 +0200]:

> There are still three calls of usb_submit_urb() that will print errors
> if those calls return -EPERM or -ENODEV. I have never triggered these,
> so I'm not sure when these return values might be seen. It still makes
> sense to be silent if these occur (since "urb is being killed" and
> "device got disconnected" aren't things to worry about).
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
>  drivers/bluetooth/btusb.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

	Gustavo
