Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Jan 2012 17:01:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: invert locking order in connect path
Message-ID: <20120111150153.GA889@x220>
References: <20120103144433.GA21712@elgon.mountain>
 <20120103185214.GA30866@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120103185214.GA30866@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 03, 2012, Gustavo Padovan wrote:
> * Dan Carpenter <dan.carpenter@oracle.com> [2012-01-03 17:44:33 +0300]:
> 
> > Hi Gustavo,
> > 
> > You didn't mean to mark the function inline in 03a001948166 "Bluetooth:
> > invert locking order in connect path" did you?  It causes a Sparse
> > warning.
> > 
> > include/net/bluetooth/l2cap.h:837:30 error: marked inline, but without
> > a definition
> 
> Indeed, I'll fix it.

I didn't see the patch for this anywhere so I did it myself and got an
ack from Marcel. It's now part of my bluetooth-next tree.

Johan
