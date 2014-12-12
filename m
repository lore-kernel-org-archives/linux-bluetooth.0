Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Dec 2014 22:03:18 -0800
From: Tristan Lelong <tristan@lelong.xyz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BCSP line discipline
Message-ID: <20141212060318.GA5095@dunderer>
References: <20141211044836.GA21771@dunderer>
 <D5F4F93F-8C6D-4B10-AEDB-7DD59C0E6E6C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D5F4F93F-8C6D-4B10-AEDB-7DD59C0E6E6C@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 11, 2014 at 01:50:28PM +0100, Marcel Holtmann wrote:
> 
> have you read my comment about creating a new hciattach:
> 
> http://permalink.gmane.org/gmane.linux.bluez.kernel/50483
> 
> And with that also the options we have for device / address configuration these days:
> 
> http://permalink.gmane.org/gmane.linux.bluez.kernel/50716
> 

Now I did, I am currently not able to do tests (no HW just my laptop), but that was really instructive.

> In summary, the whole handling of BCSP should move into the kernel. The kernel can bring up the device as unconfigured, then you use HCI User Channel to change the baud rate, then run it as configured.

Glad to hear that I wasn't wrong on that.

> 
> So just send your patches and then we see.

I cleaned the patches and will send you the first version for review, but I need to do a little bit of testing just in case the cleaning broke something.
I'll be submitting the v2 next week when I'll be able to access some hardware.
The "unclean" patches were tested on a 921600 baud link for 12 hours straight with multiple connect/disconnect.

Thanks
