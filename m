Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Apr 2010 18:39:38 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
Subject: Re: l2cap connection id in user-space
Message-ID: <20100413213938.GA1365@vigoh>
References: <20100413211913.GA20489@vigoh>
 <956973.57311.qm@web94903.mail.in2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <956973.57311.qm@web94903.mail.in2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

* Pavan Savoy <pavan_savoy@yahoo.co.in> [2010-04-14 02:54:00 +0530]:

> 
> --- On Wed, 14/4/10, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> 
> > From: Gustavo F. Padovan <gustavo@padovan.org>
> > Subject: Re: l2cap connection id in user-space
> > To: "Pavan Savoy" <pavan_savoy@yahoo.co.in>
> > Cc: linux-bluetooth@vger.kernel.org, shitiz_kumar@ti.com
> > Date: Wednesday, 14 April, 2010, 2:49 AM
> > Hi Pavan,
> > 
> > * Pavan Savoy <pavan_savoy@yahoo.co.in>
> > [2010-04-14 02:26:41 +0530]:
> > 
> > > Is there a possibility as of now for me to extract the
> > l2cap connection ID into my application ?
> > 
> > bluez-hcidump does that. Look to its source code to learn
> > how.
> 
> Yeah, correct, it does.
> However for that wouldn't I have to set filter for all ACL (or L2CAP) packets to even start receiving ACL (or L2CAP) packets ?
> strip off the l2cap_hdr and then get the channel ID from it.
> 
> I was more or less looking to add in 1 more getsockopt option to specifically request for the l2cap_hdr ? (like the imtu/omtu which happens currently).
> Wouldn't this be the right way ?

No, we do not want such info on getsockopt. If you do that you'll have
to mantain it by yourself, which is not a good idea. The cid is L2CAP
specific, upper layers should not care about it.

> 
> > > 
> > > I require 2 sets of information about an L2CAP
> > connection in my bluetooth application, I require the
> > connection ID on connection to a remote headset/sink, and
> > also the maximum packet size for that connection (which I
> > think is the MTU, I can get via the getsockopt).
> > > 
> > 
-- 
Gustavo F. Padovan
http://padovan.org
