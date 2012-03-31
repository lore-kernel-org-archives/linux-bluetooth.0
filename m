Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 22:07:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Clean up l2cap_chan_connect
Message-ID: <20120331010748.GA12922@joana>
References: <1333094228-31591-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1333097689.1870.249.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333097689.1870.249.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-03-30 10:54:49 +0200]:

> Hi Andrei,
> 
> > Reduce number of arguments by two and in future by another one. All
> > those parameters are passed inside L2CAP sockaddr_l2 pointer.
> 
> I am not sure that using sockaddr_l2 is a good idea. Are these socket
> address structs used directly in other parts of the networking
> subsystems anywhere?

This code was using sockaddr_l2 before, I changed it in my separate core from
sock patches. If we are separating thing we won't want to have a sock related
struct there.

	Gustavo
