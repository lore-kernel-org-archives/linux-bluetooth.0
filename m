Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Jan 2012 17:10:01 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: invert locking order in connect path
Message-ID: <20120103185214.GA30866@joana>
References: <20120103144433.GA21712@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120103144433.GA21712@elgon.mountain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <dan.carpenter@oracle.com> [2012-01-03 17:44:33 +0300]:

> Hi Gustavo,
> 
> You didn't mean to mark the function inline in 03a001948166 "Bluetooth:
> invert locking order in connect path" did you?  It causes a Sparse
> warning.
> 
> include/net/bluetooth/l2cap.h:837:30 error: marked inline, but without
> a definition

Indeed, I'll fix it.

	Gustavo
