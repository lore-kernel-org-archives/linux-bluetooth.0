Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Jul 2012 15:48:24 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] Bluetooth: Add MacBookPro10,1 support
Message-ID: <20120709184824.GA21411@x220>
References: <1341856347-257-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341856347-257-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrik,

On Mon, Jul 09, 2012, Henrik Rydberg wrote:
> Add support for the 2012 15'' MacBook Pro Retina.
> 
> Patch originally written by clipcarl (forums.opensuse.org).
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Gustavo,
> 
> This patch adds support for the new retina. Picked up from the suse
> forum. Getting it into 3.5 would be great, if possible.
> 
> Cheers,
> Henrik
> 
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)

I believe the requirement is to always include a usb-devices output in
the commit message (to let maintainers confirm that no typo has occurred
in the patch itself).

Johah
