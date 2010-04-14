Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Wed, 14 Apr 2010 02:51:10 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	shitiz_kumar@ti.com
Subject: Re: l2cap connection id in user-space
Message-ID: <20100414055110.GB21193@vigoh>
References: <112852.88977.qm@web94911.mail.in2.yahoo.com>
 <1271206772.22838.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1271206772.22838.0.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

* Marcel Holtmann <marcel@holtmann.org> [2010-04-13 17:59:32 -0700]:

> Hi Pavan,
> 
> > Is there a possibility as of now for me to extract the l2cap connection ID into my application ?
> > 
> > I require 2 sets of information about an L2CAP connection in my bluetooth application, I require the connection ID on connection to a remote headset/sink, and also the maximum packet size for that connection (which I think is the MTU, I can get via the getsockopt).
> 
> you need a recent kernel and then getsockname() and getpeername() will
> give you the SCID and DCID.

Sorry for the wrong info, I didn't know about that calls inside L2CAP.
;)

-- 
Gustavo F. Padovan
http://padovan.org
