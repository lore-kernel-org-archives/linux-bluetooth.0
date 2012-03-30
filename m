Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 13:18:46 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Clean up l2cap_chan_connect
Message-ID: <20120330101844.GD12694@aemeltch-MOBL1>
References: <1333094228-31591-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1333097689.1870.249.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333097689.1870.249.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 30, 2012 at 10:54:49AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Reduce number of arguments by two and in future by another one. All
> > those parameters are passed inside L2CAP sockaddr_l2 pointer.
> 
> I am not sure that using sockaddr_l2 is a good idea. Are these socket
> address structs used directly in other parts of the networking
> subsystems anywhere?

Apparently not much.

Best regards 
Andrei Emeltchenko 
