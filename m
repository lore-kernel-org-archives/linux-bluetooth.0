Return-Path: <cyrus@holtmann.org>
Message-ID: <956973.57311.qm@web94903.mail.in2.yahoo.com>
Date: Wed, 14 Apr 2010 02:54:00 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: l2cap connection id in user-space
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
In-Reply-To: <20100413211913.GA20489@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--- On Wed, 14/4/10, Gustavo F. Padovan <gustavo@padovan.org> wrote:

> From: Gustavo F. Padovan <gustavo@padovan.org>
> Subject: Re: l2cap connection id in user-space
> To: "Pavan Savoy" <pavan_savoy@yahoo.co.in>
> Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
> Date: Wednesday, 14 April, 2010, 2:49 AM
> Hi Pavan,
> 
> * Pavan Savoy <pavan_savoy@yahoo.co.in>
> [2010-04-14 02:26:41 +0530]:
> 
> > Is there a possibility as of now for me to extract the
> l2cap connection ID into my application ?
> 
> bluez-hcidump does that. Look to its source code to learn
> how.

Yeah, correct, it does.
However for that wouldn't I have to set filter for all ACL (or L2CAP) packets to even start receiving ACL (or L2CAP) packets ?
strip off the l2cap_hdr and then get the channel ID from it.

I was more or less looking to add in 1 more getsockopt option to specifically request for the l2cap_hdr ? (like the imtu/omtu which happens currently).
Wouldn't this be the right way ?

> > 
> > I require 2 sets of information about an L2CAP
> connection in my bluetooth application, I require the
> connection ID on connection to a remote headset/sink, and
> also the maximum packet size for that connection (which I
> think is the MTU, I can get via the getsockopt).
> > 
> 
> -- 
> Gustavo F. Padovan
> http://padovan.org
> 

Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
