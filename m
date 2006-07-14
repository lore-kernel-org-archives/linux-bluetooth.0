Return-Path: <hch@lst.de>
Date: Fri, 14 Jul 2006 10:03:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] bluetooth: use kthread_ API
Message-ID: <20060714080333.GA10043@lst.de>
References: <20060708185833.GA7917@lst.de> <1152798551.4838.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1152798551.4838.14.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Jul 13, 2006 at 03:49:11PM +0200, Marcel Holtmann wrote:
> Hi Christoph,
> 
> thanks for the patch. It is in my -mh patch now for further testing.
> What about RFCOMM. No fun in touching that one?

Actually I'm pretty sure I had a patch for that aswell.  Unfortunately
the box I have the kthread patches on doesn't seem to boot currently.
You'll get the rfcomm patch when I return from Ottawa.
